#latest

#######################################################################################
#ERAS.R is licensed under a Creative Commons Attribution - Non commercial 3.0 Unported License. see full license at the end of this file.
#######################################################################################

#Worni, please ignore all the comments with the word TODO, these are just notes for myself in relation to programming stuff i am working
#Worni, i saw that in your do file you mix data management with modeling. i wouldn't do that, it makes it hard to maintain. instead, i would have a section at the beginning where all the data management is done. then in subsequent sections you can build your objects and models

#TODO: check git book on http://goo.gl/j2Oxt
#TODO: investigate connection with figshare http://goo.gl/QXlpr
#TODO: format as knitr http://goo.gl/3UVAZ - bibliographic references will be dealt with as citations. need to check whether can add hyperlinks to the original publications
#TODO: gists http://goo.gl/pYs6m
#TODO for toolbox: rrdf, mysql, hadoop, toolbox input and output for clinicians (might have ontology down the line)

#####################################################################################
#SETTING ENVIRONMENT
#####################################################################################
#remove all objects and then check
rm(list = ls())
ls()
#dettach all packages
detach()

<<<<<<< HEAD
#Worni, the first time you run this script you will have to run the line below. just take the # out so that it is no longer a comment but an active command. after you run it once in your computer, you don't need to run it again
lapply(c("ggplot2", "psych", "RCurl", "irr", "car","Hmisc", "gmodels", "DAAG"), install.packages, character.only=T)

#TODO create mlibrary function to upload many packages and post as gist
lapply(c("ggplot2", "psych", "RCurl", "irr", "car","Hmisc", "gmodels", "DAAG"), library, character.only=T)
=======
#only install below if you don't have them already installed
#Worni, please see 
#install.packages(c=("package1","package2"))

#TODO create mlibrary function to upload many packages and post as gist
lapply(c("ggplot2", "psych", "RCurl", "irr", "car","Hmisc", "gmodels"), library, character.only=T)
>>>>>>> 0e5e8b765d76ea28761bb5776e8ed1dc5b86d7e7

#uploading data ------------------------------------------------------------------------
#Worni, replace below by path to the data file. command will throw all the data into the erasData object
erasData <- read.csv("/Users/rpietro/Google Drive/R/nonpublicdata/ERAS/eras.csv", stringsAsFactors=FALSE)
#below will view ERAS data in a spreadsheet format
#View(erasData)
#below will list variable names, classes (integer, factor, etc), alternative responses
str(erasData)
#list variable names so that they can be used later
# names(eras.data)
attach(erasData)

###########################################################################################
#DEMOGRAPHICS
###########################################################################################

#TODO videos: Ricardo's RStudio preferences (wrapping, etc)

#Worni, with a few simple functions I can easily reduce each one of your tables to a few lines, and later automatically throw all of the output into a table. this means that your tables will be automatically updated every time you  won't have to do any more tables by hand, ever!!! to get started, please create a few vectors with the following (code will be below): a vector with your continuous (integer) outcomes, a vector with your categorical (factor) outcomes. then just let me know in a comment what your predictor is. what i will do is to take each vector and apply a single command to run the same test against the predictor, all at once.

#integerOutcomes  <- c(var1, var2, var3) #Worni, just replace the var1 etc by the name of the continuous (integer) outcomes 

#factorOutcomes  <- c(var1, var2, var3) #Worni, just replace the var1 etc by the name of the categorical (factor) outcomes 


describe(erasData)

#Worni, year only has values of 1 in the original data set
# ttest age, by(year)
t.test(age ~ datasetyear)

# tab year gender, row chi m
# tab year gender, row chi 

#option prop.r=TRUE asks for the display to be by rows. check ?CrossTable
CrossTable(year, gender, chisq=TRUE, format="SPSS", prop.r=TRUE)


# tab race year, row col chi m
# tab race year, row col chi
# gen rac3groups=.
# replace rac3groups=0 if race=="W"
# replace rac3groups=1 if race=="B"
# replace rac3groups=2 if race=="A"|race=="D"|race=="I"|race=="U"|race==""

#Worni, i am assuming all of this recoding has already being done, but below is just for future reference. just bear in mind that i am not sure if it's a good thing to replace missing by 2
#rac3groups <- recode(race, "'W'=0; 'B'=1; c=('A','D','I')=2)
#Worni, if you really want to replace all the missing by 2, then the code above would look like this:
#rac3groups <- recode(race, " 'W'=0; 'B'=1; else='2' ")

# lab def ra 0 "White" 1 "Black" 2 "Others"
# lab val rac3groups ra
# tab rac3groups year, row col chi m
# 
# tab ethnicty year, col chi m
# tab ethnicty year, col chi 
# 

#Worni, not sure i understood what you did below as bmi is a continuous variable, at least in the data set you sent me

# bysort year: tab bmi, m
# sum bmi
summary(bmi)

# histogram bmi
qplot(bmi)

# ttest bmi, by(year)
# 
# tab asa year, col chi m
# tab asa year,  chi
# 
# gen asa2groups=.
# replace asa2groups=0 if asa<3
# replace asa2groups=1 if asa>2
# tab asa asa2groups, m
# tab asa2groups year, row col chi m
# 
# 
# tab hgb year, col m
# replace hgb=. if hgb==143|hgb==31
# sum hgb
# histogram hgb
# bysort year: sum hgb

summary(hgb~year)

# ttest hgb, by(year)
# 
# *** Check values.... ***
#   tab hct, m
# replace hct=. if hct==0|hct==95|hct==90
# tab hct year, col m
# histogram hct
# ttest hct, by(year)
# 
# tab wbc, m
# replace wbc=. if wbc==634|wbc==0
# tab wbc year, col m
# bysort year: sum wbc
# 
# tab creatinin, m
# replace creatinin=. if creatinin==0
# tab creatinin year, col m
# ttest creatinin, by(year)
# kwallis creatinin, by(year)

kruskal.test(creatinin ~ year)

# 
# *** ??????? ***
#   tab na, m
# 
# tab k, m
# replace k=. if k==0|k==402|k==35
# tab k year, m
# 
# tab bun, m
# replace bun=. if bun==0
# tab bun year, m
# bysort year: sum bun
# 
# tab albumin, m
# replace albumin=. if albumin==0
# bysort year: sum albumin
# 
# 
# *** ????????? ***
#   tab gfr, m
# 
# tab diag year, col chi m
# gen dg4groups=.
# replace dg4groups=0 if diag==0
# replace dg4groups=1 if diag==1
# replace dg4groups=2 if diag==2
# replace dg4groups=3 if diag>2
# tab diag dg4gr, m
# lab def dg 0 "neoplastic" 1 "IBD" 2 "diverticular" 3 "other"
# lab val dg4gr dg
# tab dg4gr year, row col chi

#Worni, in R you don't have to convert variables to a numeric format to play with them, and so there isn't really a label function, you just let the values be strings with the names you want and then do the computations from there. see section 11.1 of the book R for stata users i sent you

# 
# tab operation year , col chi m
# 
# 
# tab proclap year, col m
# tab proclap year, col chi
# 
# tab procopen year, col m
# tab procopen year, col chi
# 
# 
########################################################################################
# TABLE 2
########################################################################################
#   
#   *** ??????? what does 9 mean ????? ***
#   tab cho_drink, m
# replace cho_drink="" if cho_drink=="9"
# tab cho_drink year, col chi m
# tab cho_drink year, chi 
# 
# tab ab_prior year, col chi m
# tab ab_prior year,  chi 
# 
# tab epidural year, col chi m
# tab epidural year,  chi 
# 
# tab epidural_success year, col chi m
# tab epidural_success year, chi 
# 
# tab epidur_intraop_infus year, col chi m
# tab epidur_intraop_infus year,  chi 
# 
# tab vt_proph_preop year, col chi m
# tab vt_proph_preop year, chi 
# 
# tab vt_proph_postop year, col chi m
# tab vt_proph_postop year,  chi 
# 
# tab postop_fluid year, col chi m
# tab postop_fluid year,  chi 
# bysort year: tab postop_fluid datasetyear, col chi m
# 
# *** is missing == 0???? ***
#   bysort year: tab postop_add_fluid, m
# ttest postop_add_fluid, by(year)
# 
# 
# tab chlorhex_shower year, col chi m
# tab chlorhex_shower year,  chi
# 
# tab esoph_monitor year, col chi m
# tab esoph_monitor year,  chi 
# 
# tab intraabd_drain year, col chi m
# tab intraabd_drain year,  chi 
# 
# tab out_of_bed_day1 year,    col chi m
# tab out_of_bed_day1 year,  chi 
# 
# tab ambul_day year, col m
# bysort year: sum ambul_day, d
# 
# gen ambul3groups=0
# replace ambul3groups=1 if ambul_day==1
# replace ambul3groups=2 if ambul_day>1
# replace ambul3groups=2 if ambul_day==.
# lab def kk 0 "day0" 1 "day1" 2 ">day1"
# lab val ambul3groups kk
# tab ambul_day ambul3groups, m
# 
# *** What does 99 mean????? ***
#   tab foley_removal year, col m
# *kwallis foley_removal, by( year)
# 
# gen foleytimely=0
# replace foleytimely=1 if foley_removal==99
# tab foleytimely, m
# 
# *** ????????? ***
#   tab ng_removal_compliant year, col m chi
# 
# 
#####################################################################################
#TABLE 3
#####################################################################################
#   tab supinfect year, col chi m
# tab supinfect year,  chi 
# 
# tab deepinfect year, col chi m
# tab deepinfect year, chi 
# 
# replace anastleak="N" if anastleak==""
# tab anastleak year, col chi m
# tab anastleak year, chi 
# 
# gen wound_infect=0
# replace wound_infect=1 if supinfect=="Y"|deepinfect=="Y"
# replace wound_infect=. if supinfect=="."&deepinfect=="."
# tab wound_infect year, col chi m
# tab wound_infect year, chi 
# 
# gen wound_infect2=0
# replace wound_infect2=1 if supinfect=="Y"|deepinfect=="Y"|anastleak=="Y"
# replace wound_infect2=. if supinfect=="."&deepinfect=="."&anastleak=="."
# tab wound_infect2 year, col chi m
# tab wound_infect2 year, chi 
# 
# replace myoinfarct="N" if myoinfarct ==""
# tab myoinfarct year, col chi m
# tab myoinfarct year, chi 
# 
# replace cardia_arrest ="N" if cardia_arrest ==""
# tab cardia_arrest year, col chi m
# tab cardia_arrest year, chi 
# 
# *tab sudden_death year, col chi m
# *tab sudden_death year, chi 
# 
# *gen sud_arr=0
# *replace sud_arr=1 if cardia_arrest=="Y"|sudden_death=="Y"
# *tab sud_arr year, col chi m
# *tab sud_arr year, chi 
# 
# replace cardiac_compl="Y" if myoinfarct=="Y"|cardia_arrest=="Y"
# replace cardiac_compl="N" if myoinfarct=="N"&cardia_arrest==""
# replace cardiac_compl="N" if myoinfarct=="N"&cardia_arrest=="N"
# replace cardiac_compl="N" if myoinfarct==""&cardia_arrest=="N"
# 
# tab cardiac_compl year, col chi m
# tab cardiac_compl year,  chi 
# 
# tab stroke year, col chi m
# tab stroke year,  chi 
# 
# tab peri_nerve_injury year, col chi m
# tab peri_nerve_injury year,  chi 
# 
# tab neurol year, col chi m
# tab neurol year,  chi 
# 
# tab home_oxygen year, row col chi m
# tab home_oxygen year, row col chi 
# 
# replace pulm_embol ="N" if pulm_embol ==""
# tab pulm_embol year, row col chi m
# tab pulm_embol year, row col chi 
# 
# tab pneumonia year, row col chi m
# tab pneumonia year, row col chi 
# 
# replace pulm ="N" if pulm ==""
# tab pulm year, row col chi m
# tab pulm year, row col chi 
# 
# tab ut_infect year, col chi m
# tab ut_infect year,  chi 
# 
# tab prog_renal_insuff year, col chi m
# tab prog_renal_insuff year,  chi 
# 
# tab renal year, col chi m
# tab renal year,  chi 
# 
# replace ven_thromb ="N" if ven_thromb ==""
# tab ven_thromb year,  col chi m
# tab ven_thromb year,  chi 
# 
# replace sepsis ="N" if sepsis =="" 
# tab sepsis year, col chi m
# tab sepsis year,  chi 
# 
# replace septic_shock ="N" if septic_shock =="" 
# tab septic_shock year, col chi m
# tab septic_shock year,  chi 
# 
# tab overall_sepsis year, col chi m
# tab overall_sepsis year,  chi 
# 
# tab death_out_hospital year, col chi m
# tab death_out_hospital year, chi 
# 
# tab overall_compl year, col chi m
# tab overall_compl year, chi 
# gen atleastonecompl=0
# replace atleastonecompl=1 if supinfect=="Y"|deepinfect=="Y"| anastleak =="Y"| myoinfarct =="Y"| cardia_arrest =="Y"| sudden_death =="Y"|cardiac_compl=="Y"| stroke =="Y"| peri_nerve_injury =="Y"| neurol =="Y"| home_oxygen =="Y"| pulm_embol =="Y"| pneumonia =="Y"| pulm =="Y"| ut_infect =="Y"| prog_renal_insuff =="Y"| renal =="Y" | ven_thromb =="Y"| sepsis =="Y"| septic_shock =="Y"| overall_sepsis =="Y"| death_out_hospital =="Y"
# tab atleastonecompl year, col chi
# logistic atleastonecompl year

model1  <- glm(atleastonecompl~year,family=binomial(link="logit"))
<<<<<<< HEAD
summary(model1) #gives you model results
coefficients(model1) # model coefficients
confint(model1, level=0.95) # CIs for model parameters 
fitted(model1) # predicted values
residuals(model1) # residuals
anova(model1) # anova table, something like anova(model1, model2) will compare two nested models
vcov(model1) # covariance matrix for model parameters 
influence(model1) # regression diagnostics
layout(matrix(c(1,2,3,4),2,2)) # creates the white space for 4 graphs/page 
plot(model1) #generates 4 graphs/page
CVbinary(model1) #cross validation. Worni, this is something we should start trying

=======
summary(model1)
anova(model1)
confint(model1)
>>>>>>> 0e5e8b765d76ea28761bb5776e8ed1dc5b86d7e7

# xi: logistic atleastonecompl year i.proclap age female bmi asa i.operation i.dg4gr 
# xi: logistic atleastonecompl i.epidural*year age female bmi asa i.operation i.dg4gr 
# 
<<<<<<< HEAD

#Worni, this is new stata syntax and then i don't know what it means. if you shoot me an explanation i can give you the R equivalent

=======
>>>>>>> 0e5e8b765d76ea28761bb5776e8ed1dc5b86d7e7
# 
# tab los, m
# ttest los, by( year)
# histogram los
# bysort year: sum los, d
# kwallis los, by( year)
# ranksum los, by(year)
<<<<<<< HEAD

wilcox.test(los, year, conf.int = TRUE)

=======
>>>>>>> 0e5e8b765d76ea28761bb5776e8ed1dc5b86d7e7
# 
# gen ln_los=ln(los)
# histogram ln_los
# tab operation
# gen op1=0
# replace op1=1 if operation==0
# gen op2=0
# replace op2=1 if operation==1
# gen op3=0
# replace op3=1 if operation==2
# gen op4=0
# replace op4=1 if operation==3
# gen op5=0
# replace op5=1 if operation==4
# gen op6=0
# replace op6=1 if operation==5
# 
# tab dg4gr, m
# gen dg1=0
# replace dg1=1 if dg4gr ==0
# gen dg2=0
# replace dg2=1 if dg4gr ==1
# gen dg3=0
# replace dg3=1 if dg4gr ==2
# gen dg4=0
# replace dg4=1 if dg4gr ==3
# 
# gen laparoscopic=0
# replace laparoscopic=1 if proclap=="Y"
# tab lapar proclap
# 
# predxcat ln_los, xvar(year) 
# predxcat ln_los, xvar(year) adjust (laparoscopic age female bmi asa op1 op2 op3 op4 op5 op6 dg1 dg2 dg3 dg4) model mean
<<<<<<< HEAD

model2  <- ln_los ~ year + laparoscopic + age + female + bmi + asa + op1 + op2 + op3 + op4 + op5 + op6 + dg1 + dg2 + dg3 + dg4 #this is your regular model
year.pred  <- c(1,2) #these are the values you want to predict for
model2_hat  <- predict(model1, newdata=year.pred,interval="p", level=0.95)) #here you are using your original model to predict values as a function of specific years as you specified under year.pred
model2_hat #this command will show you the values

# 
# 
############################################################################
#TABLE 4
############################################################################
=======
# 
# 
# 
# ***********************
#   *** TABLE 4 ***********
#   ***********************
>>>>>>> 0e5e8b765d76ea28761bb5776e8ed1dc5b86d7e7
#   tab increase_care year, col chi m
# tab increase_care year, chi 
# gen carinc=0
# replace carinc =1 if increase_care =="Y"
# replace carinc =. if increase_care ==""
# tab carinc year, col m chi
# xi: logistic carinc year
# xi: logistic carinc year i.proclap age female bmi asa i.operation i.dg4gr 
# 
# 
# 
# tab return year, col chi m
# tab return year, chi 
# 
# tab blood year, row col chi m
# tab blood year, row col chi 
# 
# *** is 99 missing???? ***
#   tab restart_antibiotic year, chi m
# replace restart_antibiotic=. if restart_antibiotic==99
# tab restart_antibiotic year, chi m
# bysort year: sum restart_antibiotic, d
# histogram restart_antibiotic
# kwallis restart_antibiotic, by(year)
# ttest restart_antibiotic, by(year)
# nbreg restart_antibiotic year
<<<<<<< HEAD

#Worni, we went over this in a workshop, remember? http://goo.gl/5BMl1

=======
>>>>>>> 0e5e8b765d76ea28761bb5776e8ed1dc5b86d7e7
# 
# gen ab_any=1
# replace ab_any=0 if restart_antibiotic==0
# replace ab_any=0 if restart_antibiotic==.
# tab ab_any year, col chi m
# tab ab_any year,  chi 
# 
# *** Inconsistnet with death above ***
#   tab discharge year, col chi m
# tab discharge year, chi 
# 
# tab wound_care year, col chi m
# tab wound_care year,  chi 
# 
# tab pt_ot_rehab year, col chi m
# tab pt_ot_rehab year,  chi 
# 
# *** is . equal to 0 ***
#   tab ed_visit year, row col chi m
# replace ed_visit=0 if ed_visit==.
# tab ed_visit year, row col chi 
# bysort year: sum ed_visit, d
# kwallis ed_visit, by(year)
# 
# gen edrevisit=1
# replace edrevisit=0 if ed_visit==0
# tab edrevisit year, row col chi m
# 
# 
# tab readmission year, col chi m
# tab readmission year, chi 
# gen readmi=0
# replace readmi =1 if readmission=="Y"
# replace readmi =. if readmission==""
# tab readmi year, col m chi
# xi: logistic readmi year
# xi: logistic readmi year i.proclap age female bmi asa i.operation i.dg4gr 
# 
# 
# 
# tab pacu_temp year, row col chi m
# *histogram pacu_temp
# ttest pacu_temp, by(year)
# kwallis pacu_temp, by(year)
# 
# 
# tab foley_reinsertion_day year, row col chi m
# replace foley_reinsertion_day=. if foley_reinsertion_day==99
# tab foley_reinsertion_day year, row col chi m
# tab foley_reinsertion_day year, row col chi
# bysort year: sum foley_reinsertion_day, d
# ttest foley_reinsertion_day, by(year)
# kwallis  foley_reinsertion_day, by(year)
# 
# gen foley_once=0
# replace foley_once=1 if foley_reinsertion_day>0
# replace foley_once=. if foley_reinsertion_day==.
# tab foley_once year, row col chi m
# tab foley_once year, row col chi 
# xi: logistic foley_once year
# xi: logistic foley_once year i.proclap age female bmi asa i.operation i.dg4gr 
# 
# 
# replace ng_reinsertion_day="N" if ng_reinsertion_day==""
# gen ngreinsertion=0
# replace ngreinsertion=1 if ng_reinsertion_day=="Y"&year==0
# replace ngreinsertion=1 if ng_reinsertion_day=="N"&year==1
# 
# tab ngreinsertion year, row col chi m
# 
# 
# *** ????????????????? ***
#   tab electrolyt_replace year, row col chi m
# replace electrolyt_replace=. if electrolyt_replace==99
# tab electrolyt_replace year, row col chi m
# tab electrolyt_replace year, row col chi 
# 
# 
# 
# tab oral_intake year, row col chi m
# replace oral_intake=. if oral_intake==99
# tab oral_intake year, row col chi m
# bysort year: sum oral_intake, d
# kwallis oral_intake, by(year)
# histogram oral_intake
# 
# 
# predxcat ln_los, xvar(year) 
# predxcat ln_los, xvar(year) adjust (age female bmi asa op1 op2 op3 op4 op5 op6 dg1 dg2 dg3 dg4) model mean
# 
# 
# 
# 
# 
# 
# tab oral_liquid year, row col chi m
# replace oral_liquid =. if oral_liquid ==99
# tab oral_liquid year, row col chi m
# bysort year: sum oral_liquid, d
# kwallis oral_liquid, by(year)
# 
# tab first_solid year, row col chi m
# replace first_solid =. if first_solid ==99
# tab first_solid year, row col chi m
# bysort year: sum first_solid, d
# kwallis first_solid, by(year)
# 
# 
# tab first_flatus year, row col chi m
# replace first_flatus =. if first_flatus ==99
# tab first_flatus year, row col chi m
# bysort year: sum first_flatus, d
# kwallis first_flatus, by(year)
# 
# tab first_bm year, row col chi m
# replace first_bm =. if first_bm ==99
# tab first_bm year, row col chi m
# bysort year: sum first_bm, d
# kwallis first_bm, by(year)
# 
# tab first_po_meds year, row col chi m
# replace first_po_meds =. if first_po_meds ==99
# tab first_po_meds year, row col chi m
# bysort year: sum first_po_meds, d
# kwallis first_po_meds, by(year)
# 
# 
# 
# 
# ************************************************************************
#   *** TO PLAY *****
#   ************************************************************************
#   keep if year==1
# xi: logistic atleastonecompl i.datasetyear age female bmi asa op2groups i.dg4gr i.proclap i.epidural i.postop_fluid i.esoph_monitor i.out_of_bed_day1 i.ambul3groups foleytimely i.ng_removal_compliant i.intraabd_drain i.vt_proph_postop i.vt_proph_preop
# xi: logistic wound_infect i.datasetyear age female bmi asa op2groups i.dg4gr i.proclap i.epidural i.postop_fluid i.esoph_monitor i.out_of_bed_day1 i.ambul3groups foleytimely i.ng_removal_compliant i.intraabd_drain i.vt_proph_postop i.vt_proph_preop
# 
# 
# 
# xi: logistic atleastonecompl i.datasetyear age female bmi asa op2groups i.dg4gr i.proclap i.epidural_success i.postop_fluid i.esoph_monitor i.out_of_bed_day1 i.ambul3groups foleytimely i.ng_removal_compliant i.intraabd_drain i.vt_proph_postop i.vt_proph_preop
# xi: logistic wound_infect i.datasetyear age female bmi asa op2groups i.dg4gr i.proclap i.epidural_success i.postop_fluid i.esoph_monitor i.out_of_bed_day1 i.ambul3groups foleytimely i.ng_removal_compliant i.intraabd_drain i.vt_proph_postop i.vt_proph_preop
# 
# 
# 
# ************************************************************************
#   *** Compliance all *****
#   ************************************************************************
#   gen drink=.
# replace drink =1 if cho_drink=="Y"
# replace drink =0 if cho_drink=="N"|cho_drink==""
# tab drink, m
# 
# gen ab=.
# replace ab=1 if ab_prior=="Y"
# replace ab=0 if ab_prior=="N"|ab_prior==""
# tab ab
# 
# gen epi=.
# replace epi=1 if epidural_success==1
# replace epi=0 if epidural_success==0|epidural_success==.
# tab epi
# 
# gen vt=0
# replace vt=1 if vt_proph_preop=="Y"&vt_proph_postop=="Y"
# tab vt, m
# 
# gen fluid=0
# replace fluid=1 if postop_fluid=="Y"
# tab fluid, m
# 
# gen shower=0
# replace shower=1 if chlorhex_shower==1
# tab shower, m
# 
# gen esoph=0
# replace esoph=1 if esoph_monitor=="Y"
# tab esoph
# 
# gen nodrain=0
# replace nodrain=1 if intraabd_drain=="N"
# tab nodrain
# 
# gen mob=0
# replace mob=1 if out_of_bed_day1=="Y"
# tab mob
# 
# gen amb1=0
# replace amb1=1 if ambul_day<1
# 
# gen dk=0
# replace dk=1 if foleytimely==1
# tab dk
# 
# gen gtube=0
# replace gtube=1 if ng_removal_compliant==.
# 
# gen overallcompliance=.
# replace overallcompliance=drink+ab+epi+vt+fluid+shower+esoph+nodrain+mob+amb1+dk+gtube
# tab overallcompliance, m
# 
# 
# tab overallcompliance atleastonecompl, row chi m
# 
# xi: logistic atleastonecompl i.datasetyear age female bmi asa op2groups i.dg4gr i.proclap overallcompliance
# 
# 
# replace datasetyear=0 if datasetyear==2010
# replace datasetyear=1 if datasetyear==2011
# predxcat ln_los, xvar(overallcompliance) adjust (age female bmi asa op2groups dg1 dg2 dg3 dg4 laparoscopic) model mean

############################################################################################
#below is the original stata data management code - just for reference
############################################################################################

# clear
# clear matrix
# 
# version 11.2
# 
# set mem 3000m 
# 
# set more off
# 
# *insheet using "/Users/mathiasworni/Dropbox/Updates/ERAS/Data from Igor/merged_dataset_new_datapull_april.csv", comma
# *save "/Users/mathiasworni/Dropbox/Updates/ERAS/Merged Dataset/merged_dataset_new_datapull_april.dta", replace
# use "/Users/mathiasworni/Dropbox/Updates/ERAS/Merged Dataset/merged_dataset_new_datapull_april.dta", replace
# 
# tab datasetyear
# gen year=.
# replace year=0 if datasetyear==2009
# replace year=1 if datasetyear==2010|datasetyear==2011
# tab year, m
# 
# *** RENAMING ***
#   rename preopholdingq1 selffasttrack
# 
# *** RECODING ***
#   drop chlorhex_shower
# tab preopholdingq3
# tab preopholdingq4
# tab preopholdingq3 preopholdingq4
# gen chlorhex_shower=.
# replace chlorhex_shower=. if preopholdingq3=="9"|preopholdingq4=="9"
# replace chlorhex_shower=0 if preopholdingq3=="N"|preopholdingq4=="N"
# replace chlorhex_shower=1 if preopholdingq3=="Y"|preopholdingq4=="Y"
# tab chlorhex_shower, m
# 
# *** SURGERY ***
#   gen operation=.
# 
# replace operation=8 if cpt_code_1== 43279
# replace operation=8 if cpt_code_2== 43279
# replace operation=8 if cpt_code_3== 43279
# replace operation=8 if cpt_code_4== 43279
# replace operation=8 if cpt_code_5== 43279
# replace operation=8 if cpt_code_6== 43279
# 
# replace operation=7 if cpt_code_1== 44120|cpt_code_1== 44202
# replace operation=7 if cpt_code_2== 44120|cpt_code_2== 44202
# replace operation=7 if cpt_code_3== 44120|cpt_code_3== 44202
# replace operation=7 if cpt_code_4== 44120|cpt_code_4== 44202
# replace operation=7 if cpt_code_5== 44120|cpt_code_5== 44202
# replace operation=7 if cpt_code_6== 44120|cpt_code_6== 44202
# 
# replace operation=6 if cpt_code_1== 49585|cpt_code_1==49652|cpt_code_1==49562|cpt_code_1==49565|cpt_code_1==49654
# replace operation=6 if cpt_code_2== 49585|cpt_code_2==49652|cpt_code_2== 49562|cpt_code_2== 49565|cpt_code_2== 49654
# replace operation=6 if cpt_code_3== 49585|cpt_code_3==49652|cpt_code_3== 49562|cpt_code_3== 49565|cpt_code_3== 49654
# replace operation=6 if cpt_code_4== 49585|cpt_code_4==49652|cpt_code_4== 49562|cpt_code_4== 49565|cpt_code_4== 49654
# replace operation=6 if cpt_code_5== 49585|cpt_code_5==49652|cpt_code_5== 49562|cpt_code_5== 49565|cpt_code_5== 49654
# replace operation=6 if cpt_code_6== 49585|cpt_code_6==49652|cpt_code_6== 49562|cpt_code_6== 49565|cpt_code_6== 49654
# 
# replace operation=5 if cpt_code_1== 44346|cpt_code_1== 44310|cpt_code_1== 44188|cpt_code_1== 44345|cpt_code_1== 44626|cpt_code_1== 44640|cpt_code_1== 44320|cpt_code_1== 44620  
# replace operation=5 if cpt_code_2== 44346|cpt_code_2== 44310|cpt_code_2== 44188|cpt_code_2== 44345|cpt_code_2== 44626|cpt_code_2== 44640|cpt_code_2== 44320|cpt_code_2== 44620 
# replace operation=5 if cpt_code_3== 44346|cpt_code_3== 44310|cpt_code_3== 44188|cpt_code_3== 44345|cpt_code_3== 44626|cpt_code_3== 44640|cpt_code_3== 44320|cpt_code_3== 44620 
# replace operation=5 if cpt_code_4== 44346|cpt_code_4== 44310|cpt_code_4== 44188|cpt_code_4== 44345|cpt_code_4== 44626|cpt_code_4== 44640|cpt_code_4== 44320|cpt_code_4== 44620 
# replace operation=5 if cpt_code_5== 44346|cpt_code_5== 44310|cpt_code_5== 44188|cpt_code_5== 44345|cpt_code_5== 44626|cpt_code_5== 44640|cpt_code_5== 44320|cpt_code_5== 44620 
# replace operation=5 if cpt_code_6== 44346|cpt_code_6== 44310|cpt_code_6== 44188|cpt_code_6== 44345|cpt_code_6== 44626|cpt_code_6== 44640|cpt_code_6== 44320|cpt_code_6== 44620 
# 
# 
# 
# replace operation=0 if cpt_code_1==44140| cpt_code_1==44141|cpt_code_1==44143|cpt_code_1==44144|cpt_code_1==44145|cpt_code_1==44147|cpt_code_1==44204|cpt_code_1== 44205|cpt_code_1== 44206|cpt_code_1== 44207|cpt_code_1== 44208|cpt_code_1== 44160|cpt_code_1==44205|cpt_code_1== 45550|cpt_code_1== 45402 
# replace operation=0 if cpt_code_2==44140| cpt_code_2 ==44141| cpt_code_2 ==44143| cpt_code_2 ==44144| cpt_code_2 ==44145| cpt_code_2 ==44147| cpt_code_2 ==44204| cpt_code_2 == 44205| cpt_code_2 == 44206| cpt_code_2 == 44207| cpt_code_2 == 44208| cpt_code_2 == 44160| cpt_code_2 ==44205| cpt_code_2 == 45550| cpt_code_2 == 45402 
# replace operation=0 if cpt_code_3==44140| cpt_code_3 ==44141| cpt_code_3 ==44143| cpt_code_3 ==44144| cpt_code_3 ==44145| cpt_code_3 ==44147| cpt_code_3 ==44204| cpt_code_3 == 44205| cpt_code_3 == 44206| cpt_code_3 == 44207| cpt_code_3 == 44208| cpt_code_3 == 44160| cpt_code_3 ==44205| cpt_code_3 == 45550| cpt_code_3 == 45402 
# replace operation=0 if cpt_code_4==44140| cpt_code_4 ==44141| cpt_code_4 ==44143| cpt_code_4 ==44144| cpt_code_4 ==44145| cpt_code_4 ==44147| cpt_code_4 ==44204| cpt_code_4 == 44205| cpt_code_4 == 44206| cpt_code_4 == 44207| cpt_code_4 == 44208| cpt_code_4 == 44160| cpt_code_4 ==44205| cpt_code_4 == 45550| cpt_code_4 == 45402 
# replace operation=0 if cpt_code_5==44140| cpt_code_5 ==44141| cpt_code_5 ==44143| cpt_code_5 ==44144| cpt_code_5 ==44145| cpt_code_5 ==44147| cpt_code_5 ==44204| cpt_code_5 == 44205| cpt_code_5 == 44206| cpt_code_5 == 44207| cpt_code_5 == 44208| cpt_code_5 == 44160| cpt_code_5 ==44205| cpt_code_5 == 45550| cpt_code_5 == 45402 
# replace operation=0 if cpt_code_6==44140| cpt_code_6 ==44141| cpt_code_6 ==44143| cpt_code_6 ==44144| cpt_code_6 ==44145| cpt_code_6 ==44147| cpt_code_6 ==44204| cpt_code_6 == 44205| cpt_code_6 == 44206| cpt_code_6 == 44207| cpt_code_6 == 44208| cpt_code_6 == 44160| cpt_code_6 ==44205| cpt_code_6 == 45550| cpt_code_6 == 45402 
# 
# replace operation=1 if cpt_code_1==44150 |cpt_code_1== 44210 |cpt_code_1==44158
# replace operation=1 if cpt_code_2==44150 |cpt_code_2== 44210 |cpt_code_2==44158
# replace operation=1 if cpt_code_3==44150 |cpt_code_3== 44210 |cpt_code_3==44158
# replace operation=1 if cpt_code_4==44150 |cpt_code_4== 44210 |cpt_code_4==44158
# replace operation=1 if cpt_code_5==44150 |cpt_code_5== 44210 |cpt_code_5==44158
# replace operation=1 if cpt_code_6==44150 |cpt_code_6== 44210 |cpt_code_6==44158
# 
# replace operation=3 if cpt_code_1== 45126 
# replace operation=3 if cpt_code_2== 45126 
# replace operation=3 if cpt_code_3== 45126 
# replace operation=3 if cpt_code_4== 45126 
# replace operation=3 if cpt_code_5== 45126 
# replace operation=3 if cpt_code_6== 45126 
# 
# replace operation=2 if cpt_code_1== 45110 |cpt_code_1== 45111 |cpt_code_1== 45112 |cpt_code_1== 45113 |cpt_code_1== 45114 |cpt_code_1== 45116 |cpt_code_1== 45119 |cpt_code_1== 45395 |cpt_code_1== 45397  |cpt_code_1== 45136  |cpt_code_1== 44146|cpt_code_1== 45120
# replace operation=2 if cpt_code_2== 45110 | cpt_code_2 == 45111 | cpt_code_2 == 45112 | cpt_code_2 == 45113 | cpt_code_2 == 45114 | cpt_code_2 == 45116 | cpt_code_2 == 45119 | cpt_code_2 == 45395 | cpt_code_2 == 45397 |cpt_code_2== 45136 |cpt_code_2== 44146|cpt_code_2== 45120
# replace operation=2 if cpt_code_3== 45110 | cpt_code_3 == 45111 | cpt_code_3 == 45112 | cpt_code_3 == 45113 | cpt_code_3 == 45114 | cpt_code_3 == 45116 | cpt_code_3 == 45119 | cpt_code_3 == 45395 | cpt_code_3 == 45397 |cpt_code_3== 45136 |cpt_code_3== 44146|cpt_code_3== 45120
# replace operation=2 if cpt_code_4== 45110 | cpt_code_4 == 45111 | cpt_code_4 == 45112 | cpt_code_4 == 45113 | cpt_code_4 == 45114 | cpt_code_4 == 45116 | cpt_code_4 == 45119 | cpt_code_4 == 45395 | cpt_code_4 == 45397 |cpt_code_4== 45136 |cpt_code_4== 44146|cpt_code_4== 45120
# replace operation=2 if cpt_code_5== 45110 | cpt_code_5 == 45111 | cpt_code_5 == 45112 | cpt_code_5 == 45113 | cpt_code_5 == 45114 | cpt_code_5 == 45116 | cpt_code_5 == 45119 | cpt_code_5 == 45395 | cpt_code_5 == 45397 |cpt_code_5== 45136 |cpt_code_5== 44146|cpt_code_5== 45120
# replace operation=2 if cpt_code_6== 45110 | cpt_code_6 == 45111 | cpt_code_6 == 45112 | cpt_code_6 == 45113 | cpt_code_6 == 45114 | cpt_code_6 == 45116 | cpt_code_6 == 45119 | cpt_code_6 == 45395 | cpt_code_6 == 45397 |cpt_code_6== 45136 |cpt_code_6== 44146|cpt_code_6== 45120
# 
# replace operation=4 if cpt_code_1== 44155 |cpt_code_1== 44212 |cpt_code_1== 44157 |cpt_code_1== 44211
# replace operation=4 if cpt_code_2== 44155 |cpt_code_2== 44212 |cpt_code_2== 44157 |cpt_code_2== 44211
# replace operation=4 if cpt_code_3== 44155 |cpt_code_3== 44212 |cpt_code_3== 44157 |cpt_code_3== 44211
# replace operation=4 if cpt_code_4== 44155 |cpt_code_4== 44212 |cpt_code_4== 44157 |cpt_code_4== 44211
# replace operation=4 if cpt_code_5== 44155 |cpt_code_5== 44212 |cpt_code_5== 44157 |cpt_code_5== 44211
# replace operation=4 if cpt_code_6== 44155 |cpt_code_6== 44212 |cpt_code_6== 44157 |cpt_code_6== 44211 
# 
# lab def aa 0 "right, trans, left, sigmoid" 1 "total abd col" 2 "rectal res" 3 "APR" 4 "Proctocol" 5 "stomal revision/creation/closure" 6 "hernia revision w/o mentioning of stoma" 7 "small bowel surg" 8 "esophagus surg"
# lab val operation aa
# tab operation year , col m
# tab operation year , col chi
# 
# 
# gen op2groups=.
# replace op2groups=0 if operation==0|operation==1|operation==5
# replace op2groups=1 if operation==2|operation==3|operation==4
# lab def aff 0 "colon/other" 1 "including rectum"
# lab val op2groups aff
# tab operation op2groups, m
# 
# ***********************************
#   *** DROP IF NOT COLON OR STOMA ****
#   ***********************************
#   tab operation
# keep if operation==0|operation==1|operation==2|operation==3|operation==4|operation==5
# tab operation year, row col chi m
# 
# 
# *** Laparoscopic / open surgery ***
#   gen lap=0
# replace lap =1 if cpt_code_1==44212| cpt_code_1==44211|cpt_code_1==45395|cpt_code_1==45397|cpt_code_1==44210|cpt_code_1==44204|cpt_code_1==44205|cpt_code_1== 44206|cpt_code_1== 44207|cpt_code_1== 44208|cpt_code_1== 45402
# replace lap =1 if cpt_code_2==44212| cpt_code_2==44211|cpt_code_2==45395|cpt_code_2==45397|cpt_code_2==44210|cpt_code_2==44204|cpt_code_2==44205|cpt_code_2== 44206|cpt_code_2== 44207|cpt_code_2== 44208|cpt_code_2== 45402
# replace lap =1 if cpt_code_3==44212| cpt_code_3==44211|cpt_code_3==45395|cpt_code_3==45397|cpt_code_3==44210|cpt_code_3==44204|cpt_code_3==44205|cpt_code_3== 44206|cpt_code_3== 44207|cpt_code_3== 44208|cpt_code_3== 45402
# replace lap =1 if cpt_code_4==44212| cpt_code_4==44211|cpt_code_4==45395|cpt_code_4==45397|cpt_code_4==44210|cpt_code_4==44204|cpt_code_4==44205|cpt_code_4== 44206|cpt_code_4== 44207|cpt_code_4== 44208|cpt_code_4== 45402
# replace lap =1 if cpt_code_5==44212| cpt_code_5==44211|cpt_code_5==45395|cpt_code_5==45397|cpt_code_5==44210|cpt_code_5==44204|cpt_code_5==44205|cpt_code_5== 44206|cpt_code_5== 44207|cpt_code_5== 44208|cpt_code_5== 45402
# replace lap =1 if cpt_code_6==44212| cpt_code_6==44211|cpt_code_6==45395|cpt_code_6==45397|cpt_code_6==44210|cpt_code_6==44204|cpt_code_6==44205|cpt_code_6== 44206|cpt_code_6== 44207|cpt_code_6== 44208|cpt_code_6== 45402
# lab def lu 0 "open" 1 "lap"
# lab val lap lu
# tab lap year, col m chi
# 
# *** DIAGNOSIS ***
#   gen diag=.
# replace diag=0 if icd9=="211.3"|icd9=="211.4"|icd9=="153.0"|icd9=="153.1" |icd9== "153.10" |icd9== "153.2"|icd9== "153.3"|icd9== "153.4"|icd9== "153.5"|icd9== "153.6"|icd9== "153.66"|icd9== "153.7"|icd9== "153.9"|icd9== "154.0" |icd9== "154.00"|icd9== "154.1"|icd9== "154.10"|icd9== "154.2"|icd9== "154.3"|icd9== "154.9"
# replace diag=0 if icd9=="152.2"|icd9=="158.9"|icd9=="183.0"|icd9=="184.4"|icd9=="189.0"|icd9=="189.9"|icd9=="195.3"|icd9=="235.2"|icd9=="238.9"|icd9=="569.0"|icd9=="195.3MI"|icd9=="200.3"
# replace diag=1 if icd9=="555.1"|icd9=="555.9"|icd9=="556.0"|icd9== "556.6" |icd9== "556.9" 
# replace diag=1 if icd9=="555.0"|icd9=="555.2"|icd9=="556.8"|icd9=="V10.06"|icd9=="555.3"|icd9=="555.7"
# replace diag=2 if icd9=="562.1"|icd9=="562.10" |icd9== "562.11"|icd9== "562.12" |icd9== "562.13" 
# replace diag=3 if icd9=="553.1"|icd9=="552.1"|icd9=="553.2"|icd9=="553.20"|icd9=="553.21"|icd9=="553.41"|icd9=="553.6"
# replace diag=4 if icd9=="152.30"
# replace diag=5 if icd9=="530.0"
# replace diag=6 if icd9=="557.0"|icd9=="557.9"
# replace diag=7 if icd9=="560.2"|icd9=="560.81"|icd9=="560.81"|icd9=="560.9"|icd9=="564.00"
# replace diag=8 if icd9=="569.1"|icd9=="569.0"|icd9=="569.41"|icd9=="569.49"|icd9=="211.03"|icd9=="787.60"
# replace diag=9 if icd9=="569.62"|icd9=="569.69"|icd9=="V44.3"
# replace diag=10 if icd9=="569.81"|icd9=="569.82"|icd9=="596.1"|icd9=="619.1"|icd9=="569.8"
# replace diag=11 if icd9=="598.2"|icd9=="599.1"|icd9=="618.4"
# replace diag=12 if icd9=="078.11"|icd9=="707.03"
# 
# lab def bb 0 "neoplastic" 1 "IBD" 2 "diverticular/other" 3 "hernia" 4 "Meckel" 5 "achalasia" 6 "vascular disease" 7 "volvulus/ileus" 8 "bening rectal/colon polyp" 9 "stoma complication" 10 "fistula, ulcer" 11 "urethral/OBGYN disease" 12 "condyloma ac/skin disease"
# lab val diag bb
# tab diag year, col chi m
# tab diag year, col chi 
# 
# gen difinal=3
# replace difinal=0 if diag==0
# replace difinal=1 if diag==1
# replace difinal=2 if diag==2
# lab def dddd 0 "neoplastic" 1 "IBD" 2 "diverticular/other" 3 "other"
# lab val difinal dddd
# tab difinal year, col chi m

# gen female=0
# replace female=1 if gender=="F"



#######################################################################################
#ERAS.R is licensed under a Creative Commons Attribution - Non commercial 3.0 Unported License. You are free: to Share — to copy, distribute and transmit the work to Remix — to adapt the work, under the following conditions: Attribution — You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). Noncommercial — You may not use this work for commercial purposes. With the understanding that: Waiver — Any of the above conditions can be waived if you get permission from the copyright holder. Public Domain — Where the work or any of its elements is in the public domain under applicable law, that status is in no way affected by the license. Other Rights — In no way are any of the following rights affected by the license: Your fair dealing or fair use rights, or other applicable copyright exceptions and limitations; The author's moral rights; Rights other persons may have either in the work itself or in how the work is used, such as publicity or privacy rights. Notice — For any reuse or distribution, you must make clear to others the license terms of this work. The best way to do this is with a link to this web page. For more details see http://creativecommons.org/licenses/by-nc/3.0/
#######################################################################################
