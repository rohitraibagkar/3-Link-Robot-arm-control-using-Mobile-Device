classdef mobileSensorDataGetter
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        mobileDevice            % The variable where mobile device class is stored...
        connectionSummary       % The variable where details of the connection are stored...
        loggingStatus           % The variable where status of logging is stored...
        
        accelerometerStatus     % Status of accelerometer...
        gyroSensorStatus        % Status of gyro Sensor...
        magnetoStatus           % Status of magnetic sensor...
        orientation             % Status of orientation sensor...
        position                % Status of position sensor...
        
        a                       % arduino connection variable...
        s1                      % servo 1: yaw control
        s2                      % servo 2: pitch control
        s3                      % servo 3: roll control
        s4                      % servo 4: clutch and de-clutch control
        
    end
    
    methods
        
        function mobile = connectMyMobileDev (mobile) % Opens port to connect mobile device to MATLAB...
            
            options.Resize = 'on';
            options.WindowStyle = 'normal';
            options.Interpreter = 'tex';
            password = inputdlg({'Enter Alphanumeric password containing more than 5 characters'},...
                                'Enter Alpha-numeric Password', [1 50], {''}, options); % to be displayed
            connector('on', 'password', password{1,1});
            hostname = char(getHostName(java.net.InetAddress.getLocalHost)); % to be displayed
            ip_address = char(getHostAddress(java.net.InetAddress.getLocalHost)); % to be displayed
            user = getenv('UserName'); % to be displayed
            mobile.connectionSummary = sprintf('Connetion details are : \n\nDNS name : %s \nIP address : %s \nPassword : %s \nUser : %s',...
                                                hostname, ip_address, password{1,1}, user); % connecton summary of the mobile device...
            mobile.mobileDevice = mobiledev;    % the property where mobiledevice will be stored...
            d = dialog('Position', [400 400 300 190],'Name','Ready to connect !!');

            txt = uicontrol('Parent',d,...
                'Style','text',...
                'Position', [45 100 210 80],...
                'String',mobile.connectionSummary);
            
            btn = uicontrol('Parent',d,...
                'Position', [100 60 100 25],...
                'String','Close',...
                'Callback','delete(gcf)');
            
        end
        
        function mobile = disconnectMyMobileDev (mobile) % Closes port of Mobile device connected to MATLAB...
            
            mobile.mobileDevice = 0; % sets mobile device to zero
            clear mobile.mobileDevice; % clears mobile device
            connector off;
            mobile.connectionSummary = sprintf('Mobile Device successfully disconnected...!!!');
            msgbox('Mobile Device has been successfully disconnected.', 'Success', 'modal');
            
        end
        
        function mobile = enableDataLogging (mobile) % Enables data logging of mobile device sensors...
            
            if mobile.mobileDevice.Connected == 0;
                errordlg('Please connect Mobile Device to Matlab', 'Device not Connected !!', 'modal');
            elseif mobile.mobileDevice.Connected == 1;
                options.Resize = 'on';
                options.WindowStyle = 'normal';
                options.Interpreter = 'tex';
                mobile.mobileDevice.SampleRate = str2double(inputdlg({'Enter Sampling Rate from min 1 to max 100'}, ...
                    'Enter Sampleing Rate', [1 50], {'10'}, options)); % to be displayed
                if mobile.mobileDevice.Connected == true && (mobile.mobileDevice.AccelerationSensorEnabled == true ...
                        || mobile.mobileDevice.AngularVelocitySensorEnabled == true ...
                        || mobile.mobileDevice.MagneticSensorEnabled == true ...
                        || mobile.mobileDevice.OrientationSensorEnabled == true ...
                        || mobile.mobileDevice.PositionSensorEnabled == true);
                    
                    mobile.mobileDevice.Logging = true; % data logging is enabled only if all the sensors are enebled...
                    msgbox('Data Logging has been successfully enabled.', 'Success', 'modal');
                    mobile.loggingStatus = sprintf('Data Logging................:: Enabled');
                    
                elseif mobile.mobileDevice.Connected == true && (mobile.mobileDevice.AccelerationSensorEnabled == false ...
                        && mobile.mobileDevice.AngularVelocitySensorEnabled == false ...
                        && mobile.mobileDevice.MagneticSensorEnabled == false ...
                        && mobile.mobileDevice.OrientationSensorEnabled == false ...
                        && mobile.mobileDevice.PositionSensorEnabled == false);
                    errordlg('Please enable at least one Sensor of your Mobile device to enable data logging',...
                        'Sensor not enabled !!', 'modal');
                end
            end
        end
        
        function mobile = disableDataLogging (mobile) % disables data logging...
            
            if mobile.mobileDevice.Connected == 0;
                errordlg('Please connect Mobile device to Matlab', 'Device not Connected !!', 'modal');
            elseif mobile.mobileDevice.Connected == true && mobile.mobileDevice.Logging == false;
                errordlg('Data Logging is already disabled.', 'Logging disabled !!', 'modal');
            elseif mobile.mobileDevice.Connected == true && mobile.mobileDevice.Logging == true
                mobile.mobileDevice.Logging = false;
                msgbox('Data Logging has been successfully disabled.', 'Success', 'modal');
                mobile.loggingStatus = sprintf('Data Logging................:: Disabled');
            end
        end
        
        function mobile = enableAccelerometer (mobile) % enables accelerometer...
            
            if mobile.mobileDevice.Connected == true && mobile.mobileDevice.AccelerationSensorEnabled == false;
                mobile.mobileDevice.AccelerationSensorEnabled = true;
                msgbox('Accelerometer has been successfully enabled.', 'Success', 'modal');
                mobile.accelerometerStatus = sprintf('Accelerometer..............:: Enabled');
            elseif mobile.mobileDevice.Connected == true && mobile.mobileDevice.AccelerationSensorEnabled == true;
                msgbox('Accelerometer has already been enabled...!!', 'Status', 'modal');
            end
            
        end
        
        function mobile = enableGyroSensor (mobile) % enables gyro sensor...
            
            if mobile.mobileDevice.Connected == true && mobile.mobileDevice.AngularVelocitySensorEnabled == false;
                mobile.mobileDevice.AngularVelocitySensorEnabled = true;
                msgbox('Gyro sensor has been successfully enabled.', 'Success', 'modal');
                mobile.gyroSensorStatus = sprintf('Gyro Sensor.................:: Enabled');
            elseif mobile.mobileDevice.Connected == true && mobile.mobileDevice.AngularVelocitySensorEnabled == true;
                msgbox('Gyro Sensor has already been enabled...!!', 'Status', 'modal');
            end
            
        end
        
        function mobile = enableMagneticSensor (mobile) % enables magnetic sensor...
            
            if mobile.mobileDevice.Connected == true && mobile.mobileDevice.MagneticSensorEnabled == false;
                mobile.mobileDevice.MagneticSensorEnabled = true;
                msgbox('Magnetic sensor has been successfully enabled.', 'Success', 'modal');
                mobile.magnetoStatus = sprintf('Magnetic Sensor...........:: Enabled');
            elseif mobile.mobileDevice.Connected == true && mobile.mobileDevice.MagneticSensorEnabled == true;
                msgbox('Magnetic Sensor has already been enabled...!!', 'Status', 'modal');
            end
            
        end
        
        function mobile = enableOrientation (mobile) % enables orientation sensor...
            
            if mobile.mobileDevice.Connected == true && mobile.mobileDevice.OrientationSensorEnabled == false;
                mobile.mobileDevice.OrientationSensorEnabled = true;
                msgbox('Orientation sensor has been successfully enabled.', 'Success', 'modal');
                mobile.orientation = sprintf('Orientation Sensor........:: Enabled');
            elseif mobile.mobileDevice.Connected == true && mobile.mobileDevice.OrientationSensorEnabled == true;
                msgbox('Orientation Sensor has already been enabled...!!', 'Status', 'modal');
            end
            
        end
        
        function mobile = enablePosition (mobile) % this function enables position sensor
            
            if mobile.mobileDevice.Connected == true && mobile.mobileDevice.PositionSensorEnabled == false;
                mobile.mobileDevice.PositionSensorEnabled = true;
                msgbox('Position sensor (GPS) has been successfully enabled.', 'Success', 'modal');
                mobile.position = sprintf('Position (GPS) Sensor..:: Enabled');
            elseif mobile.mobileDevice.Connected == true && mobile.mobileDevice.PositionSensorEnabled == true;
                msgbox('Position Sensor (GPS) has already been enabled...!!', 'Status', 'modal');
            end
            
        end
        
        function mobile = enableAllSensors (mobile) % this function enables all the sensors at once...
            
            mobile = mobile.enableAccelerometer;
            mobile = mobile.enableGyroSensor;
            mobile = mobile.enableMagneticSensor;
            mobile = mobile.enableOrientation;
            mobile = mobile.enablePosition;
            
        end
        
        function mobile = disableMobileSensors (mobile) % the function disables the mobile device sensors...
            
            Sensors = {'Accelerometer' 'Gyro Sensor' 'Magnetic Sensor'...
                'Orientation Sensor' 'Position Sensor (GPS)' 'Turn Off all'};
            [s,v] = listdlg('ListString', Sensors, 'SelectionMode', 'single',...
                'ListSize', [173 80], 'InitialValue', [1], 'Name', 'Sensor',...
                'PromptString', 'Please select Sensors you want to Turn Off :',...
                'OKString', 'Turn Off', 'CancelString', 'Cancel');
            if v == 1;
                switch s
                    case 1 % if first choice is selected...
                        mobile.mobileDevice.AccelerationSensorEnabled = false; % accelerometer is disabled...
                        disp('Accelerometer Turned Off ...');
                        msgbox('Accelerometer has been successfully disabled.', 'Success', 'modal');
                        mobile.accelerometerStatus = sprintf('Accelerometer..............:: Disabled');
                    case 2 % if second choice is selected...
                        mobile.mobileDevice.AngularVelocitySensorEnabled = false; % angular velocity sensor is disabled...
                        disp('Gyro Sensor Turned Off ...');
                        msgbox('Gyro sensor has been successfully disabled.', 'Success', 'modal');
                        mobile.gyroSensorStatus = sprintf('Gyro Sensor.................:: Disabled');
                    case 3 % if third choice is selected...
                        mobile.mobileDevice.MagneticSensorEnabled = false; % magnetic sensor is disabled...
                        disp('Magnetic Sensor Turned Off ...');
                        msgbox('Magnetic sensor has been successfully disabled.', 'Success', 'modal');
                        mobile.magnetoStatus = sprintf('Magnetic Sensor...........:: Disabled');
                    case 4 % if fourth option is selected...
                        mobile.mobileDevice.OrientationSensorEnabled = false; % Orientation sensor is disabled...
                        disp('Orientation Sensor Turned Off ...');
                        msgbox('Orientation sensor has been successfully disabled.', 'Success', 'modal');
                        mobile.orientation = sprintf('Orientation Sensor........:: Disabled');
                    case 5 % if fifth choice is selected...
                        mobile.mobileDevice.PositionSensorEnabled = false; % gps sensor is disabled...
                        disp('Position Sensor (GPS) Turned Off ...')
                        msgbox('Position sensor (GPS) has been successfully disabled.', 'Success', 'modal');
                        mobile.position = sprintf('Position (GPS) Sensor..:: Disabled');
                    case 6 % if sixth choice is selected, all the sensors are disabled...
                        mobile.mobileDevice.AccelerationSensorEnabled = false;
                        mobile.mobileDevice.AngularVelocitySensorEnabled = false;
                        mobile.mobileDevice.MagneticSensorEnabled = false;
                        mobile.mobileDevice.OrientationSensorEnabled = false;
                        mobile.mobileDevice.PositionSensorEnabled = false;
                        disp('All sensors Turned Off');
                        msgbox('All the sensors has been successfully disabled.', 'Success', 'modal');
                        mobile.accelerometerStatus = sprintf('Accelerometer..............:: Disabled');
                        mobile.gyroSensorStatus = sprintf('Gyro Sensor.................:: Disabled');
                        mobile.magnetoStatus = sprintf('Magnetic Sensor...........:: Disabled');
                        mobile.orientation = sprintf('Orientation Sensor........:: Disabled');
                        mobile.position = sprintf('Position (GPS) Sensor..:: Disabled');
                        mobile.loggingStatus = sprintf('Data Logging................:: Disabled');
                    otherwise
                        disp('Please select sensor you want to Turn Off ...')
                end
                
            elseif v == 0
                disp('Please select sensor you want to Turn Off ...');
            end
            
        end
        
        function mobile = connectArduino (mobile) % this function connects the arduino to matlab...
            
            mobile.a = arduino; % stores arduino class to property a
            
            mobile.s1 = servo(mobile.a, 'D2'); % stores yaw control servo to s1 property and
            writePosition(mobile.s1, .25); % writes initial joint angle to yaw control servo
            
            mobile.s2 = servo(mobile.a, 'D3'); % stores pitch control servo to s2 property and
            writePosition(mobile.s2, .3); % writes initial joint angle to pitch control servo
            
            mobile.s3 = servo(mobile.a, 'D4'); % stores roll control servo to s3 property
            writePosition(mobile.s3, .5); % writes initial joint angle to pitch control servo
            
            mobile.s4 = servo(mobile.a, 'D5'); % stores clutch control servo to s4 property and
            writePosition(mobile.s4, .075); % writes initial joint angle to clutch control servo
            
            configurePin(mobile.a, 'A0');
        end
        
        function mobile = disConnectArduino (mobile) % the function to disconnect arduino...
            
            clear mobile.a;
            mobile.a = 0;
            clear mobile.s1;
            mobile.s1 = 0;
            clear mobile.s2;
            mobile.s2 = 0;
            clear mobile.s3;
            mobile.s3 = 0;
            clear mobile.s4;
            mobile.s4 = 0;
            
        end
        
    end
    
end

