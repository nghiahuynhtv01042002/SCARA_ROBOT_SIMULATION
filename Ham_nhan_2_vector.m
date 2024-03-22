function Temp=Ham_nhan_2_vector(u,p)
Temp = [-u(3)*p(2) + u(2)*p(3);
        u(3)*p(1) - u(1)*p(3);
        -u(2)*p(1) + u(1)*p(2)];
end