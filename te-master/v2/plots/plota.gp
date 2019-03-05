set encoding utf8
set terminal epslatex color size 16cm,12cm
set out "saetni.tex"
#unset key

set xlabel "\\(\\t\\)"
set ylabel "\\(\\rho_{ii}\\)"
set yrange [0:1]
#plot for [i=1:10] "../a/occ.dat" using 1:3 every 10 w l
plot for [i=0:9] "../a/occ.dat" every 10::i using 1:3 w l title sprintf("%d", i)
#plot "../a/occ.dat" every 10::1 using 1:3 w l lw 3
