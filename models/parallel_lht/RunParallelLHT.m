function RunParallelLHT(bt)

% Squash some bugs and override the model (still messy)
if ceil(log2((bt.maxRho*2))) <= 9
    set_param(['parallel_lht', '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM'], 'OverrideUsingVariant',...
        '9_bits');
else
    set_param(['parallel_lht', '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM'], 'OverrideUsingVariant',...
        'other_bits');
    
    set_param(['parallel_lht', '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM/Simple Dual Port RAM Generator'],...
        'd', int2str(bt.nRho));

    set_param(['parallel_lht', '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM/Simple Dual Port RAM Generator'],...
        'b', int2str(ceil(log2(bt.nRho))));
end

% Update simulink model
set_param('parallel_lht', 'SimulationCommand', 'update');

% Run the model
set_param('parallel_lht', 'SimulationCommand', 'start');

% Wait for simulation to end
while ~strcmp(get_param('parallel_lht','SimulationStatus'), 'stopped')
    pause(10); % wait for 10 seconds then check the simulation status.
end

end

