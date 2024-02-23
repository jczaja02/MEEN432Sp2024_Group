%%% PROJECT 2 PARAMETERS %%% 
% The following parameters are to be used for Project 2, and some will be
% used for Project 3 which will be commented out at the bottom of the
% script. 

% Vehicle Parameters
carData.Inertia = 1600; % kg m^2  -  Car Inertia
carData.Mass = 1000; % kg      -  Car Mass 


% Initial Conditions
carData.init.X0 = 0;        % m - Initial X Position of the Car
carData.init.Y0 = 0;        % m - Initial Y Position of the Car
carData.init.vx0 = 0.1;     % m/s - Initial Velocity in X of the Car
carData.init.vy0 = 0;       % m/s - Initial Velocity in Y of the Car
carData.init.omega0 = 0;    % rad/s - Initial Yaw Rate of the Car
carData.init.psi0 = 0;      % rad - Initial Heading of the Car


% Vehicle Tire Information 
carData.Calpha_f = 40000; % N/rad - Front Tire Coefficient (slope)
carData.Calpha_r = 40000; % N/rad - Rear Tire Coefficient (slope)
carData.Fyfmax = 40000*1/180*pi; % N - Max Front Tire Force
carData.Fyrmax = 40000*1/180*pi; % N - Max Rear Tire Force
carData.lr = 1.5; % m - Distance from CG to rear axis
carData.lf = 1.0; % m - Distance from CG to front axis
carData.radius = 0.3; % m - Radius of tires


track_radius = 200;
carData.understeerCoeff = ... % Understeering Coefficient 
    carData.Mass / ((carData.lr + carData.lf) * track_radius) ...
      * (carData.lr / carData.Calpha_f - ...
         carData.lf / carData.Calpha_r);


carData.maxAlpha = 4 / 180 * pi; % Max Alpha Angle for Tires


carData.vxd = 10.0; % m/s - Desired Velocity in X
carData.vx_threshold1 = 0.1; % m/s - Threshold for Velocity in X


%%% PROJECT 3 EXTRA INFORMATION %%%
% Longitudinal Dynamics Properties
% carData.C0 = 0.0041;         % N - Static Friction Coefficient 
% carData.C1 = 0.000066;       % N/(m/s) - Rolling Friction Coefficient

% Parameters for Calculation of C2
% Rho =1.225;          % Kg/m^3 - Density of Atmosphere
% A  = 2.32;           % m^2 - Projected Area
% Cd = 0.36;           % unitless - Drag Coefficient
% carData.C2 = 0.5*Rho*A*Cd; % N/(m/s)^2 - Aerodynamic Drag Coefficient
