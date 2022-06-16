syms t

sig = @(t)1000*cos(880*pi*t); 

% fplot(sig*heaviside(t))

A = 0.5; 
B = 100; 
L = 100; 
c = 333.33; 

D_a = sqrt(B^2+(L-A)^2);
D_2a = sqrt(B^2+(L-2*A)^2);

tau1 = c/D_a; 
tau2 = c/D_2a;

lowerBound = min(tau1,tau2)-0.01; 
upperBound = max(tau1, tau2)+0.01;



function [one] = lab1sim(A, B, L, sig)

end
