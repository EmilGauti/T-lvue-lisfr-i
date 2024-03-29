   MODULE PAB
   CONTAINS
   FUNCTION MATMULVG(Af,Bf)

   USE Mod_Precision

   USE lapack95
   USE blas95
   USE omp_lib

   IMPLICIT NONE

   INTEGER :: Nd1, Nd2, ierr
   COMPLEX(KIND=dp), ALLOCATABLE, DIMENSION(:,:) :: MATMULVG, Af, Bf

   Nd1 = SIZE(Af,1)
   Nd2 = SIZE(Bf,2)
   ierr = 0

   ALLOCATE(MATMULVG(Nd1,Nd2), STAT=ierr)

   MATMULVG = (0.0_dp, 0.0_dp)
   CALL GEMM3M(Af,Bf,MATMULVG)

!----------------------------------------
   END FUNCTION MATMULVG
   END MODULE PAB
