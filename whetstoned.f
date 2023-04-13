C**********************************************************************
C     Benchmark #2 -- Double  Precision Whetstone (A001)
C
C     o	This is a REAL*8 version of
C	the Whetstone benchmark program.
C
C     o	DO-loop semantics are ANSI-66 compatible.
C
C     o	Final measurements are to be made with all
C	WRITE statements and FORMAT sttements removed.
C
C**********************************************************************   
	IMPLICIT REAL*8 (A-H,O-Z)
C
	COMMON T,T1,T2,E1(4),J,K,L
	common/ptime/ptime,time0
	real time0,time1,walltime,ptime
C
	WRITE(6,1)
   1	FORMAT(/' Benchmark #2 -- Double Precision Whetstone (A001)')
C
C	Start benchmark timing at this point.
C
	time0 = walltime()
	ptime = time0
C
C	The actual benchmark starts here.
C
	T = .499975
	T1 = 0.50025
	T2 = 2.0
C
C	With loopcount LOOP=10, one million Whetstone instructions
C	will be executed in EACH MAJOR LOOP..A MAJOR LOOP IS EXECUTED
C	'II' TIMES TO INCREASE WALL-CLOCK TIMING ACCURACY.
C
	LOOP = 50000
	II   = 4
C
	DO 500 JJ=1,II
C
C	Establish the relative loop counts of each module.
C
	N1 = 0
	N2 = 12 * LOOP
	N3 = 14 * LOOP
	N4 = 345 * LOOP
	N5 = 0
	N6 = 210 * LOOP
	N7 = 32 * LOOP
	N8 = 899 * LOOP
	N9 = 616 * LOOP
	N10 = 0
	N11 = 93 * LOOP
C
C	Module 1: Simple identifiers
C
	X1 = 1.0
	X2 = -1.0
	X3 = -1.0
	X4 = -1.0
C
	IF (N1.EQ.0) GO TO 35
		DO 30 I=1,N1
		X1 = (X1 + X2 + X3 - X4)*T
		X2 = (X1 + X2 - X3 + X4)*T
		X3 = (X1 - X2 + X3 + X4)*T
		X4 = (-X1 + X2 + X3 + X4)*T
   30		CONTINUE
   35	CONTINUE
C
	IF (JJ.EQ.II)CALL POUT(N1,N1,N1,X1,X2,X3,X4)
C
C	Module 2: Array elements
C
	E1(1) = 1.0
	E1(2) = -1.0
	E1(3) = -1.0
	E1(4) = -1.0
C
	IF (N2.EQ.0) GO TO 45
		DO 40 I=1,N2
		E1(1) = (E1(1) + E1(2) + E1(3) - E1(4))*T
		E1(2) = (E1(1) + E1(2) - E1(3) + E1(4))*T
		E1(3) = (E1(1) - E1(2) + E1(3) + E1(4))*T
		E1(4) = (-E1(1) + E1(2) + E1(3) + E1(4))*T
   40		CONTINUE
   45	CONTINUE
C
	IF (JJ.EQ.II)CALL POUT(N2,N3,N2,E1(1),E1(2),E1(3),E1(4))
C
C	Module 3: Array as parameter
C
	IF (N3.EQ.0) GO TO 59
		DO 50 I=1,N3
		CALL PA(E1)
   50		CONTINUE
   59	CONTINUE
C
	IF (JJ.EQ.II)CALL POUT(N3,N2,N2,E1(1),E1(2),E1(3),E1(4))
C
C	Module 4: Conditional jumps
C
	J = 1
	IF (N4.EQ.0) GO TO 65
		DO 60 I=1,N4
		IF (J.EQ.1) GO TO 51
		J = 3
		GO TO 52
51		J = 2
52		IF (J.gt.2) GO TO 53
		J = 1
		GO TO 54
53		J = 0
54		IF (J.LT.1) GO TO 55
		J = 0
		GO TO 60
55		J = 1
   60		CONTINUE
   65	CONTINUE
C
	IF (JJ.EQ.II)CALL POUT(N4,J,J,X1,X2,X3,X4)
C
C	Module 5: Omitted
C 	Module 6: Integer arithmetic
C	
	J = 1
	K = 2
	L = 3
C
	IF (N6.EQ.0) GO TO 75
		DO 70 I=1,N6
		J = J * (K-J) * (L-K)
		K = L * K - (L-J) * K
		L = (L - K) * (K + J)
		E1(L-1) = J + K + L
		E1(K-1) = J * K * L
   70		CONTINUE
   75	CONTINUE
C
	IF (JJ.EQ.II)CALL POUT(N6,J,K,E1(1),E1(2),E1(3),E1(4))
C
C	Module 7: Trigonometric functions
C
	X = 0.5
	Y = 0.5
C
	IF (N7.EQ.0) GO TO 85
		DO 80 I=1,N7
		X=T*ATAN(T2*SIN(X)*COS(X)/(COS(X+Y)+COS(X-Y)-1.0))
		Y=T*ATAN(T2*SIN(Y)*COS(Y)/(COS(X+Y)+COS(X-Y)-1.0))
   80		CONTINUE
   85	CONTINUE
C
	IF (JJ.EQ.II)CALL POUT(N7,J,K,X,X,Y,Y)
C
C	Module 8: Procedure calls
C
	X = 1.0
	Y = 1.0
	Z = 1.0
C
	IF (N8.EQ.0) GO TO 95
		DO 90 I=1,N8
		CALL P3(X,Y,Z)
   90 		CONTINUE
   95	CONTINUE
C
	IF (JJ.EQ.II)CALL POUT(N8,J,K,X,Y,Z,Z)
C
C	Module 9: Array references
C
	J = 1
	K = 2
	L = 3
	E1(1) = 1.0
	E1(2) = 2.0
	E1(3) = 3.0
C
	IF (N9.EQ.0) GO TO 105
		DO 100  I=1,N9
		CALL P0
  100		CONTINUE
  105	CONTINUE
C
	IF (JJ.EQ.II)CALL POUT(N9,J,K,E1(1),E1(2),E1(3),E1(4))
C
C	Module 10: Integer arithmetic
C
	J = 2
	K = 3
C
	IF (N10.EQ.0) GO TO 115
		DO 110 I=1,N10
		J = J + K
		K = J + K
		J = K - J
		K = K - J - J
  110		CONTINUE
  115	CONTINUE
C
	IF (JJ.EQ.II)CALL POUT(N10,J,K,X1,X2,X3,X4)
C
C	Module 11: Standard functions
C
	X = 0.75
C
	IF (N11.EQ.0) GO TO 125
		DO 120 I=1,N11
		X = SQRT(EXP(LOG(X)/T1))
  120		CONTINUE
  125	CONTINUE
C
	IF (JJ.EQ.II)CALL POUT(N11,J,K,X,X,X,X)
C
C      THIS IS THE END OF THE MAJOR LOOP.
C
500	CONTINUE
C
C      Stop benchmark timing at this point.
C
	time1 = walltime()
C----------------------------------------------------------------
C      Performance in Whetstone KIP's per second is given by
C
C	(100*LOOP*II)/TIME
C
C      where TIME is in seconds.
C--------------------------------------------------------------------
      print *,' Double Whetstone KIPS ',
     *nint((100*LOOP*II)/(time1-time0))
	END
C
	SUBROUTINE PA(E)
	IMPLICIT REAL*8 (A-H,O-Z)
	DIMENSION E(4)
	COMMON T,T1,T2,E1(4),J,K,L
	J1 = 0
   10	E(1) = (E(1) + E(2) + E(3) - E(4)) * T
	E(2) = (E(1) + E(2) - E(3) + E(4)) * T  
	E(3) = (E(1) - E(2) + E(3) + E(4)) * T
	E(4) = (-E(1) + E(2) + E(3) + E(4)) / T2
	J1 = J1 + 1
	IF (J1 - 6) 10,20,20
C
   20	RETURN
	END
C
	SUBROUTINE P0
	IMPLICIT REAL*8 (A-H,O-Z)
	COMMON T,T1,T2,E1(4),J,K,L
	E1(J) = E1(K)
	E1(K) = E1(L)
	E1(L) = E1(J)
	RETURN
	END
C
	SUBROUTINE P3(X,Y,Z)
	IMPLICIT REAL*8 (A-H,O-Z)
	COMMON T,T1,T2,E1(4),J,K,L
	X1 = X
	Y1 = Y
	X1 = T * (X1 + Y1)
	Y1 = T * (X1 + Y1)
	Z = (X1 + Y1) / T2
	RETURN
	END
C
	SUBROUTINE POUT(N,J,K,X1,X2,X3,X4)
	IMPLICIT REAL*8 (A-H,O-Z)
	common/ptime/ptime,time0
	real ptime,time1,time0,walltime
	time1 = walltime()
	print 10, nint(time1-time0),nint(time1-ptime),N,J,K,X1,X2,X3,X4
   10	FORMAT (2i3,1X,3I9,4(1PE12.4))
	ptime = time1
	RETURN
	END

        real function walltime() 
        real it(2)
        walltime = etime(it)
        return
        end

