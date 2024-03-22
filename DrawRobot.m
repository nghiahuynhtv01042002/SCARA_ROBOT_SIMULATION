function DrawRobot(robot,handles)

Robot = handles.Robot;
cla(Robot,'reset')
hold(Robot,'on')
grid(Robot,'on');

xlim(handles.Robot,[-1 1]);
ylim(handles.Robot,[-1 1]);
zlim(handles.Robot,[0 1]);


p0 = [0 0 0];
p1 = robot.pos(1,:);%[x1 y1 z1]
p2 = robot.pos(2,:);
p3 = robot.pos(3,:);
p4 = robot.pos(4,:);

d = robot.d;
a = robot.a;
orien = robot.orien;

% define links
p0_p1 =[[p0(1) p1(1)];[p0(2) p1(2)];[p0(3) p1(3)]];%hang 1[p0x p1x];hang 2[p0y p1y];hang 3 [p0z p1z]  
p1_p2 =[[p1(1) p2(1)];[p1(2) p2(2)];[p1(3) p2(3)]];%hang 1[p1x p2x];hang 2[p1y p2y];hang 3 [p1z p2z]
p2_p3 =[[p2(1) p3(1)];[p2(2) p3(2)];[p2(3) p3(3)]];%hang 1[p2x p3x];hang 2[p2y p3y];hang 3 [p2z p3z]
p3_p4 =[[p3(1) p4(1)];[p3(2) p4(2)];[p3(3) p4(3)]];%hang 1[p3x p4x];hang 2[p3y p4y];hang 3 [p3z p4z]

xlabel(Robot,'x');
ylabel(Robot,'y');
zlabel(Robot,'z');
% Ve base link1

%%%%%%Draw_cylinder(handles,x0,y0,z0,r,h,colr)
 Draw_cylinder(handles,0,0,0,0.1,0.8*d(1),[255, 100, 0]/255)
% 
% % %link 2 2 hình tr? c?a link 2

 Draw_cylinder(handles,p0_p1(1,2),p0_p1(2,2),0.8*d(1),0.1,0.2*d(1),[255, 100, 0]/255);
 Draw_cylinder(handles,p0_p1(1,1),p0_p1(2,1),0.8*d(1),0.1,0.2*d(1),[255, 100, 0]/255);
%tính 4 ti?p ?i?m ti?p tuy?n chung
 [com_tan1,com_tan2]=F_Common_Tangent([p0_p1(1,1) p0_p1(2,1)],[p0_p1(1,2) p0_p1(2,2)],0.1,0.1,1,-1);% [p0_p1(1,1) p1_p0(2,1)] = [p0x p0y]; [p1_p2(1,2) p1_p2(2,2)}=[p1x p1y]
 [com_tan3,com_tan4]=F_Common_Tangent([p0_p1(1,1) p0_p1(2,1)],[p0_p1(1,2) p0_p1(2,2)],0.1,0.1,1,1);
% % 
%m?t duoi
 fill3(Robot,[com_tan1(1) com_tan2(1) com_tan4(1) com_tan3(1)],[com_tan1(2) com_tan2(2) com_tan4(2) com_tan3(2)],[0.8*d(1)  0.8*d(1) 0.8*d(1) 0.8*d(1)],[255, 100, 0]/255)
%m?t trên
 fill3(Robot,[com_tan1(1) com_tan2(1) com_tan4(1) com_tan3(1)],[com_tan1(2) com_tan2(2) com_tan4(2) com_tan3(2)],[1*d(1)    1*d(1)   1*d(1)   1*d(1)],[255, 100, 0]/255)
%2 bên 
fill3(Robot,[com_tan4(1) com_tan3(1) com_tan3(1) com_tan4(1)],[com_tan4(2) com_tan3(2) com_tan3(2) com_tan4(2)],[0.8*d(1) 0.8*d(1) 1*d(1) 1*d(1)],[255, 100, 0]/255)
 fill3(Robot,[com_tan1(1) com_tan2(1) com_tan2(1) com_tan1(1)],[com_tan1(2) com_tan2(2) com_tan2(2) com_tan1(2)],[0.8*d(1) 0.8*d(1) 1*d(1) 1*d(1)],[255, 100, 0]/255)


% % %link 3
 
Draw_cylinder(handles,p1_p2(1,1),p1_p2(2,1),1*d(1),0.1,0.1,[255, 100, 0]/255)
Draw_cylinder(handles,p1_p2(1,2),p1_p2(2,2),1*d(1),0.1,0.4,[255, 100, 0]/255)

% % 
[com_tan1,com_tan2]=F_Common_Tangent([p1_p2(1,1) p1_p2(2,1)],[p1_p2(1,2) p1_p2(2,2)],0.1,0.1,1,-1);
[com_tan3,com_tan4]=F_Common_Tangent([p1_p2(1,1) p1_p2(2,1)],[p1_p2(1,2) p1_p2(2,2)],0.1,0.1,1,1);
% % 
% m?t d??i
 fill3(Robot,[com_tan1(1) com_tan2(1) com_tan4(1) com_tan3(1)],[com_tan1(2) com_tan2(2) com_tan4(2) com_tan3(2)],[d(1) d(1) d(1) d(1)],[255, 100, 0]/255)
%mat trên
   fill3(Robot,[com_tan1(1) com_tan2(1) com_tan4(1) com_tan3(1)],[com_tan1(2) com_tan2(2) com_tan4(2) com_tan3(2)],[d(1)+0.1 d(1)+0.1 d(1)+0.1 d(1)+0.1],[255, 100, 0]/255)
% 2 bên
 fill3(Robot,[com_tan4(1) com_tan3(1) com_tan3(1) com_tan4(1)],[com_tan4(2) com_tan3(2) com_tan3(2) com_tan4(2)],[d(1) d(1) d(1)+0.1 d(1)+0.1],[255, 100, 0]/255)
% 
 fill3(Robot,[com_tan1(1) com_tan2(1) com_tan2(1) com_tan1(1)],[com_tan1(2) com_tan2(2) com_tan2(2) com_tan1(2)],[d(1) d(1) d(1)+0.1 d(1)+0.1],[255, 100, 0]/255)
% % 

% % % %link4
% 
Draw_cylinder(handles,p3(1),p3(2),p3(3),0.02,0.42,[0 0 0]);

view(Robot,40,40);

DH_table=[robot.a robot.alpha robot.d robot.theta];
assignin('base', 'DH_table', DH_table);
end
