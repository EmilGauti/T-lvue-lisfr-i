set encoding utf8
set terminal epslatex color size 16cm,10cm
set out "agrunnar.tex"
#unset key

set xlabel "\\(\\lambda\\)"
set ylabel "\\(E_n/\\hbar\\omega)"
set yrange [0:1]
#Plottum fjórða örvaða ástandið
plot  "../a/data/occ4.dat" every 4::1 using 1:3 w l title "\\(N = 4\\)",\
  "../a/data/occ8.dat" every 8::1 using 1:3 w l title "\\(N = 8\\)",\
  "../a/data/occ16.dat" every 16::1 using 1:3 w l title "\\(N = 16\\)",\
  "../a/data/occ32.dat" every 32::1 using 1:3 w l title "\\(N = 32\\)",\
  "../a/data/occ64.dat" every 64::1 using 1:3 w l title "\\(N = 64\\)"
