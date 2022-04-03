* Encoding: UTF-8.


***TABLE 1

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=Age_rec1 Sex_rec Nat_rec HTN_yn COPD_yn Card_vasc_yn DM_yn Cancer_yn CKD_yn 
    CLD_yn Stroke_yn autoimmune_dis_yn Comorbidity_sum_rec Vaccination_Status Infection_status BA_type 
    DISPLAY=LABEL
  /TABLE Age_rec1 + Sex_rec + Nat_rec + HTN_yn + COPD_yn + Card_vasc_yn + DM_yn + Cancer_yn + CKD_yn 
    + CLD_yn + Stroke_yn + autoimmune_dis_yn + Comorbidity_sum_rec + Vaccination_Status + Infection_status BY BA_type [COUNT F40.0, 
    COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=Age_rec1 Sex_rec Nat_rec HTN_yn COPD_yn Card_vasc_yn DM_yn Cancer_yn CKD_yn 
    CLD_yn Stroke_yn autoimmune_dis_yn Comorbidity_sum_rec Vaccination_Status Infection_status BA_type ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

EXAMINE VARIABLES=ageyearscurrent BY BA_type
  /PLOT NONE
  /PERCENTILES(5,10,25,50,75,90,95) HAVERAGE
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*Nonparametric Tests: Independent Samples. 
NPTESTS 
  /INDEPENDENT TEST (ageyearscurrent) GROUP (BA_type) MANN_WHITNEY 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE
  /CRITERIA ALPHA=0.05  CILEVEL=95.

CROSSTABS
  /TABLES=Age_rec1 Sex_rec Nat_rec HTN_yn COPD_yn Card_vasc_yn DM_yn Cancer_yn CKD_yn 
    CLD_yn Stroke_yn autoimmune_dis_yn Comorbidity_sum_rec Vaccination_Status Infection_status BY BA_type
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.


***TABLE 2
      
  CROSSTABS
  /TABLES=Dis_sev_rec Any_outcome BY BA_type
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).




***TABLE 3

SORT CASES  BY Inf_status_rec.
SPLIT FILE LAYERED BY Inf_status_rec.

CROSSTABS
  /TABLES=Dis_sev_rec BY BA_type
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).

CROSSTABS
  /TABLES=Any_outcome BY BA_type
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL
  /METHOD=EXACT TIMER(5).

SPLIT FILE OFF.


***TABLE 4
    
    
LOGISTIC REGRESSION VARIABLES Any_outcome
  /METHOD=ENTER BA_type Vacc_stat2 PriorInfection Age_rec1 Sex_rec Nat_rec Comorbidity_sum_rec 
  /CONTRAST (BA_type)=Indicator(1)
  /CONTRAST (Vacc_stat2)=Indicator(1)
    /CONTRAST (PriorInfection)=Indicator(1)
  /CONTRAST (Age_rec1)=Indicator(1)
  /CONTRAST (Sex_rec)=Indicator(1)
  /CONTRAST (Nat_rec)=Indicator(1)
  /CONTRAST (Comorbidity_sum_rec)=Indicator(1)
  /PRINT=CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).
    


************************************************************************************************************
************************************************************************************************************
************************************************************************************************************
************************************************************************************************************
************************************************************************************************************
************************************************************************************************************
************************************************************************************************************


