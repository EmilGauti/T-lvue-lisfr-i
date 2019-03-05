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

    REAL(KIND=dp),        ALLOCATABLE, DIMENSION(:)      :: Eigval, xeigval
    COMPLEX(KIND=dp),     ALLOCATABLE, DIMENSION(:,:)    :: xtanh, xeigvect, Eigvect, hmat0, hmat, xmat, absunitary, tmpm


!---------------------------------------------------------------------------

   END MODULE Mod_Fields