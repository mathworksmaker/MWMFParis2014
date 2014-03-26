function changeOrderTargetPoint

simApp = SimDisplay.getInstance();

% load TargetPosition
Positions;
% add default Trajectory
line(TargetPositions(:,1),TargetPositions(:,2),'Color','b','LineStyle',':',...
    'LineWidth',2,'Parent',simApp.TrackView.Axes); %#ok<NODEF>

hline = line(NaN,NaN,'Color','g','LineStyle','--',...
    'LineWidth',4,'Parent',simApp.TrackView.Axes); 

for idx=1:length(TargetPositions)
    line(TargetPositions(idx,1),TargetPositions(idx,2),'Color','g',...
        'LineStyle','none','Marker','o','MarkerEdgeColor',[1 0 0],...
        'MarkerFaceColor',[1 0.5 0],'MarkerSize',20,...
        'ButtonDownFcn',{@f_clickPosition,simApp},...
        'Parent',simApp.TrackView.Axes);
end
setappdata(simApp.Fig,'originalTargetPositions',TargetPositions);
setappdata(simApp.Fig,'newTargetTragectory',hline);
end

function f_clickPosition(hObject,~,simApp)
x = get(hObject,'XData');
y = get(hObject,'YData');

neworder = [getappdata(simApp.Fig,'neworder') ;x y];
setappdata(simApp.Fig,'neworder',neworder);

hline = getappdata(simApp.Fig,'newTargetTragectory');
originalTargetPositions=getappdata(simApp.Fig,'originalTargetPositions');

set(hline,'XData',neworder(:,1),'YData',neworder(:,2));
set(hObject,'MarkerEdgeColor',1-get(hObject,'MarkerEdgeColor'),...
    'MarkerFaceColor',1-get(hObject,'MarkerFaceColor'),'ButtonDownFcn','');
text(x,y,num2str(size(neworder,1)),'Color',[1 0 0],'FontWeight','bold',...
    'FontSize',20,'Parent',simApp.TrackView.Axes);

if length(neworder)==length(originalTargetPositions)
    saveFilename = which('Positions.m');
    fMySave(saveFilename,neworder);
    h=msgbox('New Order Saved');
    uiwait(h);
    delete(simApp.Fig)
else
end
end