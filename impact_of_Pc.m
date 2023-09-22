clear
run channelModel.m;

j = 1;
for p_c = 0:0.2:10 
    run iteration_part.m;
    
    Pc(j) = p_c;
    output(j) = minAoI(1,i);
    j = j + 1;
end
plot(Pc,output); hold on;
xlabel('Pc'); ylabel('min max AoI'); title('impact of Pc');

d = 100; j = 1
for p_c = 0:0.2:10 
    run iteration_part.m;
    
    Pc(j) = p_c;
    output(j) = minAoI(1,i);
    j = j + 1;
end
plot(Pc,output); hold on;

d = 120; j = 1
for p_c = 0:0.2:10 
    run iteration_part.m;
    
    Pc(j) = p_c;
    output(j) = minAoI(1,i);
    j = j + 1;
end
plot(Pc,output); hold on;
legend('D = 80','D = 100','D = 120');