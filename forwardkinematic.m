%% Lecture 3: Implement differential drive forward kinematic models %%
function [x, y, theta] = forwardkinematic(wr, wl, Rw)
%Set relevant parameters
l = 1; %m
r_w = 0.5; %m
dt = .05; %s (use .1, .5s later)

%set inital conditions
x=0;
y=0;
theta=0;

v_r = wr*r_w; %right wheel velocity
v_l = wl*r_w; %left wheel velocity
V = (v_r+v_l)/2; %Forward Velocity
w = (v_r-v_l)/l; %Rotational Velocity

%Euler's Method
x = x + dt*V*cos(theta);
y = y + dt*V*sin(theta);
theta = theta+ dt*w;

%% Integration of Forward Kinematics Technique

%Instantaneous distance from center of the car to the Icc
R = L/w*((v_l+v_r)/(v_r-v_l)); 
%horizontal position in the world frame
Iccx = x-R*sin(theta); %horizontal position of center of rotation
Iccy = y+R*cos(theta); %vertical position of center of rotation

x = (x-Iccx)*cos(w*dt)+(y-Iccy)*(-sin(w*dt))+Iccx;
y = (x-Iccx)*sin(w*dt)+(y-Iccy)*cos(w*dt) + Iccy;
