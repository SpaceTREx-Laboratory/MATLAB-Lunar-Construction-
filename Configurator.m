classdef  Configurator<DataHandler
    %   Configurator class reads the configuration files and configure all
    %   the objects in the LunarBaseSoftware
    %   Detailed explanation goes here
   properties
   Robots;
   Sandbags;
   SmartSensorUnits;
   TData;
   end
   

    methods
       function obj = Configurator()
           Temp=zeros(2160,3840);
             Map=logical(Temp);
             Emap=binaryOccupancyMap(Map);
             obj.ExternalRobotMap(Emap);
         [All,TL]=SimulationItemConfig();
           ExR=All(cell2mat(arrayfun(@(x) x.SubType=="ExternalRobot",All,'UniformOutput',false)));
            Sand=All(cell2mat(arrayfun(@(x) x.SubType=="Sandbag",All,'UniformOutput',false)));
           obj.ExternalRobotData(ExR);
           obj.ExternalRobotTarget(TL);
             obj.AllDATA(All);% Storing all Data;
             
             obj.SBData(Sand);
%              figure(2)
%              show(Emap);
       %     A=obj.AllDATA();
            
           % T = table(A.ID,A.Tag,A.Type,A.SubType,'VariableNames',["ID","Tag","Type","SubType"]);
  
        end
       end
    methods(Access=private)
        
        function obj = Physicalinfrastructure_config(obj)
           %% This function contains the physical configurator
         obj.Phy=Physical_Structure_config();
         obj.PhyDATA(obj.Phy);
         PhyData=obj.PhyDATA();
             SA=PhyData(cell2mat(arrayfun(@(x) x.SubType=="Superadobe",PhyData,'UniformOutput',false)));
             SA_Loc=(arrayfun(@(x) x.Center,SA,'UniformOutput',false))';
             SA_Loc=ceil((table2array(cell2table(SA_Loc)))/0.4008);
             CS=PhyData(cell2mat(arrayfun(@(x) x.SubType=="ChargingStations",PhyData,'UniformOutput',false)));
             CS_Loc=(arrayfun(@(x) x.Corner,CS,'UniformOutput',false))';
             CS_Loc=ceil((table2array(cell2table(CS_Loc)))/0.4008);
             obj.InternalRobotCS(CS_Loc);
             obj.InternalRobotTarget(SA_Loc);
        end
         function obj = Mobileobjects_config(obj)
           obj.InR=Internal_Robot_config(obj.InternalRobotCS);
           obj.InternalRobotData(obj.InR);
         end
         function obj = Smartsensor_config(obj)
           
         end
         function obj = Inventorylist_config(obj)
           
         end
       
    end
end