set terminal epslatex color size 16cm,10cm
set output 'decomp3.tex'
unset key
set title "\\(C^2\\) sem fall af \\(n\\)" 
set title  font ",20" norotate
set xr[0:40]
set yr[0:0.15]
set xtics 0,2,40
set xlabel '\\(n\\)'
set ylabel '\\(|c_n|^2\\)'
plot '../b/eigvect.dat' every :::9::9 using 2:(($3)**2) w impulse lw 3
