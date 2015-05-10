function varargout = Contador(varargin)
% CONTADOR MATLAB code for Contador.fig
%      CONTADOR, by itself, creates a new CONTADOR or raises the existing
%      singleton*.
%
%      H = CONTADOR returns the handle to a new CONTADOR or the handle to
%      the existing singleton*.
%
%      CONTADOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTADOR.M with the given input arguments.
%
%      CONTADOR('Property','Value',...) creates a new CONTADOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Contador_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Contador_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Contador

% Last Modified by GUIDE v2.5 29-Jun-2014 17:23:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Contador_OpeningFcn, ...
                   'gui_OutputFcn',  @Contador_OutputFcn, ...
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


% --- Executes just before Contador is made visible.
function Contador_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Contador (see VARARGIN)

% Choose default command line output for Contador
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Contador wait for user response (see UIRESUME)
% uiwait(handles.figure1);


cd ../Imagenes
a=imread('player_record.png');
a=imresize(a,[25 25]);
set(handles.rec,'CData',a);
b=imread('stop1.png');
b=imresize(b,[20 20]);
set(handles.stop,'CData',b);

imagenfondo=imread('fondo_monedas.png');
axes(handles.axes5);
image(imagenfondo)
axis off

imagen=imread('notfound.jpg');
axes(handles.axes1);
imshow(imagen)

letras2=imread('Letra2Contar.png');
axes(handles.axes8);
imshow(letras2)

letras1=imread('Letra1Contar.png');
axes(handles.axes7);
imshow(letras1)

imagencabecera=imread('CabeceraContador.jpg');
axes(handles.axes6);
imshow(imagencabecera)


cd ../GUIDE


% --- Outputs from this function are returned to the command line.
function varargout = Contador_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Ayuda.
function Ayuda_Callback(hObject, eventdata, handles)
% hObject    handle to Ayuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AyudaContador

% --- Executes on button press in rec.
function rec_Callback(hObject, eventdata, handles)
% hObject    handle to rec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd ../Codigo/
global vid flag
flag=1;
load vid3
load patrones
vid=vid2;
set(vid,'FramesPerTrigger', Inf);
set(vid,'ReturnedColorspace','rgb')
vid.FrameGrabInterval = 10;
start(vid);
cd ../GUIDE/
while (flag==1)
cont=0;
imgReal = getsnapshot(vid);
Im = im2double(imgReal);
    data=rgb2gray(imgReal);
    dataum = imcomplement( im2bw(data/0.8));
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
    axes(handles.axes1)
    imshow(imgReal)
    
hold(handles.axes1);
for n=1:size(Propiedades,1)
        
        rectangle('Position', Propiedades(n).BoundingBox,'EdgeColor','g','LineWidth',2);
        
end
    Areas = find([Propiedades.Area] > 1000 & [Propiedades.Area] < 3000);
    set(handles.text5,'String',num2str(size(Areas,2)));
    for n=1:size(Areas,2)
        rectangle('Position',Propiedades(Areas(n)).BoundingBox,'EdgeColor','b','LineWidth',0.2);
    end
    if size(Areas,2) > 0
    
    monedas=cell(1,size(Areas,2));
    for i=1:size(Areas,2)
         
        per = Propiedades(Areas(i)).Perimeter;
        centroid = Propiedades(Areas(i)).Centroid;
        selcol = imlabel(floor(centroid(2)),floor(centroid(1)));
        
        [val,pos] = min([abs(per1-per) abs(per2-per) abs(per3-per) abs(per4-per) abs(per5-per)]);
        [val,poscol] = min([abs(col4-selcol) abs(col5-selcol)]);
        if pos == 1
            cont = cont+0.05;
        else if pos == 2
                cont = cont + 0.1;
            else if pos == 3 
                    cont = cont + 0.2;
                else if pos == 4 || pos == 5
                        if poscol == 1
                            cont = cont + 0.5;
                        else 
                            cont = cont +1;
                        end
                        %if selcol > col4 - 0.1;
                        %    cont = cont + 0.5;
                        %else 
                        %   cont = cont + 1;
                        %end
                    end
                end
            end
        end
%         if per < per2+2 && selcol < col2+0.05%10 cent
%             cont = cont+0.1;
%         else if (per > per1-2 && per < per1+2) && selcol < col1+0.05%5 cent
%             cont = cont+0.05;
%         else if (per > per3-2 && per < per3+2) && selcol < col3+0.05%20 cent
%             cont = cont+0.2;
%             else if (per > per4-2 && per < per4+2) && selcol < col4+0.05%100 cent
%                     cont=cont+1;
%             else if (per > per4-2 && per < per4+2) && selcol < col4+0.05%50 cent
%                     cont = cont + 0.5;
%             end
%             end
%             end
%             end
%         end
    end
    end
    set(handles.text6,'String',num2str(cont));
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
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to Ayuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6


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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Patron


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
