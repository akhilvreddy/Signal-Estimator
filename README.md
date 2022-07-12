# Signal Estimator

This project tries to answer a really simple question which comes up often, and in differnet forms: finding the source given its effects. In this case, the source is a speaker and the effects are two microphones which are placed at specific places. The set up looks like this: 

<p align="center">
  <img 
    width="560"
    height="292"
    src="https://github.com/akhilvreddy/SignalEstimator/blob/main/image1.png"
  >
</p>

In this project I used _signal triangulation_ to get my results. I started by sending out signals from the speakers to the microphones, which I did by finding the delay and then simulating the wave. 
- I first estimated the signal to be in a sinusoidal form, and used a generic estimate to get started. 
- I used two different waves at once to do the analysis to see that the results were aligning properly. 
- Estimated the final value we were trying to find **L**, by using the time shift delay formula. 

The simulation of the first wave was done by executing the following: 

```
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
```

This resulted in two waves which I was able to use to estimate the value of **L**. 

I was finally able to automate the process by running a for loop for all the values and averaging it out. 

```
for c = x
    [y1test,y2test] = lab1simTimeChange(0.5,100,c,@(t)1000*cos(880*pi*t));
    [thetaTest,Ltest] = lab1est(0.5, 100, y1test, y2test);
    error(c) = 1-(Ltest)/c;
end
```

Running both of these scripts helped me find the true value of **L** after multiple estimates. I cross checked the values by using the speed of sound as c = 333.33 m/s and found that it works well. 
