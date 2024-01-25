classdef Sandbags<SimulationItems
    %SANDBAGS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       Sensors;
       Length;
       Width;
    end
    
    methods
        function obj = Sandbags(tag,Loc,Length,Width)
            %SANDBAGS Construct an instance of this class
            obj.Tag = tag;
            obj.ID=obj.TrackObject()+1;
             obj.TrackObject(obj.ID);
              obj.Type="PhysicalStructure";
            obj.SubType="Sandbag";
            obj.Loc=Loc;
            obj.HomeLocation=Loc;
          
            obj.Width=Width;
                      obj.Length=Length;
                        obj=obj.GraphicsObj();

        end
        
        function obj= Update(obj)
            h=findobj(obj.Screen2Handle,'Tag',obj.Tag);
            set(h,"Position",[obj.Loc(1) obj.Loc(2) obj.Length   obj.Width],FaceColor=[0.5 0.5 0.5],EdgeColor='b');
        end
        function obj=GraphicsObj(obj)
            rectangle('Position',[obj.Loc(1) obj.Loc(2) obj.Length   obj.Width],'Tag',obj.Tag,FaceColor=[0.5 0.5 0.5],EdgeColor=[0 0 0],LineWidth=2,Parent=obj.Screen1Handle);
        end
    end
end

