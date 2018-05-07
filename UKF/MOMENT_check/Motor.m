function Motor
 
% Discrete-time extended Kalman filter simulation for two-phase 
% step motor. Estimate the stator currents, and the rotor position 
% and velocity, on the basis of noisy measurements of the stator 
% currents.
 
Ra = 2; % Winding resistance
L = 0.003; % Winding inductance
lambda = 0.1; % Motor constant
J = 0.002; % Moment of inertia
B = 0.001; % Coefficient of viscous friction
 
ControlNoise = 0.001; % std dev of uncertainty in control inputs (amps)
AccelNoise = 0.05; % std dev of shaft acceleration noise (rad/sec^2)
 
MeasNoise = 0.1; % standard deviation of measurement noise (amps)
R = [MeasNoise^2 0; 0 MeasNoise^2]; % Measurement noise covariance
xdotNoise = [ControlNoise/L; ControlNoise/L; 0.5; 0];
% Define the continuous-time process noise covariance Q
Q = [xdotNoise(1)^2 0 0 0; 
    0 xdotNoise(2)^2 0 0; 
    0 0 xdotNoise(3)^2 0; 
    0 0 0 xdotNoise(4)^2]; 
P = 1*eye(4); % Initial state estimation covariance
dt = 0.0002; % Simulation step size (seconds)
T = 0.001; % how often measurements are obtained
tf = 2; % Simulation length
 
x = [0; 0; 0; 0]; % Initial state
xhat = x; % Initial state estimate
w = 2 * pi; % Control input frequency (rad/sec)
Q = Q * T; % discrete-time process noise covariance
 
dtPlot = 0.01; % How often to plot results
tPlot = -inf; % Most recent time at which data was saved for plotting
 
% Initialize arrays for plotting at the end of the program
xArray = []; % true state
xhatArray = []; % estimated state
trPArray = []; % trace of estimation error covariance
tArray = []; % time array
yArray=[]; 
% Begin simulation loop
for t = 0 : T : tf-T+eps
    y = [x(1); x(2)]+ MeasNoise * randn(2,1); % noisy measurement
    if t >= tPlot + dtPlot
        % Save data for plotting
        tPlot = t + dtPlot - eps;
        xArray = [xArray x];
        xhatArray = [xhatArray xhat];
        trPArray = [trPArray trace(P)];
        tArray = [tArray t];
        yArray=[yArray y];
    end
    % System simulation
    for tau = 0 : dt : T-dt+eps
        time = t + tau;
        ua = sin(w*time);
        ub = cos(w*time);
        xdot = [-Ra/L*x(1) + x(3)*lambda/L*sin(x(4)) + ua/L;
            -Ra/L*x(2) - x(3)*lambda/L*cos(x(4)) + ub/L;
            -3/2*lambda/J*x(1)*sin(x(4)) + ...
            3/2*lambda/J*x(2)*cos(x(4)) - B/J*x(3);
            x(3)];
        xdot = xdot + xdotNoise .* randn(4,1);
        x = x + xdot * dt; % rectangular integration
        x(4) = mod(x(4), 2*pi); % keep the angle between 0 and 2*pi
    end
    ua = sin(w*t);
    ub = cos(w*t);
    % Compute the partial derivative matrices
    A = [-Ra/L 0 lambda/L*sin(xhat(4)) xhat(3)*lambda/L*cos(xhat(4));
        0 -Ra/L -lambda/L*cos(xhat(4)) xhat(3)*lambda/L*sin(xhat(4));
        -3/2*lambda/J*sin(xhat(4)) 3/2*lambda/J*cos(xhat(4)) -B/J ...
        -3/2*lambda/J*(xhat(1)*cos(xhat(4))+xhat(2)*sin(xhat(4)));
        0 0 1 0];
    C = [1 0 0 0; 0 1 0 0];
    % Compute the Kalman gain
    K = P * C' * inv(C * P * C' + R);
    % Update the state estimate
    deltax = [-Ra/L*xhat(1) + xhat(3)*lambda/L*sin(xhat(4)) + ua/L;
            -Ra/L*xhat(2) - xhat(3)*lambda/L*cos(xhat(4)) + ub/L;
            -3/2*lambda/J*xhat(1)*sin(xhat(4)) + ...
            3/2*lambda/J*xhat(2)*cos(xhat(4)) - B/J*xhat(3);
            xhat(3)] * T;
    xhat = xhat + deltax + K * (y - [xhat(1); xhat(2)]);
    % keep the angle estimate between 0 and 2*pi
    xhat(4) = mod(xhat(4), 2*pi); 
    % Update the estimation error covariance.
    % Don't delete the extra parentheses (numerical issues).
    P = A * ((eye(4) - K * C) * P) * A' + Q;
end
yArray;
xArray;
xhatArray;
trPArray;
% Plot the results
close all;
figure; set(gcf,'Color','White');
 
subplot(2,2,1); hold on; box on;
plot(tArray, xArray(1,:), 'b-', 'LineWidth', 2);
plot(tArray, xhatArray(1,:), 'r:', 'LineWidth', 2)
plot(tArray, yArray(2,:), 'g:', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('Current A (Amps)');
legend('True', 'Estimated','measured');
 
subplot(2,2,2); hold on; box on;
plot(tArray, xArray(2,:), 'b-', 'LineWidth', 2);
plot(tArray, xhatArray(2,:), 'r:', 'LineWidth', 2)
plot(tArray, yArray(2,:), 'g:', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('Current B (Amps)');
legend('True', 'Estimated','measured');
 
subplot(2,2,3); hold on; box on;
plot(tArray, xArray(3,:), 'b-', 'LineWidth', 2);
plot(tArray, xhatArray(3,:), 'r:', 'LineWidth', 2)
plot(tArray, yArray(2,:), 'g:', 'LineWidth', 2)
set(gca,'FontSize',12); 
xlabel('Time (Seconds)'); ylabel('Speed (Rad/Sec)');
legend('True', 'Estimated','measured');
 
subplot(2,2,4); hold on; box on;
plot(tArray, xArray(4,:), 'b-', 'LineWidth', 2);
plot(tArray,xhatArray(4,:), 'r:', 'LineWidth', 2)
plot(tArray, yArray(2,:), 'g:', 'LineWidth', 2)
set(gca,'FontSize',12); 
xlabel('Time (Seconds)'); ylabel('Position (Rad)');
legend('True', 'Estimated','measured');
 
figure;
plot(tArray, trPArray); title('Trace(P)', 'FontSize', 12);
set(gca,'FontSize',12); set(gcf,'Color','White');
xlabel('Seconds');
 
% Compute the standard deviation of the estimation errors
N = size(xArray, 2);
N2 = round(N / 2);
xArray = xArray(:,N2:N);
xhatArray = xhatArray(:,N2:N);
iaEstErr = sqrt(norm(xArray(1,:)-xhatArray(1,:))^2 / size(xArray,2));
ibEstErr = sqrt(norm(xArray(2,:)-xhatArray(2,:))^2 / size(xArray,2));
wEstErr = sqrt(norm(xArray(3,:)-xhatArray(3,:))^2 / size(xArray,2));
thetaEstErr = sqrt(norm(xArray(4,:)-xhatArray(4,:))^2 / size(xArray,2));
disp(['Std Dev of Estimation Errors = ',num2str(iaEstErr),', ', ...
    num2str(ibEstErr),', ',num2str(wEstErr),', ',num2str(thetaEstErr)]);
