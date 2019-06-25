requires("1.42p");
run("M51 Galaxy (177K, 16-bits)");
methods = getList("threshold.methods");
title = getTitle;
for (i=0; i<methods.length; i++) {
   showProgress(i, methods.length);
   showStatus((i+1)+"/"+methods.length+": "+methods[i]);
   print(methods[i]);
   setAutoThreshold(methods[i]+" dark");
   getThreshold(lower, upper);
   rename(methods[i]+": "+lower+"-"+upper);
   wait(2000);
}
rename(title);