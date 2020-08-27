function trackCoord=genTrackCoord(tau,s,diam,dt,nFr)
%simulate a constant speed track arounda circle
%output is a table
%all spatial units in nm
% temporal units in s
%tau: track lifetime
%s: track speed
%diam: ring diameter
%dt: frame interval
%nFr, number of frames

%randomize velocity as +/- based on speed
v=s*(2*randi([0 1])-1);

%angular velocity omega=v/r
omega=2*v/diam;
dTheta=omega*dt;

%need to generate
% t_n (integer),theta_n, x_n, y_n
%generate midpoint of track, [t,theta]
tauFr=tau/dt;%track length in frames
frMid=randi(nFr);
thetaMid=rand*2*pi;
%calculate start and end points
frStart=max(1,round(frMid-tauFr/2));
frEnd=min(nFr,round(frMid+tauFr/2));
trackLenFr=frEnd-frStart+1;

thetaStart=mod(thetaMid-(frMid-frStart)*dt*omega,2*pi);

fr=[frStart:1:frEnd]';
t=fr/dt;
thetaRaw=[thetaStart:dTheta:thetaStart+dTheta*(trackLenFr-1)]';
theta=mod(thetaRaw,2*pi);
x=cos(theta)*diam/2;
y=sin(theta)*diam/2;

trackCoord=table;
trackCoord.fr=fr;
trackCoord.t=t;
trackCoord.theta=theta;
trackCoord.x=x;
trackCoord.y=y;
