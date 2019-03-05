   MODULE Mod_Fields

!-----------------------------------

    USE Mod_Precision
    USE Mod_Init

    IMPLICIT NONE

    INTEGER                     :: Nmax

    REAL(KIND=dp)               :: al

    COMPLEX(KIND=dp)            :: cl

    CHARACTER(LEN=1)            :: TransA, TransB



!----------------------------------------------------------------

    REAL(KIND=dp),        ALLOCATABLE, DIMENSION(:)      :: Eigval, lambda
    COMPLEX(KIND=dp),     ALLOCATABLE, DIMENSION(:,:)    :: Hmat, Eigvect, hmat0, xmat,xmat4


!---------------------------------------------------------------------------

   END MODULE Mod_Fields
