function varargout = Demo_Interaction(varargin)
% DEMO_INTERACTION MATLAB code for Demo_Interaction.fig
%      DEMO_INTERACTION by itself, creates a new DEMO_INTERACTION or raises the
%      existing singleton*.
%
%      H = DEMO_INTERACTION returns the handle to a new DEMO_INTERACTION or the handle to
%      the existing singleton*.
%
%      DEMO_INTERACTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO_INTERACTION.M with the given input arguments.
%
%      DEMO_INTERACTION('Property','Value',...) creates a new DEMO_INTERACTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo_Interaction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo_Interaction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo_Interaction

% Last Modified by GUIDE v2.5 02-Oct-2017 04:31:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo_Interaction_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo_Interaction_OutputFcn, ...
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

% --- Executes just before Demo_Interaction is made visible.
function Demo_Interaction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demo_Interaction (see VARARGIN)
% Choose default command line output for Demo_Interaction
global X Memorize MemoryList;
Memorize='memorize([]).';
MemoryList=cell(0);
X='trekking';
handles.output = 'Yes';
set(handles.text1,'String','Do you like trekking?');guidata(hObject, handles);
pause(0.1),tts('Do you like trekking?');
% Update handles structure
guidata(hObject, handles);

% Insert custom Title and Text if specified by the user
% Hint: when choosing keywords, be sure they are not easily confused 
% with existing figure properties.  See the output of set(figure) for
% a list of figure properties.
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'title'
          set(hObject, 'Name', varargin{index+1});
         case 'string'
          set(handles.text1, 'String', varargin{index+1});
        end
    end
end

% Determine the position of the dialog - centered on the callback figure
% if available, else, centered on the screen
FigPos=get(0,'DefaultFigurePosition');
OldUnits = get(hObject, 'Units');
set(hObject, 'Units', 'pixels');
OldPos = get(hObject,'Position');
FigWidth = OldPos(3);
FigHeight = OldPos(4);
if isempty(gcbf)
    ScreenUnits=get(0,'Units');
    set(0,'Units','pixels');
    ScreenSize=get(0,'ScreenSize');
    set(0,'Units',ScreenUnits);

    FigPos(1)=1/2*(ScreenSize(3)-FigWidth);
    FigPos(2)=2/3*(ScreenSize(4)-FigHeight);
else
    GCBFOldUnits = get(gcbf,'Units');
    set(gcbf,'Units','pixels');
    GCBFPos = get(gcbf,'Position');
    set(gcbf,'Units',GCBFOldUnits);
    FigPos(1:2) = [(GCBFPos(1) + GCBFPos(3) / 2) - FigWidth / 2, ...
                   (GCBFPos(2) + GCBFPos(4) / 2) - FigHeight / 2];
end
FigPos(3:4)=[FigWidth FigHeight];
set(hObject, 'Position', FigPos);
set(hObject, 'Units', OldUnits);

% Show a question icon from dialogicons.mat - variables questIconData
% and questIconMap

% Make the GUI modal
set(handles.figure1,'WindowStyle','modal')

% UIWAIT makes Demo_Interaction wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Demo_Interaction_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.figure1);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global X Memorize MemoryList;
% if length(Memorize)==13, append_comma=''; else append_comma=','; end
% Memorize=[Memorize(1:end-3) append_comma X ']).'];
MemoryList{end+1}=lower(X);
handles.output = get(hObject,'String');
QueryProlog1({['like(' lower(X) ').']},'w');
% QueryProlog({['memorize(' lower(X) ').']},'w');
[X,status]=QueryProlog1({['ask(X,' lower(X) ').']},'r');
if status==0
    set(handles.text1,'String',upper(X));
    pause(0.1),tts(X);
    pause(10);
    uiresume(handles.figure1);
end
Exclaims;
str1=PositiveExclaim1{randi(length(PositiveExclaim1))};
str2=Question{randi(length(Question))};
str3=PositiveExclaim2{randi(length(PositiveExclaim2))};
set(handles.text1,'String',[str1 str2 X str3]);
pause(0.1),tts([str1 str2 X str3]);
% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
% uiresume(handles.figure1);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = get(hObject,'String');
global X Memorize MemoryList;
% if length(Memorize)==13, append_comma=''; else append_comma=','; end
% Memorize=[Memorize(1:end-3) append_comma X ']).'];
handles.output = get(hObject,'String');
MemoryList{end+1}=lower(X);
QueryProlog1({['dislike(' lower(X) ').']},'w');
% QueryProlog({['memorize(' lower(X) ').']},'w');
[X,status]=QueryProlog1({['ask(X,' lower(X) ').']},'r');
if status==0
    set(handles.text1,'String',upper(X));
    pause(0.1),tts(X);
    pause(10);
    uiresume(handles.figure1);
end
Exclaims;
str1=NegativeExclaim1{randi(length(NegativeExclaim1))};
str2=Question{randi(length(Question))};
str3=NegativeExclaim2{randi(length(NegativeExclaim2))};
set(handles.text1,'String',[str1 str2 X str3]);
pause(0.1),tts([str1 str2 X str3]);
% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
% uiresume(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said no by hitting escape
    handles.output = 'No';
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.figure1);
end    
    
if isequal(get(hObject,'CurrentKey'),'return')
    uiresume(handles.figure1);
end    
