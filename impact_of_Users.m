clear;

f = 2.4 * 10^9;                             % carrier freq. 2.4GHz
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


d_i = 0.15;                                  % communication distance 1m
h_ci = 1 / d_i^2.7;                     
h_ri = h_ci;
Ksi_FLi = c / (4 * pi * f * d_i);           % fading constant
Ksi_ABSi = exp(-a * d_i / 2);
Ksi_i = Ksi_FLi * Ksi_ABSi;
z_ci = Ksi_i * h_ci;
z_ri = Ksi_i * h_ri;
k = 0;
for I = 1:50
    Num(I) = I;
    M_i = I*m_ri + m_ci;                      %% 应为方阵
    E_ci = u_i * z_ci * p_c * (m_ci + (I-1) * m_ri) * Ts;    % 行向量
    p_ri = E_ci ./ (m_ri * Ts);             %% 应为方阵
    SNR_i = (z_ri * p_ri) / (Pn + h_I * p_c);%% 应为方阵
    V = 1 - 1 ./ (1 + SNR_i).^2;
    C = log2(1 + SNR_i);
    error_i = qfunc(sqrt(m_ri./V).*(C-d./m_ri)*log(2));
    AoI_i = 0.5 * M_i + M_i./(1-error_i);
    optAoI1(I) = min(min(AoI_i));
    if find(AoI_i == min(min(AoI_i))) < 1501
        k = k+1;
        I_mc_equal_01(k) = I;        % 若数量太多则说明充电效率过高
    end
end
plot(Num,optAoI1); hold on;

d_i = 0.3;                                  % communication distance 1m
h_ci = 1 / d_i^2.7;                     
h_ri = h_ci;
Ksi_FLi = c / (4 * pi * f * d_i);           % fading constant
Ksi_ABSi = exp(-a * d_i / 2);
Ksi_i = Ksi_FLi * Ksi_ABSi;
z_ci = Ksi_i * h_ci;
z_ri = Ksi_i * h_ri;
k = 0;
for I = 1:50
    M_i = I*m_ri + m_ci;                      %% 应为方阵
    E_ci = u_i * z_ci * p_c * (m_ci + (I-1) * m_ri) * Ts;    % 行向量
    p_ri = E_ci ./ (m_ri * Ts);             %% 应为方阵
    SNR_i = (z_ri * p_ri) / (Pn + h_I * p_c);%% 应为方阵
    V = 1 - 1 ./ (1 + SNR_i).^2;
    C = log2(1 + SNR_i);
    error_i = qfunc(sqrt(m_ri./V).*(C-d./m_ri)*log(2));
    AoI_i = 0.5 * M_i + M_i./(1-error_i);
    optAoI2(I) = min(min(AoI_i));
    if find(AoI_i == min(min(AoI_i))) < 1501
        k = k+1;
        I_mc_equal_02(k) = I;        % 若数量太多则说明充电效率过高
    end
end
plot(Num,optAoI2); hold on;

d_i = 0.45;                                  % communication distance 1m
h_ci = 1 / d_i^2.7;                     
h_ri = h_ci;
Ksi_FLi = c / (4 * pi * f * d_i);           % fading constant
Ksi_ABSi = exp(-a * d_i / 2);
Ksi_i = Ksi_FLi * Ksi_ABSi;
z_ci = Ksi_i * h_ci;
z_ri = Ksi_i * h_ri;
k = 0;
for I = 1:50
    M_i = I*m_ri + m_ci;                      %% 应为方阵
    E_ci = u_i * z_ci * p_c * (m_ci + (I-1) * m_ri) * Ts;    % 行向量
    p_ri = E_ci ./ (m_ri * Ts);             %% 应为方阵
    SNR_i = (z_ri * p_ri) / (Pn + h_I * p_c);%% 应为方阵
    V = 1 - 1 ./ (1 + SNR_i).^2;
    C = log2(1 + SNR_i);
    error_i = qfunc(sqrt(m_ri./V).*(C-d./m_ri)*log(2));
    AoI_i = 0.5 * M_i + M_i./(1-error_i);
    optAoI3(I) = min(min(AoI_i));
    if find(AoI_i == min(min(AoI_i))) < 1501
        k = k+1;
        I_mc_equal_03(k) = I;        % 若数量太多则说明充电效率过高
    end
end
plot(Num,optAoI3); hold on;
xlabel('I'); ylabel('min AoI'); legend('distance = 0.15m','distance = 0.3','distance = 0.45m');
plot(I_mc_equal_01(1),optAoI1(I_mc_equal_01(1)),'*');hold on;
plot(I_mc_equal_02(1),optAoI2(I_mc_equal_02(1)),'*');hold on;
plot(I_mc_equal_03(1),optAoI3(I_mc_equal_03(1)),'*');hold on;