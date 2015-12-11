%%--------------- Gating Probabilities  ----------------
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


figure; plot(v,[m_inf,h_inf,n_inf, m3_h_inf, m_inf_3, n_inf_4])

title('Asymptotic Values of Gating Probabilities');
xlabel('Voltage in mV')
ylabel('Gating Probability')



%%--------------- What Happens in the Action Potential  ----------------

[t,y] = RunHH(20,100,0.1);

[v,m,h,n,I] = deal(y(:,1),y(:,2),y(:,3),y(:,4),y(:,5));

figure;
hold on;
plot(t,v); ylabel('Membrane Voltage in mV');
title('What happens in Action Potentials');
xlabel('time in ms')

[t,y] = RunHH(20,36,0.1);

[v,m,h,n,I] = deal(y(:,1),y(:,2),y(:,3),y(:,4),y(:,5));
plot(t,v,'r');

hold off;
