% Initial Conditions
w_0_values = [10, 0];
J_values = [100, 0.01];
A_values = [0, 100];
b_values = [10, 0.1];
dT = [0.001, 0.1, 1];
solver = ["ode1", "ode4"];

% Figure index
figIndex = 1;



% Nested loops for each combination of w_0, J, A, b, dT, and solver

for w0_index = 1:2
    for J_index = 1:2
        for A_index = 1:2
            for b_index = 1:2
                for dT_index = 1:length(dT)
                    for solver_index = 1:length(solver)
                        % Set the parameters for the simulation
                        w_0 = w_0_values(w0_index);
                        J = J_values(J_index);
                        A = A_values(A_index);
                        b = b_values(b_index);
                        currentSolver = solver(solver_index);
                        currentdT = dT(dT_index);

                        % Initialize a matrix to hold the maximum error for each dT and each solver
                        max_errors = zeros(3, 2);
                        
                        tic;
                        % Run the simulation
                        simout = sim('P1_pt1_1.slx', 'Solver', currentSolver, 'FixedStep', string(currentdT));

                        cpu_times(dT_index, solver_index) = toc;

                        % Extract data from simulation output
                        W = simout.get('w').signals.values;
                        W_DOT = simout.get('w_dot').signals.values;
                        T = simout.get('tout');

                        % Calculate the theoretical W using your model
                        % This assumes your theoretical model function accepts the time vector and parameters
                        W_theoretical = theoretical_model(currentdT, w_0, J, A, b);
                        
                        % Calculate the error between simulation and theoretical model
                        error_W = abs(W - W_theoretical);
                        
                        % Find the maximum error for this simulation
                        max_error_current_simulation = max(error_W);
                        
                        % Store the maximum error in the array corresponding to the current dT
                        max_errors(dT_index, solver_index) = max_error_current_simulation;

                        % Plot the results for W
                        figure(figIndex);
                        subplot(2,1,1); % upper plot
                        plot(T, W);
                        title(['W for Solver: ', currentSolver, ', dT: ', num2str(currentdT)]);
                        xlabel('Time');
                        ylabel('W');
                        grid on;

                        % Plot the results for W_DOT
                        subplot(2,1,2); % lower plot
                        plot(T, W_DOT);
                        title(['W\_DOT for Solver: ', currentSolver, ', dT: ', num2str(currentdT)]);
                        xlabel('Time');
                        ylabel('W\_DOT');
                        grid on;

                        %Increment figure index for next plot
                        figIndex = figIndex + 1;
                    end
                end
            end
        end
    end
end


%---------------------------Max Simulation Error Vs Time Step per ODE Plotting-----------------------------%
% After all simulations are complete, plot the maximum error against dT
for solver_idx = 1:2
    figure;
    plot(dT, max_errors(:, solver_idx), '-o');
    title(sprintf('Maximum Simulation Error vs Time Step (dT) for Solver %s', char(solver(solver_idx))));
    xlabel('Time Step (dT)');
    ylabel('Maximum Error');
    grid on;
end
%---------------------------Max Simulation Error Vs Time Step per ODE Plotting-----------------------------%


%---------------------------CPU Simulated Time Vs Time Step per ODE Plotting-------------------------------%
for solver_idx = 1:2
    figure;
    plot(dT, cpu_times(:, solver_idx), '-o');
    title(sprintf('CPU Time vs Time Step (dT) for Solver %s', char(solver(solver_idx))));
    xlabel('Time Step (dT)');
    ylabel('CPU Time (seconds)');
    grid on;
end
%---------------------------CPU Simulated Time Vs Time Step per ODE Plotting-------------------------------%


%------------------------Max Simulation Error Vs CPU Simulated Time per ODE Plotting-----------------------%
for solver_idx = 1:2
    figure;
    plot(cpu_times(:, solver_idx), max_errors(:, solver_idx), '-o');
    title(sprintf('Max Simulation Error Vs CPU Simulated Time for Solver %s', char(solver(solver_idx))));
    xlabel('CPU Time (seconds)');
    ylabel('Maximum Error');
    grid on;

    dT_str = arrayfun(@num2str, dT, 'UniformOutput', false);
    text(cpu_times(:, solver_idx), max_errors(:, solver_idx), dT_str, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end
%------------------------Max Simulation Error Vs CPU Simulated Time per ODE Plotting-----------------------%









solverVar = ["ode45", "ode23tb"];
freq_values = [0.1, 100];

for w0_index = 1:2
    for J_index = 1:2
        for A_index = 1:2
            for b_index = 1:2
                for freq_index = 1:2
                    for solverVar_index = 1:2
                        % Set the parameters for the simulation
                        w_0 = w_0_values(w0_index);
                        J = J_values(J_index);
                        A = A_values(A_index);
                        b = b_values(b_index);
                        freq = freq_values(freq_index);
                        currentSolver = solverVar(solverVar_index);

                        % Run the simulation
                        simout = sim('P1_pt1_1_Variable.slx', 'Solver', currentSolver);

                        % Extract data from simulation output
                        W = simout.get('w').signals.values;
                        W_DOT = simout.get('w_dot').signals.values;
                        T = simout.get('tout');

                        % Plot the results for W
                        figure(figIndex);
                        subplot(2,1,1); % upper plot
                        plot(T, W);
                        title(['W for Solver: ', currentSolver, ', Sine Wave ']);
                        xlabel('Time');
                        ylabel('W');
                        grid on;

                        % Plot the results for W_DOT
                        subplot(2,1,2); % lower plot
                        plot(T, W_DOT);
                        title(['W\_DOT for Solver: ', currentSolver, ', Sine Wave']);
                        xlabel('Time');
                        ylabel('W\_DOT');
                        grid on;

                        % Increment figure index for next plot
                        figIndex = figIndex + 1;

                    end
                end
            end
        end
    end
end




function W_theoretical = theoretical_model(T, w_0, J, A, b)
    % Replace the line below with the actual calculation of the theoretical model
    W_theoretical = (A/b)*(1-exp((-b*T)/J))+ w_0*exp((-b*T)/J);  % Your theoretical model calculation here
end