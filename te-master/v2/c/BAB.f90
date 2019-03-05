   MODULE BAB
   CONTAINS
   FUNCTION lambda(Af,Bf,xmat, k)

   USE Mod_Precision

   USE lapack95
   USE blas95
   USE omp_lib
   USE PAB
   use Mod_Init
   IMPLICIT NONE

   INTEGER :: Nd1, Nd2, Nd3, ierr, i, j
   real(kind=dp) :: k
   COMPLEX(KIND=dp), ALLOCATABLE, DIMENSION(:,:) :: lambda, Af, Bf, xmat, amin, aplus
   allocate(amin(Nf,Nf),aplus(Nf,Nf))
   Nd1 = SIZE(Af,1)
   Nd2 = SIZE(Bf,2)
   ierr = 0
   amin = Czero
   aplus = Czero

   do i = 1, Nf
      do j = 1, i-1
         aplus(i,j) = xmat(i,j)
      end do
   end do

  
   amin = xmat - aplus
   
         
   ALLOCATE(lambda(Nd1,Nd2), STAT=ierr)

   lambda = (0.0_dp, 0.0_dp)
   lambda =-ci*(matmulvg(Af,Bf) - matmulvg(Bf,Af)) - 0.5_dp*k*(matmulvg(matmulvg(amin,Bf),aplus)&
          & - matmulvg(aplus,matmulvg(amin,Bf)) +&
   &matmulvg(amin,matmulvg(Bf,aplus)) - matmulvg(matmulvg(Bf,aplus),amin))

!----------------------------------------
   END FUNCTION lambda
   END MODULE BAB
