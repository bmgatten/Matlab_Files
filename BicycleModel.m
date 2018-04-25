%% Assignment 1: Part 3/4, Bicycle model

%Define geometric parameters
r_w = 0.5; %m, wheel radius
l = 2.5; %m, wheel base

%Define slip/skid angles
delta_1 = deg2rad(-4); %rad, front wheel skiding slip angle
s = 0.0; %rear wheel slip coefficient
delta_2 = deg2rad(4); %rad, rear wheel skid angle

%Define initial vehicle conditions
x=0; %m, horizontal position
y=0; %m, vertical position
theta=deg2rad(90); %rad, orientation
v = 0; %rad/s, rear wheel velocity
gamma = 0; %rad, initial steer angle
%Define initial vehicle conditions for the second plot
xs = x; %m, horizontal position
ys = y; %m, vertical position
thetas = theta; %rad, orientation
vs = v;  %rad/s, rear wheel velocity
gammas = gamma; %rad, initial steer angle

%Define times
dt = 0.01; %s, integration time step
DT = dt; %s, controller sampling interval
tau_g = 0; %s, steering angle time constant
tau_v = 0; %m/s, velocity time constant

%Desired steering angle & vehicle velocity
gamma_d = deg2rad(90); %rad, desired steering angle
v_d = 5; %m/s, desired velocity

%Apply closed loop control to turn a semi-circle
hold on;
while theta < deg2rad(270)
    [x, y, theta, gamma, v] = KinematicBike_slip_skid(x,y,theta,gamma_d, gamma, tau_g, v_d, tau_v, delta_1, s, delta_2, v, r_w,l,dt,DT);
    plot(x, y, '+g');
%     [xs, ys, thetas, gammas, vs] = KinematicBike_slip_skid(xs,ys,thetas,gamma_d, gammas, tau_g, v_d, tau_v, delta_1, s, delta_2, vs, r_w,l,dt,DT);
%     plot(xs,ys,'.b');
end

axis equal;
title('Part 3: Bicycle Model, \delta_1=-4, \delta_2=4');
ylabel('Meters');
xlabel('Meters');
%% Assignment 1: Part 4
%Implement a step function for the steering angle, gamma_d
%Define geometric parameters
r_w = 0.5; %m, wheel radius
l = 2.5; %m, wheel base

%Define slip/skid angles
delta_1 = deg2rad(0); %rad, front wheel skiding slip angle
s = 0; %rear wheel slip coefficient
delta_2 = deg2rad(0); %rad, rear wheel skid angle

%Define initial vehicle conditions
x=0; %m, horizontal position
y=0; %m, vertical position
theta=deg2rad(90); %rad, orientation
v = 0; %rad/s, rear wheel velocity
gamma = 0; %rad, initial steer angle

%Define times
dt = 0.01; %s, integration time step
DT = dt; %s, controller sampling interval
tau_g = 2; %s, steering angle time constant
tau_v = 0; %m/s, velocity time constant
T_final = 5; %s, simulation time

%Desired steering angle & vehicle velocity
gamma_d = deg2rad(45); %rad, desired steering angle
v_d = 5; %m/s, desired velocity

%Plot vehicle position for a ramp input steering angle
hold on

while theta < deg2rad(270)
    if sqrt(x^2+y^2) < 2 %distance travelled is less than 2 meters
        gamma_d = 0; %steering angle is zero
    else
        gamma_d = deg2rad(45);
    end
    [x, y, theta, gamma, v] = KinematicBike_slip_skid(x,y,theta,gamma_d, gamma, tau_g, v_d, tau_v, delta_1, s, delta_2, v, r_w,l,dt,DT);
    plot(x,y,'.g');
end

axis equal;
title('Part 4: Bicycle Model, \tau_v=1');
ylabel('Meters');
xlabel('Meters');
%%
legend('\tau_g=0','\tau_g=1','\tau_g=2');