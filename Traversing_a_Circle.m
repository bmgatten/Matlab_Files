%% Assignment 1: Part 1
%% Traversing a Circle
%Set relevant parameters
l = 1; %m, width of the vehicle
r_w = 0.5; %m, radius of the wheel
dt = .5; %s (use .1, .5s later)

%Set speeds
wr = pi/10;%rad/s, right wheel rot. velocity
wl = pi/20;%rad/s, left wheel rot. velocity
vr = wr*r_w;%m/s, right wheel lin. velocity
vl = wl*r_w;%m/s, left wheel lin. velocity
V = (vr+vl)/2; %m/s, Forward Velocity

%set times
dt=.5; %s, integration time step
R = l/2*((vl+vr)/(vr-vl)); %m, radius of the circle
Tfinal= 2*pi*R/V; %s, time to traverse a circle w/radius R

%Set initial conditions
theta = pi/2; %rad, facing vertically up
x = 0; %m, horizontal position
y = 0; %m, vertical position
%Initial conditions for Euler Integration
thetae = theta;
xe = x;
ye = y;
 
%Simulate and trace the vehicle
hold on
for i=0:dt:Tfinal
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);  
    plot(x,y,'+g')
% %     T(1,1)=x;
% %     T(2,1)=y;
% %     T(3,1)=theta;
% %     plotTractor(T,l,wr)
     [xe,ye,thetae]=KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
     plot(xe,ye,'.b')
 end
axis equal %Places the object in the center
legend('ICC Integration','Euler Integration')
title(['\deltat= 0.5seconds'])
%% Assignment 1: Part 2
%Traversing a circle with slip and skid
%Assign a linear velocity of 5m/s
%%
% $$V_{linear} = \frac{\omega_r r_{wheel}+\omega_l r_{wheel}}{2}$$
%Rewrite the left wheel angular velocity in terms of the right wheel
%%
% $$\omega_l = \frac{2*V_{linear}}{r_{wheel}} - \omega_r $$
%Establish velocities
V = 5;%m/s, linear velocity
wr = 4*pi; %rad/s, right wheel angular velocity
l = 1; %m, width of the vehicle
r_w = 0.5; %m, radius of the wheel
dt = .05; %s

%Rough estimate of wl using non-slip condition
wl = 2*V/r_w - wr; %rad/s, left wheel velocity 
%estimate linear wheel speeds
vr=r_w*wr; %m/s
vl=r_w*wl; %m/s
%Set slip/skid parameters
sl = 0.1;
sr = 0.2;
delta = deg2rad(5);

%Set initial orientation
theta = pi/2; %rad, facing vertically up
x = 0; %m, horizontal position
y = 0; %m, vertical position
%set initial conditions for second plot
thetas=theta; %rad
xs=x; %m
ys=y; %m

%Set times
R = l/2*((vl+vr)/(vr-vl)); %m, radius of the circle
Tfinal= 2*pi*R/V; %s, time to traverse a circle w/radius R
%Simulate and trace the vehicle
hold on;
for i=0:dt:T_final
    [x,y,theta] = KinematicEuler_slip_skid(x,y,theta,0,0,0,wl,wr,r_w,l,dt);
    plot(x,y,'+g')
    [xs,ys,thetas] = KinematicEuler_slip_skid(xs,ys,thetas,sl,sr,delta,wl,wr,r_w,l,dt);
    plot(xs,ys,'.b')
end

axis equal %Places the object in the center
title('Plot 4');
legend('Slip_L=0, Slip_R=0, \delta=0','Slip_L=0.1, Slip_R=0.2, \delta=5');
% title('Plot 3');
% legend('Slip_L=0, Slip_R=0, \delta=0','Slip_L=0, Slip_R=0, \delta=5');
% title('Plot 2');
% legend('Slip_L=0, Slip_R=0, \delta=0','Slip_L=0.1, Slip_R=0.2, \delta=0');
% title('Plot 1');
% legend('Slip_L=0, Slip_R=0, \delta=0');