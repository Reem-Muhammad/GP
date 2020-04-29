function plot3d(fig,leg1,leg2,leg3,sel_Data,Patient_Labels)
% fig -> figure number
%leg1 -> Feature1 name
%leg2 -> Feature2 name
%leg3 -> Feature3 name
%sel_Data -> Feature matrix of the selected three features
%Patient_Labels -> correponding labels of sel_Data


%load('pat_3.mat');
% figure(fig);
% % sel_Data=Patient_Data;
% gscatter(sel_Data(:,1),sel_Data(:,2),Patient_Labels)
% xlabel(leg1);ylabel(leg2);
% 
% figure(fig+1);
% gscatter(sel_Data(:,1),sel_Data(:,3),Patient_Labels)
% xlabel(leg1);ylabel(leg3);
% 
% figure(fig+2);
% gscatter(sel_Data(:,2),sel_Data(:,3),Patient_Labels)
% xlabel(leg2);ylabel(leg3);
T=[];
F=[];

%separate true windows from false ones
for i=1:length(Patient_Labels)
    if(Patient_Labels(i)==1)
        T=[T; sel_Data(i,:) ];
    else
        F=[F; sel_Data(i,:)];
    end
end

figure(fig);
scatter3(F(:,1),F(:,2),(F(:,3)),'r');
xlabel(leg1);
ylabel(leg2);
zlabel(leg3);
hold on;
scatter3(T(:,1),T(:,2),(T(:,3)),'b');
end