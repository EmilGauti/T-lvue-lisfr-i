program main
! """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
! File: adal
! Author: V. Kári Daníelsson og Emil Gauti Friðriksson
! Email: vkd1@hi.is, egf3@hi.is
! Gitlab: gitlab.com/Jaktrep
! Description: Forrit til að finna orkuróf truflaðs skammtakjörsveifils
! """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

use omp_lib
use Mod_Precision
use Mod_Fields
use Mod_Init

use lapack95
use blas95

use PAB
use PcAB
use PABz

implicit none

integer :: i, j, ierr

! Opna skrár til að skrifa upplýsingar í.
open(unit = 69,   file = 'eigval.dat',  status = 'new', iostat = ierr)

ierr = 0

! Skilgreinum víddir grindanna okkar. 
! tmpm er notaður fyrir millireikninga, xmat er fylki x-virkjans,
! xeigval inniheldur eigingildi xmat, xtanh er tanh af x-virkjanum í eigingrunni sínum,
! hmat er loka Hamilton fylkið, hmat0 er fylki hamilton virkjans fyrir
! ótruflaða kjörsveifilinn í eigngrunni sínum, xmat4 er x í fjórða veldi.

allocate(hmat0(Nf,Nf), stat=ierr, xmat(Nf,Nf), xtanh(Nf,Nf), tmpm(Nf,Nf), xeigvect(Nf,Nf), &
  & xeigval(Nf), hmat(Nf,Nf), absunitary(Nf,Nf))

hmat0 = Czero
hmat = Czero
xmat = Czero
tmpm = Czero

! Stök hmat0 skilgreind
do j = 1, Nf, 1
  do i = 1, Nf, 1
    if (j .eq. i) then
      hmat0(i,j) = real(i-1,dp) + 0.5_dp
    end if
  end do
end do

! Stök xmat skilgreind
do j = 1, Nf, 1
  do i = 1, Nf, 1
    if (abs(i-j) .eq. 1) then
      absunitary(i,j) = 0.5_dp*sqrt(real((i + j - 1),dp))
    end if
  end do
end do

xmat = absunitary

! Eigingildi og eiginvigrar xmat fundnir
call heevr(absunitary,xeigval,UPLO,xeigvect)

tmpm = matmulvg(matmulvgc(xeigvect,xmat),xeigvect)

! xtanh skilgreint og varpað aftur í eigingrunn hmat0
xtanh = tanh(tmpm)
xtanh = matmulvg(xeigvect,matmulvgz(xtanh,xeigvect))

! Mættið skilgreint, xtanh varpað aftur í eigingrunn hamiltonvirkjans.
tmpm = 0.5_dp*matmulvg(xmat,xtanh) - 0.5_dp*matmulvg(xmat,xmat)


! Loka Hamilton fylkið skilgreint
hmat = hmat0 + tmpm

! Minni tekið frá fyrir eigingildi og eiginvigra hmat
allocate(Eigval(Nf),Eigvect(Nf,Nf))

! Eigingildi og eiginvigrar hmat reiknaðir
call heevr(hmat,Eigval,UPLO,Eigvect)

! Eigingildi hmat (orkustigin) skrifuð í skrá til að plotta.
do i = 1, Nf
  write(69,FMT='(I4,2X,E15.8)') i, Eigval(i)  ! Eigenvalues printed
end do

allocate(hmat0(Nf,Nf), stat=ierr, xmat(Nf,Nf), xtanh(Nf,Nf), tmpm(Nf,Nf), &
  & xeigval(Nf), xeigvect(Nf,Nf), hmat(Nf,Nf), absunitary(Nf,Nf), Eigval(Nf), Eigvect(Nf,Nf))

end program main
