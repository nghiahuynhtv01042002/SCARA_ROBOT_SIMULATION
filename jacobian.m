function jacobian_matrix=jacobian(object)
A0_1 = DH(object.a(1),object.alpha(1)*pi/180,object.d(1),object.theta(1)*pi/180) ;
A1_2 = DH(object.a(2),object.alpha(2)*pi/180,object.d(2),object.theta(2)*pi/180) ;
A2_3 = DH(object.a(3),object.alpha(3)*pi/180,object.d(3),object.theta(3)*pi/180) ;
A3_4 = DH(object.a(4),object.alpha(4)*pi/180,object.d(4),object.theta(4)*pi/180) ;

A0_2=A0_1*A1_2;
A0_3=A0_2*A2_3;
A0_4=A0_3*A3_4;

z0 = [0;0;1];
p0 = [0;0;0];
z1 = [A0_1(1,3);A0_1(2,3);A0_1(3,3)];
p1 = [A0_1(1,4);A0_1(2,4);A0_1(3,4)];
z2 = [A0_2(1,3);A0_2(2,3);A0_2(3,3)];
p2 = [A0_2(1,4);A0_2(2,4);A0_2(3,4)];
z3 = [A0_3(1,3);A0_3(2,3);A0_3(3,3)];
p3 = [A0_3(1,4);A0_3(2,4);A0_3(3,4)];
z4 = [A0_4(1,3);A0_4(2,3);A0_4(3,3)];
pE = [A0_4(1,4);A0_4(2,4);A0_4(3,4)];

J11 = Ham_nhan_2_vector(z0,(pE-p0));
J12 = Ham_nhan_2_vector(z1,(pE-p1));
J13 = z2;
J14 = Ham_nhan_2_vector(z3,(pE-p3));

Temp0 = [0;0;0];
Temp1 = cat(2,J11,J12,J13,J14);
Temp2 = cat(2,z0,z1,Temp0,z3);

jacobian_matrix = cat(1,Temp1,Temp2);
end

