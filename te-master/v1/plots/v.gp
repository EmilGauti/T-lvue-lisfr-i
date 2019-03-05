set terminal epslatex color size 16cm,10cm
set out 'v.tex'
set ylabel '\\(V(x)\\)'
set xlabel '\\(x\\)'
unset key 
plot x*tanh(x)
