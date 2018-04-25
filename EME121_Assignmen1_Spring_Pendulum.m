%% EME 121: Assignment 1
%Nick, Ben
%Simulating a Spring Pendulum

%Clean up
close all;
clearvars;
clc;

%Define global variables
global L_o g k m;
%Set relevant parameters
L_o = 1;%m, free length of the spring
g = 9.8; %m/s/s, acceleration due to gravity
m = 5;%kg, point mass

%% Pendulum Angle for A Stiff Spring
%Set the spring stiffness
fn = 1; %hz
%Set a very high spring stiffness
k=10000;%N/m
%Set the initial conditions for the states
theta = deg2rad(45);%rad, initial angle
r = L_o;  %m, initial pendulum length
v_r=0; %m/s, initial radial velocity
w=0; %4rad/s, initial angular velocity
initial=[r,theta,v_r,w]'; %Initial states
tspan=linspace(0,4,1001); %time array
%Integrate the equations of motion over tspan
[t,s]=ode45(@Function1_121,tspan,initial);
%Plot Figure 3.2
plot(tspan,rad2deg(s(:,2)))
title('Figure 3.2: Pendulum angle when a spring is very stiff');
grid on;
axis([0 4 -60 60]);
xlabel('Time, s');
ylabel('Pendulum angle, degrees');

%% Pendulum length for a stiff spring
plot(tspan,s(:,1));
title('Figure 3.3: Pendulum length when a spring is very stiff');
grid on;
xlabel('Time, s');
ylabel('Pendulum Length, m');
grid on;
%% Pendulum Length Versus Angle
fn=1; %hz, natural frequency 
k=m*(2*pi*fn)^2; %N/m
r=L_o;%m, initial radius
theta=deg2rad(45);%rad, initial angle
initial=[r,theta,v_r,w]'; %Initial states
tspan=linspace(0,4,1001); %time array
%Integrate the equations of motion over tspan
[t,s]=ode45(@Function1_121,tspan,initial); %Numerical Integration
plot(rad2deg(s(:,2)),s(:,1));
title('Figure 3.4: Pendulum length versus angle for \theta=45 and r_{ini}=L_o');
xlabel('Pendulum angle, degrees');
ylabel('Pendulum length, m');
axis([-60 60 1 1.6]);
grid on;
%% Pendulum Length Versus Angle Pt. 2
%Set initial condition
r=2*L_o;%m, initial pendulum radius
initial=[r,theta,v_r,w]'; %Initial states
[t,s]=ode45(@Function1_121,tspan,initial); %Numerical Integration
plot(rad2deg(s(:,2)),s(:,1));
title('Figure 3.5: Pendulum length versus angle for \theta=45 and r_{ini}=2L_o');
xlabel('Pendulum angle, degrees');
ylabel('Pendulum length, m');
axis([-60 60 0.5 2]);
grid on;
