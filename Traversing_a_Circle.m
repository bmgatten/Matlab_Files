%Set relevant parameters
l = 1; %m
r_w = 0.5; %m
dt = .01; %s (use .1, .5s later)

%Set speeds
wr = pi;%rad/s
wl = pi/6;%rad/s
vr = wr*r_w;%m/s
vl = wl*r_w;%m/s
V = (vr+vl)/2; %Forward Velocity

%Set initial conditions
theta = pi/2; %rad, facing vertically up
x = 0; %m, horizontal position
y = 0; %m, vertical position
thetae = theta;
xe = x;
ye = y;

%Determine the time to traverse the circle
%?: Should we be simulating with wheel encoders or is this time based?
R = l/2*(vl+vr)/(vr-vl); %Radius of the circle
T_final = 2*pi*R/V; %s, Time to traverse the circle 
%Simulate and trace the vehicle
axis([-4*R R -2*R 2*R])
hold on
for i=0:dt:T_final
    [x,y,theta] = forwardkinematic(x,y,theta,wl,wr,r_w,l,dt);
    plot(x,y,'^g')
    [xe,ye,thetae]=KinematicEuler(xe,ye,theta,wl,wr,r_w,l,dt);
    plot(xe,ye,'.b')
end