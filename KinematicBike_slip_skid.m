function [x, y, theta,gamma,v] = KinematicBike_slip_skid(x, y, theta, gamma_d, gamma, tau_g, v_d, tau_v, delta_1, s, delta_2,w, r_w,l,dt,DT) %Accept Rad/s as inputs for wl and wr
%gamma_d - desired steering angle
%tau_g - s, gamma time constant
%v_d - desired velocity
%tau_d- m/s, velocity time constant
%DT - s,time it takes to read state from sensors
%dt - s,Integration time step
%delta_1 - front wheel skiding slip angle
%s = rear wheel slip
%delta_2 - rear wheel slip angle

%define velocities
v = r_w*w; %m/s, rear tire speed w/o slip
v = (1-s)*v; %m/s, rear tire speed with slip
vy = v*tan(delta_2); %m/s, horizontal skid tire speed

%Enforce input constraints
gamma_max = deg2rad(45); %rad, maximum steering angle
gamma_min = -gamma_max; %rad, the minimum steering angle
v_max = 5; %m/s, maximum speed
v_min = -v_max;
if gamma_d > gamma_max
    gamma_d = gamma_max; 
elseif gamma_d < gamma_min
    gamma_d = gamma_min;
else
end

if v_d > v_max
    v_d = v_max;
elseif v_d < v_min
    v_d = v_min;
else
end

%integration
for i=0:dt:DT-dt
    %enforce output constraints later
    x = x + dt*(v*cos(theta)-vy*sin(theta)); %m, horizontal position
    y = y + dt*(v*sin(theta)+vy*cos(theta)); %m, vertical position
    theta= theta + dt*(v*tan(gamma+delta_1)-vy)/l; %rad, orientation
    
    %If time constants are zero, make steering angle and speed desired
    if tau_v == 0
        v = v_d; %m/s rear wheel speed
    else
        v = v + dt*(-v+v_d)/tau_v; %m/s, rear wheel speed
    end
    if tau_g == 0
        gamma = gamma_d;%rad, steering angle
    else
        gamma = gamma + dt*(-gamma+gamma_d)/tau_g; %rad, steering angle
        display(gamma);
    end
    
    %Enforce output constraints
    %Steering angle
    if gamma>gamma_max
        gamma=gamma_max; %rad
    elseif gamma<gamma_min
        gamma=gamma_min; %rad
    end
    
    %vehicle speed
    if v>v_max
        v = v_max; %m/s
    elseif v<v_min
        v = v_min; %m/s
    end
end