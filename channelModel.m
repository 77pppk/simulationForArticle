clear;
% assumption: 3 users
d_1 = 0.1;                                  % communication distance 1m
d_2 = 0.13;
d_3 = 0.15;
u_1 = 0.3;                                  % charging efficiency
u_2 = 0.3;
u_3 = 0.3;

f = 2.4 * 10^9;                             % carrier freq. 2.4GHz
a = 0.1;                                    % medium absorption coefficient
Ts = 0.025;                                 % duration of a symbol, in ms
p_c = 1;                                    % charging power
d = 80;                                     % #bits
Pn = 0.01;                                  % noise power
h_I = 0.1;                                  % residual loop interference (not seriously checked yet)   
c = 3 * 10^8;

Ksi_FL1 = c / (4 * pi * f * d_1);           % user1, fading constant
Ksi_ABS1 = exp(-a * d_1 / 2);
Ksi_1 = Ksi_FL1 * Ksi_ABS1;
Ksi_FL2 = c / (4 * pi * f * d_2);           % user2, fading constant
Ksi_ABS2 = exp(-a * d_2 / 2);
Ksi_2 = Ksi_FL2 * Ksi_ABS2;
Ksi_FL3 = c / (4 * pi * f * d_3);           % user3, fading constant
Ksi_ABS3 = exp(-a * d_3 / 2);
Ksi_3 = Ksi_FL3 * Ksi_ABS3;

h_c1 = 1 / d_1^2.7;                     
h_r1 = h_c1;
z_c1 = Ksi_1 * h_c1;
z_r1 = Ksi_1 * h_r1;
h_c2 = 1 / d_2^2.7;                     
h_r2 = h_c2;
z_c2 = Ksi_2 * h_c2;
z_r2 = Ksi_2 * h_r2;
h_c3 = 1 / d_3^2.7;                     
h_r3 = h_c3;
z_c3 = Ksi_3 * h_c3;
z_r3 = Ksi_3 * h_r3;