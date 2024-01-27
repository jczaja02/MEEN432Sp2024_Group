% Project 1 Initial Conditions
tic;
% Initial Conditions

w_0 = 1.0;
J = 1;
A = 1;
b = 1;

dT = [0.001, 0.1, 1];
solver = ["ode1", "ode4"];

for i = 1:2
    for j = 1:3


        
        simout = sim("P1_pt1.slx", "Solver", solver(i), "FixedStep", string(dT(j)));
        
        W = simout.w.Data;
        W_DOT = simout.w_dot.Data;
        T = simout.tout;
        
        plot(W,T)
        hold on

        
    end
    hold off
    figure;
end

for i = 1:2
    for j = 1:3


        
        simout = sim("P1_pt1.slx", "Solver", solver(i), "FixedStep", string(dT(j)));
        
        W = simout.w.Data;
        W_DOT = simout.w_dot.Data;
        T = simout.tout;
        


        plot(W_DOT,T)
        hold on
    end
    hold off
    figure;
    
    
end

toc