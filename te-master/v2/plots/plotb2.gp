set encoding utf8
set terminal epslatex color size 16cm,12cm
set out "meanx2.tex"
#unset key

set xlabel "\\(t\\)"
set ylabel "\\(\\langle x^2\\rangle\\)"
#plot for [i=1:10] "../a/occ.dat" using 1:3 every 10 w l
unset key 
unset title
plot "../b/x2density.dat" using 1:2 w l
#plot "../a/occ.dat" every 10::1 using 1:3 w l lw 3
