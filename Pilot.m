function varargout = Pilot(varargin)
% PILOT MATLAB code for Pilot.fig
%      PILOT, by itself, creates a new PILOT or raises the existing
%      singleton*.
%
%      H = PILOT returns the handle to a new PILOT or the handle to
%      the existing singleton*.
%
%      PILOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PILOT.M with the given input arguments.
%
%      PILOT('Property','Value',...) creates a new PILOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pilot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pilot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pilot

% Last Modified by GUIDE v2.5 03-May-2018 14:10:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pilot_OpeningFcn, ...
                   'gui_OutputFcn',  @Pilot_OutputFcn, ...
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

function Reset(hObject, handles)

clear global

global originalImage;
global directionalRatio;
global extractedSomas;
global segmentedImage;
global base;
global rectangles;

originalImage = imread('null.png');
directionalRatio = imread('null.png');
extractedSomas = imread('null.png');
segmentedImage = imread('null.png');
base = imread('null.png');
rectangles = [];

imshow(originalImage);

handles.pushbutton8.Enable = 'off';
handles.pushbutton7.Enable = 'off';

% --- Executes just before Pilot is made visible.
function Pilot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pilot (see VARARGIN)

% Tidy

% Choose default command line output for Pilot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pilot wait for user response (see UIRESUME)
% uiwait(handles.figure1);

axis off;

Reset(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Pilot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function menu_open_button_Callback(hObject, eventdata, handles)
% hObject    handle to menu_open_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Display a dialog to search the image.

% clearvars -global base;

Reset(hObject, handles);

global originalImage;
% global directionalRatio;
% global extractedSomas;
% global segmentedImage;

% Prompt the user for a TIF file.
[imageName, imagePath] = uigetfile('*.tif');

% Open the TIF file.
originalStack = tiffRead(fullfile(imagePath, imageName), {'MONO'});
originalImage = originalStack.MONO;

% Process the TIF file.
% f = waitbar(0,'Loading...');
% [image, ~, ~] = segmentImage(originalImage, find(originalImage > 0), model, get(handles.slider4, 'Value'), 10);
% waitbar(.5,f);
% [directionalRatio, ~, extractedSomas, segmentedImage] = Main_Anigauss_2d(image, get(handles.slider3, 'Value'), 10);
% waitbar(1,f);
% close(f);
% 
handles.radiobutton1.Value = 1;
imshow(originalImage);
% DisplayImage(handles);

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

global originalImage;

imshow(originalImage);

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2

global segmentedImage;

imshow(segmentedImage);

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3

global directionalRatio;

imshow(directionalRatio);
colormap(handles.axes1, 'jet');

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4

global extractedSomas;

imshow(extractedSomas);

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5

global base;

imshow(base, [], 'Parent', handles.axes1);

% function DisplayImage(handles)
% 
% global originalImage;
% global directionalRatio;
% global extractedSomas;
% global segmentedImage;
% global base;
% global lb;
% 
% axes(handles.axes1);
% 
% if handles.radiobutton1.Value == 1
%     imshow(originalImage, []);
% elseif handles.radiobutton2.Value == 1
%     imshow(segmentedImage, []);
% elseif handles.radiobutton3.Value == 1
%     imshow(directionalRatio, []);
%     colormap(handles.axes1, 'jet');
% elseif handles.radiobutton4.Value == 1
%     imshow(extractedSomas, []);
% elseif handles.radiobutton5.Value == 1
%     if isempty(base)
%         option.rect = 1; % Hard-Coded
%         option.manual = handles.checkbox1.Value;
%         lb = get(handles.slider1, 'Value');
% 
%         runCenterLineParallel(segmentedImage, extractedSomas, option);
%     end
%     
%     imshow(base, [], 'Parent', handles.axes1);
% end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rectangles;

save('matlabRectangles.mat', 'rectangles', '-v7.3');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rectangles;

[fileName, filePath] = uigetfile('*.mat');
load(strcat(filePath, fileName), 'rectangles');

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% StepSize / (Max - Min)

hObject.Value = round(hObject.Value * 100) / 100;
sliderValue = get(handles.slider1, 'Value');
set(handles.text4, 'String', num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

hObject.Value = round(hObject.Value);
sliderValue = get(handles.slider3, 'Value');
set(handles.text8, 'String', num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

hObject.Value = round(hObject.Value * 100) / 100;
sliderValue = get(handles.slider4, 'Value');
set(handles.text10, 'String', num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global originalImage;
global segmentedImage;

load('MaxModel(April4-1).mat'); % This is hard-coded.

f = waitbar(0,'Loading...');

[~, segmentedImage, ~] = segmentImage(originalImage, find(originalImage > 0), model, get(handles.slider4, 'Value'), 10);

waitbar(1,f);

close(f);

if handles.radiobutton2.Value == 1
    imshow(segmentedImage);
end

handles.pushbutton8.Enable = 'on';

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global segmentedImage;
global extractedSomas;
global base;
global lb;
global rectangles;

if isempty(rectangles)
    option.rect = 1;
    disp("It is empty.");
else
    option.rect = 0;
    option.cell = rectangles;
    disp("It is NOT empty.");
end

option.manual = handles.checkbox1.Value;
lb = get(handles.slider1, 'Value');

[~, rectangles] = runCenterLineParallel(segmentedImage, extractedSomas, option);

if handles.radiobutton5.Value == 1
    imshow(base, [], 'Parent', handles.axes1);
end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global directionalRatio;
global extractedSomas;
global segmentedImage;

load('MaxModel(April4-1).mat'); % This is hard-coded.

f = waitbar(0,'Loading...');

[directionalRatio, ~, extractedSomas, ~] = Main_Anigauss_2d(segmentedImage, get(handles.slider3, 'Value'), 10);

waitbar(1,f);

close(f);

if handles.radiobutton3.Value == 1
    imshow(directionalRatio);
    colormap(handles.axes1, 'jet');
elseif handles.radiobutton4.Value == 1
    imshow(extractedSomas);
end

handles.pushbutton7.Enable = 'on';
