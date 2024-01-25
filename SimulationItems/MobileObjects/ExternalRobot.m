classdef ExternalRobot<Robots
    %ExternalRobot Summary of this class goes here
    %   Detailed explanation goes here


    methods
        function obj = ExternalRobot(Tag,Loc,max_speed,min_speed,robottype,roving_energy_max,roving_energy_min)
            obj.ID=obj.TrackObject()+1;
            obj.TrackObject(obj.ID);
            obj.Type="MobileObject";
            obj.SubType="ExternalRobot";
            obj.Tag=Tag;
            obj.RobotType=robottype;
            %% Robot's Permance Parameters
            obj.BatteryLevel=100;
            obj.MaxEnergy=100;
            obj.Speed.Max=max_speed;
            obj.Speed.Min=min_speed;
            obj.FullPath=obj.InternalRobotPath();
            obj.HomeLocation=Loc; % Parking Location
            obj.Loc=Loc; % Current Location
            obj.Map=obj.ExternalRobotMap();
            obj=obj.CreateGraphicsobj();
            obj.RovingEnergy.Max=roving_energy_max;
            obj.RovingEnergy.Min=roving_energy_min;
            obj.TaskList=[];
            obj.Mode="Idle";
        end
        %% Start the robot and do health diagonisis
        function obj=Start(obj)
            obj.Mode="Moving";
            if strcmp(obj.Task,"Patrol")
                obj.LocalPath=obj.FullPath;
            else
                obj.TargetList=[obj.Target;obj.HomeLocation];
            end
        end

        function obj=Update(obj)
            %% This function updates the robot status
            obj=obj.AssignSpeed();
            if  strcmp(obj.Mode,"Wait")
                switch convertStringsToChars(obj.Task)
                    case 'FireFighting'
                        obj=obj.FireFighting();
                    case 'AssetManagement'
                        obj.Target=obj.TargetList;
                        obj.TargetList=[];

                end
            elseif isempty(obj.LocalPath) && ~isempty(obj.TaskList)
                obj=obj.PathPlanning();
                obj.PowerConsumptionRate=obj.RovingEnergy.Min*0.10;
                obj.Mode="Moving";
                obj.Move();
            elseif strcmp(obj.Task,"Patrol")
                obj=obj.Patrol();
            elseif strcmp(obj.Mode,"Moving")
                obj=obj.Move();

            end


        end
       
        function obj=PathPlanning(obj)
            %% Path planning
%             planner=plannerAStarGrid(obj.Map);
%             rng('default');
% 
%             robot_Path=plan(planner,flip(obj.Loc),flip(obj.Target));
% %                      figure(3)
% %                      show(planner)
distance=ceil(pdist2(obj.Loc,obj.Target));
 
% Generate the data points on the line
x = ceil(linspace(obj.Loc(1), obj.Target(1), distance));
y = ceil(linspace(obj.Loc(2), obj.Target(2), distance));

            obj.LocalPath=unique([x;y]','rows');


        end
      
          function obj=Move(obj)
            if strcmp(obj.Status,'Occupied') || strcmp(obj.Status,'LowPower') || strcmp(obj.Mode,'Moving') 
            % Move location
            f=find(double(ismember(obj.LocalPath,obj.Loc,"rows"))==1);
            f=f(1);
            if (f+obj.Speed.Current)<size(obj.LocalPath,1)
            obj.Loc=obj.LocalPath(f+obj.Speed.Current,:);
            elseif abs(sum(obj.Target-obj.HomeLocation))>0
            % Updating location if target is nearby
            obj.Loc=obj.Target;
            obj.LocalPath=[];
            obj=obj.ChargingUpdate();
            obj=obj.TargetUpdate();
            else
            obj.Loc=obj.HomeLocation;
            obj.Mode='Idle';
            obj.Task=[];
 
            end
                obj=obj.PowerconsumptionUpdate();
                obj=obj.UpdateGraphicsobj();
            else
            return;
            end
            
        end
            %% Updating charge
        function obj=ChargingUpdate(obj)

             if strcmp(obj.Status,'LowPower') 
        
             obj.BatteryLevel=100;
             obj.Mode=obj.Task;
             obj.Status="Occupied";
            end
        end

        %% Updating target location
        
        function obj=TargetUpdate(obj)

            if isempty(obj.TargetList)
                obj.Target=obj.HomeLocation;
            else
                 Cu_Target=ismember(obj.TargetList, obj.Target,"rows");
                 obj.TargetList(Cu_Target,:)=[];
                 if size(obj.TargetList)>1
                     obj.Target=obj.TargetList(1,:);
                     obj.TargetList=obj.TargetList(2:end,:);
                 else
                     switch convertStringsToChars(obj.Task)
                         case 'FireFighting'
                             EnvM=obj.FRData();
                             if  max(Location.Temp(),[],'all')>27 && EnvM(1)>=0 
                                 obj.Mode="Wait";
                             else
                                 obj.Target=obj.TargetList;
                                 obj.TargetList=[]; 
                                 obj.Mode="Moving";
                             end
                         case 'AssetManagement'
                             Sand=obj.SBData();
                             Sand_Loc=cell2mat(arrayfun(@(x) x.Loc,Sand,'UniformOutput',false)');
                             RbTL=obj.ExternalRobotTarget();
                             tmpS=find(ismember(unique(Sand_Loc,"rows"),obj.Loc,"rows"));
                             tmpT=find(ismember(RbTL,obj.Loc,"rows"));
                             if tmpS==1
                                 obj.Target=RbTL(1,:);
                                 Temp_sand=find(ismember(Sand_Loc,obj.Loc,"rows"));

                             elseif tmpT==1
                                 RbTL=RbTL(2:end,:);
                                 obj.Target=Sand_Loc(1,:);
                             else
                                 obj.Target=obj.HomeLocation;
                             end


                     end
                 end
            end
        end

         function obj=PowerconsumptionUpdate(obj)
            if strcmp(obj.Status,"LowPower")
                obj.BatteryLevel=obj.BatteryLevel-(obj.PowerConsumptionRate*0.001);
            else
                obj.BatteryLevel=obj.BatteryLevel-obj.PowerConsumptionRate;
                obj=obj.CheckBatteryLevel();
            end
        end
   
        %% Checking battery level 

        function obj=CheckBatteryLevel(obj)
        if (obj.BatteryLevel/obj.MaxEnergy)<0.25 
        obj.Mode="Moving";
        obj.LocalPath=[];
        obj.Target=obj.FullPath(3000,:);
        obj.Status="LowPower";
        else 
        return;
        end
        end
        %% Speed
        function obj=AssignSpeed(obj)
            if strcmp(obj.TaskType,"High") || strcmp(obj.Status,"LowPower") 
            obj.Speed.Current=obj.Speed.Max;

            elseif strcmp(obj.TaskType,"Medium")
            obj.Speed.Current=obj.Speed.Max*(0.5);

            else
            obj.Speed.Current=obj.Speed.Min;
                
            end

        end
         function obj=CreateGraphicsobj(obj)
            %% This function create the graphics object

            obj=CreateGraphicsobj@MobileObjects(obj);
        end
        %% Updating Graphics

        function obj=UpdateGraphicsobj(obj)
              %% This function update the graphics object
            obj=UpdateGraphicsobj@MobileObjects(obj);
        end
    end
end