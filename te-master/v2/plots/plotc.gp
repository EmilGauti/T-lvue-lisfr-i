set encoding utf8
set terminal epslatex color size 16cm,12cm
set out "saetnic.tex"
#unset key

set xlabel "\\(t\\)"
set ylabel "\\(\\rho_{ii}\\)"
set yrange [0:1]
plot for [i=0:9] "../c/occ.dat" every 10::i using 1:3 w l title sprintf("%d", i)
