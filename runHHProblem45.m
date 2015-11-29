%% Problem 4A
[t,y] = run_hh_model(20,100,0.1);  % run the HH model for 20ms applying a currrent pulse 100uA/cm^2 high & 0.1ms wide.
[v,m,h,n,I] = deal(y(:,1),y(:,2),y(:,3),y(:,4),y(:,5));  % extract the individual variables of interest from the state vector, y. 

GNa = 120;      % max possible sodium conductnce (mS)
GK = 36;        % max possible potassium conductnce (mS)

gNa = GNa.*m.^3.*h;  % ** replace this with the correct expression for gNa!!!
gK = GK.*n.^4;    % ** replace this with the correct expression for gK!!!

figure;
subplot(3,1,1); plot(t,v); ylabel('Membrane Voltage (mv)'); title('What happens during an Action Potiential')
subplot(3,1,2); plot(t,[gNa,gK]); ylabel('Conductance (mS)'); legend({'gNa','gK'})   
subplot(3,1,3); plot(t,[m,h,n]); ylabel('Open Probability'); legend({'m','h','n'}); xlabel('Time (ms)');
for k=1:3, subplot(3,1,k); xlim([-1 20]); end
 

%% Problem 4B
current_amplitude_list = [0:1:100]';  N = length(current_amplitude_list); 
vmax = zeros(N,1); %initialize vmax
for k = 1:N,
    [t,y] = run_hh_model(10,current_amplitude_list(k),0.1);
    v = y(:,1);                    % extract the membrane voltage (v) from the state vector (y) 
    vmax(k) = max(v);
end
figure; plot(current_amplitude_list,vmax,'.-');
xlabel('Amplitide of a 0.1ms Current Pulse (uA/cm^2)')
ylabel('Peak Depolarization (mv)')
title('"All or none" behavior in Action Potential firing')

%% Problem 4C goes here
% note that the code will mostly look like that for 2B.  
% The main differences would be that current_amplitude_list should be restricted to the middle 6 values 
% instucted in the problem statement, and a plot statement will need to be inserted inside the for loop
current_amplitude_list = [33:1:38]';
N = length(current_amplitude_list);

vmax = zeros(N,1);
figure;
for k = 1:N,
  [t,y] = run_hh_model(10,current_amplitude_list(k),0.1);
  v = y(:,1);
  hold on;
  plot(t,v,'-');
end

hold off;
ylim([-65 -50])
xlabel('Time in ms')
ylabel('Peak Depolarization in mV')
title('Vmem Subthreshold and Superthreshold')
%% Problem 4D goes here
% note that this code will again mostly look like that for 2B.  
% The main differences would be that inside the for loop you need to keep track of the time at which 
% the peak depolarization occurs rather than the voltage level at this peak.
current_aplitude_list = [0:1:100]';
N = length(current_amplitude_list);
for k = 1:N,
  [t,y] = run_hh_model(10, current_amplitude_list(k),0.1);
  v = y(:,1);

  vmax = max(v);
  timemax = t(find(v == vmax));
end

figure;
plot(current_amplitude_list, timemax, '.-');
ylabel('Time in ms')
xlabel('Amplitude of 0.1 ms of current pulse')
title('TimeMax')

%% Problem 4E goes here
% although you're not required to show it, a plot like that in 2B would be helpful in determining 
% the current amplitude threshold for AP firing when the pulse width is 50us rather than 100us
current_amplitude_list = [0:1:100]';
N = length(current_amplitude_list);

vmax = zeros(N,1);
for k = 1:N,
  [t,y] = run_hh_model(10, current_amplitude_list(k), 0.05);
  v = y(:,1);
  vmax(k) = max(v);
end
figure;
plot(current_amplitude_list, vmax,'.-');
xlabel('Amplitude of a 0.05ms Current pulse')
ylabel('Peak Depolarization in mV')
title('All or None in an Action Potential')



   


