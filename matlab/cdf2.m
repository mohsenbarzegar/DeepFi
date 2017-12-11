clc;clear;
std_csi=[0,0.05,0.08,0.1,0.2,0.25,0.4,0.6,0.8,1]
CDF=[0,0.2,0.4,0.55,0.8,0.9,0.95,1,1,1]
std_csi_raw=[0,0.05,0.08,0.1,0.2,0.25,0.4,0.6,0.8,1]
CDF_raw=[0,0.2,0.35,0.4,0.7,0.82,0.92,1,1,1]
plot([std_csi_raw],[CDF_raw],'-rs','LineWidth',1.5,...
    'MarkerSize',5)
ylim([0 1])
grid on
ylabel('CDF')
xlabel('Std of normalized amplitude over antenna 1')
hold on
plot([std_csi],[CDF],'--b','LineWidth',1.5,...
    'MarkerSize',5)
legend('raw CSI values','CSI values best features','Location','southeast')

