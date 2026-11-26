program mandelbrot
double precision x1, y1, x2, y2, x, y
complex*16 c, z, im
integer i, j, NX, NY, counter, ix0, iy0
parameter(im =(0.d0,1.d0), Max_interation = 6000)

integer, parameter :: res_x = 800
integer, parameter :: res_y = 600
! Start the package
call gINIT

call MAXVIEW(nx, ny)

ix0 = nx/2 - res_x/2
iy0 = ny/2 - res_y/2

x1 = -1.7d0
x2 = 0.8d0
y1 = -1.d0
y2 = 1.d0

do i = 0, res_x
  x = x1 + dble(i) *(x2 - x1)/dble(res_x)
    do j = 0, res_y
      y = y1 + dble(j) *(y2-y1)/dble(res_y)
      c = x + im*y
      
      z = 0.d0
      counter = 0
      100 z = z*z +c

      if(ABS(z) .lt. 2.d0) then
        counter = counter + 1

        if(counter .lt. Max_interation) GOTO 100

        call pixel( ix0+i, iy0+j )
      end if
    end do
end do
call gEND
end program mandelbrot
