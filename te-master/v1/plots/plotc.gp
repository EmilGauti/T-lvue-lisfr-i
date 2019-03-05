set encoding utf8
set terminal epslatex color size 16cm,10cm
set out "spectrumc.tex"
unset key

set xlabel "\\(\\lambda\\)"
set ylabel "\\(E_n/\\hbar\\omega\\)"
set yrange [0:8]
set xrange [0:20]
plot "../c/eigval.dat" using ($1 - 1):2 w l, \
  x + 0.5
