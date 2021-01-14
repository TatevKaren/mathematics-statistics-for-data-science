import excel "/Users/tatev/Downloads/data.xlsx", sheet("Request file") firstrow

**************************************************************************************************
*generating company id
**************************************************************************************************

gen id = _n
sort Firm_id
by Firm_id: gen company_id = 1 if _n == 1 
replace company_id = sum(company_id)
replace company_id = . if missing(Firm_id)
drop if date ==.

**************************************************************************************************
* making the window to [-100, 100]
**************************************************************************************************
gen daily_window_start = dofd(window_start)
gen daily_window_end = dofd(window_end)

gen window_start_100 = daily_window_start + 150
gen window_end_100 = daily_window_end - 150

format daily_window_start daily_window_end window_start_100 window_end_100 %td

**************************************************************************************************
* we need to make sure that only observations in between the the right window time period are used
**************************************************************************************************
keep if ((date > window_start) & (date < window_end))
keep if company_id == 2
gen time = _n
tsset time

**************************************************************************************************
*per firm we wanna run OLS to detrmine gamma_i for only single company e.g. company 1
**************************************************************************************************
reg Firm_return Market_Return event_date if company_id == 2

**************************************************************************************************
*we can use stata's for loop type of approach to do this for all 45 companies
**************************************************************************************************

forvalues i = 2/45{
regress Firm_return Market_Return event_date if company_id == `i' 

}
 
**************************************************************************************************
*what are the firm_ids(string from original data) corresponding to the integers in company_id
**************************************************************************************************
bysort company_id: tab Firm_id

**************************************************************************************************
*Garch(1,1) 1 garch 1 arch model
**************************************************************************************************
* we need the previous residuals and previous error terms from the first equations

clear all
import excel "/Users/tatev/Downloads/DATA_LONGWINDOWFINAL.xlsx", sheet("Window-250,250") firstrow clear
gen id = _n
sort Firm_id
by Firm_id: gen company_id = 1 if _n == 1 
replace company_id = sum(company_id)
replace company_id = . if missing(Firm_id)
drop if date ==.
keep if ((date > window_start) & (date < window_end))

keep if company_id == `i' 

gen time = _n
tsset time

reg Firm_return Market_Return event_date 
*creating residuals
predict resid, residuals
*variance model using 
arch resid event_date , arch(1/1) garch(1/1)

**************************************************************************************************
*Obtaining test statistics
**************************************************************************************************
*number of unique companies in our simple
gen n =_N
gen test1_gamma_numerator = sum(gamma_i/n)


**************************************************************************************************
*We need the residuals at time period 0 for each company for calculating adjusted test statistics
**************************************************************************************************
clear all
import excel "/Users/tatev/Downloads/DATA_LONGWINDOWFINAL.xlsx", sheet("Window-250,250") firstrow clear

gen id = _n
sort Firm_id
by Firm_id: gen company_id = 1 if _n == 1 
replace company_id = sum(company_id)
replace company_id = . if missing(Firm_id)
drop if date ==.
keep if ((date > window_start) & (date < window_end))

keep if Firm_id == "24MYL" 

gen time = _n
tsset time

reg Firm_return Market_Return event_date 
*creating residuals
predict resid, residuals
tabulate resid if  event_date == 1
tabulate Firm_id




















