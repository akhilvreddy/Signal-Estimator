%lab1est
function [theta, L] = function2(A,B,y1,y2)

[Ctest, lagstest] = xcorr(y1,y2);
peak = max(Ctest);
lagIndex = find(Ctest == peak);
lagIndexFixed = lagstest(lagIndex)/44100;
c = 333.33; 
X = (c/A)*lagIndexFixed;
theta = asin(X);
L = tan(theta)*B;

end