a = 0.5; 
b = 100; 
l = 100; 
c = 333.33;

D_a = sqrt(b^2+(l-a)^2);
D_2a = sqrt(b^2+(l-2*a)^2);

tau1 = D_a/c; 
tau2 = D_2a/c;

lowerBound = min(tau1,tau2)-0.01; 
upperBound = max(tau1, tau2)+0.01;

fs = 44100; 
inverseFs = 1/fs;

t = lowerBound:inverseFs:upperBound; 

s = @(t)1000*cos(880*pi*t);

y1 = s(t-tau1); 
y2 = s(t-tau2);

subplot(2,1,1);
plot(t,y1);

title('Plot of y1(t) and y2(t)')
xlabel('min(tau1,tau2)-0.01 < t < max(tau1,tau2)+0.01') 
ylabel('y1(t) values')

subplot(2,1,2);
plot(t,y2);

xlabel('min(tau1,tau2)-0.01 < t < max(tau1,tau2)+0.01') 
ylabel('y2(t) values')

% Now I am going to use the function to generate two signals and I will
% plot the signals

[y1signal, y2signal] = lab1sim(0.5, 100, 100, @(t)1000*cos(880*pi*t));

%Now I want to plot these to see if they are the same as the previous
%plots.

figure();

subplot(2,1,1);
plot(t,y1signal);

title('Function generated y1(t) and y2(t)')
xlabel('min(tau1,tau2)-0.01 < t < max(tau1,tau2)+0.01') 
ylabel('y1(t) values')

subplot(2,1,2);
plot(t,y2signal);

xlabel('min(tau1,tau2)-0.01 < t < max(tau1,tau2)+0.01') 
ylabel('y2(t) values')


%-----------End of Part 2.1-----------%

[y1signalnew, y2signalnew] = lab1simTimeChange(0.5, 100, 100, @(t)1000*cos(880*pi*t));
[C, lags] = xcorr(y1signalnew, y2signalnew);
lags = lags/fs;
figure();
stem(lags,C);

title('C values vs lags')
xlabel('lags/Fs values') 
ylabel('C values')

%-----------End of Part 2.2-----------%


x = linspace(1,100);

for c = x
    [y1test,y2test] = lab1simTimeChange(0.5,100,c,@(t)1000*cos(880*pi*t));
    [thetaTest,Ltest] = lab1est(0.5, 100, y1test, y2test);
    error(c) = 1-(Ltest)/c;
end

figure();
plot(x, error); 

title('Plot of error values)')
xlabel('x values from 0-100') 
ylabel('error values')

%-----------End of Part 2.3-----------%

z1 = y1signalnew.*randn;
z2 = y2signalnew.*randn;

[Cnoise, lagsnoise] = xcorr(z1,z2); 
lagsnoise = lagsnoise/fs;
figure();
stem(lagsnoise,Cnoise);

%Looking at the corresponding lag value, it is now 0.00009, which is higher
%than the previous case we had.

%Doing the previous estimate, we get L is approximately 6 meters.

z3 = y1signalnew.*(randn*100);
z4 = y2signalnew.*(randn*100);

[Cnoise2, lagsnoise2] = xcorr(z3,z4); 
lagsnoise2 = lagsnoise2/fs;
figure();
stem(lagsnoise2,Cnoise2);

%Looking at the corresponding lag value, it is now 0.000091, which is around
%the previous case we had.

%Doing the previous estimate, we get L is approximately 5 meters.

alphaValues = linspace(10,10,150);
N = 1:100; 
errors = [0];

for n = alphaValues
    sum = 0;
    for m = N
    [thetaloop,Lloop] = lab1est(0.5, 100, z1, z2);
    sum = sum + (Lloop - 100)^2;
    end
    errors = [errors sum/100];
end

errors(3:end);
figure();
plot(10:151:150,errors);

title('Errors for different alpha')
xlabel('alpha values') 
ylabel('errors values')

%-----------End of Part 2.4-----------%

%----------Start of Functions----------%
function [y1sig,y2sig] = lab1sim(A, B, L, sig)
twoA = 2*A; 
c = 333.3;
D_a = sqrt(B^2+(L-A)^2);
D_2a = sqrt(B^2+(L-twoA)^2);
tau1 = D_a/c; 
tau2 = D_2a/c;

t = min(tau1,tau2)-0.01:1/44100:max(tau1,tau2)+0.01; 
%t = 0:1/44100:0.5; 

y1sig = sig(t-tau1);
y2sig = sig(t-tau2);
end

function [y1sig,y2sig] = lab1simTimeChange(A, B, L, sig)
twoA = 2*A; 
c = 333.3;
D_a = sqrt(B^2+(L-A)^2);
D_2a = sqrt(B^2+(L-twoA)^2);
tau1 = D_a/c; 
tau2 = D_2a/c;

%t = min(tau1,tau2)-0.01:1/44100:max(tau1,tau2)+0.01; 
t = 0:1/44100:0.5; 

y1sig = sig(t-tau1);
y2sig = sig(t-tau2);
end

function [theta, L] = lab1est(A,B,y1,y2)
[Ctest, lagstest] = xcorr(y1,y2);
peak = max(Ctest);
lagIndex = find(Ctest == peak);
lagIndexFixed = lagstest(lagIndex)/44100;
c = 333.33; 
X = (c/A)*lagIndexFixed;
theta = asin(X);
L = tan(theta)*B;
end