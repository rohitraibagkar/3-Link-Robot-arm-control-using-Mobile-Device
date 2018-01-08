function varargout = mobileBotControl_ECE5620(varargin)
% MOBILEBOTCONTROL_ECE5620 MATLAB code for mobileBotControl_ECE5620.fig
%      MOBILEBOTCONTROL_ECE5620, by itself, creates a new MOBILEBOTCONTROL_ECE5620 or raises the existing
%      singleton*.
%
%      H = MOBILEBOTCONTROL_ECE5620 returns the handle to a new MOBILEBOTCONTROL_ECE5620 or the handle to
%      the existing singleton*.
%
%      MOBILEBOTCONTROL_ECE5620('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOBILEBOTCONTROL_ECE5620.M with the given input arguments.
%
%      MOBILEBOTCONTROL_ECE5620('Property','Value',...) creates a new MOBILEBOTCONTROL_ECE5620 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mobileBotControl_ECE5620_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mobileBotControl_ECE5620_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mobileBotControl_ECE5620

% Last Modified by GUIDE v2.5 15-Dec-2017 21:00:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mobileBotControl_ECE5620_OpeningFcn, ...
                   'gui_OutputFcn',  @mobileBotControl_ECE5620_OutputFcn, ...
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


% --- Executes just before mobileBotControl_ECE5620 is made visible.
function mobileBotControl_ECE5620_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mobileBotControl_ECE5620 (see VARARGIN)

% Choose default command line output for mobileBotControl_ECE5620
handles.output = hObject;
mobileSensorDataGetter;
handles.mobileBotController = mobileSensorDataGetter;
handles.stop_bit = false;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mobileBotControl_ECE5620 wait for user response (see UIRESUME)
% uiwait(handles.main_axes);


% --- Outputs from this function are returned to the command line.
function varargout = mobileBotControl_ECE5620_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function mobile_device_Callback(hObject, eventdata, handles)
% hObject    handle to mobile_device (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function connect_mobile_device_Callback(hObject, eventdata, handles)
% hObject    handle to connect_mobile_device (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.connectMyMobileDev;
set(handles.connection_summary, 'String', handles.mobileBotController.connectionSummary);
guidata(hObject, handles);

% --------------------------------------------------------------------
function disconnect_mobile_device_Callback(hObject, eventdata, handles)
% hObject    handle to disconnect_mobile_device (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.disconnectMyMobileDev;
set(handles.connection_summary, 'String', handles.mobileBotController.connectionSummary);
guidata(hObject, handles);


% --------------------------------------------------------------------
function data_logging_Callback(hObject, eventdata, handles)
% hObject    handle to data_logging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function enable_data_logging_Callback(hObject, eventdata, handles)
% hObject    handle to enable_data_logging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.enableDataLogging;
set(handles.logging_status, 'String', handles.mobileBotController.loggingStatus);
guidata(hObject, handles);

% --------------------------------------------------------------------
function disable_data_logging_Callback(hObject, eventdata, handles)
% hObject    handle to disable_data_logging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.disableDataLogging;
set(handles.logging_status, 'String', handles.mobileBotController.loggingStatus);
guidata(hObject, handles);


% --------------------------------------------------------------------
function disable_sensors_Callback(hObject, eventdata, handles)
% hObject    handle to disable_sensors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.disableMobileSensors;
set(handles.accelerometer_status, 'String', handles.mobileBotController.accelerometerStatus);
set(handles.gyro_sensor_status, 'String', handles.mobileBotController.gyroSensorStatus);
set(handles.magneto_status, 'String', handles.mobileBotController.magnetoStatus);
set(handles.orientation_status, 'String', handles.mobileBotController.orientation);
set(handles.position_status, 'String', handles.mobileBotController.position);
guidata(hObject, handles);


% --------------------------------------------------------------------
function enable_sensor_Callback(hObject, eventdata, handles)
% hObject    handle to enable_sensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function enable_accelerometer_Callback(hObject, eventdata, handles)
% hObject    handle to enable_accelerometer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.enableAccelerometer;
set(handles.accelerometer_status, 'String', handles.mobileBotController.accelerometerStatus);
guidata(hObject, handles);

% --------------------------------------------------------------------
function enable_gyro_sensor_Callback(hObject, eventdata, handles)
% hObject    handle to enable_gyro_sensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.enableGyroSensor;
set(handles.gyro_sensor_status, 'String', handles.mobileBotController.gyroSensorStatus);
guidata(hObject, handles);

% --------------------------------------------------------------------
function enable_magnetic_sensor_Callback(hObject, eventdata, handles)
% hObject    handle to enable_magnetic_sensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.enableMagneticSensor;
set(handles.magneto_status, 'String', handles.mobileBotController.magnetoStatus);
guidata(hObject, handles);

% --------------------------------------------------------------------
function enable_orientation_sensor_Callback(hObject, eventdata, handles)
% hObject    handle to enable_orientation_sensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.enableOrientation;
set(handles.orientation_status, 'String', handles.mobileBotController.orientation);
guidata(hObject, handles);

% --------------------------------------------------------------------
function enable_positon_sensor_Callback(hObject, eventdata, handles)
% hObject    handle to enable_positon_sensor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.enablePosition;
set(handles.position_status, 'String', handles.mobileBotController.position);
guidata(hObject, handles);


% --------------------------------------------------------------------
function enable_all_sensors_Callback(hObject, eventdata, handles)
% hObject    handle to enable_all_sensors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.enableAllSensors;
set(handles.accelerometer_status, 'String', handles.mobileBotController.accelerometerStatus);
set(handles.gyro_sensor_status, 'String', handles.mobileBotController.gyroSensorStatus);
set(handles.magneto_status, 'String', handles.mobileBotController.magnetoStatus);
set(handles.orientation_status, 'String', handles.mobileBotController.orientation);
set(handles.position_status, 'String', handles.mobileBotController.position);
guidata(hObject, handles);

% --- Executes on button press in start_data_logging.
function start_data_logging_Callback(hObject, eventdata, handles)
% hObject    handle to start_data_logging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    while handles.mobileBotController.mobileDevice.Connected == true && handles.mobileBotController.mobileDevice.Logging == true...
            && handles.mobileBotController.mobileDevice.AccelerationSensorEnabled == true...
            && handles.mobileBotController.mobileDevice.AngularVelocitySensorEnabled == true...
            && handles.mobileBotController.mobileDevice.MagneticSensorEnabled == true...
            && handles.mobileBotController.mobileDevice.OrientationSensorEnabled == true...
            && handles.mobileBotController.mobileDevice.PositionSensorEnabled == true;
        
        if handles.stop_bit == true;
            handles.stop_bit = false;
            break;
        elseif handles.stop_bit == 0;
            set(handles.sensor_data_log_display, 'String', matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(handles.mobileBotController.mobileDevice));
            jointAngles = handles.mobileBotController.mobileDevice.Orientation;
            
            flexVoltage = (readVoltage(handles.mobileBotController.a, 'A0')/5) - 0.1;
            if jointAngles(1,1)/180 >=0.25 && jointAngles(1,1)/180 <= 0.75;
                writePosition(handles.mobileBotController.s1, jointAngles(1,1)/180); % yaw
            end
            
            if jointAngles(1,2)/60 >= 0.2 && jointAngles(1,2)/60 <= 0.7;
                writePosition(handles.mobileBotController.s2, jointAngles(1,2)/60); % pitch
            end
            
            if jointAngles(1,3)/180 >= 0.25 && jointAngles(1,3)/180 <= 0.75;
                writePosition(handles.mobileBotController.s3, jointAngles(1,3)/180); % roll
            end
            
            if flexVoltage <=0.075 
                writePosition(handles.mobileBotController.s4, 0.075); % clutch
            elseif flexVoltage >= 0.2
                writePosition(handles.mobileBotController.s4, 0.2); % declutch
            end
            
            set(handles.joint_angles, 'String', sprintf('Joint angles : [%f %f %f]', jointAngles(1,1), jointAngles(1,2), jointAngles(1,3)));
            set(handles.flex_value, 'String', sprintf('Clutch Value : %f', flexVoltage));
            
        end
        
        pause(.075);
        guidata(hObject, handles);
    end
catch
    errordlg('Please enable mobile device connector, connect mobile device and enable data logging', 'Device not connected !!', 'modal');
end
guidata(hObject, handles);


% --- Executes on button press in stop_data_logging.
function stop_data_logging_Callback(hObject, eventdata, handles)
% hObject    handle to stop_data_logging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.stop_bit = true;
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function logging_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logging_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function accelerometer_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accelerometer_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function gyro_sensor_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gyro_sensor_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function magneto_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to magneto_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function orientation_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orientation_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function position_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to position_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function connection_summary_CreateFcn(hObject, eventdata, handles)
% hObject    handle to connection_summary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function yaw_Callback(hObject, eventdata, handles)
% hObject    handle to yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pitch_Callback(hObject, eventdata, handles)
% hObject    handle to pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function roll_Callback(hObject, eventdata, handles)
% hObject    handle to roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function roll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function sensor_data_log_display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sensor_data_log_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function joint_angles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to joint_angles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function flex_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flex_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function connect_arduino_Callback(hObject, eventdata, handles)
% hObject    handle to connect_arduino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function connect_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.connectArduino;
guidata(hObject, handles);

% --------------------------------------------------------------------
function disconnect_Callback(hObject, eventdata, handles)
% hObject    handle to disconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mobileBotController = handles.mobileBotController.disConnectArduino;
guidata(hObject, handles);
