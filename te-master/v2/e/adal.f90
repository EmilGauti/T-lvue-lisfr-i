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
!use Te
use lapack95
use blas95

use PAB
use PABz
use PcAB
use BAB
implicit none

integer :: i, j, ierr, ft
complex(kind=dp), allocatable, dimension(:,:) :: c, tmpd, tmpd2, density2
complex(kind=dp), allocatable, dimension(:) :: tsum
real(kind=dp) :: dt, lamb, k, error
!complex(kind=dp) :: trace, error
open(unit = 69,   file = 'occ.dat',     status = 'new', iostat = ierr)
open(unit = 100,  file = 'trace.dat',   status = 'new', iostat = ierr)
ierr = 0
ft=4096
allocate(hmat0(Nf,Nf), xmat(Nf,Nf), stat=ierr, hmat(Nf,Nf), &
    & density(Nf,Nf,ft), density2(Nf,Nf), c(Nf,Nf), tmpd(Nf,Nf), tmpd2(Nf,Nf), tsum(ft))
tsum = Czero
hmat0 = Czero
hmat = Czero
xmat = Czero
density = Czero
density2 = Czero
tmpd = czero
tmpd2 = czero
c = czero

lamb = 1.0_dp
dt = 0.01_dp
k = 0.015_dp ! dempunarstuðull fyrir c-lið

do j = 1, Nf, 1
  do i = 1, Nf, 1
    if (j .eq. i) then
      hmat0(i,j) = cmplx(real(i-1,dp) + 0.5_dp,0.0_dp,dp)
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


hmat = hmat0 + lamb*xmat !breytum síðan 1 í OMEGA

density(4,4,1) = 1.0_dp*CUnit

do i = 1, ft-1 ! Búum til breytu seinna fyrir 50(Fjöldi tímaskrefa)
    tmpd = density(:,:,i)
    density(:,:,i+1) = density(:,:,i) + dt*lambda(hmat,tmpd,xmat,k)
    c = density(:,:,i) + 0.5_dp*dt*lambda(hmat,tmpd,xmat,k)! i+1?
    error = 0.0_dp
    do j = 1, 15 ! Fjöldi ítranna fyrir hvert tímaskref
        tmpd = density(:,:,i+1)
        density(:,:,i+1) = c +0.5_dp*dt*lambda(hmat,tmpd,xmat,k)
        tmpd2 = density(:,:,i+1)
        error = sqrt(abs(sum(tmpd2-tmpd)))
        if (error .le. 1e-6) exit
    end do
end do
do i = 1, ft
    tmpd = density(:,:,i)
    density2 =  matmulvg(tmpd,tmpd)
    do j = 1, Nf
        tsum(i) = tsum(i) + density2(j,j)
    end do
end do
tsum = -log(tsum)
do j = 1, ft
    write(100,fmt='(I6,2X,E15.8,2X,E15.8)') j, tsum(j)  ! Eigenvalues printed
    do i = 1, Nf
        write(69,fmt='(I6,2X,I4,2X,E15.8,1X,E15.8)') j, i, density(i,i,j)  ! Eigenvalues printed
    end do
end do

end program main
