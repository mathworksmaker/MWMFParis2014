function setPositions()
% function setPositions() helps you
% to graphically set nPosition Target position + 1 initial robot position

simApp = SimDisplay.getInstance();
set(simApp.TrackView.Image,'ButtonDownFcn',{@f_setPosition,simApp});
set(simApp.Fig,'CloseRequestFcn',{@f_savePosition,simApp});
end

function f_setPosition(~,~,simApp)
X = get(simApp.TrackView.Axes,'CurrentPoint');
X = round(X(1,1:2)) ;

TargetPositions = [getappdata(simApp.Fig,'TargetPositions');X];
setappdata(simApp.Fig,'TargetPositions',TargetPositions);
text(X(1),X(2),num2str(size(TargetPositions,1)),'Color',[1 0 0],...
    'BackgroundColor',[.7 .9 .7],'FontWeight','bold',...
    'Parent',simApp.TrackView.Axes);
hline = getappdata(simApp.Fig,'hLine');
if isempty(hline)
    hline = line(NaN,NaN,'Color','b','LineStyle','--',...
        'LineWidth',2,'Parent',simApp.TrackView.Axes);
end
set(hline,'XData',TargetPositions(:,1),'YData',TargetPositions(:,2));


end

function f_savePosition(~,~,simApp)
TargetPositions = getappdata(simApp.Fig,'TargetPositions');
saveFilename = fullfile(fileparts(which('Background.jpg')),'Positions.m');
fMySave(saveFilename,TargetPositions);
delete(simApp.Fig);
end