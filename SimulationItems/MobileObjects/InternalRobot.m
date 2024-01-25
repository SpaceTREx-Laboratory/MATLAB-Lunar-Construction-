classdef InternalRobot<Robots
%% This is internal Robot Class
%% Internal Robot's Constructor
    methods
        function obj = InternalRobot(Tag,Loc,max_speed,min_speed,robottype,roving_energy_max,roving_energy_min)
            obj.ID=obj.TrackObject()+1;
            obj.TrackObject(obj.ID);
            obj.Type="MobileObject";
            obj.SubType="InternalRobot";
            obj.Tag=Tag;
            obj.RobotType=robottype;         
            %% Robot's Permance Parameters
            obj.BatteryLevel=100;
            obj.MaxEnergy=100;
            obj.Speed.Max=max_speed;
            obj.Speed.Min=min_speed;
            obj.FullPath=obj.InternalRobotPath();
            obj.HomeLocation=Loc;
            obj.Loc=Loc;
            obj.Map=obj.InternalRobotMap();
            obj=obj.CreateGraphicsobj();
            obj.RovingEnergy.Max=roving_energy_max;
            obj.RovingEnergy.Min=roving_energy_min;
            obj.TaskList=[];
            obj.Mode="Idle";
        end

    end

  methods (Access=public)
      %% This are the elemental tasks and operations that can be accessed from out side

       function obj=Start(obj)
           obj.Mode="Moving";
           if strcmp(obj.Task,"Patrol")
               obj.LocalPath=obj.FullPath;
           else
            obj.TargetList=[obj.Target;obj.HomeLocation];
           end
       end
  end


    methods  
        function obj=CreateGraphicsobj(obj)
            %% This function create the graphics object

            obj=CreateGraphicsobj@MobileObjects(obj);
        end
       
        function obj=Update(obj)

            %% This function updates the robot status
            obj=obj.AssignSpeed();
            if  strcmp(obj.Mode,"Wait")
                switch convertStringsToChars(obj.Task)
                    case 'FireFighting'
                        obj=obj.FireFighting();
                    case 'AsstetManagement'
                        obj.Target=obj.TargetList;
                        obj.TargetList=[];

                end


            elseif isempty(obj.LocalPath) && ~isempty(obj.TaskList)
                obj=obj.PathPlanning();
                obj.PowerConsumptionRate=obj.RovingEnergy.Min*0.10;
                obj.Mode="Moving";
                obj.Move();
            elseif strcmp(obj.Mode,"Patrol")
                obj=obj.Patrol();
            elseif strcmp(obj.Mode,"Moving")
                obj=obj.Move();

            end


        end


        function obj=AssignSpeed(obj)
            if strcmp(obj.TaskType,"High") || strcmp(obj.Status,"LowPower") 
            obj.Speed.Current=obj.Speed.Max;

            elseif strcmp(obj.TaskType,"Medium")
            obj.Speed.Current=obj.Speed.Max*(0.5);

            else
            obj.Speed.Current=obj.Speed.Min;
                
            end

        end
       
        function obj=Patrol(obj)
            obj.PowerConsumptionRate=obj.RovingEnergy.Max*0.001;
            obj=obj.Move();
        end


        function obj=PathPlanning(obj)
         planner=plannerAStarGrid(obj.Map);         
         rng('default');
         
         robot_Path=plan(planner,flip(obj.Loc),flip(obj.Target)); 
%          figure(3)
%          show(planner)
         obj.LocalPath=[robot_Path(:,2) robot_Path(:,1)];
        end

        %% Move Update

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
                         case 'AsstetManagement'
                              obj.Target=obj.TargetList;
                              obj.TargetList=[];
                      
                     end
                 end
            end
        end

         %% Power consumption Update
        
        function obj=PowerconsumptionUpdate(obj)
            if strcmp(obj.Status,"LowPower")
                obj.BatteryLevel=obj.BatteryLevel-(obj.PowerConsumptionRate*0.001);
            else
                obj.BatteryLevel=obj.BatteryLevel-obj.PowerConsumptionRate;
                obj=obj.CheckBatteryLevel();
            end
        end

        %% Fire fighting
            function obj=FireFighting(obj)
                EnvM=obj.FRData();
                if   max(Location.Temp(),[],'all')>27 || EnvM(1)>0
                    obj.Mode="Wait";
                else
                    obj.Target=obj.TargetList;
                    obj.TargetList=[];
                    
                    obj.Mode="Moving";
                    obj.Task="ReturningHome";
                end
                return;
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
        %% Updating Graphics

        function obj=UpdateGraphicsobj(obj)
              %% This function update the graphics object
            obj=UpdateGraphicsobj@MobileObjects(obj);
        end
    end
end