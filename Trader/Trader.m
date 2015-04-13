function varargout = Trader(varargin)
% TRADER MATLAB code for Trader.fig
%      TRADER, by itself, creates a new TRADER or raises the existing
%      singleton*.
%
%      H = TRADER returns the handle to a new TRADER or the handle to
%      the existing singleton*.
%
%      TRADER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRADER.M with the given input arguments.
%
%      TRADER('Property','Value',...) creates a new TRADER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Trader_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Trader_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Trader

% Last Modified by GUIDE v2.5 12-Apr-2015 17:36:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Trader_OpeningFcn, ...
                   'gui_OutputFcn',  @Trader_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Trader is made visible.
function Trader_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Trader (see VARARGIN)

% Choose default command line output for Trader
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Trader wait for user response (see UIRESUME)
% uiwait(handles.Trader);


% --- Outputs from this function are returned to the command line.
function varargout = Trader_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    file = uigetfile({'*.xlsx';'*.xls'});
    if isequal(file, 0)
        return
    end
    
    [NUM, TXT, RAW] = xlsread(file);
    [m, n] = size(NUM);
    gui = guidata(hObject);
    if ~isfield(gui, 'pricedata')
        gui.pricedata = PriceData;
    end
    gui.pricedata.data_length = m;
    gui.pricedata.price_open = NUM(:, 1);
    gui.pricedata.price_high = NUM(:, 2);
    gui.pricedata.price_low  = NUM(:, 3);
    gui.pricedata.price_close= NUM(:, 4);
    gui.pricedata.timestamp  = datenum(TXT(2:m+1, 1));

    if ~isfield(gui, 'plotline')
        gui.plotline = PlotLine;
    end
    
    guidata(hObject, gui);
    DrawMain(gcbf);


% --- Executes on key press with focus on Trader or any of its controls.
function Trader_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Trader (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
    all_axes = findall(hObject, 'Type', 'axes');
    for i= 1: length(all_axes)
        tag = get(all_axes(i), 'Tag');
        if strcmp(tag, 'MainFrame')
            main_axes = all_axes(i);
            ZoomMain(main_axes, eventdata.Key);
            break;
        end
    end


% --------------------------------------------------------------------
function Toogle_Close_Price_Callback(hObject, eventdata, handles)
% hObject    handle to Toogle_Close_Price (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   TooglePlot(hObject, PlotName.CLOSE_PRICE);

% --------------------------------------------------------------------
function Toogle_Open_Price_Callback(hObject, eventdata, handles)
% hObject    handle to Toogle_Open_Price (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    TooglePlot(hObject, PlotName.OPEN_PRICE);


% --------------------------------------------------------------------
function Plotline_Callback(hObject, eventdata, handles)
% hObject    handle to Plotline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function MainFrame_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to MainFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
