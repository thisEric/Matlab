function TooglePlot( hObject, name )
%TOOGLEPLOT Summary of this function goes here
%   Detailed explanation goes here
    gui = guidata(hObject);
    all_axes = findall(gcf, 'Type', 'axes');
    for i= 1: length(all_axes)
        tag = get(all_axes(i), 'Tag');
        if strcmp(tag, 'MainFrame')
            main_axes = all_axes(i);
            break;
        end
    end
    switch name
        case PlotName.OPEN_PRICE
            h = TooglePrice(main_axes, gui.plotline.hPriceOpen, gui.pricedata.price_open, 'r-');
            gui.plotline.hPriceOpen = h;
        case PlotName.CLOSE_PRICE
            h = TooglePrice(main_axes, gui.plotline.hPriceClose, gui.pricedata.price_close, 'g-.');
            gui.plotline.hPriceClose = h;
        otherwise
            return
    end
    guidata(hObject, gui);
end

function h = TooglePrice(hAxes, hPrice, price, color)
    if isempty(hPrice)
        h = plot(hAxes, price, color, 'LineWidth', 2);
    else
        visible = get(hPrice, 'Visible');
        if strcmp(visible, 'on')
            set(hPrice, 'Visible', 'off');
        else
            set(hPrice, 'Visible', 'on');
        end
        h = hPrice;
    end
end

