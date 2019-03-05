program main
! """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
! File: adal
! Author: V. Kári Daníelsson og Emil
! Email: valtyrkarid@gmail.com
! Gitlab: gitlab.com/Jaktrep
! Description: Forrit til að finna orkuróf skammtakjörsveifils
! """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

use omp_lib
use Mod_Precision
use Mod_Fields
use Mod_Init

use lapack95
use blas95

implicit none

integer :: i, j, ierr

open(unit = 420,  file = 'eigvect.dat', status = 'new', iostat = ierr)
open(unit = 69,   file = 'eigval.dat',  status = 'new', iostat = ierr)
open(unit = 1917, file = 'hmat.dat',      status = 'new', iostat = ierr)

ierr = 0

allocate(hmat0(Nf,Nf), stat=ierr, xmat(Nf,Nf), hmat(Nf,Nf), xmat4(Nf,Nf), lambda)

lambda = 1.0_dp

hmat0 = Czero
hmat = Czero
xmat = Czero

do j = 1, Nf, 1
  do i = 1, Nf, 1
    if (j .eq. i) then
      hmat0(i,j) = real(i-1,dp) + 0.5_dp
    end if
  end do
end do

do j = 1, Nf, 1
  do i = 1, Nf, 1
    if (abs(i-j) .eq. 1) then
      xmat(i,j) = 0.5_dp*sqrt(real((i + j - 1),dp))
    end if
  end do
end do

xmat4 = matmul(matmul(xmat,xmat),matmul(xmat,xmat))

hmat = hmat0 + lambda*xmat4

do i = 1, Nf
  do j = 1, Nf
    write(1917, FMT='(I4,2X,I4,E15.8,1X,E15.8)') i,j,hmat(i,j)
  end do
end do

allocate(Eigval(Nf),Eigvect(Nf,Nf),stat=ierr)

call heevr(hmat,Eigval,UPLO,Eigvect)

do j = 1, Nf, 1
  do i = 1, Nf, 1
    write(420, fmt='(I4,2X,I4,E15.8,1X,E15.8)') i,j, Eigvect(i,j)
  end do
  write(420,fmt='()')
end do

do i = 1, Nf
  write(69,FMT='(I4,2X,E15.8)') i, Eigval(i)  ! Eigenvalues printed
end do


end program main
