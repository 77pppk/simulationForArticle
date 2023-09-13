clear;

f = 2.4 * 10^9;                             % carrier freq. 2.4GHz
d_i = 0.3;                                  % communication distance 1m
a = 0.1;                                    % medium absorption coefficient
u_i = 0.3;                                  % charging efficiency
Ts = 0.025;                                 % duration of a symbol, in ms
p_c = 1;                                    % charging power
d = 80;                                     % #bits
Pn = 0.01;                                  % noise power
h_I = 0.1;                                  % residual loop interference (not seriously checked yet)   
c = 3 * 10^8;

m_ri = [0:1500]';                           % 列向量, block length. #symbols
m_ci = [0:1000];                            % 行向量

M_i = m_ri + m_ci;                      %% 应为方阵

Ksi_FLi = c / (4 * pi * f * d_i);           % fading constant
Ksi_ABSi = exp(-a * d_i / 2);
Ksi_i = Ksi_FLi * Ksi_ABSi;
h_ci = 1 / d_i^2.7;                     
h_ri = h_ci;
z_ci = Ksi_i * h_ci;
z_ri = Ksi_i * h_ri;
E_ci = u_i * z_ci * p_c * m_ci * Ts;    % 行向量
p_ri = E_ci ./ (m_ri * Ts);             %% 应为方阵
SNR_i = (z_ri * p_ri) / (Pn + h_I * p_c);%% 应为方阵
V = 1 - 1 ./ (1 + SNR_i).^2;
C = log2(1 + SNR_i);
error_i = qfunc(sqrt(m_ri./V).*(C-d./m_ri)*log(2));
AoI_i = 0.5 * M_i + M_i./(1-error_i);
min(min(AoI_i))
figure(1)
[X,Y] = meshgrid(1:1000,1:1500);
AoI_i(AoI_i > 6000) = NaN;
p3 = surf(m_ci,m_ri,AoI_i);set(gca,'ZScale','log');shading interp;alpha(.5);hold on;
AoI_i(error_i > 0.1) = NaN;                                 
p3 = surf(m_ci,m_ri,AoI_i);set(gca,'ZScale','log');shading interp;
xlabel('m_ci');ylabel('m_ri');zlabel('AoI_i');

figure(2)
[X,Y] = meshgrid(1:1000,1:1500);
p3 = surf(m_ci,m_ri,error_i);set(gca,'ZScale','log');shading interp;
xlabel('m_ci');ylabel('m_ri');zlabel('error_i');