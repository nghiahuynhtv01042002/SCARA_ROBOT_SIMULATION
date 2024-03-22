function [s,v,a,t,v_max,tf] = trajectory_S_curve(s_max,v_max,a_max)
% s_max=0.5;
% v_max=3;
% a_max=0.1;
if  v_max > sqrt(0.5*s_max*a_max)-0.01;
    v_max = sqrt(0.5*s_max*a_max);
    tc = v_max/a_max;
    tf = 4*tc;
    t_m = 0;
else
    tc = v_max/a_max;
    t_m = (s_max-2*a_max*tc^2)/(a_max*tc);
    tf = 4*tc + t_m;
end

%% Dieu kien
% s_max > 2*a_max*tc^2 = 2*v_max^2/a_max
% v_max < sqrt(0.5*s_max*a_max)

Jerk = a_max/tc;
t = 0:tf/100:tf;
for i = 1:length(t)
    if t(i) <= tc
        a(i) = Jerk*t(i);
        v(i) = 1/2*Jerk*t(i)^2;
        s(i) = 1/6*Jerk*t(i)^3;
        J(i)=Jerk;
        a1 = Jerk*tc;
        v1 = 1/2*Jerk*tc^2;
        s1 = 1/6*Jerk*tc^3;
    elseif t(i) <= 2*tc
        J(i)=-Jerk;
        a(i) = a1 + Jerk*-(t(i)-tc);
        v(i) = v1 - 1/2*Jerk*(t(i)-tc)^2 + a1*(t(i)-tc);
        s(i) = s1 - 1/6*Jerk*(t(i)-tc)^3 + 1/2*a1*(t(i)-tc)^2 + v1*(t(i)-tc);
        a2 = 0;
        v2 = v1 - 1/2*Jerk*(tc)^2 + a1*(tc);
        s3 = s1 - 1/6*Jerk*(tc)^3 + 1/2*a1*(tc)^2 + v1*(tc);
        a3 = 0;
        v3 = v2;
        if(t_m==0)
            s4=s3;
        end
%         s3 = s_max-s2;
    elseif t(i) <= 2*tc + t_m
        J(i)=0;
        a(i) = 0;
        v(i) = v3;
            
        s(i) = s3 + v2*(t(i)-2*tc);
        s4=s3 + v2*t_m;
        
    elseif t(i) <= 3*tc + t_m
        J(i)=-Jerk;
        a(i) = -Jerk*(t(i) - 2*tc - t_m);
        v(i) = v3 - 1/2*Jerk*(t(i) - 2*tc - t_m)^2 + a3*(t(i) - 2*tc - t_m);
        s(i) = s4 - 1/6*Jerk*(t(i) - 2*tc - t_m)^3 + 1/2*a3*(t(i) - 2*tc - t_m)^2 + v3*(t(i) - 2*tc - t_m);
        
        a5 = 0;
        v5 = 0;
        s5 = s_max;
    else
        J(i)=Jerk;
        a(i) = Jerk*(t(i) - tf);
        v(i) = 1/2*Jerk*(t(i) - tf)^2;
        s(i) = s5 + 1/6*Jerk*(t(i) - tf)^3;
    end
end
% figure(1)
% plot(t,s,'r');
% grid on;
% title('s');
% 
% figure(2)
% plot(t,v,'r');
% title('v');
% grid on;
% 
% figure(3)
% plot(t,a,'r');
% grid on;
% title('a');
% 
% figure(4)
% plot(t,J,'r');
% grid on
% title('J');


