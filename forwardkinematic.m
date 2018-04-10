%% Lecture 3: Implement differential drive forward kinematic models %%
function [x, y, theta] = forwardkinematic(x,y,theta,wl, wr, r_w,l,dt) %Accept Rad/s as input
%Calculate Velocities
v_r = wr*r_w; %right wheel velocity
v_l = wl*r_w; %left wheel velocity
V = (v_r+v_l)/2; %Forward Velocity
w = (v_r-v_l)/l; %Rotational Velocity

%% Integration of Forward Kinematics Technique
%Calculate change in angle
theta = theta+ dt*w;
%Case1: No Rotation
if (v_r-v_l)<.001 %Do we use euler's method?
    x = V*dt*cos(theta)+x;
    y = V*dt*sin(theta)+y;
%Case 2: The car is rotating and translating
else
    %Calculate instantaneous distance from center of the car to the Icc
    R = l/w*((v_l+v_r)/(v_r-v_l));
    Iccx = x-R*sin(theta); %horizontal position of center of rotation
    Iccy = y+R*cos(theta); %vertical position of center of rotation
    x = (x-Iccx)*cos(w*dt)+(y-Iccy)*(-sin(w*dt))+Iccx; %Update horizontal position
    y = (x-Iccx)*sin(w*dt)+(y-Iccy)*cos(w*dt) + Iccy;  %Update vertical position
end
end