clear;
close;
clc;

% Crear objeto Arduino
a = arduino('COM6', 'Uno', 'Libraries', 'Servo');

% Adjuntar los servos a los pines correspondientes
servo1 = servo(a, 'D3');
servo2 = servo(a, 'D5');
servo3 = servo(a, 'D6');

% Mover los servos a la posición inicial
writePosition(servo1, 90/180); % Posición inicial en grados
writePosition(servo2, 90/180); % Posición inicial en grados
writePosition(servo3, 0/90);  % Posición inicial en grados

% Parámetros del robot
a1 = 12;
a2 = 10;
d = 13;

L1 = Revolute('a',a1,'alpha',0,'d',d);
L2 = Revolute('a',a2,'alpha',pi,'d',0);
L3 = Prismatic('a',0,'alpha',0,'theta',0,'qlim',[0.5, 2]);

bot = SerialLink([L1, L2, L3]);

% Animación
ws = [-15, 15, -18, 18, 0, 17];
bot.teach([pi/2, pi/2, 0.5], 'workspace', ws, 'noname');

% Bucle para cambiar manualmente la posición
while true
    % Obtener la posición deseada del usuario
    P = input('Introduzca un vector de posicion deseada [x, y, z]: ');
    
    % Dibujar una esfera en la posición deseada
    plot_sphere(P, 0.2, 'y');
    
    input('Presione cualquier boton para mover el robot');
    
    % Calcular la cinemática inversa
    q = invkin(P(1), P(2), P(3), a1, a2, d);
    
    % Mover los servos a las posiciones calculadas
    writePosition(servo1, q(1) / 180); % Convertir de grados a rango [0, 1]
    writePosition(servo2, q(2) / 180); % Convertir de grados a rango [0, 1]
    writePosition(servo3, q(3) / 1);   % Prismatic, ya está en rango [0, 1]
    
    % Actualizar la animación del robot
    bot.plot(q, 'workspace', ws, 'noname');
end

% Cinemática inversa
function k = invkin(x, y, z, a1, a2, d)
    D = (x^2 + y^2 - a1^2 - a2^2) / (2 * a1 * a2);
    q2 = atan2(sqrt(1 - D^2), D);
    q1 = atan2(y, x) - atan2(a2 * sin(q2), a1 + a2 * cos(q2));
    q3 = d - z;
    k = [rad2deg(q1), rad2deg(q2), q3];
end

% Función para dibujar una esfera
function plot_sphere(center, radius, color)
    [X, Y, Z] = sphere;
    X = X * radius + center(1);
    Y = Y * radius + center(2);
    Z = Z * radius + center(3);
    surf(X, Y, Z, 'FaceColor', color, 'EdgeColor', 'none');
end
