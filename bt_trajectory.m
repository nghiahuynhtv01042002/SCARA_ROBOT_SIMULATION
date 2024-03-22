function [q,v,a,t] = bt_trajectory(q_max, v_max, a_max)
    if v_max > sqrt(q_max * a_max)
        v_max = sqrt(q_max * a_max);
    end

    tc = v_max / a_max;
    qc = 1/2 * a_max * tc^2;
    t_m = (q_max - 2 * qc) / v_max;
    tf = 2 * tc + t_m;

    t = 0:tf/100:tf;
    
    % T?o m?t ??i t??ng figure tr??c vòng l?p ?? tránh vi?c t?o figure m?i m?i l?n c?p nh?t
    hFig = figure;

    for i = 1:length(t)
        if t(i) < tc
            q(i) = 1/2 * a_max * t(i)^2;
            v(i) = a_max * t(i);
            a(i) = a_max;
        elseif t(i) < tc + t_m
            q(i) = qc + v_max * (t(i) - tc);
            v(i) = v_max;
            a(i) = 0;
        else
            q(i) = q_max - 1/2 * a_max * (tf - t(i))^2;
            v(i) = a_max * (tf - t(i));
            a(i) = -a_max;
        end

        % C?p nh?t ?? th? và ??i 0.01 giây tr??c khi v? ti?p
        subplot(3, 1, 1);
        plot(t(1:i), q(1:i), 'r', 'LineWidth', 1.5);
        title('Position');
        xlabel('t(s)');
        ylabel('P');
        grid on;

        subplot(3, 1, 2);
        plot(t(1:i), v(1:i), 'g', 'LineWidth', 1.5);
        title('Velocity');
        xlabel('t(s)');
        ylabel('V');
        grid on;

        subplot(3, 1, 3);
        plot(t(1:i), a(1:i), 'b', 'LineWidth', 1.5);
        title('Acceleration');
        xlabel('t(s))');
        ylabel('a');
        grid on;

        drawnow;
        pause(0.001);
    end
end
