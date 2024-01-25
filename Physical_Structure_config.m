function Phy=Physical_Structure_config()
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
Sa=Basedata_strc.Superadobes{1}; % Superadopestructure data
Ct=Basedata_strc.ControlTowers{1}; % Control Tower
Pr=Basedata_strc.PavedRoads{1};   % PavedRoads
Pm=Basedata_strc.PressurisedModules{1}; % PressurisedModules
Lts=Basedata_strc.LunarTransportShed{1};% LTS
Hq=Basedata_strc.HumanQuietarea{1}; % HumanQuietarea
Cc=Basedata_strc.CommunicationCenter{1}; % CommunicationCenter
Sp=Basedata_strc.Superadobepath{1}; % CommunicationCenter
Ld=Basedata_strc.LoadingDocks{1}; % LoadingDock
Lp=Basedata_strc.LandingPads{1}; % LoadingDock
Lpr=Basedata_strc.LandingPadRoads{1}; % LoadingDock
Cs=Basedata_strc.ChargingStations{1}; % LoadingDock
Fk=Basedata_strc.FireKits{1}; % LoadingDock
Physicalat.Material='al';
Inv=1;
Invo=1;
%% Superadobe configurator
for i=1:length(Sa.("S No"))
Physicalat.Radius=Sa.Radius(i);
Physicalat.Center=[Sa.Center_x(i) Sa.Center_y(i)];
SA(i)=Superadobe(Sa.Tag(i),Physicalat,Inv); %Config
end
%% Landing Pads

for i=1:length(Lp.("S No"))
PhysicalatL.Radius=Lp.Radius(i);
PhysicalatL.Center=[Lp.Center_x(i) Lp.Center_y(i)];
LP(i)=LandingPads(Lp.Tag(i),PhysicalatL,Inv); %Config
end
% 
%% Control Tower
for i=1:length(Ct.("S No"))
Physical.Width=80;
Physical.Length=80;
Physical.Corner=[Ct.Center_x(i) Ct.Center_y(i)];
CT(i)=ControlTower(Ct.Tag(i),Physical,Invo); %Version1
end
% % 
%% Communication Center
for i=1:length(Cc.("S No"))
PhysicalC.Radius=Cc.Radius(i);
PhysicalC.Center=[Cc.Center_x(i) Cc.Center_y(i)];
CC(i)=CommunicationCenter(Cc.Tag(i),PhysicalC,Invo); %Version1
end
%% PavedRoads
for i=1:length(Pr.("S No"))
Physicalt.Width=Pr.Width(i);
Physicalt.Length=Pr.Length(i);
Physicalt.Corner=[Pr.Corner_x(i) Pr.Corner_y(i)];
PR(i)=PavedRoads(Pr.Tag(i),Physicalt,Invo); %Version1
end
% 

for i=1:length(Lpr.("S No"))
    Physicaltlp.Corner(1)=Lpr.Corner_x1(i);
Physicaltlp.Length=Lpr.Corner_x2(i);
Physicaltlp.Corner(2)=Lpr.Corner_y1(i);
Physicaltlp.Width=Lpr.Corner_y2(i);
    LPPR(i)=LandingPadPavedRoads(Lpr.Tag(i),[Lpr.Corner_x1(i) Lpr.Corner_y1(i) Lpr.Corner_x2(i) Lpr.Corner_y2(i)],Invo);
     
end
% 
%% Pressuriesd Modelues
for i=1:length(Pm.("S No"))
PhysicalM.Width=Pm.Width(i);
PhysicalM.Length=Pm.Length(i);
PhysicalM.Corner=[Pm.Corner_x(i) Pm.Corner_y(i)];
PM(i)=PressurisedModules(Pm.Tag(i),PhysicalM,Invo);
end
%% LTS
for i=1:length(Lts.("S No"))
PhysicalL.Width=Lts.Width(i);
PhysicalL.Length=Lts.Length(i);
PhysicalL.Corner=[Lts.Corner_x(i) Lts.Corner_y(i)];
LTS(i)=LunarTransportShed(Lts.Tag(i),PhysicalL,Invo); %Version1
end
% % 
%% HumanQuietArea
for i=1:length(Hq.("S No"))
PhysicalH.Width=Hq.Width(i);
PhysicalH.Length=Hq.Length(i);
PhysicalH.Corner=[Hq.Corner_x(i) Hq.Corner_y(i)];
HQ(i)=HumanQuietArea(Hq.Tag(i),PhysicalH,Invo); 
end
%% Superadope path
for i=1:length(Sp.("S No"))
PhysicalSp.Width=Sp.Width(i);
PhysicalSp.Length=Sp.Length(i);
PhysicalSp.Corner=[Sp.Corner_x(i) Sp.Corner_y(i)];
Spdp(i)=Superadobepath(Sp.Tag(i),PhysicalSp,Invo); 
end
% 
 %% clearance
[~,sheet_name_clear]=xlsfinfo('Clearance.xlsx'); % Reading lunarbase data
for k=1:numel(sheet_name_clear)
    Sheet_clear=sheet_name_clear{k};
    Data_clear{k}=readtable('Clearance.xlsx','Sheet',Sheet_clear,'VariableNamingRule','preserve');
end
Clearance_strc=array2table(Data_clear,"VariableNames",sheet_name_clear);
Rectangle=Clearance_strc.Rect{1}; % Superadopestructure data
for i=1:length(Rectangle.("S No"))
Corner=[Rectangle.Corner_X(i)  Rectangle.Corner_Y(i)];
Length=Rectangle.Length(i);
width=Rectangle.Width(i);
Graphics_cleaner(Corner,Length,width);
end
for i=1:length(Ld.("S No"))
Physicall.Width=Ld.Width(i);
Physicall.Length=Ld.Length(i);
Physicall.Corner=[Ld.Corner_x(i) Ld.Corner_y(i)];
LD(i)=PressurisedModules(Ld.Tag(i),Physicall,Invo);
end
for i=1:length(Cs.("S No"))
Physicall.Width=5;
Physicall.Length=5;
Physicall.Corner=[Cs.Corner_x(i) Cs.Corner_y(i)];
CS(i)=ChargingStations(Cs.Tag(i),Physicall,Invo);
end
for i=1:length(Fk.("S No"))
Physicall.Width=5;
Physicall.Length=5;
Physicall.Corner=[Fk.Corner_x(i) Fk.Corner_y(i)];
FK(i)=FireKits(Fk.Tag(i),Physicall,Invo);
end
InternalRoverTrack();
%Phy=[SA,LP,CC,HQ];
Phy=[SA,LP,CT,CC,PR,PM,LTS,HQ,Spdp,LD,LPPR,CS,FK];
%Asset_Mangement;
end