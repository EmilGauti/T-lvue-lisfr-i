set terminal epslatex color size 16cm,10cm
set output 'decomp2.tex'
unset key
set title "\\(|C_n|^2\\) sem fall af \\(n\\)" 
set title  font ",20" norotate
set xr[0:23]
set yr[0:0.3]
set xtics 1, 2, 23
set xlabel '\\(n\\)'
set ylabel '\\(|c_n||^2\\)'
plot '../b/eigvect.dat' every :::4::4 using 2:(($3)**2) w impulse lw 3
