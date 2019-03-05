set encoding utf8
set terminal epslatex color size 16cm,10cm
set out "spectrum.tex"
unset key

set xlabel "\\(\\lambda\\)"
set ylabel "\\(E_n/\\hbar\\omega)"
set yrange [0:8]
plot for [i=0:5] "../a/eigval.dat" using ($2*0.01):3 every 6::i w l 
