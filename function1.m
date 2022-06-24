%lab1sim
function [y1sig,y2sig] = function1(A, B, L, sig)
twoA = 2*A; 
c = 333.3;
D_a = sqrt(B^2+(L-A)^2);
D_2a = sqrt(B^2+(L-twoA)^2);
tau1 = D_a/c; 
tau2 = D_2a/c;

t = min(tau1,tau2)-0.01:1/44100:max(tau1,tau2)+0.01; 

y1sig = sig(t-tau1);
y2sig = sig(t-tau2);
end