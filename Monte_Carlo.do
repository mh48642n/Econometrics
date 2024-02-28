clear all
set more off

cd "C:\Users\marvi\OneDrive\Documents\GitHub\Econometrics"

*Creates 10,000 empty rows of data
set obs 10000

*this creates the error term
*rnormal
gen u = rnormal()*10
summarize u

gen x = runiform()*20 + 10 
gen y = 2 + 3*x + u

hist x
hist u

*Test that real value of B1 is 2
*Monte Carlo Simulation

program define lnsim, rclass
		version 11.2
		/*Gives the program a variable that it needs to run*/
		syntax[, obs(integer 1)]
		drop _all
		/*sets the number observations by the number we tell Stata*/
		set obs `obs'
		
		/*This creates temperay variables*/
		tempvar x u y
		gen `u' = rnormal()*10
		gen `x' = runiform()*20 + 10 
		gen `y' = 2 + 3*x + u
		
		reg `y' `x'
		return scalar b1 = _b[`x']
		return scalar b0 = _b[_cons]
	end

simulate b1 = r(b1), reps(1000): lnsim, obs(1000)
	
	
