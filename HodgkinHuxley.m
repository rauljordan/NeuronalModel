function dpdt = HodgkinHuxley(t,p)
% this function contains the diff eqs that define the Hodgkin-Huxley model.
% p is the state vector containing v,m,h,n and I_injected (in that order)

%various constants:
GNa = 120;    % GNa = the max possible value of gNa (mS)
GK = 36;      % GK = the max possible value of gK
GL = 0.3;     % the "leakage" current
VNa = 55;     % Nernst potential for Na (mv)
VK = -72;     % Nernst potential for K
VL = -50;     % Nernst potential for "leakage" - somewhat of a hack
C = 1;        % Membrane capacitance (uF/cm^2)

[v,m,h,n,I] = deal(p(1),p(2),p(3),p(4),p(5));  %extract individual state variables from p

gNa = GNa*m^3*h;
gK = GK*n^4;
gL = GL;

dvdt = (1/C)*(-gNa*(v-VNa) - gK*(v-VK) - gL*(v-VL) + I);   % Main HH equation - diff eq for v

a_m  = -0.1*(40+v)/(exp(-(40+v)/10)-1);                    % diff eq for m
b_m  = 4*exp(-(v+65)/18);
dmdt = a_m*(1-m) - b_m*m;

a_h  = 0.07*exp(-(v+65)/20);                               % diff eq for h
b_h  = 1/(exp(-(35+v)/10)+1);
dhdt = a_h*(1-h) - b_h*h;

a_n  = -0.01*(55+v)/(exp(-(55+v)/10)-1);                   % diff eq for n
b_n  = 0.125*exp(-(v+65)/80);
dndt = a_n*(1-n) - b_n*n;

dIdt = 0;
dpdt = [dvdt,dmdt,dhdt,dndt,dIdt]';

end
