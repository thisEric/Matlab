function DrawMain( hObject )
%DRAWMAIN Summary of this function goes here
%   Detailed explanation goes here
%   hObject should be the figure handle 
    all_axes = findall(hObject, 'Type', 'axes');
    gui = guidata(hObject);
    for i= 1: length(all_axes)
        tag = get(all_axes(i), 'Tag');
        if strcmp(tag, 'MainFrame')
            main_axes = all_axes(i);
            break;
        end
    end
    set(hObject, 'currentaxes', main_axes);
    candle(gui.pricedata.price_high, gui.pricedata.price_low, ...
           gui.pricedata.price_close, gui.pricedata.price_open)
    hold on
    %candle(gui.pricedata.price_high, gui.pricedata.price_low, ...
    %       gui.pricedata.price_close, gui.pricedata.price_open, ...
    %       'b', gui.pricedata.timestamp, 25);
    
    %set callback
    hcdl_bx = findobj(main_axes, 'Type', 'patch');
    for i = 1: length(hcdl_bx)
        set(hcdl_bx(i), 'ButtonDownFcn', @Patch_ButtonDownFcn);
    end

end

function Patch_ButtonDownFcn(hObject, eventdata, handles)
    gui = guidata(hObject);
    if isempty(gui.plotline.hText)
        gui.plotline.hText = text('Color', 'red', 'VerticalAlign', 'Bottom', 'EdgeColor','red');
    end
    
    mousePoint = get(gca, 'CurrentPoint');
    mouseX = mousePoint(1,1);
    mouseY = mousePoint(1,2);
    set(gui.plotline.hText, 'Position',[mouseX, mouseY, 1]);
    index = round(mouseX);
    info = sprintf('Date: %s\nOpen :%.2f\nClose :%.2f\nHigh  :%.2f\nLow   :%.2f', ...
                    datestr(gui.pricedata.timestamp(index), 0), ...
                    gui.pricedata.price_open(index), ...
                    gui.pricedata.price_close(index), ...
                    gui.pricedata.price_high(index), ...
                    gui.pricedata.price_low(index));
    set(gui.plotline.hText, 'String',info);
    
    set(gcf, 'WindowButtonMotionFcn', @hoverCallback);    
    guidata(hObject, gui);
end

 function hoverCallback(hObject, eventdata, handles)
     gui = guidata(hObject);
     set(gcf, 'WindowButtonMotionFcn', '');
     set(gui.plotline.hText, 'String', '');
     guidata(hObject, gui);
end

