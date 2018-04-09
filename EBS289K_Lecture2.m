%% Textbook Examples pgs. 22-24
%make a homogeneous transformation using se2
%se2(X,Y,theta) -in radians
T1 = se2(1,2,30*pi/180); %T1 is now the transform matrix
axis([0 5 0 5]);
hold on
trplot2(T1,'frame','1','color','b')

%create another pose with displacement 2,1 and no rotation
T2 = se2(2,1,0);
%plot in red
trplot2(T2,'frame','2','color','r');

%Compose two relative poses
T3 = T1*T2;
trplot2(T3,'frame','3','color','g');
%note that compositions are not commutative.
%T2*T1 != T1*T2
T4 = T2*T1;
trplot2(T4,'frame','4','color','c');

%Define a new point relative to the world frame
P = [3;2];
plot_point(P,'*');
%We can determine the coordinate of the point
%with respect to {1} by using...
P1 = inv(T1)*[P;1];
%note that the Enclidian point must have
%an additional 1 to be in homogeneous form.
%The following operation does the same.
h2e(inv(T1)*e2h(P));
%the following operation does the same
homtrans(inv(T1),P);


%% In class problem: Fruit localization
%Known Robot Pose:
x=5;
y=4;
theta = 45*pi/180;
T_robot = se2(x,y,theta);
%Known Camera Pose:
x=2;
y=-.2;
theta = -30*pi/180;
T_camera = se2(x,y,theta);
%% Plot the Reference Frames
hold off
trplot2(T_robot,'frame','R','color','m');
axis([0 14 -2 7]);
hold on
trplot2(T_camera,'frame','C','color','b');
%Given the 10 fruit positions from camera
%Recover fruit coordinates in {F}
p1 = [-1.7326;-2.7593];
p2 = [4.6739;-2.8955];
p3 = [-1.8295;-2.4566];
p4 = [-1.6129;-2.7695];
p5 = [3.0871;-2.6233];
p6 = [-1.4017; -2.9581];
p7 = [6.0614; -2.9787];
p8 = [6.1569; -2.5992];
p9 = [4.9803; -3.3158];
p10 = [-.9346; -3.2678];

%Transforming from cameraframe->robotframe->worldframe
T = T_robot*T_camera;
homtrans(T,p1)
homtrans(T,p2)
homtrans(T,p3)
homtrans(T,p4)
homtrans(T,p5)
homtrans(T,p6)
homtrans(T,p7)
homtrans(T,p8)
homtrans(T,p9)
homtrans(T,p10)
