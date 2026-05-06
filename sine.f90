program sine
double precision x1, y1, x2, y2
integer i

! adapted function from Paul Devries
call gINIT
! Data range 0 < x < 10 ; -1 < y < 1
x1 = 0.d0
x2 = +10.d0
y1 = -1.d0
y2 = 1.d0
call WINDOW(x1, y1, x2, y2)
call NOC( number )
call COLOR(2)
call FILL(x1, y1, x2, y2)
! Draw x-axis
call LINE(x1, 0.d0, x2, 0.d0)

!tickmarks on x-axis
y1 = -0.04d0
y2 = 0.00d0
do i = 1, 10
  x1 = dble(i)
  call LINE(x1, y1, x1, y2)
end do

! Draw y-axis
call LINE(x1, y1, x1, y2)
end program test
call color(1)
!Draw sine curve
do i = 1, 50
  x1 = dble(i-1)*0.2d0
  y1 = sin(x1)
  x2 = dble( i )*0.2d0
  y2 = sin(x2)
  call LINE(x1, y1, x2, y2)
end do

call gEND
end program sine
