classdef (Abstract) Robots<MobileObjects
    %ROBOTS, This class contains all the function for doing basic
    % operations 
    %   Detailed explanation goes here
    
    properties
        Mode;
        Status;
        Operation;
        FullPath;
        LocalPath;
        Map;
        Target;
        Task;
        TaskList;
        TargetList;
        OperationList;
        Mission;
        ToolAttached;
        CurrentToolList;
        Speed;
        MaxEnergy;
        PowerConsumptionRate;
        PayloadCapacity;
        BatteryLevel;
        RovingEnergy;
        RobotType;
        TaskType;
    end
    properties (Dependent)
        Current;
        Max;
        Min;
    end
    
    methods 

        
    end
end

