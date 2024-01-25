classdef (Abstract) DataHandler<LunarConstruction
    %% This class handles all the data of the software
    % Every static function stores data of an array of objects;

    properties
        Tag;
        ID;
        Type;
        Loc;
        GraphicsHandle;
        SubType;
        PixTom=1/0.1302;   % Assuming the total length of the LunarBase is 500 m
    end
    methods (Static)
        %% All objects DATA
        function out = AllDATA(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end


        %% Physical Infrastructure DATA

        function out = PhyDATA(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
        %% Simulation Windows handles

        function out = Screen1Handle(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
        function out = Screen2Handle(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end

        %% Tracking Total Number of Objects

        function out = TrackObject(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end

        %% InternalRobotMap

        function out = InternalRobotMap(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
        %% InternalRobotPath;
        function out = InternalRobotPath(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end

        %%     InternalRobotData
        function out = InternalRobotData(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
%% Internal Robot Target
        
function out = InternalRobotTarget(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
%% Internal ChargingStations
function out = InternalRobotCS(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end

    %% Environmental Data
    function out = EnvDataTemp(data)
           persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
    end
     %% Pressurised Area Data
    function out = PRArea(data)
       persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
    end
    
    %% Fire Data

    function out = FRData(data)
          persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
    end
       %% Sandbag Data
    function out = SBData(data)
          persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
    end
     %% SMartSensor Data
      function out = SMData(data)
          persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
    end
     %% ExternalRobotMap

        function out = ExternalRobotMap(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
        %% ExternalRobotPath;
        function out = ExternalRobotPath(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end

        %%     ExternalRobotData
        function out = ExternalRobotData(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
%% External Robot Target
        
function out = ExternalRobotTarget(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
%% External ChargingStations
function out = ExternalRobotCS(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
end

%% 
    function out = SimulationComplete(data)
          persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
    end
    function out = ExternalRobotTargetLS(data)
          persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
    end
    end
end

