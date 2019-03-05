set terminal epslatex color size 16cm,10cm
set output 'decomp1.tex'
set title "\\(|C_n|^2\\) sem fall af \\(n\\)" 
set xr[0:10]
set yr[0:1]
set xtics 5
set ytics add (0.943)
set xtics add (1,3)
set xlabel '\\(n\\)'
set ylabel '\\(|c_n|^2\\)'
unset key
plot '../b/eigvect.dat' every :::0::0 using 2:($3**2) w impulse lw 3
