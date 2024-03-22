function Setplot(handles,xlimt,q_max,v_max,a_max)
%axes theta1
axes(handles.theta1)
cla
hold on
grid on
title('${\theta_1}$ (deg)', 'Interpreter','latex')
xlabel('Time (s)');
xlim(handles.theta1, [0,  xlimt]);
ylim(handles.theta1, [-180, 180]);
%axes theta2
axes(handles.theta2)
cla
hold on
grid on
title('${\theta_2}$ (deg)', 'Interpreter','latex')
xlim(handles.theta2, [0, xlimt]);
ylim(handles.theta2, [-180, 180]);
xlabel('Time (s)');
%axes d3
axes(handles.d3)
cla
hold on
grid on
title('${\ d3}$ (deg)', 'Interpreter','latex')
xlim(handles.d3, [0, xlimt]);
ylim(handles.d3, [-0.16, 0]);
xlabel('Time (s)');
%axes theta2
axes(handles.theta4)
cla
hold on
grid on
title('${\theta_4}$ (deg)', 'Interpreter','latex')
xlim(handles.theta4, [0, xlimt]);
ylim(handles.theta4, [-180, 180]);
xlabel('Time (s)');
% plot theta1 theta2 d3 theta4 dot

axes(handles.thetadot1)
cla
hold on
grid on
title('$\dot{\theta_1}$ (deg)', 'Interpreter','latex')
xlim(handles.thetadot1, [0, xlimt]);
ylim(handles.thetadot1, [-100, 100]);
xlabel('Time (s)');

axes(handles.thetadot2)
cla
hold on
grid on
title('$\dot{\theta_2}$ (deg)', 'Interpreter','latex')
xlim(handles.thetadot2, [0, xlimt]);
ylim(handles.thetadot2, [-100, 100]);
xlabel('Time (s)');

axes(handles.d3dot3)
cla
hold on
grid on
title('$\dot{d_3}$ (m/s)', 'Interpreter','latex')
xlim(handles.thetadot2, [0, xlimt]);
% ylim(handles.thetadot2, [-0.1, 0.1]);
xlabel('Time (s)');
axes(handles.thetadot4)
cla
hold on
grid on
title('$\dot{\theta_4}$ (deg)', 'Interpreter','latex')
xlabel('Time (s)');
xlim(handles.thetadot4, [0, xlimt]);
ylim(handles.thetadot4, [-100, 100]);
%% plot Q V A
axes(handles.ax_q)
cla
hold on
grid on
title('q', 'Interpreter','latex')
xlim(handles.ax_q, [0, xlimt]);
ylim(handles.ax_q, [0, q_max]);
xlabel('Time (s)');

axes(handles.ax_v)
cla
hold on
grid on
title('v', 'Interpreter','latex')
xlim(handles.ax_v, [0, xlimt]);
ylim(handles.ax_v, [-v_max, v_max]);
xlabel('Time (s)');

axes(handles.ax_a)
cla
hold on
grid on
title('a', 'Interpreter','latex')
xlim(handles.ax_a, [0, xlimt]);
ylim(handles.ax_a, [-a_max, a_max]);
xlabel('Time (s)');
%% plot end effector
axes(handles.End_Px)
cla
hold on
grid on
title('Px', 'Interpreter','latex')
xlim(handles.End_Px, [0, xlimt]);
% ylim(handles.End_Px, [0, q_max ]);
xlabel('Time (s)');


axes(handles.End_Py)
cla
hold on
grid on
title('Py', 'Interpreter','latex')
xlim(handles.End_Py, [0, xlimt]);
% ylim(handles.End_Py, [0,q_max ]);
xlabel('Time (s)');


axes(handles.End_Pz)
cla
hold on
grid on
title('Pz', 'Interpreter','latex')
xlim(handles.End_Pz, [0, xlimt]);
% ylim(handles.End_Pz, [0,q_max ]);
% xlabel('Time (s)');


axes(handles.End_Yaw)
cla
hold on
grid on
title('Yaw', 'Interpreter','latex')
xlim(handles.End_Yaw, [0, xlimt]);
% ylim(handles.End_Yaw, [-180,180 ]);
% xlabel('Time (s)');


%%pxdot,pydot,pzdot
axes(handles.End_Pxdot)
cla
hold on
grid on
title('Pxdot', 'Interpreter','latex')
xlim(handles.End_Pxdot, [0, xlimt]);
% ylim(handles.End_Pxdot, [0,v_max ]);


axes(handles.End_Pydot)
cla
hold on
grid on
title('Pydot', 'Interpreter','latex')
xlim(handles.End_Pydot, [0, xlimt]);
ylim(handles.End_Pydot, [0,v_max ]);


axes(handles.End_Pzdot)
cla
hold on
grid on
title('Pzdot', 'Interpreter','latex')
xlim(handles.End_Pzdot, [0, xlimt]);
% ylim(handles.End_Pzdot, [0,v_max ]);



