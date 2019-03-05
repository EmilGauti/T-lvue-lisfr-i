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

use PAB
use PABz
use PcAB
use BAB
implicit none

integer :: i, j, ierr, ft
complex(kind=dp), allocatable, dimension(:,:) :: c, tmpd, tmpd2
complex(kind=dp), allocatable, dimension(:) :: tsum, txsum, tx2sum
complex(kind=dp), allocatable, dimension(:,:,:) :: xdensity,x2density
real(kind=dp):: dt
open(unit = 101,  file = 'xdensity.dat',    status = 'new', iostat = ierr)
open(unit = 102,  file = 'x2density.dat',   status = 'new', iostat = ierr)

ierr = 0
ft=512
allocate(hmat0(Nf,Nf), xmat(Nf,Nf), stat=ierr, hmat(Nf,Nf), density(Nf,Nf,ft), c(Nf,Nf), tmpd(Nf,Nf), tmpd2(Nf,Nf))
allocate(xdensity(Nf,Nf,ft), x2density(Nf,Nf,ft), txsum(ft), tx2sum(ft), stat=ierr)
hmat0 = Czero
hmat = Czero
xmat = Czero
density = Czero
tmpd = czero
tmpd2 = czero
c = czero
dt = 0.02_dp
xdensity = Czero
x2density = Czero
txsum = Czero
tx2sum = Czero
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


  hmat = hmat0 + 1*xmat !breytum síðan 1 í OMEGA


  density(1,1,1) = 1.0_dp*CUnit

  do i = 1, ft ! Búum til breytu seinna fyrir 50(Fjöldi tímaskrefa)
     tmpd = density(:,:,i)
     density(:,:,i+1) = density(:,:,i) - 2*0.5_dp*ci*dt*lambda(hmat,tmpd)
     c = density(:,:,i) - 0.5_dp*ci*dt*lambda(hmat,tmpd)! i+1?
     do j = 1, 10 ! Fjöldi ítranna fyrir hvert tímaskref
        tmpd = density(:,:,i+1)
        density(:,:,i+1) = c -0.5_dp*ci*dt*lambda(hmat,tmpd)
     end do
  end do
! FINNUM VÆNTIGILDI Á X: <X>

   do i = 1, ft
      xdensity(:,:,i) = matmul(xmat,density(:,:,i))
      x2density(:,:,i)= matmul(matmul(xmat,xmat),density(:,:,i))
   end do
   do i = 1, ft
      do j = 1, Nf  
         txsum(i) = txsum(i) + xdensity(j,j,i)
         tx2sum(i) = tx2sum(i) + x2density(j,j,i) 
      end do
   end do

   do j = 1, ft
      write(101,fmt='(I4,2X,E15.8,2X,E15.8)') j, txsum(j)
      write(102,fmt='(I4,2X,E15.8,2X,E15.8)') j, tx2sum(j)
   end do
end program main
