#Instituto Tecnologico de Costa Rica
#Area Academica de Ingenieria en Computadores
#Analisis Numerico para Ingenieria
#Estudiante: Diego Alonso Granados Ly
#Tarea_2

%Graficos con OpenGL
graphics_toolkit('gnuplot');
%Aumentamos la precision de salida
output_precision(10);
%Entrada del sistema.
xi = input("Ingrese un valor para x: ")
%Declaracion de las variables
h0     = 1;
lambda = double(1.1);
xil  = 0;%xi-1
xip  = 0;%xi+1
fxil = 0;%f(xi-1)
fxi  = 0;%f(xi)
fxip = 0;%f(xi+1)
vector_h   = zeros(1,500);%Vector con los tamanos de paso
vector_da  = zeros(1,500);%Vector con la diferencia hacia atras
vector_dd  = zeros(1,500);%Vector con la diferencia hacia adelante
vector_c   = zeros(1,500);%Vector con la diferencia centrada
error_da   = zeros(1,500);%Vector con el error de la diferencia hacia adelante
error_dd   = zeros(1,500);%Vector con el error de la diferencia hacia atras
error_c    = zeros(1,500);%Vector con la diferencia centrada

valorVerdadero = 2*xi*(e^(xi^2))*cos((pi/180)*(e^(xi^2)))

#Ciclo Que define los valores de xi , xi+1 y xi-1
#ademas de sus evaluaciones en la funcion.
for i=1:10
  if (i==1)
    vector_h(i) = h0;               %Excepcion para i = 1 con  h0 = 1
  else
    vector_h(i) = lambda*vector_h(i-1); %Con i!=1 se aplica h(i)=lambda*h(i-1) 
  endif
  xil  = xi - vector_h(i);      %xi-1 = xi-h
  xip  = xi + vector_h(i);      %xi+1 = xi+h
  fxil = double(sin(e^(xil^2)));%f(xi-1)
  fxi  = double(sin(e^(xi^2)));  %f(xi)
  fxip = double(sin(e^(xip^2)));%f(xi+1)

  vector_da(i) = double((fxi-fxil)/(xi-xil));
  vector_dd(i) = double((fxip-fxi)/(xip-xi));
  vector_c (i) = double((fxip-fxil)/(2*vector_h(i)));

  error_da(i)  = (valorVerdadero-vector_da(i))/valorVerdadero; %(vv-va)/vv
  error_dd(i)  = (valorVerdadero-vector_dd(i))/valorVerdadero;
  error_c (i)  = (valorVerdadero-vector_c(i))/valorVerdadero;
  
endfor

#Definimos las propiedades de la grafica.
figure(1);
axis ([1e-15,2,1e-13,10 ]);
hold on;
loglog(abs(vector_h),abs(error_da),'r');
loglog(abs(vector_h),abs(error_dd),'g');
loglog(abs(vector_h),abs(error_c),'b');
xlabel("Diferencia h");
ylabel("Error aproximado");
title("Aproximacion por diferencias"); 
legend("Adelante","Atras","Centrada");
grid;
hold off;

