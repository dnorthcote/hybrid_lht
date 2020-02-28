function RunHybridLHT(bt)

% Squash some bugs and override the model (still messy)
set_param([bdroot, '/Hybrid LHT/Hybrid LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM/Simple Dual Port RAM Generator'],...
        'd', int2str(bt.nRho));

% Update simulink model
set_param('hybrid_lht', 'SimulationCommand', 'update');

% Run the model
set_param('hybrid_lht', 'SimulationCommand', 'start');

% Wait for simulation to end
while ~strcmp(get_param('hybrid_lht','SimulationStatus'), 'stopped')
    pause(10); % wait for 10 seconds then check the simulation status.
end

end

