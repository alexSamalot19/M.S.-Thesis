      Program Kalman

      implicit none

      integer:: dim, tickKalman, tickKalman_resYes, tickBias_Pred
      integer:: tickKalman_resTom, tickModTom_f, tickKG
      integer:: tickObs, tickModYes, justatick, TOTx, TOTp
      integer:: station, tickModTom, tickyV, tickX_m, tickP_M
      integer:: tickX, tickP,i,j,k,m,n,Status,hours, TOTq, TOTr
      integer:: hour_obs, history_index, numStat, index

      real:: S1,S2,S3,Covar,Var
      real:: Uobs,Umod 
      real:: V,y,z,ss,Bias 
      real:: Q1,pre,Mean
      real:: Sum,Sumsquare, MeanError, MeanAbsError, StDevError
      real:: StDevAbsError,RMSE
      real:: Probab,Sumabs,aa, history_index_r, index_r

      Parameter (dim=2)  
      Parameter (hours=4872)  
      Parameter (history_index=24)  
      Parameter (index=history_index-1)  
      !Parameter (numStat=10000)

      real,dimension(1547,1)::GC
      real,dimension(dim,dim)::D
      real,dimension(0:index) :: L1
      real,dimension(0:index) :: L2
      real,dimension(dim,0:index) :: E
      real,dimension(0,index) :: a1
      real,dimension(0,index) :: b1
      real,dimension(dim,dim) :: diff
      real,dimension(0:index) :: yV
      real,dimension(dim,0:index) :: xV
      real,dimension(dim,dim) :: temp
      real,dimension(dim,dim) :: A
      real,dimension(dim,dim) :: C
      real,dimension(dim,dim) :: H
      real,dimension(dim,dim) :: PR
      real,dimension(dim,0:history_index) :: x_matrix 
      real,dimension(dim,dim) :: KG
      real,dimension(dim,dim) :: S
      real,dimension(dim,dim) :: T
      real,dimension(dim,dim) :: x
      real,dimension(dim,dim) :: Q 
      real,dimension(dim,dim) ::P1
      real,dimension(dim,dim) :: ID
      real,dimension(dim,dim) :: B
      real,dimension(48) :: Obs 
      real,dimension(48) :: Model
      real,dimension(48) :: KAL
      real,dimension(48) :: ErrorModel
      real,dimension(48) :: ErrorKAL
      real,dimension(dim,dim) :: W
      real,dimension(dim,dim) :: P
      real,dimension(hours) :: Tobs
      real,dimension(hours) :: Tmod1
      real,dimension(hours) :: Tmod2
      real,dimension(hours) :: date_mod1
      real,dimension(hours) :: date_mod2
      real,dimension(hours) :: date_obs
      real,dimension(hours) :: filtered
      real,dimension(hours) :: Bias_P
      
      character(len=100)::BiasPname
      character(len=100)::obsname
      character(len=100)::modYesname
      character(len=100)::modTomname
      character(len=100)::yVname
      character(len=100)::x_mname
      character(len=100)::xname
      character(len=100)::Kalman_rYn
      character(len=100)::Kalman_rTn
      character(len=100)::modeltom_f
      character(len=100)::kalmanname
      character(len=100)::P_mname
      character(len=100)::Pname 


      open(unit=2, file='GClistMet32.txt')
      read(2,*)GC
      close(2)

      



      do m=1,dim
      do n=1,dim
         if (m.eq.n) then
          ID(m,n)=1
         else 
          ID(m,n)=0
         endif 
      enddo
      enddo

      history_index_r = history_index*1.0
      index_r = index*1.0

      !write (*,*) 'history_index=', history_index
      !write (*,*) 'index=', index
      !write (*,*) 'history_index_r=', history_index_r
      !write (*,*) 'index_r=', index_r

        tickObs=501
        tickModYes=502
        tickModTom=503
        tickyV=504
        tickX_M=505
        tickP_M=506
        tickModTom_f=507
        tickBias_Pred=508
		tickKG=509
		TOTx=510
		TOTp=511
		TOTq=512
		TOTr=513
		

      !station = 1 
        DO justatick=1,134
        station=GC(justatick,1)


      !write (*,*) 'station=', station
        tickObs=tickObs+14
        tickModYes=tickModYes+14
        tickModTom=tickModTom+14
        tickyV=tickyV+14
        tickX_M=tickX_M+14
        tickP_M=tickP_M+14
        tickModTom_f=tickModTom_f + 14
        tickBias_Pred=tickBias_Pred+14
		tickKG=tickKG+14
		TOTX=TOTX+14
		TOTp=TOTp+14
		TOTq=TOTq+14
		TOTr=TOTr+14

        if (station<10) then
		    write(TFname, '(“TF",I1,"/")') hour
            write(BiasPname, '("Bias_Pred",I1,".txt")') station
            write(obsname, '("Obs",I1,".txt")') station
            write(modYesname, '("ModYes",I1,".txt")') station
            write(modTomname, '("ModTom",I1, ".txt")') station
            write(yVname, '("yV",I1,".txt")') station
            write(x_mname, '("x_matrix",I1,".txt")') station
            write(P_mname, '("P_matrix",I1,".txt")') station
            write(xname, '("x",I1,".txt")') station
            write(kalmanname,'("Kalman",I1,".txt")') station
            write(Kalman_rTn,'("Kalman_resTom",I1,".txt")') station
            write(modeltom_f,'("modeltom_filt",I1,".txt")') station
            write(Kalman_rYn,'("Kalman_resYes",I1,".txt")') station
            write(Pname, '("P",I1,".txt")') station
		    write(KGname, '(“KG",I1,".txt")') station
            write(TOTx, '(“TOTx",I1,".txt")') station
		    write(TOTp, '(“TOTp",I1,".txt")') station
            write(TOTq, '(“TOTq",I1,".txt")') station
		    write(TOTr, '(“TOTr",I1,".txt")') station

        elseif (station<100 .AND. station>9) then
		    write(TFname, '(“TF",I2,"/")') hour
            write(BiasPname, '("Bias_Pred",I2,".txt")') station
            write(obsname, '("Obs",I2,".txt")') station
            write(modYesname, '("ModYes",I2,".txt")') station
            write(modTomname, '("ModTom",I2, ".txt")') station
            write(yVname, '("yV",I2,".txt")') station
            write(x_mname, '("x_matrix",I2,".txt")') station
            write(P_mname, '("P_matrix",I2,".txt")') station
            write(xname, '("x",I2,".txt")') station
            write(kalmanname,'("Kalman",I2,".txt")') station
            write(Kalman_rTn,'("Kalman_resTom",I2,".txt")') station
            write(modeltom_f,'("modeltom_filt",I2,".txt")') station
            write(Kalman_rYn,'("Kalman_resYes",I2,".txt")') station
            write(Pname, '("P",I2,".txt")') station
		    write(KGname, '(“KG",I2,".txt")') station
		    write(TOTx, '(“TOTx",I2,".txt")') station
		    write(TOTp, '(“TOTp",I2,".txt")') station
		    write(TOTq, '(“TOTq",I2,".txt")') station
		    write(TOTr, '(“TOTr",I2,".txt")') station

        elseif (station<1000 .AND. station>99) then
		    write(TFname, '(“TF",I3,"/")') hour
            write(BiasPname, '("Bias_Pred",I3,".txt")') station
            write(obsname, '("Obs",I3,".txt")') station
            write(modYesname, '("ModYes",I3,".txt")') station
            write(modTomname, '("ModTom",I3, ".txt")') station
            write(yVname, '("yV",I3,".txt")') station
            write(x_mname, '("x_matrix",I3,".txt")') station
            write(P_mname, '("P_matrix",I3,".txt")') station
            write(xname, '("x",I3,".txt")') station
            write(kalmanname,'("Kalman",I3,".txt")') station
            write(Kalman_rTn,'("Kalman_resTom",I3,".txt")') station
            write(modeltom_f,'("modeltom_filt",I3,".txt")') station
            write(Kalman_rYn,'("Kalman_resYes",I3,".txt")') station
            write(Pname, '("P",I3,".txt")') station
		    write(KGname, '(“KG",I3,".txt")') station
		    write(TOTx, '(“TOTx",I3,".txt")') station
		    write(TOTp, '(“TOTp",I3,".txt")') station
		    write(TOTq, '(“TOTq",I3,".txt")') station
		    write(TOTr, '(“TOTr",I3,".txt")') station

        elseif (station<10000 .AND. station>999) then
		    write(TFname, '(“TF",I4,"/")') hour
            write(BiasPname, '("Bias_Pred",I4,".txt")') station
            write(obsname, '("Obs",I4,".txt")') station
            write(modYesname, '("ModYes",I4,".txt")') station
            write(modTomname, '("ModTom",I4, ".txt")') station
            write(yVname, '("yV",I4,".txt")') station
            write(x_mname, '("x_matrix",I4,".txt")') station
            write(P_mname, '("P_matrix",I4,".txt")') station
            write(xname, '("x",I4,".txt")') station
            write(kalmanname,'("Kalman",I4,".txt")') station
            write(Kalman_rTn,'("Kalman_resTom",I4,".txt")') station
            write(modeltom_f,'("modeltom_filt",I4,".txt")') station
            write(Kalman_rYn,'("Kalman_resYes",I4,".txt")') station
            write(Pname, '("P",I4,".txt")') station
		    write(KGname, '(“KG",I4,".txt")') station
		    write(TOTx, '(“TOTx",I4,".txt")') station
		    write(TOTp, '(“TOTp",I4,".txt")') station
		    write(TOTq, '(“TOTq",I4,".txt")') station
		    write(TOTr, '(“TOTr",I4,".txt")') station

        elseif (station<100000 .AND. station>9999) then
		    write(KGname, '(“KG",I5,".txt")') station
            write(BiasPname, '("Bias_Pred",I5,".txt")') station
            write(obsname, '("Obs",I5,".txt")') station
            write(modYesname, '("ModYes",I5,".txt")') station
            write(modTomname, '("ModTom",I5, ".txt")') station
            write(yVname, '("yV",I5,".txt")') station
            write(x_mname, '("x_matrix",I5,".txt")') station
            write(P_mname, '("P_matrix",I5,".txt")') station
            write(xname, '("x",I5,".txt")') station
            write(kalmanname,'("Kalman",I5,".txt")') station
            write(Kalman_rTn,'("Kalman_resTom",I5,".txt")') station
            write(modeltom_f,'("modeltom_filt",I5,".txt")') station
            write(Kalman_rYn,'("Kalman_resYes",I5,".txt")') station
            write(Pname, '("P",I5,".txt")') station
		    write(KGname, '(“KG",I5,".txt")') station
            write(TOTx, '(“TOTx",I5,".txt")') station
		    write(TOTp, '(“TOTp",I5,".txt")') station
		    write(TOTq, '(“TOTq",I5,".txt")') station
		    write(TOTr, '(“TOTr",I5,".txt")') station
 
        endif


   
         open(unit=tickObs, status='old', file=obsname)
         open(unit=tickModYes, status='old', file=modYesname)
         open(unit=tickModTom, status='old', file=modTomname)
         !open(unit=tickModTom_f, status='old', file=modeltom_f)

      !   write(*,*) 'xname=', xname
        do i=1,hours 
          read (tickObs,*) Tobs(i)
        enddo
 1000 format(a12,1x,f2.0) !you definatley need to change this 

        do i=1,hours
          read (tickModTom,*) Tmod2(i)
        enddo

        do i=1,hours 
          read (tickModYes,*) Tmod1(i) 
        enddo
 1500 format(a12,1x,f7.2) !you definatley will need to change

      !   write(*,*) 'xname=', xname
 
      DO i=1,hours   ! Loop over number of  hours 
      ! write (*,*) 'HOUR=', i 

      pre=Tmod1(i)
       !write (*,*) 'Pre=', pre

       !open(unit=tickKalman, status='old', file=kalmanname)
       !open(unit=tickKalman_resYes, status='old', file=Kalman_rYn)
       !open(unit=tickKalman_resTom, status='old', file=Kalman_rTn)
       !open(unit=tickmodeltom_filt, status='old', file=modeltom_f)

!105      read (tickKalman,*,ioStat=Status) !none
!      if (Status.lt.0) then 
!        go to 106
!      else 
!        go to 105
!      endif

!106   continue

!       write (*,*) 'Dim=', dim


!205      read(tickKalman_resYes,*,ioStat=Status) !none
!      if (Status.lt.0) then
!        go to 206
!      else
!        go to 205
!      endif

!206   continue


!       write (*,*) 'Dim=', dim
!305      read (tickKalman_resTom,*,ioStat=Status) !none
!      if (Status.lt.0) then
!        go to 306
!      else
!        go to 305
!      endif

!306   continue



      !   write(*,*) 'xname=', xname

!       write (*,*) 'Dim=', dim
!405      read (tickmodeltom_filt,*,ioStat=Status) !none
!      if (Status.lt.0) then
!        go to 406
!      else
!        go to 405
!      endif

!406   continue


      !   write(*,*) 'xname=', xname

!       write (*,*) 'Dim=', dim
         ss = Tmod1(i)
         z  = Tobs(i)
         
110     y=z-ss

      !   write(*,*) 'xname=', xname
        do n=1,dim
         H(1,n)=ss**(n-1)
        enddo
      !write (*,*) 'y=', y 
      !write (*,*) 'H=', H 
         open(unit=tickyV, status='old', file=yVname)
          do j=0,index 
           read(tickyV,*) yV(j)
          enddo

         open(unit=tickx_m, status='old', file=X_Mname) 
          do j=0,history_index 

          read(tickx_m,*) (x_matrix(m,j), m=1,dim)
          enddo

          do j=1,history_index
          do m=1,dim 
            xV(m,j) = x_matrix(m,j) - x_matrix(m,j-1)
          enddo 
          enddo 
      !   print *, x_matrix

      !   write(*,*) 'xname=', xname
         call Variance(yV,S1,S2,Mean,V,dim,history_index,index)


      !   write(*,*) 'Pname=', Pname
         open (unit=tickP_m, file=Pname, status='old')
          do n=1,dim 
             read(tickP_m,*) (P(m,n), m=1,dim)
          enddo

        if (station<10) then
            write(xname, '("x",I1,".txt")') station
        elseif (station<100 .AND. station>9) then
            write(xname, '("x",I2,".txt")') station
        elseif (station<1000 .AND. station>99) then
            write(xname, '("x",I3,".txt")') station
        elseif (station<10000 .AND. station>999) then
            write(xname, '("x",I4,".txt")') station
        elseif (station<100000 .AND. station>9999) then
            write(xname, '("x",I5,".txt")') station
        end if
        !write(xname, '("x",I1,".txt")') station
      !  write(*,*) 'xname=', xname
         open (unit=tickx, file=xname, status='old')
         read(tickx,*) (x(m,1), m=1,dim)

         do m=1,dim
         do n=1,dim
          call Line(xV,dim,m,L1,index)
          call Line(xV,dim,n,L2,index)
        call Covariance(L1,L2,S1,S2,S3,W(m,n),dim,history_index,index)
         enddo
         enddo

        !Kalman Gain!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

120     do m=1,dim
        do n=1,dim     
         P1(m,n) = P(m,n) + W(m,n)
        enddo
        enddo



        call sf(H,P1,Q,dim)
        Q1=Q(1,1)
        call mT(H,T,dim)
        call mprod(P1,T,PR,dim)

        do m=1,dim
        do n=1,dim
         KG(m,n)=PR(m,n)/(Q1+V)
        enddo
        enddo


       !New Value Calculation!!!!!!!!!!!!!!!!!!!!!!!!!!

        call mprod(H,x,PR,dim)
        D=y-PR(1,1)

        call mprod(KG,D,PR,dim)

        
        do m=1,dim
        do n=1,dim
         S(m,n)=x(m,n)+PR(m,n)
         temp(m,n)=x(m,n) 
         x(m,n)=S(m,n)
         diff(m,n)=x(m,n)-temp(m,n)
        enddo
        enddo


         if (dim.eq.1) then 
          pre=x(1,1)
         else 
          pre=x(1,1)+x(2,1)*Tmod1(i)
         endif

         if (dim.ge.3) then  
          do m=3,dim
           pre=pre+x(m,1)*(Tmod1(i)**(m-1))
          enddo
         endif

        Bias = pre 
        pre = pre + Tmod2(i)
 !       filtered(i) = pre

        if ((abs(pre-Tmod2(i)).gt.20.).or.(pre.lt.0.)) then 
         pre = Tmod2(i)
        endif

        filtered(i) = pre
        Bias_P(i)=Bias
      ! write(*,*) 'x', x
      ! write(*,*) 'PR', PR
      ! write(*,*) 'KG', KG
      ! write(*,*) 'P', P
      !  write(*,*) 'Station=', Station
       !write (tickKalman,*) Tobs(i), Tmod1(i), Tmod2(i), pre
       !write (tickKalman_resYes,*) Tobs(i), Tmod1(i)
       !write (tickKalman_resTom,*) Tmod2(i), pre
       !write (tickModTom_f,*) pre


3000  FORMAT(f8.2,2x,f8.2)

       !Update new Coefficients!!!!!!!!!!!!!!!!!!!

       call mprod(KG,H,PR,dim)
       call mdif(ID,PR,D,dim)
       call mprod(D,P1,PR,dim)
      
        do m=1,dim
        do n=1,dim
          P(m,n)=PR(m,n)
        enddo
        enddo



150     close (tickObs)
        close(tickModYes)
        close(tickModTom)
        close(tickyV)
        close(tickX_m)
        close(tickP_m)
        close(tickx)


	    open(unit=tickKG, status='replace', file=TFname//KGname)
        do n=1, dim
        write(tickKG,*) (KG(m,n), m=1,dim) 
        enddo 
        close (tickKG)

		open(unit=TOTx, status='replace', file=TFname//TOTXname)
        do n=1, dim
        write(TOTx,*) (x (m,n), m=1,dim) 
        enddo 
        close (TOTx)

		open(unit=TOTp, status='replace', file=TFname//TOTpname)
        do n=1, dim
        write(TOTp,*) (p (m,n), m=1,dim) 
        enddo 
        close (TOTp)
		
	    open(unit=TOTq, status='replace', file=TFname//TOTqname)
        do n=1, dim
        write(TOTq,*) (w(m,n), m=1,dim) 
        enddo 
        close (TOTp)
		
		open(unit=TOTr, status='replace', file=TFname//TOTrname)
        !do n=1, dim
        write(TOTr,*) (V) 
        !enddo 
        close (TOTr)
		

         open(unit=tickyV, file=yVname, status='replace') 
          do j=1,index 
          write (tickyV,*) yV(j)
          enddo 
  
          yV(index) = Tobs(i)-Tmod1(i)
 
          do m=1,dim
           aa = Tmod1(i)
           yV(index) = yV(index)-x(m,1)*(aa**(m-1))
          enddo           

          write (tickyV,*) yV(index) 
         close (tickyV)


         open(unit=tickx_m, file=x_mname, status='replace') 
          do j=1,history_index
           write (tickx_m,*) (x_matrix(m,j), m=1,dim) 
          enddo 
           write (tickx_m,*) (x(m,1), m=1,dim) 
         close (tickx_m)

         open (unit=tickP_m, file=P_mname, status='replace')
          do n=1,dim
             write(tickP_m,*) (P(m,n), m=1,dim)
          enddo
         close (tickP_m)

    
         open (unit=tickx, file=xname, status='replace')
         write (tickx,*) (x(m,1), m=1,dim)
         close (tickx)
      !   write(*,*), 'modeltom_f =', filtered(i)

100    continue      
       END DO   ! end do loop over days 

        write(*,*) 'Station=', Station
       !write (tickKalman,*) Tobs(i), Tmod1(i), Tmod2(i), pre
         open(unit=tickModTom_f, status='replace', file=modeltom_f)
         do m=1, hours
            write(tickModTom_f,*) (filtered(m))
         
         enddo
         close (tickModTom_f)

    
         open(unit=tickBias_Pred, status='replace', file=BiasPname)
         do m=1, hours
            write(tickBias_Pred,*) (Bias_P(m))
         
         enddo
         close (tickBias_Pred)





 !write(*,*) 'Station=', Station
       !write (tickKalman,*) Tobs(i), Tmod1(i), Tmod2(i), pre
  !      open(unit=tickModTom_f, status='replace', file=modeltom_f)
   !      do i=1,hours
    !      write(tickModTom_f,*) Tmod2(i)
     !   enddo
      !  close(tickModTom_f)

         enddo
        stop
        end 

        !Transpose function !!!!!!!!!!!!!!!!!!!

        subroutine mT(A,T,dim)
        integer dim
        real A, T  
        dimension A(dim,dim), T(dim,dim) 

        do m=1,dim
        do n=1,dim
          T(m,n)=A(n,m)
        enddo
        enddo
      
        return
        end 

        !Product of Matrices!!!!!!!!!!!!!!!!
 
        subroutine mprod(A,B,PR,dim)
        integer dim
        real A,B,PR
        DIMENSION A(dim,dim), B(dim,dim), PR(dim,dim)
    
        do m=1,dim
        do n=1,dim
         PR(m,n)=0
        enddo
        enddo
    
        do m=1,dim
        do n=1,dim
        do k=1,dim
         PR(m,n)=PR(m,n)+A(m,k)*B(k,n)
        enddo
        enddo
        enddo
    
        return 
        end 

        !Triple Product!!!!!!!!!!!!!!!!!
 
        subroutine sf(A,B,Q,dim)
        integer dim
        real, Dimension(dim,dim)::A 
        real, Dimension(dim,dim):: B
        real, Dimension(dim,dim):: C
        real, Dimension(dim,dim):: Q
        real, Dimension(dim,dim):: PR
        real, Dimension(dim,dim):: T


       call mprod(A,B,PR,dim)
      
       do m=1,dim
       do n=1,dim
          C(m,n)=PR(m,n)
       enddo
       enddo 
     
      call mT(A,T,dim)
      call mprod(C,T,PR,dim)

       do m=1,dim
       do n=1,dim
          Q(m,n)=PR(m,n)
       enddo
       enddo 
    
       return 
       end 

      !Matrix Difference!!!!!!!!!!!!!!
 
      subroutine mdif(A,B,D,dim)
      integer dim 

      real, Dimension(dim,dim)::A 
      real, Dimension(dim,dim):: B
      real, Dimension(dim,dim)::D
 
      do m=1,dim
      do n=1,dim
         D(m,n)=A(m,n)-B(m,n)
      enddo
      enddo 
    
      return
      end

      !Variance!!!!!!!!!!!!!!!!!!!!!

        subroutine Variance(a1,S1,S2,Mean,Var,dim,history_index,index)
        integer dim,history_index,index
        real S1,S2,Mean,Var,history_index_r,index_r 
        real, Dimension(0:index)::A1 
        integer i
  
        S1=0
        S2=0
        Mean=0
        Var=0

        history_index_r = history_index*1.0
        index_r = index*1.0
     
        do i=0,index
          S1=S1+a1(i)
          S2=S2+(a1(i)**2)
        enddo

        Mean=S1/history_index_r
   
        Var=(1.0/index_r)*S2-(history_index_r/index_r)*(Mean**2)
   
        return
        end

      !Covariance!!!!!!!!!!!!!!!!!!
 
      subroutine Covariance(a1,b1,S1,S2,S3,Covar,dim,history_index, & 
      index)
        integer dim,history_index,index
        real a1,b1,S1,S2,S3,Covar,history_index_r,index_r 
        dimension a1(0:index), b1(0:index)
        integer i
   
        S1=0
        S2=0
        S3=0
        Covar=0
     
        history_index_r = history_index*1.0
        index_r = index*1.0

        do i=0,index
         S1=S1+a1(i)
         S2=S2+b1(i)
         S3=S3+a1(i)*b1(i)
        enddo

      Covar=(1.0/history_index_r)*S3 - & 
      (S1/history_index_r)*(S2/history_index_r)
  
        return
        end

       !i line of Matrix E!!!!!!!!!!!!!

        subroutine Line(E,dim,i,L1,index)
        integer i,n,dim,index
        real, dimension(dim,0:index):: E
        real, dimension(0:index)::L1
  
        do n=0,index
         L1(n)=E(i,n)
        enddo

        return
        end 
