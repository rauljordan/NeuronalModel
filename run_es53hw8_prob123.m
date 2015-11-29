% ---------------------- Starter m-file for HW-8a -----------------------
% ---------------------- RAUL EDUARDO JORDAN ES53 -----------------------

%-------------------------------  Problem 1  ----------------------------

% The equations below are from the Hodgkin-Huxley model (note that the paramaters
% are such that the units for membrane voltage are millivolts (mV)).

v=[-100:.1:50]';                            % make a column vector for v=v_mem  
a_m  = -0.1*(40+v)./(exp(-(40+v)/10)-1);    % a & b are intermediate variables                
b_m  = 4*exp(-(v+65)/18);
m_inf = a_m./(a_m+b_m);  % m_inf = "m-infinity" = the asymptotic value of m

m_inf_3 = m_inf.^3

a_h  = 0.07*exp(-(v+65)/20);                               
b_h  = 1./(exp(-(35+v)/10)+1);
h_inf = a_h./(a_h+b_h);% h_inf = "h-infinity" = the asymptotic value of h

m3_h_inf = (m_inf.^3).*h_inf;

a_n  = -0.01*(55+v)./(exp(-(55+v)/10)-1);                   
b_n  = 0.125*exp(-(v+65)/80);
n_inf = a_n./(a_n+b_n);% n_inf = "n-infinity" = the asymptotic value of n

n_inf_4 = n_inf.^4;


figure; plot(v,[m_inf,h_inf,n_inf, m3_h_inf, m_inf_3, n_inf_4])         % be sure to add axis labels & a legend to this plot as well as the traces for m^3, m^3*h, & n^4

title('Asymptotic Values of Gating Probabilities');
xlabel('Voltage in mV')
ylabel('Gating Probability')

%----------------------------  Problems 2 & 3  ----------------------------

% make sure that you look at y.a, y.b, etc, that are displayed in the MATLAB command window when this code 
% is run, as this text display shows the solutions to the differential equations we're defining below.

% 1-step reaction kinetics
y = dsolve('Da = -k*a', 'a(0) = 1', 'Db = k*a', 'b(0) = 0', 't'); 
disp('kinetics for 1-step rxn:'); disp(y.a); disp(y.b); 
k=2; t=[0:.001:4]'; 
figure; 
subplot(2,1,1); plot(t,1./exp(k*t)); 
subplot(2,1,2); plot(t,1 - 1./exp(k*t));
ylabel_list = {'a(t)','b(t)'};
for k=1:2, subplot(2,1,k); xlabel('Time'); ylabel(ylabel_list{k}); ylim([0 1]); end
subplot(2,1,1); title('Reactions kinetics for a --> b')

% 2-step reaction kinetics
y = dsolve('Da = -k*a', 'a(0) = 1', 'Db = k*a-k*b', 'b(0) = 0','Dc = k*b', 'c(0)=0','t'); 
disp('kinetics for 2-step rxn:'); disp(y.a); disp(y.b); disp(y.c) 
k=2; t=[0:.001:4]'; 
figure; 
subplot(3,1,1); plot(t,1./exp(k*t)); 
subplot(3,1,2); plot(t,(k*t)./exp(k*t));
subplot(3,1,3); plot(t,1 - (k*t)./exp(k*t) - 1./exp(k*t));
ylabel_list = {'a(t)','b(t)','c(t)'};
for k=1:3, subplot(3,1,k); xlabel('Time'); ylabel(ylabel_list{k}); ylim([0 1]); end
subplot(3,1,1); title('Reactions kinetics for a --> b --> c')


% Part 2d)

% plotting Response Time vs Steps
N = [1:5];
response_time = [0.5, 1, 1.4, 1.7, 2];

figure;
plot(N, response_time,'*');
title('Response Time vs. Steps')
xlabel('Steps')
ylabel('Response Time (s)')


%------------ Problem 3 -------------------

% plotting Response Time vs Steps
N = [1:5];
response_time = [0.62, 0.72, 0.83, 0.90, 0.95];

figure;
plot(N, response_time,'*');
title('Response Time vs. Steps')
xlabel('Steps')
ylabel('Response Time (s)')



%----------------------------  Problem 5  ----------------------------

[t,y] = run_hh_model(20,100,0.1);

[v,m,h,n,I] = deal(y(:,1),y(:,2),y(:,3),y(:,4),y(:,5));

figure;
hold on;
plot(t,v); ylabel('Membrane Voltage in mV');
title('What happens in Action Potentials');
xlabel('time in ms')

[t,y] = run_hh_model(20,36,0.1);

[v,m,h,n,I] = deal(y(:,1),y(:,2),y(:,3),y(:,4),y(:,5));
plot(t,v,'r');

hold off;









