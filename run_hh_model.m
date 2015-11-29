function [t,y] = run_hh_model(T_final,pulse_height,pulse_width)
% This function is a front end interface to "hh_model" below which contains the diff eqs that define the Hodgkin-Huxley model.
% note that the state vector y is made up of [Vm,m,h,n,I].  Although injected current (I) isn't really 
% a state, it's included for purely technical reasons regarding the MATLAB implemention of the model
% Note that we're using a 10us (0.01ms) time resolution here.

if nargin <3, pulse_width=0.1; end  % set the default width if no pulse_width input is given
t = [0:.01:T_final]';
if ~ismember(pulse_width,t), disp('Error: Invalid pulse width.  Please choose a value divisible by 0.01.'); end 
t1 = [0:.01:pulse_width];
t2 = [pulse_width:.01:T_final];
[v0,m0,h0,n0] = deal(-61.9200, 0.0755, 0.4864, 0.3656); % set initial values for state variables

y0 = [v0,m0,h0,n0,pulse_height];     % initial condition of the state vector
[T1,Y1] = ode45('hod_hux',t1,y0);    % 1st part of the simulation: run the HH model during the pulse
y0 = [Y1(end,1:4), 0];               % "initial" condition for 2nd part of the simulation
[T2,Y2] = ode45('hod_hux',t2,y0);    % 2nd part of the  simulation: run the HH model after the pulse offset
y = [Y1;Y2(2:end,:)];                  % concatenate the results of part 1 & part 2, eliminating overlap
end
