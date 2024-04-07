% Highway
simout_highway = sim("p3_car_highway.slx");
sim_vel_highway = simout_highway.vel.Data;
sim_time_highway = simout_highway.tout;

figure;
plot(sim_time_highway, sim_vel_highway*(1/mph2mps), 'b') % [MPH]
hold on
plot(TimeHighway, DriveDataHighway, '--r') 
plot(TimeHighway, (DriveDataHighway)+3, '--k') 
plot(TimeHighway, (DriveDataHighway)-3, '--k') 
xlabel("Time [s]")
ylabel("Velocity [MPH]") 
legend("Simulation V", "Drive Cycle V")
title("Simulation Vehicle V vs Highway Time Cycle")


% Error
error = zeros(length(TimeHighway),1);
for j = 1:length(TimeHighway)
    time_dc = TimeHighway(j);
    vel_dc = DriveDataHighway(j);
    for i = 1:length(sim_time_highway)
        time_s = sim_time_highway(i);
        vel_s = sim_vel_highway(i);

        if time_s == time_dc
            err = vel_dc - vel_s;
            error(j) = err;
        else
        end
    end
end

sim_tau_highway = simout_highway.torque.Data; % [Nm]
sim_omega_highway = simout_highway.angularvelocity.Data; % [RPM]

power_highway = zeros(size(sim_time_highway));
for j = 1:length(sim_time_highway)
    omega_rads_highway = (sim_omega_highway(j) * ((2*pi) / 60)); % [rad/s]
    power_highway(j) = sim_tau_highway(j)*omega_rads_highway; % [W]
end

% Energy consumed [J]
energy_highway = sum(power_highway)*0.001;
disp(['Highway energy consumed: ' num2str(energy_highway) ' Joules']);
