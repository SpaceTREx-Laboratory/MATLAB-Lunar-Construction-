function [All,TL]= SimulationItemConfig()
%% Data From the configuration file
% Location of Static Structure
[~,sheet_name_strc]=xlsfinfo('LunarBase.xlsx'); % Reading lunarbase data
for k=1:numel(sheet_name_strc)
    Sheet_strc=sheet_name_strc{k};
    Data_strc{k}=readtable('LunarBase.xlsx','Sheet',Sheet_strc,'VariableNamingRule','preserve');
end
%% Data loading
Basedata_strc=array2table(Data_strc,"VariableNames",sheet_name_strc);
%load("LunarBase_Physical_Structure_Data.mat");
ER=Basedata_strc.ExternalRobots{1}; % Superadopestructure data
Sa=Basedata_strc.Sandbags{1}; % Control Tower
Park=Basedata_strc.Walls{1};   % PavedRoads
%Park=Basedata_strc.ExternalRobotParkingLocation{1}; % PressurisedModules
Charge=Basedata_strc.ExternalRobotChargingStations{1};% LTS
max_speed=2;
min_speed=1;
robottype="Modular";
roving_energy_max=0.2;
roving_energy_min=0.1;
for i=1:length(ER.("S No"))
Loc=[ER.Corner_x(i) ER.Corner_y(i)]*1/0.4008;
Mob(i)= ExternalRobot(ER.Tag{i},ceil(Loc),max_speed,min_speed,robottype,roving_energy_max,roving_energy_min); %Config
end
for i=1:length(Sa.("S No"))
Loc=[Sa.Corner_x(i) Sa.Corner_y(i)]*1/0.4008;
Sand(i)=Sandbags(Sa.Tag{i},ceil(Loc),Sa.Length(i)*1/0.4008,Sa.Width(i)*1/0.4008); %Config
end
for i=1:length(Sa.("S No"))
Loc=[Sa.Corner_x(i) Sa.Corner_y(i)]*1/0.4008;
Sm(i)= SmartSensors(Sa.Tag{i},ceil(Loc),4*1/0.4008,4*1/0.4008); %Config
end
for i=1:length(Charge.("S No"))
Loc=[Charge.Corner_x(i) Charge.Corner_y(i)]*1/0.4008;
Ch(i)=ChargingStations(Charge.Tag{i},Loc, Charge.Length(i),Charge.Width(i)); %Config
end
for i=1:1
Loc=[Park.Corner_x(i) Park.Corner_y(i)]*1/0.4008;
Pa(i)= ParkingStations(Park.Tag{i},ceil(Loc), Park.Length(i)*1/0.4008,Park.Width(i)*1/0.4008); %Config
end
TL=ceil(1/0.4008*[repmat(Park.Corner_x(1)+20,78,1)' repmat(Park.Corner_x(1),78,1)';linspace(Park.Corner_y(1),Park.Corner_y(1)+Park.Width(1),Park.Width(1)/10),linspace(Park.Corner_y(1),Park.Corner_y(1)+Park.Width(1),Park.Width(1)/10)]');
All=[Mob,Sand,Sm,Ch,Pa];
end

