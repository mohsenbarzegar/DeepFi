e3=[2.04,2.08,0.62,2.26,0.64,3.82,1.77,2.73,0.96,1.48,0.98,4.99,2.01,0.93,1.89,0.7,1.36,1.57,4.81];
e2=[1.49,1.83,0.36,1.56,1.02,3.97,1.66,2.96,0.97,1.50,0.31,5.09,1.68,0.63,1.60,0.72,1.67,1.76,4.95];
mu = 0;
sigma = 1;
pd = makedist('Normal',mu,sigma);
y3 = cdf(pd,e3);
y2 = cdf(pd,e2);
Distance_error=linspace(0,6,length(e3));
plot([0,sort(e3)],[0,sort(y3)],'-rs','LineWidth',1.5,...
    'MarkerSize',5)
hold on
plot([0,sort(e2)],[0,sort(y2)],'--g*','LineWidth',1.5,...
    'MarkerSize',5)
xlabel('Distance Error(m)')
grid on
ylabel('CDF')
ylim([0,1])
legend('3 NN','2 NN','Location','southeast')