classdef LunarConstruction<matlab.mixin.Heterogeneous
    %% LUNARCONSTRUCTION is top of the hierarchy in Lunar construction GNC software
    properties
        %% storing data for crictical class of the software
     ConfiguratorObj; % Configurator object
     DestructorObj;   % Destructor object
     SimulationHandlerObj; % SimulationHandler object
     SchedulerObj;
    end

    methods
        function obj = LunarConstruction() % LUNARCONSTRUCTION
                 
        end
    end
    methods(Access=public)
        %% Lunar Base Setup

        function obj= Setup(obj)    
           obj.SimulationHandlerObj=SimulationHandler(); 
           obj.ConfiguratorObj=Configurator(); % Configurator
           %obj.DestructorObj=Destructor(); 
    
           obj.SchedulerObj=Scheduler();
        end
         function obj= Update(obj)
             obj.SchedulerObj.Update(); % Main simulation Parameter
          %   obj.SimulationHandlerObj.Display(); % Simulation Graphics updater
             %obj.Close();
        end
    end
    methods(Access=private)
    function obj=Close(obj)
        obj=obj.DestructorObj.Close(obj.SimulationHandlerObj);
    end
        
    end
     
end

