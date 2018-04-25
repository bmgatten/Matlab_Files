function [ds,ext] = Function1_121(t,s)
%Equations of motion for spring pendulum

%Declare global variables
global L_o g k m;

%Write the equations of motion
%Explicit, 1st order $\dot{x} = f(x,u)$
r = s(1); %m, Pendulum radius 
theta = s(2); %rad, Pendulum Angle
v_r = s(3); %m/s, velocity
w = s(4); %rad/s, angular velocity


r_dot = v_r;  %m/s
theta_dot = w; %rad/s
v_r_dot = r*w^2+g*cos(theta) - k/m*(r-L_o); %m/s
w_dot = -g/r*sin(theta) - 2*v_r*w/r; %rad/s/s

%return the state derivatives
ds=[r_dot theta_dot v_r_dot w_dot]';

%return extra variables
%N/A
end

