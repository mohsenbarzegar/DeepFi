function y=my_phi(theta,d,param)

y=exp(-2*pi*j*d*sin(theta)*param.f_c/param.c);
