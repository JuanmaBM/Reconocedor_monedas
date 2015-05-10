function varargout = Patron(varargin)
% PATRON MATLAB code for Patron.fig
%      PATRON, by itself, creates a new PATRON or raises the existing
%      singleton*.
%
%      H = PATRON returns the handle to a new PATRON or the handle to
%      the existing singleton*.
%
%      PATRON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PATRON.M with the given input arguments.
%
%      PATRON('Property','Value',...) creates a new PATRON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Patron_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Patron_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Patron

% Last Modified by GUIDE v2.5 29-Jun-2014 13:55:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Patron_OpeningFcn, ...
                   'gui_OutputFcn',  @Patron_OutputFcn, ...
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


% --- Executes just before Patron is made visible.
function Patron_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Patron (see VARARGIN)

% Choose default command line output for Patron
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Patron wait for user response (see UIRESUME)
% uiwait(handles.figure1);

cd ../Imagenes
a=imread('player_record.png');
a=imresize(a,[25 25]);
set(handles.pushbutton4,'CData',a);
set(handles.pushbutton5,'CData',a);
set(handles.pushbutton6,'CData',a);
set(handles.pushbutton7,'CData',a);
set(handles.pushbutton8,'CData',a);

imagenfondo=imread('fondo.jpg');
axes(handles.axes12);
imagenfondo=rgb2gray(imagenfondo);
imagenfondo=imresize(imagenfondo,[450 900]);
imshow(imagenfondo)

cabecera=imread('CabeceraPatron.jpg');
axes(handles.axes6);
imshow(cabecera)

imagen5=imread('5.jpg');
axes(handles.axes7);
imshow(imagen5)

imagen20=imread('20.jpg');
axes(handles.axes9);
imshow(imagen20)

imagen50=imread('50.jpg');
axes(handles.axes4);
imshow(imagen50)

imagen10=imread('10.jpg');
axes(handles.axes8);
imshow(imagen10)

imagen1=imread('1.jpg');
axes(handles.axes5);
imshow(imagen1)
cd ../GUIDE/


% --- Outputs from this function are returned to the command line.
function varargout = Patron_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global per1 per2 per3 per4 per5 col1 col2 col3 col4 col5
cd ../Codigo
save patrones per1 per2 per3 per4 per5 col1 col2 col3 col4 col5
cd ../GUIDE



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AyudaPatron

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global per1 col1
cd ../Codigo/
[per1,col1,moneda1] = MonedaPatron3;
axes(handles.axes7);
moneda1=moneda1*2;
imshow(moneda1);
cd ../GUIDE/


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global per2 col2
cd ../Codigo/
[per2,col2,moneda2] = MonedaPatron3;
axes(handles.axes8);
moneda2=moneda2*2;
imshow(moneda2);
cd ../GUIDE/


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global per3 col3
cd ../Codigo/
[per3,col3,moneda3] = MonedaPatron3;
axes(handles.axes9);
moneda3=moneda3*2;
imshow(moneda3);
cd ../GUIDE/


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global per4 col4
cd ../Codigo/
[per4,col4,moneda4] = MonedaPatron3;
axes(handles.axes4);
moneda4=moneda4*2;
imshow(moneda4);
cd ../GUIDE/


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global per5 col5
cd ../Codigo/
[per5,col5,moneda5] = MonedaPatron3;
axes(handles.axes5);
moneda5=moneda5*2;
imshow(moneda5);
cd ../GUIDE/


% --- Executes during object creation, after setting all properties.
function axes12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes12
