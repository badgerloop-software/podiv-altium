%% run calcs

clear
clc

% constants
trackLength = 1250; %m
safetyDistance = 100; %m
wD = 6.25; % wheel diameter in inches
pM =137.7; %kg
decel = 3*-9.81; % g's of braking
air_rho=0.07894; %kg/m^3 at 0.135psi 80F 50%RH 
CD=0.12; %pod 4 (10/14) 
Area_pod=0.34;%m^2 pod 4 (10/14)
T=table();
Max_RPM=6000; %max motor RPM
num_vert= 2 ; % # of vertical wheels in the stability system of the same size
num_lat= 4 ;%# of lateral wheels of the same size
num_prop= 1 ;% # of propulsion wheels

minertia_lat= 0.000540 ; % mass moment of inertia derived value from CAD in kg-m^2 
minertia_vert=5.7338e-5  ; % '' modelled as solid 

r_lat=convlength(2,'in','m');   %pod 3 wheel size convlength(radius,'unit input','unit desired')
r_vert=convlength(1.5,'in','m'); %pod 3
for wD= 8:0.05:16%in
    r_prop=convlength(wD/2,'in','m');
    minertia_prop= (r_prop)^2 *(0.4468*wD-0.9262)*1/2 ; %modelled as a solid disk
    pM=137.7;
    pM=pM+0.4468*wD-0.9262; %pM with prop wheel weight
    m_rot=num_lat*(minertia_lat/r_lat^2)+num_vert*(minertia_vert/r_vert^2)+num_prop*(minertia_prop/r_prop^2);
    pM=pM+m_rot; % pM is equivalent with wheel weight now
    
    for gear_ratio=1:0.01:1     % conditions
        dt = 0.001; 
        v = 0;
        x = 0;
        t = 0;
        a=0;
        RPM = 0;
        c = 1;
        r=0;
        
        current_voltage = 290;
        accumulated_power = 0;
        power = zeros(25002);
        tt = linspace(0,25,25000); %create vector of 25000 evenly spaced points beween 0 and 25
        tt = [tt 25001 25002];  %adds 0 to tt vector 
        current_capacity = 6; % 6 aH
        load_amps = 300; % countinous current required by the Motor
        ii = 2; %index variable for tt and power vectors
        
        torque=90*gear_ratio;
        force_prop= torque/((wD*0.0254)/2) - (0.5 *CD*air_rho*Area_pod*(v(c))^2)-100;
        a(1)= force_prop/pM;%N
        while r==0%prop loop
            c = c + 1;
            v(c) = a(c-1)*dt + v(c-1);
            x(c) = v(c)*dt + x(c-1);
            t(c) = c*dt;
            
            RPM=(v(c)*60)/(pi()*(wD*0.0254)) ;
            RPM_motor=RPM*gear_ratio;
            motor_torque=((1e-07*RPM_motor^2) + (-0.0019*RPM_motor) + 90);%torque at the motor
            torque=gear_ratio*motor_torque; %takes care of the torque lost with the RPM toque 
            force_prop= torque/((wD*0.0254)/2)- (0.5 *CD*air_rho*Area_pod*(v(c))^2)-100;
            a(c)= force_prop/pM;
                      
            PowerLoss = (17.5 + (0.0499*RPM_motor) + (1.73E-05*RPM_motor^2)); % internal losses in watts
            CurrentPower = ((motor_torque*2*pi() * RPM_motor)/60) - PowerLoss; % Watts
            load_amps = CurrentPower/ current_voltage; % amps required for desired power
            charge_used = load_amps * (dt / 3600); %amp hrs used in single iteration
            current_capacity =  current_capacity - charge_used; %subtracts charge used from current capacity         
            accumulated_power = accumulated_power + get_voltage(load_amps,current_capacity) * load_amps; %for each iteration, calculates power, sums up            
            current_voltage = get_voltage(load_amps, current_capacity); % new current voltage  
            power(ii) = accumulated_power; 
            
            ii = ii + 1; %increments index of ii
            
            Max_RPM = 24 * current_voltage; % 24 is slope of line of (Power/RPM), pretty linear





            if ((v(c))^2/(2*-decel))>=(trackLength - safetyDistance - x(c))
                vMax=v(c);
                vMax_mph=convvel(v(c), 'm/s', 'mph');
                r=1;
                y={'No more track'};
                   
            end    
            
            if RPM_motor>=Max_RPM
               vMax=v(c);
               vMax_mph=convvel(v(c), 'm/s', 'mph');
               r=2;
               y={'No more motor RPM'};
          
                 
            end
             
%             if t(c)>=15
%                  
%                  vMax=v(c);
%                  vMax_mph=convvel(v(c), 'm/s', 'mph');
%                  r=3;
%                  y={'Battery ran out'};
%              end
             
            
        end
        t_prop=t(c);
        while v(c)>=0
            c = c + 1;
            v(c) = decel*dt + v(c-1);
            x(c) = v(c)*dt + x(c-1);
            t(c) = c*dt;
        end
       
        xMax = x(c);
        tMax = t(c);
        dat=[gear_ratio, wD, vMax, vMax_mph,t_prop, y, tMax, xMax,];
        data=array2table(dat());
        T=vertcat(T,data);
        
    end
end

%post process
T.Properties.VariableNames={'Gear_Ratio','Wheel_diameter','Velocity_max','Velocity_max_mph','Time_propulsion','End_Mode','Run_Time_s', 'Distance_travelled',};
%disp(T)
T=sortrows(T,4,'descend');
Top3=T(1:3,1:8)

%plot of winning run
wD=table2cell(Top3(1,'Wheel_diameter'));
wD=cell2mat(wD);
gear_ratio=table2cell(Top3(1,'Gear_Ratio'));
gear_ratio=cell2mat(gear_ratio);

 % conditions
       dt = 0.001; 
        v = 0;
        x = 0;
        t = 0;
        a=0;
        RPM = 0;
        c = 1;
        r=0;
        current_voltage=0;
        current_voltage(c) = 290;
        accumulated_power = 0;
        power = zeros(25002);
        tt = linspace(0,25,25000); %create vector of 25000 evenly spaced points beween 0 and 25
        tt = [tt 25001 25002];  %adds 0 to tt vector 
        current_capacity = 6; % 6 aH
        load_amps = 300; % countinous current required by the Motor
        ii = 1; %index variable for tt and power vectors
       
        
        torque=90*gear_ratio;
        force_prop= torque/((wD*0.0254)/2) - (0.5 *CD*air_rho*Area_pod*(v(c))^2)-100;
        a(1)= force_prop/pM;%N
        while r==0%prop loop
            c = c + 1;
            v(c) = a(c-1)*dt + v(c-1);
            x(c) = v(c)*dt + x(c-1);
            t(c) = c*dt;
            
            
            RPM=(v(c)*60)/(pi()*(wD*0.0254)) ;
            RPM_motor=RPM*gear_ratio;
            motor_torque=((1e-07*RPM_motor^2) + (-0.0019*RPM_motor) + 90);%torque at the motor
            torque=gear_ratio*motor_torque; %takes care of the torque lost with the RPM toque 
            force_prop= torque/((wD*0.0254)/2)- (0.5 *CD*air_rho*Area_pod*(v(c))^2)-100;
            a(c)= force_prop/pM;
                      
           
            CurrentPower = (motor_torque*2*pi() * RPM_motor)/60; % Watts
            load_amps = CurrentPower / current_voltage(c-1); % amps required for desired power
            charge_used = load_amps * (dt / 3600); %amp hrs used in single iteration
            current_capacity =  current_capacity - charge_used; %subtracts charge used from current capacity         
            accumulated_power = accumulated_power + get_voltage(load_amps,current_capacity) * load_amps; %for each iteration, calculates power, sums up            
            current_voltage(c) = get_voltage(load_amps, current_capacity); % new current voltage  
            power(ii) = accumulated_power; 
            
            ii = ii + 1; %increments index of ii
            
            Max_RPM = 24 * current_voltage; % 24 is slope of line of (Power/RPM), pretty linear


    if RPM_motor>=Max_RPM
       vMax=v(c);
       vMax_mph=v(c)*2.23694;
       r=1;
       
       

    end
    if (trackLength - safetyDistance - x(c))<=(v(c)^2/(2*-decel))
        vMax=v(c);
        vMax_mph=v(c)*2.23694;
        r=2;
          
    end
    t_p_time(c)=t(c);
        end

braking_dist=(v(c)^2/(2*-decel));

while v(c)>=0
    c = c + 1;
    v(c) = decel*dt + v(c-1);
    x(c) = v(c)*dt + x(c-1);
    t(c) = c*dt;
    
    
    

end

figure(1)
plot(x,v)
xlabel('Distance[m]')
ylabel('Velocity[m/s]')
figure(2)
plot(t,x)
ylabel('Distance[m]')
xlabel('time[s]')
figure(3)
plot(t,v)
xlabel('time[s]')
ylabel('Velocity[m/s]')
plot(t_p_time,current_voltage);
xlabel('time[s]');
ylabel('voltage[V]');
ts = timeseries(x,t);
save('PositionProfile','ts','-v7.3');