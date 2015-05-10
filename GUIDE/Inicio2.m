function varargout = Inicio2(varargin)
% INICIO2 MATLAB code for Inicio2.fig
%      INICIO2, by itself, creates a new INICIO2 or raises the existing
%      singleton*.
%
%      H = INICIO2 returns the handle to a new INICIO2 or the handle to
%      the existing singleton*.
%
%      INICIO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INICIO2.M with the given input arguments.
%
%      INICIO2('Property','Value',...) creates a new INICIO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Inicio2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Inicio2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Inicio2

% Last Modified by GUIDE v2.5 28-Jun-2014 12:21:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Inicio2_OpeningFcn, ...
                   'gui_OutputFcn',  @Inicio2_OutputFcn, ...
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


% --- Executes just before Inicio2 is made visible.
function Inicio2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Inicio2 (see VARARGIN)

% Choose default command line output for Inicio2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Inicio2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
cd ../Imagenes
a=imread('MonedaIntrusa1.jpg');
a=imresize(a,[60 147]);
%a=a*0.7;
set(handles.Intrusa,'CData',a);


b=imread('Contadordemonedas.png');
b=imresize(b,[60 147]);
%b=b*0.7;
set(handles.Contar,'CData',b);

cd ../GUIDE

% --- Outputs from this function are returned to the command line.
function varargout = Inicio2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Contar.
function Contar_Callback(hObject, eventdata, handles)
% hObject    handle to Contar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Contador


% --- Executes on button press in Intrusa.
function Intrusa_Callback(hObject, eventdata, handles)
% hObject    handle to Intrusa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Cadena


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4

cd ../Imagenes
fondo=imread('fondoinicio2.png');
image(fondo)
axis off

cd ../GUIDE
