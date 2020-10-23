clc; 
clear all;

C = 0.47; % drag Force
r = 0.2; % object Radio 
A = pi * r^2; % surface area m^2.
D = 0.9; % air density kg/m^3
g = 9.81; % gravity

dt = 0.5; % time delta

rock_num =input("Amount of Simulations:\n"); % simulations run 
count = 1;

%main loop
for i=1:rock_num
    angulo = 0;
    
    %random values in range
    while angulo <= 25
        angulo = randi(160);
    end

    vo = 0;
    while vo < 40
        vo = randi(150);
    end

    m = 0;
    while m < 35
        m = randi(100);
    end
    
    %key variables
    beta = angulo*pi/180;
    vox = vo*cos(beta);
    voy = vo*sin(beta);

    vx = vox;
    vy = voy;

    xo = 0;
    yo = 3020;

    x = xo;
    y = yo;
    
    td = 0;
    ymax = yo;
    x_ymax = 0;
   
   graphed = false; %flag for max. height point
   
    while y > 2200  %euler method
        plot(x,y, 'k.');
        hold on;
        %f = getframe; %comment for instant view
        
        dvy = -g*dt -(abs(vy)/vy)*(C*0.5*A*D*(vy^2)*dt)/m;     
        dvx = (abs(vx)/vx)*(-C*0.5*A*D*(vx^2)*dt)/m;

        vy = vy+dvy;
        vx = vx+dvx;
        
        x = x+vx*dt;
        y = y+vy*dt;
       
        td = td + dt;
        
        if ymax < y
            ymax = y;
            x_ymax = x;
            tmax = td;
        elseif graphed == false
            scatter(x_ymax,ymax, "filled", 'ro'); %graph max height point
            graphed = true;
        end
    
       
    end
    
    %Print Results 
    fprintf('==========\nSimulation #%i\n', count);
    disp('Initial Values:');
    fprintf('Angle: %0.2f | ', angulo);
    fprintf('Mass: %0.2f | ', m);
    fprintf('Velocity: %0.2f | ', vo);
    fprintf('Total Time %0.2f\n', td);
    fprintf('Maximum Height Values:\n');
    fprintf('Maximum Height: %.2fm | ', ymax);
    fprintf('Time at Maximum Height: %0.2fs  | ', tmax);
    fprintf('Distance at Maximum Height: %0.2fs\n', x_ymax);

    count = count + 1;
end