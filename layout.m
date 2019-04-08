function varargout = layout(varargin)
% LAYOUT MATLAB code for layout.fig
%      LAYOUT, by itself, creates a new LAYOUT or raises the existing
%      singleton*.
%
%      H = LAYOUT returns the handle to a new LAYOUT or the handle to
%      the existing singleton*.
%
%      LAYOUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAYOUT.M with the given input arguments.
%
%      LAYOUT('Property','Value',...) creates a new LAYOUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before layout_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to layout_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help layout

% Last Modified by GUIDE v2.5 18-Apr-2018 19:11:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @layout_OpeningFcn, ...
                   'gui_OutputFcn',  @layout_OutputFcn, ...
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


% --- Executes just before layout is made visible.
function layout_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to layout (see VARARGIN)

% Choose default command line output for layout
handles.output = hObject;

handles.Fs = 16000;
handles.nBit = 16;
handles.length= 3;
set(handles.edit_Fs,'string','16000');
set(handles.edit_nBit,'string','16');
set(handles.edit_length,'string','3');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes layout wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = layout_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_location_Callback(hObject, eventdata, handles)
% hObject    handle to edit_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_location as text
%        str2double(get(hObject,'String')) returns contents of edit_location as a double


% --- Executes during object creation, after setting all properties.
function edit_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_select.
function btn_select_Callback(hObject, eventdata, handles)

voiceLocation=uigetdir('/Users/chaikai/Desktop/final');
fileFolder = getFolderName(voiceLocation);
set(handles.edit_location,'string',voiceLocation);
[dataT,audionumber]=getTableData(voiceLocation);
set(handles.table,'Data',dataT);

disp(voiceLocation);
handles.voiceLocation = voiceLocation;
handles.fileFolder = fileFolder;
handles.audionumber=audionumber;
guidata(hObject,handles);


% --- Executes during object deletion, before destroying properties.
function table_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_draw.
function btn_draw_Callback(hObject, eventdata, handles)

data = getAllMFCCData(handles.voiceLocation,handles.fileFolder);
group=getAllGroupData(handles.voiceLocation,handles.fileFolder,handles.audionumber);
save([handles.voiceLocation,'/data/MFCC.mat'],'data');
save([handles.voiceLocation,'/data/Y.mat'],'group');


% --- Executes on button press in btn_judge.
function btn_judge_Callback(hObject, eventdata, handles)
load([handles.voiceLocation,'/data/MFCC.mat']);
load([handles.voiceLocation,'/data/Y.mat']);

temp=getOneTrainData(handles.recData,handles.Fs);
index=findAnswer(data,group,temp);
result=handles.fileFolder(1,index);
set(handles.edit_ans,'string',result);



function edit_ans_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ans as text
%        str2double(get(hObject,'String')) returns contents of edit_ans as a double


% --- Executes during object creation, after setting all properties.
function edit_ans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_play.
function btn_play_Callback(hObject, eventdata, handles)

sound(handles.recData,handles.Fs,handles.nBit);

% --- Executes on button press in btn_offline.
function btn_offline_Callback(hObject, eventdata, handles)

 [FileName,PathName,FilterIndex]=uigetfile('*.wav');
 recSrc=[PathName,FileName];
 [recData,fs]=audioread(recSrc);
 recData=EndDetection(recData);
 plot(recData);
 
 handles.recSrc=recSrc;
 handles.recData=recData;
 guidata(hObject,handles);

% --- Executes on button press in btn_online.
function btn_online_Callback(hObject, eventdata, handles)

myRecorder=audiorecorder(handles.Fs,handles.nBit,1);
recordblocking(myRecorder,handles.length);

recData=getaudiodata(myRecorder);

handles.recData=recData;

plot(recData);

guidata(hObject,handles);

function edit_Fs_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Fs as text
%        str2double(get(hObject,'String')) returns contents of edit_Fs as a double


% --- Executes during object creation, after setting all properties.
function edit_Fs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nBit_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nBit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nBit as text
%        str2double(get(hObject,'String')) returns contents of edit_nBit as a double


% --- Executes during object creation, after setting all properties.
function edit_nBit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nBit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double


% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_confirm.
function btn_confirm_Callback(hObject, eventdata, handles)

aa=get(handles.edit_Fs,'string');
bb=get(handles.edit_nBit,'string');
cc=get(handles.edit_length,'string');

handles.Fs=str2num(aa);
handles.nBit=str2num(bb);
handles.length=str2num(cc);

guidata(hObject,handles);
