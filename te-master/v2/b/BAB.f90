   MODULE BAB
   CONTAINS
   FUNCTION lambda(Af,Bf)

   USE Mod_Precision

   USE lapack95
   USE blas95
   USE omp_lib
   USE PAB

   IMPLICIT NONE

   INTEGER :: Nd1, Nd2, ierr
   COMPLEX(KIND=dp), ALLOCATABLE, DIMENSION(:,:) :: lambda, Af, Bf

   Nd1 = SIZE(Af,1)
   Nd2 = SIZE(Bf,2)
   ierr = 0

   ALLOCATE(lambda(Nd1,Nd2), STAT=ierr)

   lambda = (0.0_dp, 0.0_dp)
   lambda = matmulvg(Af,Bf) - matmulvg(Bf,Af)

!----------------------------------------
   END FUNCTION lambda
   END MODULE BAB
