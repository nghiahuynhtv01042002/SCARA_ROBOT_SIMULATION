classdef SCARA
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %% DH parameter
        a;
        d;
        alpha;  % unit degree
        theta;  % unit degree
        
        %% Limatation of workspace
        theta1_max;
        theta2_max;
        d3_max; %%maximum value of d3
        pos;    %%position of 4 joints 1 2 3 4
        orien;  %%orientation of 4 joints 1 2 3 4, unit radian
    end
    
    methods(Static)
        function obj = SCARA(handles,a1,a2,d1,d4,theta1_max,theta2_max,d3_max)
            obj.a = [0; 0; 0; 0];
            obj.d = [0; 0; 0; 0];
            obj.alpha = [0.00; 0.00; 0.00; 180];
            obj.theta = [0.00; 90.0; 0.00; -90];
            obj.a(1)=a1;
            obj.a(2)=a2;
            obj.d(1)=d1;
            obj.d(4)=d4;
            obj.theta1_max = theta1_max;
            obj.theta2_max = theta2_max;
            obj.d3_max = d3_max;
            [obj.pos,obj.orien] = obj.ForwardKinematic(obj);
        end
        function [p_robot,o_robot] = ForwardKinematic(self)
            a = self.a;
            alpha = self.alpha*pi/180;
            d = self.d;
            theta = self.theta*pi/180;
            
            theta1_max = self.theta1_max;
            theta2_max = self.theta2_max;
            d3_max = self.d3_max;

            if (abs(theta(1))*180/pi>theta1_max)||(abs(theta(2))*180/pi>theta2_max)||(d(3)<-d3_max)
                ok = 0;
%                 obj = obj;
                questdlg('workspace warning','Warning','OK','OK');
                return
            end

            %% Ham tinh dong hoc thuan cua robot
            % Input: DH Parameter
            % Output: joint position p1 p2 p3 p4     (x y z)
            %         joint orientation o1 o2 o3 o4  (roll pitch yaw)
            %% FK Matrix
            A0_1 = DH(a(1),alpha(1),d(1),theta(1)) ;
            A1_2 = DH(a(2),alpha(2),d(2),theta(2)) ;
            A2_3 = DH(a(3),alpha(3),d(3),theta(3)) ;
            A3_4 = DH(a(4),alpha(4),d(4),theta(4)) ;

            A0_2=A0_1*A1_2;
            A0_3=A0_1*A1_2*A2_3;
            A0_4=A0_1*A1_2*A2_3*A3_4;   % Te

            p0 = [0;0;0];
            [p1, o1] = cal_pose(A0_1,p0);
            [p2, o2] = cal_pose(A0_2,p0);
            [p3, o3] = cal_pose(A0_3,p0);
            [p4, o4] = cal_pose(A0_4,p0);

            p_robot = [p1 p2 p3 p4]'; % hnag 1 la p1, hang 2 la p2 ...
            o_robot = [o1; o2; o3; o4];
        end
   function [obj,ok] = InverseKinematic(x,y,z,yaw,obj)
            % Input: x y z yaw a1 a2
            % Output: theta1 theta2 d3 theta4
            a1 = obj.a(1);
            a2 = obj.a(2);
            d1 = obj.d(1);
            d4 = obj.d(4);
            cos_theta2 = (x^2 + y^2 - a1^2 - a2^2)/(2*a1*a2);
            if (abs(cos_theta2)<=1)
                sin_theta2 = sqrt(1-cos_theta2^2);
                theta21 = atan2(sin_theta2,cos_theta2);
                theta22 = atan2(-sin_theta2,cos_theta2);
                
                if abs(theta21 - obj.theta(2)*pi/180) < pi
                    theta2 = theta21;
                else
                    theta2 = theta22;
                    sin_theta2 = -sin_theta2;
                end

                t1 = [a1+a2*cos_theta2 -a2*sin_theta2;a2*sin_theta2 a1+a2*cos_theta2]^(-1)*[x;y];
                cos_theta1 = t1(1);
                sin_theta1 = t1(2);
                theta1 = atan2(sin_theta1,cos_theta1);

                d3 = z - d1-d4;
                theta4 = yaw - ( theta1 + theta2 );
                
                if (abs(theta1*180/pi)>obj.theta1_max)||(abs(theta2*180/pi)>obj.theta2_max)||(d3<-obj.d3_max)
                       ok = 0;
               
                    questdlg('out of workspace','Warning','OK','OK');
                    return
                else
                    ok = 1;
                    obj.theta(1) = theta1*180/pi;
                    obj.theta(2) = theta2*180/pi;
                    
                    obj.d(3) = d3;
                    obj.theta(4) = theta4*180/pi;
                end
            else
                    ok = 0;
                  
                    questdlg('Kinematic warning','Warning','OK','OK');
                return
            end
        end
function singularity = KinematicSingularity(obj)
            a = obj.a;
            alpha = obj.alpha/180*pi;
            d = obj.d;
            theta = obj.theta/180*pi;

            A0_1 = DH(a(1),alpha(1),d(1),theta(1));
            A1_2 = DH(a(2),alpha(2),d(2),theta(2));
            A2_3 = DH(a(3),alpha(3),d(3),theta(3));
            A3_4 = DH(a(4),alpha(4),d(4),theta(4));

            A0_2 = A0_1*A1_2;
            A0_3 = A0_2*A2_3;
            A0_4 = A0_3*A3_4;
            
            z0 = [0 0 1]';
            p0 = [0 0 0]';

            z1 = A0_1(1:3,3);
            z2 = A0_2(1:3,3);
            z3 = A0_3(1:3,3);
            z4 = A0_4(1:3,3);

            p1 = A0_1(1:3,4);
            p2 = A0_2(1:3,4);
            p3 = A0_3(1:3,4);
            p4 = A0_4(1:3,4);

            %% Khop 1 xoay, khop 2 xoay, khop 3 tinh tien, khop 4 xoay
            J = [cross(z0,p4-p0) cross(z1,p4-p1) z2 cross(z3,p4-p3);
                 z0 z1 [0;0;0] z3];
            J = J(1:3,1:3);
            det(J)
            if abs(det(J)) <= 10e-4
                singularity = 1;
            else
                singularity = 0;
            end
        end
        
      end
end

