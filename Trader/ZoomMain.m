function ZoomMain( hObject, key)
%ZOOMMAIN Summary of this function goes here
%   Detailed explanation goes here
%   hObject is handle to current axes
%   key:    a - shift left
%           d - shift right
%           w - zoom in
%           s - zoom out
% get current XLim
    XLim = get(hObject, 'XLim');
    YLim = get(hObject, 'YLim');
    Xmin = XLim(1);
    Xmax = XLim(2);
    switch key
        case 'a'
            Xmin = XLim(1) - (XLim(2)-XLim(1))/10;
            Xmax = XLim(2) - (XLim(2)-XLim(1))/10;
        case 'd'
            Xmin = XLim(1) + (XLim(2)-XLim(1))/10;
            Xmax = XLim(2) + (XLim(2)-XLim(1))/10;
        case 'w'
            Xmin = XLim(1) + (XLim(2)-XLim(1))/10;
            Xmax = XLim(2) - (XLim(2)-XLim(1))/10;
        case 's'
            Xmin = XLim(1) - (XLim(2)-XLim(1))/10;
            Xmax = XLim(2) + (XLim(2)-XLim(1))/10;
    end
    %xlim(hObject, [Xmin, Xmax]);
    %xlim(hObject, 'manual');
    axis([Xmin, Xmax, YLim(1), YLim(2)]);
    %datetick(hObject, 'x', 25, 'keeplimits');
end

