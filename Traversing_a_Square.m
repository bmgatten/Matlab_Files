%% Assignment 1: Part 1
%Set relevant parameters
l = 1; %m
r_w = 0.5; %m
dt = .5; %s (use .1, .5s later)

% Move Up Vertically Over 5 Seconds
%Set time values
T_final = 50; %s, time to translate linearly
%Set wheel speeds
wr = pi/10; %rad/s, right wheel velocity
wl = pi/10; %rad/s, left wheel velocity
%Set initial conditions
theta = pi/2; %rad, facing vertically up
x = 0; %m, horizontal position
y = 0; %m, vertical position
thetae=theta;
xe=x;
ye=y;

%set up a plot
axis([-15 6 -7 15]);
hold on
%Simulate and trace the vehicle moving vertically up
for i=0:dt:T_final
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    plot(x,y,'+g')
    [xe,ye,thetae] = KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
    plot(xe,ye,'.b')
end

% Rotate the Vehicle Counterclockwise
%Move Wheel Velocities In Opposite Directions
wl = -wr;
V_r = wr*r_w; %m/s, velocity of the right wheel
T_turn = pi*l/4/V_r;  %s, Time it takes to rotate the vehicle 90 degrees
for(t=0:dt:T_turn)
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    [xe,ye,thetae] = KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
end
wl = wr; %Make the wheel velocities the same again.
hold on;
% Move Left Laterally
for i=0:dt:T_final
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    plot(x,y,'+g')
    [xe,ye,thetae] = KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
    plot(xe,ye,'.b')
end
%Move Wheel Velocities In Opposite Directions
wl = -wr;
% Rotate the Vehicle Counterclockwise
for i=0:dt:T_turn
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    [xe,ye,thetae] = KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
end
wl = wr; %Make the wheel velocities the same again.

% Move Vertically Down
hold on;
for i=0:dt:T_final
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    plot(x,y,'+g')
    [xe,ye,thetae] = KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
    plot(xe,ye,'.b')
end

% Rotate the Vehicle Counterclockwise
%Move Wheel Velocities In Opposite Directions
wl = -wr; %rad/s
hold on;
for i=0:dt:T_turn
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    [xe,ye,thetae] = KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
end

wl = wr; %Make the wheel velocities the same again.

% Move Right Laterally (back to origin)
for i=0:dt:T_final
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    plot(x,y,'+g')
    [xe,ye,thetae] = KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
    plot(xe,ye,'.b')
end
axis equal
legend('ICC Integration','Euler Integration')
title(['\deltat= 0.5seconds'])

%% Assignment 1: Part 2
%Traversing a Square with slip and skid.
V = 5;%m/s, linear velocity
l = 1; %m, width of the vehicle
r_w = 0.5; %m, radius of the wheel
dt = .005; %s, integration time step

%Set the wheel velocities to be the same (assuming no slip condition)
wr = V/r_w;
wl=wr;

%Set slip/skid parameters
sl = 0.1; %left slip
sr = 0.2; %right slip
delta = deg2rad(5); %rad, slip angle

%Set initial orientation
theta = pi/2; %rad, facing vertically up
x = 0; %m, horizontal position
y = 0; %m, vertical position
%set initial conditions for second plot
thetas=theta; %rad
xs=x; %m
ys=y; %m

%Simulate and trace the vehicle
hold on;

%set times
T_final = 10; %s, amount of time to actuate the wheel motors
T_turn=pi*l/4/(wr*r_w); %s, amount of time to turn the vehicle 90deg
%Simulate and trace the vehicle moving vertically up
for i=0:dt:T_final
    [x,y,theta] = KinematicEuler_slip_skid(x,y,theta,0,0,0,wl,wr,r_w,l,dt);
    plot(x,y,'+g')
    [xs,ys,thetas] = KinematicEuler_slip_skid(xs,ys,thetas,sl,sr,delta,wl,wr,r_w,l,dt);
    plot(xs,ys,'.b')
end
hold on;
% Rotate the Vehicle Counterclockwise
%Move Wheel Velocities In Opposite Directions
wl = -wr; %rad/s
for (i=0:dt:T_turn)
    [x,y,theta] = KinematicEuler_slip_skid(x,y,theta,0,0,0,wl,wr,r_w,l,dt);
    [xs,ys,thetas] = KinematicEuler_slip_skid(xs,ys,thetas,sl,sr,delta,wl,wr,r_w,l,dt);
end

wl = wr; %Make the wheel velocities the same again.
% Move Left Laterally
for i=0:dt:T_final
    [x,y,theta] = KinematicEuler_slip_skid(x,y,theta,0,0,0,wl,wr,r_w,l,dt);
    plot(x,y,'+g')
    [xs,ys,thetas] = KinematicEuler_slip_skid(xs,ys,thetas,sl,sr,delta,wl,wr,r_w,l,dt);
    plot(xs,ys,'.b')
end

% Rotate the Vehicle Counterclockwise
%Move Wheel Velocities In Opposite Directions
wl = -wr;
for i=0:dt:T_turn
    [x,y,theta] = KinematicEuler_slip_skid(x,y,theta,0,0,0,wl,wr,r_w,l,dt);
    [xs,ys,thetas] = KinematicEuler_slip_skid(xs,ys,thetas,sl,sr,delta,wl,wr,r_w,l,dt);
end
wl = wr; %Make the wheel velocities the same again.

% Move Vertically Down
for i=0:dt:T_final
    [x,y,theta] = KinematicEuler_slip_skid(x,y,theta,0,0,0,wl,wr,r_w,l,dt);
    plot(x,y,'+g')
    [xs,ys,thetas] = KinematicEuler_slip_skid(xs,ys,thetas,sl,sr,delta,wl,wr,r_w,l,dt);
    plot(xs,ys,'.b')
end

% Rotate the Vehicle Counterclockwise
%Move Wheel Velocities In Opposite Directions
wl = -wr; %rad/s
for (i=0:dt:T_turn)
    [x,y,theta] = KinematicEuler_slip_skid(x,y,theta,0,0,0,wl,wr,r_w,l,dt);
    [xs,ys,thetas] = KinematicEuler_slip_skid(xs,ys,thetas,sl,sr,delta,wl,wr,r_w,l,dt);
end
wl = wr; %Make the wheel velocities the same again.

% Move Right Laterally (back to origin)
for i=0:dt:T_final
    [x,y,theta] = KinematicEuler_slip_skid(x,y,theta,0,0,0,wl,wr,r_w,l,dt);
    plot(x,y,'+g')
    [xs,ys,thetas] = KinematicEuler_slip_skid(xs,ys,thetas,sl,sr,delta,wl,wr,r_w,l,dt);
    plot(xs,ys,'.b')
end
 axis equal;
% title(['Plot 1'])
% legend('Slip_L=0, Slip_R=0, \delta=0');
%title(['Plot 2'])
%legend('Slip_L=0, Slip_R=0, \delta=0','Slip_L=0.1, Slip_R=0.2, \delta=0deg');
% title(['Plot 3'])
% legend('Slip_L=0, Slip_R=0, \delta=0','Slip_L=0, Slip_R=0, \delta=5deg');
title(['Plot 4'])
legend('Slip_L=0, Slip_R=0, \delta=0','Slip_L=0.1, Slip_R=0.2, \delta=5deg');
ylabel('meters')
xlabel('meters')