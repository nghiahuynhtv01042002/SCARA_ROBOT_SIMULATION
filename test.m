%  matrixDH = DH(a, alpha, d, theta)
% A0_1 = DH(0,asin(1),d1,theta1)
% A1_2 = DH(a2,0,0,theta2+90)
% A2_3 = DH(a3,0,0,theta3-90)
% A3_4 = DH(a4,0,0,theta4)
% 
% A1_4 = A1_2*A2_3*A3_4
% A0_4 = A0_1*A1_4
syms theta1 theta2 theta3 theta4 d1 a2 a3 a4



A0_1 = [cos(theta1) 0 sin(theta1) 0 ;
        sin(theta1) 0 -cos(theta1) 0;
        0           1 0             d1;
         0 0 0 1]
A1_2 = DH(a2,0,0,theta2+90)
A2_3 = DH(a3,0,0,theta3-90)
A3_4 = DH(a4,0,0,theta4)

% A1_2 = [-sin(theta2) cos(theta2) 0 -a2*sin(theta2);
%         cos(theta2) -sin(theta2) 0  a2*cos(theta2);
%         0 0 1 0;
%         0 0 0 1] 
%  A2_3 = [sin(theta3) cos(theta3) 0 a3*sin(theta3);
%         -cos(theta3) sin(theta3) 0 a3*cos(theta3);
%         0 0 1 0;
%         0 0 0 1] 
%   A3_4 = [cos(theta4) -sin(theta4) 0 a4*cos(theta4);
%         sin(theta4) cos(theta4) 0 a4*sin(theta4);
%         0 0 1 0;
%         0 0 0 1]
%   A0_4 = A0_1*A1_2*A2_3*A3_4
  A0_4 = simplify(A0_1 * A1_2 * A2_3 * A3_4)
  A0_2 = simplify(A0_1*A1_2)
    