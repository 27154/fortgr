! =======================================================
!     graphlib.f90
! =======================================================
      SUBROUTINE gINIT
      INCLUDE 'fgraph.fd'
      
      OPEN(iunit, FILE='plot.cmd', STATUS='REPLACE')
      OPEN(ipix, FILE='pixels.dat', STATUS='REPLACE')
      
      icolor = -1  ! Preto
      iobj = 0     ! Contador de objetos
      npix = 0     ! Contador de pixels
      
      RETURN
      END SUBROUTINE gINIT

! =======================================================
      SUBROUTINE WINDOW(x1,y1,x2,y2)
      INCLUDE 'fgraph.fd'
      REAL*8 x1, y1, x2, y2

      xwndo = x1
      ywndo = y1
      xwind = x2 - x1
      ywind = y2 - y1

      WRITE(iunit, *) 'set xrange [',x1,':',x2,']'
      WRITE(iunit, *) 'set yrange [',y1,':',y2,']'
      RETURN
      END SUBROUTINE WINDOW

! =======================================================
      SUBROUTINE LINE(x1,y1,x2,y2)
      INCLUDE 'fgraph.fd'
      REAL*8 x1, y1, x2, y2

      WRITE(iunit, '(A, F20.8, A, F20.8, A, F20.8, A, F20.8, A, I3)') & 
        'set arrow from ',x1,',',y1,' to ',x2,',',y2,' nohead lc ',icolor
      RETURN
      END SUBROUTINE LINE

! =======================================================
      SUBROUTINE NOC(number)
      INTEGER number
      number = 15
      RETURN
      END SUBROUTINE NOC

      SUBROUTINE COLOR(index)
      INCLUDE 'fgraph.fd'
      INTEGER index
      icolor = index
      RETURN
      END SUBROUTINE COLOR

      SUBROUTINE FILL(x1, y1, x2, y2)
      INCLUDE 'fgraph.fd'
      REAL*8 x1, y1, x2, y2
      iobj = iobj + 1
      
      WRITE(iunit, '(A, I5, A, F20.8, A, F20.8, A, F20.8, A, F20.8, &
     & A, I3, A)') &
     'set object ', iobj, ' rect from ', x1,',',y1, ' to ', x2,',', &
     y2, ' fc lt ', icolor, ' fs solid'
      RETURN
      END SUBROUTINE FILL

! =======================================================
      SUBROUTINE PIXEL(ix, iy)
      INCLUDE 'fgraph.fd'
      INTEGER ix, iy
      
!     Salva o pixel e incrementa o contador
      WRITE(ipix, *) ix, iy, icolor
      npix = npix + 1
      
      RETURN
      END SUBROUTINE PIXEL

      SUBROUTINE MAXVIEW(nx, ny)
      INTEGER nx, ny
      nx = 800
      ny = 600
      RETURN
      END SUBROUTINE MAXVIEW

! =======================================================    
!     Se tiver pixels (npix > 0), plota o arquivo de pixels.
!     Se nao tiver pixels (so linhas), plota 1/0 para ativar o grafico.
! =======================================================
      SUBROUTINE gEND
      INCLUDE 'fgraph.fd'
      
      CLOSE(ipix)
!    
!     WRITE(iunit, *) 'set size ratio -1' 
      
      IF (npix .GT. 0) THEN
!        Se for fractal/imagem, ratio -1 para nao distorcer
         WRITE(iunit, *) 'set size ratio -1'
         WRITE(iunit, *) 'plot "pixels.dat" using 1:2:3 with dots', &
     &   ' lc variable notitle'
      ELSE
!        Se for funcao normal (linhas).
         WRITE(iunit, *) 'set size noratio'
         WRITE(iunit, *) 'plot 1/0 notitle'
      END IF
      
      CLOSE(iunit)
      
      CALL EXECUTE_COMMAND_LINE('gnuplot -persist plot.cmd')
      RETURN
      END SUBROUTINE gEND

! =======================================================
!  Dummy 
! =======================================================
      SUBROUTINE VIEWPORT(x1,y1,x2,y2)
         REAL*8 x1, y1, x2, y2
         RETURN
      END SUBROUTINE VIEWPORT

      SUBROUTINE SCALE(ix1,iy1,ix2,iy2)
         RETURN
      END SUBROUTINE SCALE

      SUBROUTINE MOVE(x,y)
         REAL*8 x, y
         RETURN
      END SUBROUTINE MOVE

      SUBROUTINE DRAW(x,y)
         REAL*8 x, y
         RETURN
      END SUBROUTINE DRAW
