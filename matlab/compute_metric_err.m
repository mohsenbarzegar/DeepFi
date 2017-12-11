function err=compute_metric_err(x1,x2,x3,x4)
p1=[2,2];p2=[1,2.75];p3=[2,3.5];p4=[1,4.25];p5=[2,5.25];
p6=[1,6];p7=[4,2];p8=[3,2.75];p9=[4,4];p10=[3,4.75];
p11=[4,5.5];p12=[3,6.25];p13=[6,2];p14=[5,2.75];p15=[6,3.5];
p16=[5,4.25];p17=[6,5];p18=[5,5.75];p19=[6,6.5];
p=[p1;p2;p3;p4;p5;p6;p7;p8;p9;p10;p11;p12;p13;p14;p15;p16;p17;p18;p19];

p1_x=p(x1,1);
p1_y=p(x1,2);
p2_x=p(x2,1);
p2_y=p(x2,2);
p3_x=p(x3,1);
p3_y=p(x3,2);

pReal_x=p(x4,1)
pReal_y=p(x4,2)

pEst_x=mean([p1_x,p2_x,p3_x])
pEst_y=mean([p1_y,p2_y,p3_y])

err=sqrt((pEst_x-pReal_x)^2+(pEst_y-pReal_y)^2);

