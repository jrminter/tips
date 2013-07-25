#!/bin/bash
cd ~/git/tips/scripts
R CMD BATCH  ./knit-them-all.R

rm -rf *.Rout
rm -rf *.RData
rm -rf tab.tex
