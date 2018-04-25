function [x, y, theta] = KinematicEuler(x,y,theta,wl, wr, r_w,l,dt) %Accept Rad/s as inputs for wl and wr
%KinematicEuler determines a new position vector from rotational wheel
%velocities and time steps

%Calculate Velocities
v_r = wr*r_w; %right wheel velocity
v_l = wl*r_w; %left wheel velocity
V = (v_r+v_l)/2; %Forward Velocity
w = (v_r-v_l)/l; %Rotational Velocity
%Euler's Method
x = x + dt*V*cos(theta); %m
y = y + dt*V*sin(theta); %m
theta = theta+ dt*w; %rad
end