%syms t

%sig = @(t)1000*cos(880*pi*t); 

%fplot(sig*heaviside(t))

signalFrequency = 880*pi;

A = 0.5;
twoA = 2*A; 
B = 100; 
L = 100; 
c = 333.33; 

D_a = sqrt(B^2+(L-A)^2);
D_2a = sqrt(B^2+(L-twoA)^2);

tau1 = c/D_a; 
tau2 = c/D_2a;

lowerBound = min(tau1,tau2)-0.01; 
upperBound = max(tau1, tau2)+0.01;

fs = 44100; 
inverseFs = 1/fs;

t = lowerBound:inverseFs:upperBound;
signal = @(t)1000*cos(signalFrequency*t);

subplot(2,1,1);
plot(t,signal(t-tau1))

subplot(2,1,2); 
plot(t,signal(t-tau2))


function [y1sig,y2sig] = lab1sim(A, B, L, sig)

twoA = 2*A; 
c = 333.3;
D_a = sqrt(B^2+(L-A)^2);
D_2a = sqrt(B^2+(L-twoA)^2);
tau1 = c/D_a; 
tau2 = c/D_2a;

lowerBound = min(tau1,tau2)-0.01; 
upperBound = max(tau1, tau2)+0.01;

fs = 44100; 
inverseFs = 1/fs;

t = lowerBound:inverseFs:upperBound;

y1sig = sig(t-tau1);
y2sig = sig(t-tau2);

end
