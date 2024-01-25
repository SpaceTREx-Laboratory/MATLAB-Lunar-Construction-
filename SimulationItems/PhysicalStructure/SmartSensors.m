classdef SmartSensors<SimulationItems
    %SMARTSENSORS Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Width;
                      Length;
    end

    methods
        function obj = SmartSensors(tag,Loc,Length,Width)
            %SMARTSENSORS Construct an instance of this class
            %   Detailed explanation goes here
            obj.Tag = tag;
            obj.ID=obj.TrackObject()+1;
            obj.TrackObject(obj.ID);
            obj.Type="PhysicalStructure";
            obj.SubType="SmartSensor";
            obj.Loc=Loc;
           
            obj.Width=Width;
                      obj.Length=Length;
                       obj=obj.GraphicsObj();
        end

        function obj= Update(obj)
            h=findobj(obj.Screen2Handle,'Tag',obj.Tag);
            set(h,"Position",[obj.Loc(1) obj.Loc(2) obj.Length   obj.Width],FaceColor='r',EdgeColor=[0 0 0],LineWidth=1,Parent=obj.Screen1Handle);
        end
        function obj=GraphicsObj(obj)
            rectangle('Position',[obj.Loc(1) obj.Loc(2) obj.Length   obj.Width],'Tag',obj.Tag,FaceColor='y',EdgeColor=[0 0 0],LineWidth=1,Parent=obj.Screen1Handle);
        end

    end
end

