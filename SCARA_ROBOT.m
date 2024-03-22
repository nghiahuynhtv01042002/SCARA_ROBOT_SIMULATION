function varargout = SCARA_ROBOT(varargin)
% SCARA_ROBOT MATLAB code for SCARA_ROBOT.fig
%      SCARA_ROBOT, by itself, creates a new SCARA_ROBOT or raises the existing
%      singleton*.
%
%      H = SCARA_ROBOT returns the handle to a new SCARA_ROBOT or the handle to
%      the existing singleton*.
%
%      SCARA_ROBOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCARA_ROBOT.M with the given input arguments.
%
%      SCARA_ROBOT('Property','Value',...) creates a new SCARA_ROBOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SCARA_ROBOT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SCARA_ROBOT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SCARA_ROBOT

% Last Modified by GUIDE v2.5 09-Dec-2023 21:01:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SCARA_ROBOT_OpeningFcn, ...
                   'gui_OutputFcn',  @SCARA_ROBOT_OutputFcn, ...
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


% --- Executes just before SCARA_ROBOT is made visible.
function SCARA_ROBOT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SCARA_ROBOT (see VARARGIN)

% Choose default command line output for SCARA_ROBOT


global myScara;
global theta1_pre;
global theta2_pre;
global d3_pre;
global theta4_pre;
theta1_pre=0;
theta2_pre=pi/2;
d3_pre=0;
theta4_pre=0;
myScara = SCARA(handles,0.45,0.4,0.46,0.01,125 ,145 ,0.16);
% obj   = SCARA(handles,a1  ,a2 ,d1  ,d4  ,theta1_max,theta2_max,d3_max)
%%set cac slider cung giá tr? v?i edit.
hd_theta1=str2double(get(handles.edit_theta1,'string'));
hd_theta2=str2double(get(handles.edit_theta2,'string'));
hd_d3=str2double(get(handles.edit_d3,'string'));
hd_theta4=str2double(get(handles.edit_theta4,'string'));

set(handles.slider_theta1,'value',hd_theta1);
set(handles.slider_theta2,'value',hd_theta2);
set(handles.slider_d3,'value',hd_d3);
set(handles.slider_theta4,'value',hd_theta4);
%%reset point 
myScara.theta(2)=10;
myScara.theta(1)=0; 
myScara.theta(4)=0;
myScara.d(3)=0;
[myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara);
DrawRobot(myScara,handles);


global DH_table;
DH_table=[myScara.a myScara.alpha myScara.d myScara.theta];
set(handles.table_DH,'Data',DH_table);
set(handles.position,'Data',[myScara.pos,myScara.orien*180/pi]);

set(handles.pn_forward,'Visible','On');
set(handles.pn_inverse,'Visible','Off');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SCARA_ROBOT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SCARA_ROBOT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_theta1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global theta1;
theta1=get(handles.slider_theta1,'value');
set(handles.edit_theta1,'string',num2str(theta1));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_theta2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global theta2;
theta2=get(handles.slider_theta2,'value');
set(handles.edit_theta2,'string',num2str(theta2));

% --- Executes during object creation, after setting all properties.
function slider_theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_d3_Callback(hObject, eventdata, handles)
% hObject    handle to slider_d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global d3;
d3=get(handles.slider_d3,'value');
set(handles.edit_d3,'string',num2str(d3));

% --- Executes during object creation, after setting all properties.
function slider_d3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_theta4_Callback(hObject, eventdata, handles)
% hObject    handle to slider_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global theta4;
theta4=get(handles.slider_theta4,'value');
set(handles.edit_theta4,'string',num2str(theta4));

% --- Executes during object creation, after setting all properties.
function slider_theta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_theta1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta1 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta1 as a double
global theta1;
theta1=get(handles.edit_theta1,'string');
theta1=str2double(theta1);
if (theta1<180)&&(theta1>-180)
    set(handles.slider_theta1,'value',theta1);
else 
    set(handles.warning,'string','you shoud enter required value(-180<theta1<180)')
end

% --- Executes during object creation, after setting all properties.
function edit_theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta2 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta2 as a double
global theta2;
theta2 = str2double(get(handles.edit_theta2, 'string'));

if (theta2 <= 180) && (theta2 >= -180)
   set(handles.sider_theta2, 'value', theta2 );
else
   set(handles.warning,'string','Nhap gia tri theta2 trong khoang tu -180 den 180');
end


% --- Executes during object creation, after setting all properties.
function edit_theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_d3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_d3 as text
%        str2double(get(hObject,'String')) returns contents of edit_d3 as a double
global d3;
d3 = get(handles.d3_fw, 'string');
d3 = str2double(d3);
if (d3 <= 280) && (d3 >= 0)
   set(handles.slider_d3, 'value', d3 );
else
   set(handles.warning,'string','Nhap gia tri trong khoang tu 0 den 280');
end

% --- Executes during object creation, after setting all properties.
function edit_d3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta4 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta4 as a double
global theta4;
theta4 =str2double(get(handles.edit_theta4, 'string'));

if (theta4 <= 180) && (theta4 >= -180)
   set(handles.sliderd3, 'value', theta4 );
else
   set(handles.textWarning,'string','Nhap gia tri trong khoang tu -180 den 180');
end


% --- Executes during object creation, after setting all properties.
function edit_theta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_run_forward.
function btn_run_forward_Callback(hObject, eventdata, handles)
% hObject    handle to btn_run_forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.Robot);
%Forward Kinematic
global myScara;
global theta1_pre;
global theta2_pre;
global d3_pre;
global theta4_pre;
theta1_pre = myScara.theta(1);
theta2_pre = myScara.theta(2);
theta4_pre = myScara.theta(4);
d3_pre = myScara.d(3);

theta1=str2double(get(handles.edit_theta1,'string'));
theta2=str2double(get(handles.edit_theta2,'string'));
d3=str2double(get(handles.edit_d3,'string'));
theta4=str2double(get(handles.edit_theta4,'string'));

theta1_draw=linspace(theta1_pre,theta1,15);
theta2_draw=linspace(theta2_pre,theta2,15);
d3_draw=linspace(d3_pre,d3,15);
theta4_draw=linspace(theta4_pre,theta4,15);

end_effector_trajectory_x = zeros(15, 1);
end_effector_trajectory_y = zeros(15, 1);
end_effector_trajectory_z = zeros(15, 1);

for i=1:15
end_effector_trajectory_x(i) = myScara.pos(4,1);
end_effector_trajectory_y(i) = myScara.pos(4,2);
end_effector_trajectory_z(i) = myScara.pos(4,3);

myScara.theta(1)=theta1_draw(i);
myScara.theta(2)=theta2_draw(i);
myScara.d(3)=d3_draw(i);
myScara.theta(4)=theta4_draw(i);
set(handles.warning,'string','running!!!....');
[myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara);
DrawRobot(myScara,handles);
DH_table=[myScara.a myScara.alpha myScara.d myScara.theta];
set(handles.table_DH,'Data',DH_table);
set(handles.position,'Data',[myScara.pos,myScara.orien*180/pi]);
set(handles.warning,'BackgroundColor',[rand(1,3)]);
plot3(handles.Robot, end_effector_trajectory_x(1:i) , end_effector_trajectory_y(1:i),end_effector_trajectory_z(1:i), 'b', 'LineWidth', 1.5);

pause(0.01);
rotate3d on;

end
 set(handles.warning,'string','Complete');



% --- Executes on button press in btn_reset.
function btn_reset_Callback(hObject, eventdata, handles)
% hObject    handle to btn_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
global myScara;
global theta1_pre;
global theta2_pre;
global d3_pre;
global theta4_pre;

theta1_pre=0;
theta2_pre=0;
d3_pre=0;
theta4_pre=0;

hd_theta1=str2double(get(handles.edit_theta1,'string'));
hd_theta2=str2double(get(handles.edit_theta2,'string'));
hd_d3=str2double(get(handles.edit_d3,'string'));
hd_theta4=str2double(get(handles.edit_theta4,'string'));

set(handles.slider_theta1,'value',hd_theta1);
set(handles.slider_theta2,'value',hd_theta2);
set(handles.slider_d3,'value',hd_d3);
set(handles.slider_theta4,'value',hd_theta4);

myScara.theta(2)=10;
myScara.theta(1)=0;
myScara.theta(4)=0;
myScara.d(3)=0;
[myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara);
DrawRobot(myScara,handles);


grid on 
DH_table=[myScara.a myScara.alpha myScara.d myScara.theta];
set(handles.table_DH,'Data',DH_table);
set(handles.position,'Data',[myScara.pos,myScara.orien*180/pi]);
set(handles.checkbox_workspace,'Value',0);
set(handles.checkbox_coordinate,'Value',0)



function warning_Callback(hObject, eventdata, handles)
% hObject    handle to warning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of warning as text
%        str2double(get(hObject,'String')) returns contents of warning as a double


% --- Executes during object creation, after setting all properties.
function warning_CreateFcn(hObject, eventdata, handles)
% hObject    handle to warning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_view_forward.
function btn_view_forward_Callback(hObject, eventdata, handles)
% hObject    handle to btn_view_forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pn_forward,'Visible','On');
set(handles.pn_inverse,'Visible','Off');
set(handles.pn_planning,'Visible','Off');

set(handles.End_effector_panel,'Visible','Off');
set(handles.Joint_panel,'Visible','Off');
set(handles.pn_qva,'Visible','Off');
% --- Executes on button press in btn_view_inverse.
function btn_view_inverse_Callback(hObject, eventdata, handles)
% hObject    handle to btn_view_inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pn_inverse,'Visible','On');
set(handles.pn_forward,'Visible','Off');
set(handles.pn_planning,'Visible','Off');

set(handles.End_effector_panel,'Visible','Off');
set(handles.Joint_panel,'Visible','Off');
set(handles.pn_qva,'Visible','Off');

% --- Executes on button press in btn_view_planning.
function btn_view_planning_Callback(hObject, eventdata, handles)
% hObject    handle to btn_view_planning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pn_inverse,'Visible','Off');
set(handles.pn_forward,'Visible','Off');
set(handles.pn_planning,'Visible','On');

set(handles.End_effector_panel,'Visible','Off');
set(handles.Joint_panel,'Visible','Off');
set(handles.pn_qva,'Visible','On');

function edit_Px_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Px (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Px as text
%        str2double(get(hObject,'String')) returns contents of edit_Px as a double


% --- Executes during object creation, after setting all properties.
function edit_Px_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Px (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_run_inverse.
function btn_run_inverse_Callback(hObject, eventdata, handles)
% hObject    handle to btn_run_inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global px;
global py;
global pz;
global yaw;
global myScara;
global theta1;
global theta2;
global theta4;
global d3;


global sucess;

% global myScara;
global theta1_pre;
global theta2_pre;
global d3_pre;
global theta4_pre;
theta1_pre = myScara.theta(1);
theta2_pre = myScara.theta(2);
theta4_pre = myScara.theta(4);
d3_pre = myScara.d(3);


px=str2double(get(handles.edit_Px,'string'));
py=str2double(get(handles.edit_Py,'string'));
pz=str2double(get(handles.edit_Pz,'string'));
yaw=str2double(get(handles.edit_Yaw,'string'));

end_effector_trajectory_x = zeros(15, 1);
end_effector_trajectory_y = zeros(15, 1);
end_effector_trajectory_z = zeros(15, 1);

tempScara = myScara;
[tempScara,sucess] = tempScara.InverseKinematic(px,py,pz,yaw/180*pi,tempScara);

if tempScara.KinematicSingularity(tempScara) == 1
        h = questdlg('Kinematic Singularity','Warning','OK','OK');
        set(handles.warning,'string','Kinematic Singularity');
        return
end

if sucess          
        theta1 = tempScara.theta(1);
        theta2 = tempScara.theta(2);
        d3 = tempScara.d(3);
        theta4 = tempScara.theta(4);
        



theta1_draw=linspace(theta1_pre,theta1,15);
theta2_draw=linspace(theta2_pre,theta2,15);
d3_draw=linspace(d3_pre,d3,15);
theta4_draw=linspace(theta4_pre,theta4,15);

for i=1:15
end_effector_trajectory_x(i) = myScara.pos(4,1);
end_effector_trajectory_y(i) = myScara.pos(4,2);
end_effector_trajectory_z(i) = myScara.pos(4,3);
myScara.theta(1)=theta1_draw(i);
myScara.theta(2)=theta2_draw(i);
myScara.d(3)=d3_draw(i);
myScara.theta(4)=theta4_draw(i);
set(handles.warning,'string','running!!!....');
[myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara);
DrawRobot(myScara,handles);
DH_table=[myScara.a myScara.alpha myScara.d myScara.theta];
set(handles.table_DH,'Data',DH_table);
set(handles.position,'Data',[myScara.pos,myScara.orien*180/pi]);
set(handles.warning,'BackgroundColor',[rand(1,3)]);
plot3(handles.Robot, end_effector_trajectory_x(1:i) , end_effector_trajectory_y(1:i),end_effector_trajectory_z(1:i), 'b', 'LineWidth', 1.5);

pause(0.01);
rotate3d on;

end
 set(handles.warning,'string','Complete');

end
 


function edit_Yaw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Yaw as text
%        str2double(get(hObject,'String')) returns contents of edit_Yaw as a double


% --- Executes during object creation, after setting all properties.
function edit_Yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Pz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Pz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Pz as text
%        str2double(get(hObject,'String')) returns contents of edit_Pz as a double


% --- Executes during object creation, after setting all properties.
function edit_Pz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Pz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Py_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Py (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Py as text
%        str2double(get(hObject,'String')) returns contents of edit_Py as a double


% --- Executes during object creation, after setting all properties.
function edit_Py_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Py (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.




function checkbox_workspace_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_workspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global myScara
if get(hObject, 'Value')
    PlotWorkspace(myScara,handles);
else
    DrawRobot(myScara,handles);
end
rotate3d on;
% Hint: get(hObject,'Value') returns toggle state of checkbox_workspace


% --- Executes on button press in checkbox_coordinate.
function checkbox_coordinate_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_coordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global myScara
if get(hObject, 'Value')
    axes(handles.Robot);
    
    A0_1 = DH(myScara.a(1),myScara.alpha(1)*pi/180,myScara.d(1),myScara.theta(1)*pi/180) ;
    A1_2 = DH(myScara.a(2),myScara.alpha(2)*pi/180,myScara.d(2),myScara.theta(2)*pi/180) ;
    A2_3 = DH(myScara.a(3),myScara.alpha(3)*pi/180,myScara.d(3),myScara.theta(3)*pi/180) ;
    A3_4 = DH(myScara.a(4),myScara.alpha(4)*pi/180,myScara.d(4),myScara.theta(4)*pi/180) ;
    A0_0 =[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];% unit matrix
    A0_2 = A0_1*A1_2;
    A0_3 = A0_1*A1_2*A2_3;
    A0_4 = A0_1*A1_2*A2_3*A3_4;   % Te
    
    plot_coordinate(0,0,0+myScara.d(1)+0.04,A0_0,'0');
    
    plot_coordinate(myScara.pos(1,1),myScara.pos(1,2),myScara.pos(1,3)+myScara.d(1)*4/4 - 0.3,A0_1,'1');
    plot_coordinate(myScara.pos(2,1),myScara.pos(2,2),myScara.pos(2,3)+myScara.d(1),A0_2,'2');
    plot_coordinate(myScara.pos(3,1),myScara.pos(3,2),myScara.pos(3,3)+myScara.d(1)-0.55,A0_3,'3');
    plot_coordinate(myScara.pos(4,1),myScara.pos(4,2),myScara.pos(4,3)+myScara.d(3)-0.2,A0_4,'4');
else
    DrawRobot(myScara,handles); 
end
% Hint: get(hObject,'Value') returns toggle state of checkbox_coordinate


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
img = imread('logobk.png');  % Thay ??i path_to_your_image.jpg thành ???ng d?n t?i ?nh c?a b?n
imshow(img);
% Hint: place code in OpeningFcn to populate axes4


% --- Executes on button press in radbtn_trapezodial.
function radbtn_trapezodial_Callback(hObject, eventdata, handles)
% hObject    handle to radbtn_trapezodial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radbtn_scurve, 'Value', 0);
% Hint: get(hObject,'Value') returns toggle state of radbtn_trapezodial


% --- Executes on button press in radbtn_scurve.
function radbtn_scurve_Callback(hObject, eventdata, handles)
% hObject    handle to radbtn_scurve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radbtn_trapezodial, 'Value', 0);

% Hint: get(hObject,'Value') returns toggle state of radbtn_scurve



function edit_amax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amax as text
%        str2double(get(hObject,'String')) returns contents of edit_amax as a double


% --- Executes during object creation, after setting all properties.
function edit_amax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_vmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vmax as text
%        str2double(get(hObject,'String')) returns contents of edit_vmax as a double


% --- Executes during object creation, after setting all properties.
function edit_vmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xd as text
%        str2double(get(hObject,'String')) returns contents of edit_xd as a double


% --- Executes during object creation, after setting all properties.
function edit_xd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yd as text
%        str2double(get(hObject,'String')) returns contents of edit_yd as a double


% --- Executes during object creation, after setting all properties.
function edit_yd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_zd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_zd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_zd as text
%        str2double(get(hObject,'String')) returns contents of edit_zd as a double


% --- Executes during object creation, after setting all properties.
function edit_zd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_zd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yawd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yawd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yawd as text
%        str2double(get(hObject,'String')) returns contents of edit_yawd as a double


% --- Executes during object creation, after setting all properties.
function edit_yawd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yawd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_run_planning.
function btn_run_planning_Callback(hObject, eventdata, handles)
% hObject    handle to btn_run_planning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global x;
% global y;
% global z;
% global yaw;
global myScara;
global theta1;
global theta2;
global theta4;
global d3;


global sucess;


global theta1_pre;
global theta2_pre;
global d3_pre;
global theta4_pre;
theta1_pre = myScara.theta(1);
theta2_pre = myScara.theta(2);
theta4_pre = myScara.theta(4);
d3_pre = myScara.d(3);





xd=str2double(get(handles.edit_xd,'string'));
yd=str2double(get(handles.edit_yd,'string'));
zd=str2double(get(handles.edit_zd,'string'));
yawd=str2double(get(handles.edit_yawd,'string'));

x0 = myScara.pos(4,1);
y0 = myScara.pos(4,2);
z0 = myScara.pos(4,3);
yaw0 = myScara.orien(4,3)*180/pi;



v_max = str2double(get(handles.edit_vmax,'String'));
a_max = str2double(get(handles.edit_amax,'String'));

p_max = norm([xd-x0 yd-y0 zd-z0]);
if(handles.radbtn_trapezodial.Value)   
        [p,v,a,t,v_max,tf] = trajectory_trapezoid(p_max,v_max,a_max);
else
        [p,v,a,t,v_max,tf] = trajectory_S_curve(p_max,v_max,a_max); % S-curve
end

x =  x0+(p/p_max)*(xd-x0);
y = y0+(p/p_max)*(yd-y0);
z = z0+(p/p_max)*(zd-z0);
yaw = yaw0 +(p/p_max)*(yawd-yaw0);

Setplot(handles,length(t),p_max,v_max,a_max)

% joint_space = [myScara.theta(1) myScara.theta(2) myScara.d(3) myScara.theta(4)];
joint_space_theta1 = zeros(length(t), 1);
joint_space_theta2 = zeros(length(t), 1);
joint_space_d3 = zeros(length(t), 1);
joint_space_theta4= zeros(length(t), 1);

theta1_derivative = zeros(length(t), 1);
theta2_derivative =zeros(length(t), 1);
d3_derivative =zeros(length(t), 1);
theta4_derivative =zeros(length(t), 1);

v_px = zeros(length(t), 1);
v_py = zeros(length(t), 1);
v_pz = zeros(length(t), 1);

end_effector_trajectory_x = zeros(length(t), 1);
end_effector_trajectory_y = zeros(length(t), 1);
end_effector_trajectory_z = zeros(length(t), 1);



tmpScara = myScara;
[tmpScara,sucess] = tmpScara.InverseKinematic(xd,yd,zd,yawd/180*pi,tmpScara);

if tmpScara.KinematicSingularity(tmpScara) == 1
        h = questdlg('Kinematic Singularity','Warning','OK','OK');
        set(handles.warning,'string','Kinematic Singularity');
        return
end

if sucess
        

        for i=1:length(t)
            [myScara,sucess] = myScara.InverseKinematic(x(i),y(i),z(i),yaw(i)/180*pi,myScara);
            theta1 = myScara.theta(1);
            theta2 = myScara.theta(2);
            d3 = myScara.d(3);
            theta4 = myScara.theta(4);
            
             end_effector_trajectory_x(i) = myScara.pos(4,1);
             end_effector_trajectory_y(i) = myScara.pos(4,2);
             end_effector_trajectory_z(i) = myScara.pos(4,3);
                    


            set(handles.warning,'string','running!!!....');
            [myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara);
            DrawRobot(myScara,handles);
            DH_table=[myScara.a myScara.alpha myScara.d myScara.theta];
            set(handles.table_DH,'Data',DH_table);
            set(handles.position,'Data',[myScara.pos,myScara.orien*180/pi]);
            set(handles.warning,'BackgroundColor',[rand(1,3)]);

            rotate3d on;
            if i > 1
                    joint_space_theta1(i) = myScara.theta(1);
                    joint_space_theta2(i) = myScara.theta(2);
                    joint_space_d3(i) = myScara.d(3);
                    joint_space_theta4(i) = myScara.theta(4);

                    theta1_derivative(i) = (joint_space_theta1(i) - joint_space_theta1(i-1)) / (t(i) - t(i-1)); % Tính toán ??o hàm
                    theta2_derivative(i) = (joint_space_theta2(i) - joint_space_theta2(i-1)) / (t(i) - t(i-1)); % Tính toán ??o hàm
                    d3_derivative(i) = (joint_space_d3(i) - joint_space_d3(i-1)) / (t(i) - t(i-1)); % Tính toán ??o hàm
                    theta4_derivative(i) = (joint_space_theta4(i) - joint_space_theta4(i-1)) / (t(i) - t(i-1)); % Tính toán ??o hàm

                    v_px(i) = (x(i)-x(i-1))/(t(i) - t(i-1));
                    v_py(i) = (y(i)-y(i-1))/(t(i) - t(i-1));
                    v_pz(i) = (z(i)-z(i-1))/(t(i) - t(i-1));
                    
                   
                    
                    plot(handles.theta1, 1:i, joint_space_theta1(1:i), 'r', 'LineWidth', 1.5);
                    plot(handles.theta2, 1:i, joint_space_theta2(1:i), 'r', 'LineWidth', 1.5);
                    plot(handles.d3, 1:i, joint_space_d3(1:i), 'r', 'LineWidth', 1.5);
                    plot(handles.theta4, 1:i, joint_space_theta4(1:i), 'r', 'LineWidth', 1.5);

                    plot(handles.thetadot1,1:i,theta1_derivative(1:i),'b','LineWidth', 1.5);
                    plot(handles.thetadot2,1:i,theta2_derivative(1:i),'b','LineWidth', 1.5);
                    plot(handles.d3dot3,1:i,d3_derivative(1:i),'b','LineWidth', 1.5);
                    plot(handles.thetadot4,1:i,theta4_derivative(1:i),'b','LineWidth', 1.5);

                    plot(handles.ax_q,1:i,p(1:i),'r','LineWidth', 1.5);
                    plot(handles.ax_v,1:i,v(1:i),'g','LineWidth', 1.5);
                    plot(handles.ax_a,1:i,a(1:i),'b','LineWidth', 1.5);
        
                    plot(handles.End_Px,1:i,x(1:i),'r','LineWidth', 1.5);
                    plot(handles.End_Py,1:i,y(1:i),'r','LineWidth', 1.5);
                    plot(handles.End_Pz,1:i,z(1:i),'r','LineWidth', 1.5);
                    plot(handles.End_Yaw,1:i,yaw(1:i),'r','LineWidth', 1.5);
                    
                    plot(handles.End_Pxdot,1:i,v_px(1:i),'r','LineWidth', 1.5);
                    plot(handles.End_Pydot,1:i,v_py(1:i),'r','LineWidth', 1.5);
                    plot(handles.End_Pzdot,1:i,v_pz(1:i),'r','LineWidth', 1.5);
                    
                    
                    plot3(handles.Robot, end_effector_trajectory_x(1:i) , end_effector_trajectory_y(1:i),end_effector_trajectory_z(1:i), 'b', 'LineWidth', 1.5);
                    drawnow;
            end
        
        
        pause(0.001);
        end
       
 set(handles.warning,'string','Complete');
%  plot(handles.theta2,i,joint_space(:,2),'r','LineWidth',1.5);
% plot(handles.theta2, 1:length(t), joint_space, 'r', 'LineWidth', 1.5);
end



    
% --- Executes on key press with focus on radbtn_trapezodial and none of its controls.
function radbtn_trapezodial_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to radbtn_trapezodial (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on radbtn_scurve and none of its controls.
function radbtn_scurve_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to radbtn_scurve (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_visible_joint_theta_d.
function btn_visible_joint_theta_d_Callback(hObject, eventdata, handles)
% hObject    handle to btn_visible_joint_theta_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.End_effector_panel,'Visible','Off');
set(handles.Joint_panel,'Visible','On');
set(handles.pn_qva,'Visible','Off');


% --- Executes on button press in btn_view_end_effector.
function btn_view_end_effector_Callback(hObject, eventdata, handles)
% hObject    handle to btn_view_end_effector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.End_effector_panel,'Visible','On');
set(handles.Joint_panel,'Visible','Off');
set(handles.pn_qva,'Visible','Off');

% --- Executes on button press in btn_QVA.
function btn_QVA_Callback(hObject, eventdata, handles)
% hObject    handle to btn_QVA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.End_effector_panel,'Visible','Off');
set(handles.Joint_panel,'Visible','Off');
set(handles.pn_qva,'Visible','On');


% --- Executes during object creation, after setting all properties.

% hObject    handle to ax_logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate ax_logo


% --- Executes during object creation, after setting all properties.
function ax_logo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ax_logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% axes(handles.ax_logo);
img = imread('G:\matlab\filesave\BTL_robot\robot_scara_Curent\logobk.png');
imshow(img)
% Hint: place code in OpeningFcn to populate ax_logo
