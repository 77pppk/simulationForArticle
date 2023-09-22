clear
run channelModel.m;

% 改D后仍是直线
j = 1;
for h_aver = 0:0.2:10
    h_c1 = 70*h_aver; h_r1 = h_c1;
    h_c2 = 80*h_aver; h_r2 = h_c2;
    h_c3 = 90*h_aver; h_r3 = h_c3;
    
    run iteration_part.m;
    h_Aver(j) = h_aver;
    output(j) = minAoI(1,i);
    j = j + 1;
end
plot(h_Aver,output); hold on;
xlabel('|h_i|'); ylabel('min max AoI'); title('impact of average h');