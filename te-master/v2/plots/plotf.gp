set encoding utf8
set terminal epslatex color size 16cm,12cm
set out "meanE.tex"

set xlabel "\\(t\\)"
set ylabel "\\(\\langle E\\rangle\\)"
unset title
unset key
plot "../f/trace.dat" using 1:2 w l
