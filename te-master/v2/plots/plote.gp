set encoding utf8
set terminal epslatex color size 16cm,12cm
set out "entropy.tex"
unset key
unset title

set xlabel "\\(t\\)"
set ylabel "\\(S\\)"
#set yrange [0:1]
plot "../e/trace.dat" using 1:2 w l 
