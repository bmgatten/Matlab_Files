%Set relevant parameters
l = 1; %m
r_w = 0.5; %m
dt = .05; %s (use .1, .5s later)

%% Move vertically over 5 seconds
%Set time values
T_final = 5; %s, time to translate linearly
%Set wheel speeds
wr = pi; %rad/s, right wheel velocity
wl = pi; %rad/s, left wheel velocity
%Set initial conditions
theta = pi/2; %rad, facing vertically up
x = 0; %m, horizontal position
y = 0; %m, vertical position
thetae=theta;
xe=x;
ye=y;

%set up a plot
axis([-20 1 -1 20]);
hold on
%Simulate and trace the vehicle moving vertically up
for i=0:dt:T_final
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    plot(x,y,'^g')
    [xe,ye,thetae] = KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
    plot(xe,ye,'.b')
end
%rotate the vehicle counterclockwise
theta = pi;
thetae = theta;
%% Move laterally
T_final = 5; %s, time to translate linearly
wr = 2*pi; %rad/s, right wheel velocity
wl = 2*pi; %rad/s, left wheel velocity
for i=0:dt:T_final
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    plot(x,y,'^g')
    [xe,ye,thetae] = KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
    plot(xe,ye,'.b')
end

%% Move Vertically Down
% Rotate the vehicle counterclockwise
theta = deg2rad(270);
thetae = theta;
T_final = 5; %s, time to translate linearly
for i=0:dt:T_final
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    plot(x,y,'^g')
    [xe,ye,thetae] = KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
    plot(xe,ye,'.b')
end
%% Move back to origin
% Rotate the vehicle counterclockwise
theta=0;
thetae=theta;
T_final = 5; %s, time to translate linearly
for i=0:dt:T_final
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    plot(x,y,'^g')
    [xe,ye,thetae] = KinematicEuler(xe,ye,thetae,wl,wr,r_w,l,dt);
    plot(xe,ye,'.b')
end