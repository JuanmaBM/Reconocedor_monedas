function varargout = Cadena(varargin)
% CADENA MATLAB code for Cadena.fig
%      CADENA, by itself, creates a new CADENA or raises the existing
%      singleton*.
%
%      H = CADENA returns the handle to a new CADENA or the handle to
%      the existing singleton*.
%
%      CADENA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CADENA.M with the given input arguments.
%
%      CADENA('Property','Value',...) creates a new CADENA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Cadena_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Cadena_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Cadena

% Last Modified by GUIDE v2.5 29-Jun-2014 10:57:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Cadena_OpeningFcn, ...
                   'gui_OutputFcn',  @Cadena_OutputFcn, ...
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



% --- Executes just before Cadena is made visible.
function Cadena_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Cadena (see VARARGIN)

% Choose default command line output for Cadena
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Cadena wait for user response (see UIRESUME)
% uiwait(handles.figure1);

cd ../Imagenes
a=imread('player_record.png');
a=imresize(a,[25 25]);
set(handles.play,'CData',a);
b=imread('stop1.png');
b=imresize(b,[20 20]);
set(handles.stop,'CData',b);

imagen=imread('patroninicial.png');
axes(handles.axes11);
imshow(imagen)

imagenfondo=imread('fondo_monedas.png');
axes(handles.axes7);
image(imagenfondo)
axis off

imagen=imread('notfound.jpg');
axes(handles.axes4);
imshow(imagen)

imagenCabecera=imread('CabeceraIntrusa.jpg');
axes(handles.axes8);
imshow(imagenCabecera)

letra1=imread('Letra1Intrusa.png');
axes(handles.axes9);
imshow(letra1)

cd ../GUIDE


% --- Outputs from this function are returned to the command line.
function varargout = Cadena_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd ../Codigo/
global perimetro color vid flag cont
load vid3
vid=vid2;
flag = 1;
set(vid,'FramesPerTrigger', Inf);
set(vid,'ReturnedColorspace','rgb')
vid.FrameGrabInterval = 10;
start(vid);
while (flag == 1)
cont=0;
imgReal = getsnapshot(vid);
Im = im2double(imgReal);
    data=rgb2gray(imgReal);
    %databw = im2bw(data);
    cd ../Codigo/
    dataum = imcomplement( im2bw(data/0.8));
    cd ../GUIDE/
    [r c p] = size(imgReal);
    imR = squeeze(Im(:,:,1));
    imG = squeeze(Im(:,:,2));
    imB = squeeze(Im(:,:,3));
    imbinR = im2bw(imR,graythresh(imR));
    imbinG = im2bw(imG,graythresh(imG));
    imbinB = im2bw(imB,graythresh(imB));
    imBin = imcomplement(imbinR&imbinG&imbinB);
    se = strel('disk',3);
    imclean = imopen(dataum,se);
    imclean = imfill(imclean,'holes');
    imclean = imclearborder(imclean);    
    [L ne] = bwlabel(imclean);
    Propiedades     = regionprops(L,'Area','Perimeter', 'BoundingBox','Centroid');
    rLabel = zeros(r,c);
    gLabel = zeros(r,c);
    bLabel = zeros(r,c);
    for i=1:ne
        rLabel(L==i) = median(imR(L==i));
        gLabel(L==i) = median(imG(L==i));
        bLabel(L==i) = median(imB(L==i));
    end
    imlabel = cat(3,rLabel,gLabel,bLabel);
    axes(handles.axes4)
    imshow(imgReal)
    
hold(handles.axes4);

    Areas = find([Propiedades.Area] > 1000 & [Propiedades.Area] < 3000);
    for n=1:size(Areas,2)
        rectangle('Position',Propiedades(Areas(n)).BoundingBox,'EdgeColor','g','LineWidth',2);
    end
    if size(Areas,2) > 0
        for i=1:size(Areas,2)

            per = Propiedades(Areas(i)).Perimeter;
            centroid = Propiedades(Areas(i)).Centroid;
            selcol = imlabel(floor(centroid(2)),floor(centroid(1)));
            if abs(per-perimetro) > 5 || abs(selcol-color) > 0.2%per+5 < perimetro || per-5 > perimetro 
                    hold(handles.axes4),
                    %,plot(centroid(1),centroid(2),'xr','MarkerSize',20);
                    rectangle('Position',Propiedades(Areas(i)).BoundingBox,'EdgeColor','r','LineWidth',2);
                    cont = cont + 1; 
                    
            end
        end
    end
    set(handles.text2, 'String', num2str(cont));
end 



% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid flag
flag = 0;
stop(vid)
flushdata(vid);


% --- Executes on button press in Ayuda.
function Ayuda_Callback(hObject, eventdata, handles)
% hObject    handle to Ayuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AyudaIntrusa

% --- Executes during object creation, after setting all properties.
function Logo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Logo


% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes7




% --- Executes during object creation, after setting all properties.
function axes8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes8



% --- Executes during object creation, after setting all properties.
function axes9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes9



% --- Executes on button press in Patron.
function Patron_Callback(hObject, eventdata, handles)
% hObject    handle to Patron (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd ../Codigo
global perimetro color moneda
[perimetro,color,moneda] = MonedaPatron3;
guidata(hObject,handles);
axes(handles.axes11);
moneda=moneda*2;
imshow(moneda);
cd ../GUIDE/


% --- Executes during object creation, after setting all properties.
function axes11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes11


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4
