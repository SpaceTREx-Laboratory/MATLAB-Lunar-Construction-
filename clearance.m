classdef clearance
    methods (Static) 
        function cicle(Center,Radius)
                     I=Img.Value();
                     [X,Y]=meshgrid(1:size(I,2),1:size(I,1));
                     mask=(X-(Center(1)*1/0.4008)).^2+(Y-(Center(2)*1/0.4008)).^2<=(Radius*1/0.4008).^2;
   
                     I(repmat(mask,[1 ,1 ,1]))=0;
                     I(repmat(mask,[1 ,1 ,2]))=0;
                     I(repmat(mask,[1 ,1 ,3]))=0;
                     Img.Value(I);
        end
        function rect(Corner,length,width)
            I=Img.Value();
            %I=imrect(I,[Corner(1) Corner(2) length width]*1/0.4008,'Color','b');
            [X,Y]=meshgrid(1:size(I,2),1:size(I,1));
            mask=X>Corner(1)*1/0.4008 & Y>Corner(2)*1/0.4008 & X<(Corner(1)+length)*1/0.4008 & Y<(Corner(2)+width)*1/0.4008;
                     I(repmat(mask,[1 ,1 ,1]))=0;
                      I(repmat(mask,[1 ,1 ,2]))=0;
                      I(repmat(mask,[1 ,1 ,3]))=0;
                      Img.Value(I);
     end
     end
end                     

                    