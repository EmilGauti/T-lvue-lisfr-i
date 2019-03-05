set encoding utf8
set terminal epslatex color size 16cm,12cm
set out "dmeanx.tex"
unset key
unset title

set xlabel "\\(t\\)"
set ylabel "\\(\\langle x\\rangle\\)"
#plot for [i=1:10] "../a/occ.dat" using 1:3 every 10 w l
plot "../d/xdensity.dat" using 1:2 w l
#plot "../a/occ.dat" every 10::1 using 1:3 w l lw 3
