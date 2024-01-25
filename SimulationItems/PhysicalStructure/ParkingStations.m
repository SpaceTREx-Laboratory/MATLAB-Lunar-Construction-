classdef ParkingStations<SimulationItems
    %PARKINGSTATIONS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        PowerAvailable; 
        CurrentRobots;
     Width;
                      Length;
    end
    
    methods
        function obj = ParkingStations(tag,Loc,Length,Width)
             %SANDBAGS Construct an instance of this class
             obj.Tag = tag;
            obj.ID=obj.TrackObject()+1;
             obj.TrackObject(obj.ID);
              obj.Type="PhysicalStructure";
            obj.SubType="ParkingStation";
             obj.Loc = Loc;
             obj.Width=Width;
                      obj.Length=Length;
                       obj=obj.GraphicsObj();
        end
        
         function obj= Update(obj)
            h=findobj(obj.Screen1Handle,'Tag',obj.Tag);
            set(h,"Position",[obj.Loc(1) obj.Loc(2) obj.Length   obj.Width],FaceColor=[0 0 0],EdgeColor=[1 1 1],LineWidth=1,Parent=obj.Screen1Handle);
        end
        function obj=GraphicsObj(obj)
            rectangle('Position',[obj.Loc(1) obj.Loc(2) obj.Length   obj.Width],'Tag',obj.Tag,FaceColor=[0 0 0],EdgeColor=[1 1 1],LineWidth=1,Parent=obj.Screen1Handle);
        end
end
end
