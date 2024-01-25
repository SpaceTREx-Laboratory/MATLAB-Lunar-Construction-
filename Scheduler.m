classdef Scheduler<DataHandler
    %SCHUDULER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       TargetDA;
      
    end
    
    methods
        function obj = Scheduler()
           obj.TargetDA=TargetDynamicAllocator();
        end
        
        function  obj= Update(obj)
        ExR=obj.ExternalRobotData(); % all data of External Robot
        Sand=obj.SBData();
        Sand_Loc=cell2mat(arrayfun(@(x) x.Loc,Sand,'UniformOutput',false)');
        ExR(1)=ExR(1).Start();
        ExR(1).Task='AssetManagement';
        ExR(1).Target=Sand_Loc(1,:);
        ExR(1).TaskList='AssetManagement';
       % obj.ExternalRobotData(ExR);
        for i=1:10000
            %ExR=obj.ExternalRobotData();
            ExR=arrayfun(@(x) x.Update(),ExR,'UniformOutput',true); 
           % obj.ExternalRobotData(ExR);
           pause(0.001)
        end
         
        end
    end
end

