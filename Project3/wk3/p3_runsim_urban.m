% Urban
simout = sim("p3_car_urban.slx");
sim_vel = simout.vel.Data;
sim_time = simout.tout;

figure;
plot(sim_time, sim_vel*(1/mph2mps), 'b') % [MPH]
hold on
plot(TimeUrban, DriveDataUrban, '--r') 
plot(TimeUrban, (DriveDataUrban)+3, '--k') 
plot(TimeUrban, (DriveDataUrban)-3, '--k') 
xlabel("Time [s]")
ylabel("Velocity [MPH]") 
legend("Simulation V", "Drive Cycle V") 
title("Simulated Vehicle V vs Urban Time Cycle")

% Error
error = zeros(length(TimeUrban),1);
for j = 1:length(TimeUrban)
    time_dc = TimeUrban(j);
    vel_dc = DriveDataUrban(j);
    for i = 1:length(sim_time)
        time_s = sim_time(i);
        vel_s = sim_vel(i);

        if time_s == time_dc
            err = vel_dc - vel_s;
            error(j) = err;
        else
        end
    end
end


sim_tau = simout.torque.Data; % [Nm]
sim_omega = simout.angularvelocity.Data; % [RPM]

power = zeros(size(sim_time));
for i = 1:length(sim_time)
    omega_rads = (sim_omega(i) * ((2*pi) / 60)); % [rad/s]
    power(i) = sim_tau(i)*omega_rads; % [W]
end

% Energy consumed [J]
energy = sum(power)*0.001; 
disp(['Urban energy consumed: ' num2str(energy) ' Joules']);
