classdef (Abstract)SimulationItems<DataHandler
    %SIMULATIONITEMS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        HomeLocation;
    end
    
    methods
      
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

