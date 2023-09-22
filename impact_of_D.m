clear
run channelModel.m;

j = 1;
Pc = 0.01
for d = 30:2:100
    run iteration_part.m;

    D(j) = d;
    output(1,j) = minAoI(1,i);
    j = j+1;
end
plot(D,output(1,:),'b'); hold on;
xlabel('D'); ylabel('min max AoI'); title('impact of D');

j = 1;
Pc = 1
for d = 30:2:100
    run iteration_part.m;

    D(j) = d;
    output(2,j) = minAoI(1,i);
    j = j+1;
end
plot(D,output(2,:),'y'); hold on;

j = 1;
Pc = 10
for d = 30:2:100
    run iteration_part.m;

    D(j) = d;
    output(3,j) = minAoI(1,i);
    j = j+1;
end
plot(D,output(3,:),'r'); 
legend('Pc = 0.01','Pc = 1','Pc = 10')