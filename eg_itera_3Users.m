clear; % 与全局遍历搜索到的最小值一致

% parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

% initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_r1(1) = 8;                           % error_123 < 0.1
m_r2(1) = 8;                           
m_r3(1) = 10;                          
m_c(1) = 10;                            

mr1_matrix = [1:1500]';
mr2_matrix = [1:1500];
mr3_matrix = [1:1500]';
mc_matrix  = [0:1500];
% iteration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 1; 
while 1
    % optimization variables m_r1, m_r2, get m_r1(i+1), m_r2(i+1)
    M = mr1_matrix + mr2_matrix + m_r3(i) + m_c(i);   
    m_c1 = mr2_matrix + m_r3(i) + m_c(i); 
    m_c2 = mr1_matrix + m_r3(i) + m_c(i);
    m_c3 = mr1_matrix + mr2_matrix + m_c(i);
    
    E_c1 = u_1 * z_c1 * p_c * m_c1 * Ts;    
    p_r1 = E_c1 ./ (mr1_matrix * Ts);             
    SNR_1 = (z_r1 * p_r1) / (Pn + h_I * p_c);
    V_1 = 1 - 1 ./ (1 + SNR_1).^2;
    C_1 = log2(1 + SNR_1);
    error_1 = qfunc(sqrt(mr1_matrix./V_1).*(C_1-d./mr1_matrix)*log(2));
    AoI_1 = 0.5 * M + M./(1-error_1);
    E_c2 = u_2 * z_c2 * p_c * m_c2 * Ts;    
    p_r2 = E_c2 ./ (mr2_matrix * Ts);             
    SNR_2 = (z_r2 * p_r2) / (Pn + h_I * p_c);
    V_2 = 1 - 1 ./ (1 + SNR_2).^2;
    C_2 = log2(1 + SNR_2);
    error_2 = qfunc(sqrt(mr2_matrix./V_2).*(C_2-d./mr2_matrix)*log(2));
    AoI_2 = 0.5 * M + M./(1-error_2);
    E_c3 = u_3 * z_c3 * p_c * m_c3 * Ts;    
    p_r3 = E_c3 ./ (m_r3(i) * Ts);             
    SNR_3 = (z_r3 * p_r3) / (Pn + h_I * p_c);
    V_3 = 1 - 1 ./ (1 + SNR_3).^2;
    C_3 = log2(1 + SNR_3);
    error_3 = qfunc(sqrt(m_r3(i)./V_3).*(C_3-d./m_r3(i))*log(2));
    AoI_3 = 0.5 * M + M./(1-error_3);

    AoI = max(max(AoI_1,AoI_2),AoI_3);
    [m,n] = find(AoI == min(min(AoI)));   % m行n列
    m_r1(i+1) = mr1_matrix(m(1));
    m_r2(i+1) = mr2_matrix(n(1));
    minAoI(1,i) = min(min(AoI));



    % optimazation variables m_r3, m_c, with m_r1(i+1), m_r2(i+1)
    M = m_r1(i+1) + m_r2(i+1) + mr3_matrix + mc_matrix;
    m_c1 = m_r2(i+1) + mr3_matrix + mc_matrix;
    m_c2 = m_r1(i+1) + mr3_matrix + mc_matrix;
    m_c3 = m_r1(i+1) + m_r2(i+1) + mc_matrix;

    E_c1 = u_1 * z_c1 * p_c * m_c1 * Ts;    
    p_r1 = E_c1 ./ (m_r1(i+1) * Ts);             
    SNR_1 = (z_r1 * p_r1) / (Pn + h_I * p_c);
    V_1 = 1 - 1 ./ (1 + SNR_1).^2;
    C_1 = log2(1 + SNR_1);
    error_1 = qfunc(sqrt(m_r1(i+1)./V_1).*(C_1-d./m_r1(i+1))*log(2));
    AoI_1 = 0.5 * M + M./(1-error_1);
    E_c2 = u_2 * z_c2 * p_c * m_c2 * Ts;    
    p_r2 = E_c2 ./ (m_r2(i+1) * Ts);             
    SNR_2 = (z_r2 * p_r2) / (Pn + h_I * p_c);
    V_2 = 1 - 1 ./ (1 + SNR_2).^2;
    C_2 = log2(1 + SNR_2);
    error_2 = qfunc(sqrt(m_r2(i+1)./V_2).*(C_2-d./m_r2(i+1))*log(2));
    AoI_2 = 0.5 * M + M./(1-error_2);
    E_c3 = u_3 * z_c3 * p_c * m_c3 * Ts;    
    p_r3 = E_c3 ./ (mr3_matrix * Ts);             
    SNR_3 = (z_r3 * p_r3) / (Pn + h_I * p_c);
    V_3 = 1 - 1 ./ (1 + SNR_3).^2;
    C_3 = log2(1 + SNR_3);
    error_3 = qfunc(sqrt(mr3_matrix./V_3).*(C_3-d./mr3_matrix)*log(2));
    AoI_3 = 0.5 * M + M./(1-error_3);

    AoI = max(max(AoI_1,AoI_2),AoI_3);
    [m,n] = find(AoI == min(min(AoI)));
    m_r3(i+1) = mr3_matrix(m(1));
    m_c(i+1) = mc_matrix(n(1));
    
    minAoI(2,i) = min(min(AoI));
    if i > 1 && abs(minAoI(1,i)-minAoI(1,i-1)) < 0.01
        break;
    end
    i = i+1; 
end



