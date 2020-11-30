/* Reading in Data and Renaming Variables */
proc import out=happy_data (rename= GDP_per_capita=economy rename=Social_support=family rename=Healthy_life_expectancy=health rename=Freedom_to_make_life_choices=freedom rename=Perceptions_of_corruption=trust)
datafile="C:\Users\017035809\Desktop\2019.csv"
dbms=csv replace;
run;

/* Normality Check */
proc univariate;
 var Score;
  histogram/normal;
run;

/*Fitting then general linear model*/
proc genmod;
 model Score = economy family health freedom trust generosity / dist=normal link=identity;
run;

/* Intercept Only Model */
proc genmod;
 model Score = / dist=normal link=identity;
run;

/* Deviance Test */
data deviance_test;
 deviance=-2*(-237.5708-(-119.7648));
 p=1-probchi(deviance,6);
run;
proc print noobs;
run;
