% Initialize space
N = 100;               % nr of iterations
x = zeros(N,1);
u = zeros(N,1);
yv = zeros(N,1);

xprio = zeros(N,1); % a-priori     xk|k-1
xpost = zeros(N,1); % a-posteriori xk|k
Pprio = zeros(N,1);
Ppost = zeros(N,1);
K = zeros(N,1);

%------------------------ Variables to play with:
modelError = -0.04;     % relative model error
Q = 0.01;               % std. deviation of disturbance
R = 0.1;                % std. deviation of measurement noise
x(1) = 0.5;             % initial state of plant
xpost(1) = 1;           % initial estimate (state of Kalman filter)
Ppost(1) = 0.001;       % initial error estimate (state of Kalman filter)
%------------------------

% Plant
Areal = 0.99;
B = 1;
C = 1;
% Model of plant
Amodel = Areal*(1+modelError); % model never describes reality perfectly

% Generate noise
w = Q*randn(N,1);
v = R*randn(N,1);

% Iterate
for k = 2:N
    % simulate plant
    x(k) = Areal*x(k-1) + B*u(k-1) + w(k);
    % measurement
    yv(k) = C*x(k) + v(k);

    % prediction: predict current state from previous state and control
    xprio(k) = Amodel*xpost(k-1)+B*u(k-1);
    Pprio(k) = Amodel*Ppost(k-1)*Amodel' + Q;

    % correction: use measurements with proper weight (K)
    K(k) = Pprio(k)*C * inv(C*Pprio(k)*C' + R);
    xpost(k) = xprio(k) + K(k)*(yv(k) - C*xprio(k));
    Ppost(k) = (1 - K(k)*C)*Pprio(k);
end

% Plot results
figure;
subplot(2,1,1);
hold on
ylabel('X value');
xlabel('No.Of Samples');
plot(x,'k');
plot(yv,'kx');
plot(xpost,'r');
legend('x real','x measure','x estimated');

% Important to see how K changes with time
subplot(2,1,2);
hold on
ylabel('Kalman gain value');
xlabel('No.Of Samples');
plot(K,'b')
legend('K');
% There are some tips: