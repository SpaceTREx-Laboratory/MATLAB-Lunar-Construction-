classdef TargetDynamicAllocator<DataHandler
    %TARGETDYNAMICALLOCATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       DATA;
       comp;
    end
    
    methods
        function obj = TargetDynamicAllocator()
            DATA=obj.ExternalRobotTarget();
        end
        
        function obj = Update(obj)
               
        end
    end
end

