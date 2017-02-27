
# Size of knapsack
param con;


# Items: index, size, profit
set ONE, dimen 5;
set TWO, dimen 5;
set THREE, dimen 5;
set FOUR, dimen 5;
set FIVE, dimen 5;
set SIX, dimen 5;
set SEVEN, dimen 5;
set Z, dimen 1;

table data IN "CSV" "pitchers.csv":
	ONE <- [Rank,Weight,Profit,Name,Team];

table data IN "CSV" "catchers.csv":
	TWO <- [Rank,Weight,Profit,Name,Team];

table data IN "CSV" "1B.csv":
	THREE <- [Rank,Weight,Profit,Name,Team];

table data IN "CSV" "2B.csv":
	FOUR <- [Rank,Weight,Profit,Name,Team];

table data IN "CSV" "3B.csv":
	FIVE <- [Rank,Weight,Profit,Name,Team];

table data IN "CSV" "SS.csv":
	SIX <- [Rank,Weight,Profit,Name,Team];

table data IN "CSV" "OF.csv":
	SEVEN <- [Rank,Weight,Profit,Name,Team];

table data IN "CSV" "Set.csv":
	Z <- [Team];

# Indices
set J := setof{(i,s,p,w,t) in ONE} i;
set I := setof{(i,s,p,w,t) in TWO} i;
set K := setof{(i,s,p,w,t) in THREE} i;
set L := setof{(i,s,p,w,t) in FOUR} i;
set M := setof{(i,s,p,w,t) in FIVE} i;
set N := setof{(i,s,p,w,t) in SIX} i;
set O := setof{(i,s,p,w,t) in SEVEN} i;




# Assignment
var a{J}, binary;
var b{I}, binary;
var c{K}, binary;
var d{L}, binary;
var e{M}, binary;
var f{N}, binary;
var g{O}, binary;


maximize obj :
  sum{(i,s,p,w,t) in ONE} p*a[i] + sum{(i,s,p,w,t) in TWO} p*b[i] + sum{(i,s,p,w,t) in THREE} p*c[i] + sum{(i,s,p,w,t) in FOUR} p*d[i] + sum{(i,s,p,w,t) in FIVE} p*e[i] + sum{(i,s,p,w,t) in SIX} p*f[i] + sum{(i,s,p,w,t) in SEVEN} p*g[i];

s.t. size :
 sum{(i,s,p,w,t) in ONE} s*a[i] + sum{(i,s,p,w,t) in TWO} s*b[i] + sum{(i,s,p,w,t) in THREE} s*c[i] + sum{(i,s,p,w,t) in FOUR} s*d[i] + sum{(i,s,p,w,t) in FIVE} s*e[i] + sum{(i,s,p,w,t) in SIX} s*f[i] + sum{(i,s,p,w,t) in SEVEN} s*g[i] <= con;

s.t. number :
 sum{(i,s,p,w,t) in ONE} a[i] = 1;

s.t. number2 :
 sum{(i,s,p,w,t) in TWO} b[i] = 1;

s.t. number3 :
 sum{(i,s,p,w,t) in THREE} c[i] = 1;

s.t. number4 :
 sum{(i,s,p,w,t) in FOUR} d[i] = 1;

s.t. number5 :
 sum{(i,s,p,w,t) in FIVE} e[i] = 1;

s.t. number6 :
 sum{(i,s,p,w,t) in SIX} f[i] = 1;

s.t. number7 :
 sum{(i,s,p,w,t) in SEVEN} g[i] = 3;

s.t. number8 {z in Z}:
 sum{(i,s,p,w,t) in ONE} (if z = t then a[i] else 0*a[i]) + sum{(i,s,p,w,t) in TWO} (if z = t then b[i] else 0*b[i])  + sum{(i,s,p,w,t) in THREE} (if z = t then c[i] else 0*c[i])  + sum{(i,s,p,w,t) in FOUR} (if z = t then d[i] else 0*d[i])  + sum{(i,s,p,w,t) in FIVE} (if z = t then e[i] else 0*e[i])  + sum{(i,s,p,w,t) in SIX} (if z = t then f[i] else 0*f[i])  + sum{(i,s,p,w,t) in SEVEN} (if z = t then g[i] else 0*g[i])  <=9;

solve;

printf "The knapsack contains:\n";
printf "Pitcher:\n";
printf {(i,s,p,w,t) in ONE: a[i] == 1} " %s %s\n", w,t;
printf "Catcher:\n";
printf {(i,s,p,w,t) in TWO: b[i] == 1} " %s %s\n", w,t;
printf "First Base:\n";
printf {(i,s,p,w,t) in THREE: c[i] == 1} " %s %s\n", w,t;
printf "Second Base:\n";
printf {(i,s,p,w,t) in FOUR: d[i] == 1} " %s %s\n", w,t;
printf "Third Base:\n";
printf {(i,s,p,w,t) in FIVE: e[i] == 1} " %s %s\n", w,t;
printf "Short Stop:\n";
printf {(i,s,p,w,t) in SIX: f[i] == 1} " %s %s\n", w,t;
printf "Outfield:\n";
printf {(i,s,p,w,t) in SEVEN: g[i] == 1} " %s %s\n", w,t;



data;

# Size of the knapsack
param con := 35000;
 

end;

