function y=my_omega(taw,f_delta,N)
%f_delta=4e6; %Mhz
y=exp(-2*j*pi*f_delta*taw*[1:(N)]);