module Te 
contains
  SUBROUTINE Trace_and_error(trace,error)
    
    USE Mod_Precision
    USE Mod_Init
    USE Mod_Fields
!    USE Mod_Matrices_Master_Equation

    IMPLICIT NONE

    INTEGER          :: mu,nu,i
    COMPLEX(KIND=dp) :: error,trace


    trace = (0.0_dp, 0.0_dp)
    DO mu = 1, Nf
      trace = trace+density(mu,mu,i+1)
    END DO
    error = (0.0_dp, 0.0_dp)
    error = SQRT(ABS(SUM(density(:,:,i+1)-density(:,:,i))))
  END SUBROUTINE Trace_and_error
  end module Te
