#Instituto Tecnologico de Costa Rica
#Area Academica de Ingenieria en Computadores
#Analisis Numerico para Ingenieria
#Estudiante: Diego Alonso Granados Ly
#Tarea_2

%Graficos con OpenGL
graphics_toolkit('gnuplot');

%Entrada del sistema.
x = input("Ingrese un valor para x: ")
%Declaracion de las variables
h0     = 1;
lambda = double(0.1);
xil  = 0;%xi-1
xi   = 0;%xi
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


#Ciclo Que define los valores de xi , xi+1 y xi-1
#ademas de sus evaluaciones en la funcion.
for i=1:500
  if (i==1)
    vector_h(i) = h0;
  else
    vector_h(i) = vector_h(i-1)/10;  #agregar excepcion para i = 1
  endif
  xil  = xi - vector_h(i);%xi-1 = xi-h
  xip  = xi + vector_h(i);%xi+1 = xi+h
  fxil = double(sin(e^(xil^2)));%f(xi-1)
  fxi  = double(sin(e^(x^2)));  %f(xi)
  fxip = double(sin(e^(xip^2)));%f(xi+1)

                           #######################Voy por aca##################

  vector_da(i) = double((fxip-fxi)/(xip-xi));
  vector_dd(i) = double((fxi-fxil)/(xi-xil));
  vector_c (i) = double((fxip-fxil)/(2*vector_h(i)));

  #Excepcion para i = 1, no existe error pues no contamos
  #con una aproximacion anterior para calcular el error
  if (i==1)
    error_da(i)  = 0;
    error_dd(i)  = 0;
    error_c (i)  = 0;
  else
    error_da(i)  = abs(((vector_da(i-1)-vector_da(i))/(vector_da(i)))*100);
    error_dd(i)  = abs(((vector_dd(i-1)-vector_dd(i))/(vector_dd(i)))*100);
    error_c (i)  = abs(((vector_c (i-1)-vector_c (i))/(vector_c(i)))*100);
  endif
endfor
#{

#Ciclo Que define los valores de xi , xi+1 y xi-1
#ademas de sus evaluaciones en la funcion.
for i=1:500
  if (i==1)
    vector_h = h0;
  else
    vector_h(i) = vector_h(i-1)/10;  #agregar excepcion para i = 1
  endif
  xil  = xi - vector_h(i);
  xip  = xi + vector_h(i);
  fxil = double(polinomio(1)*(xil^4) -polinomio(3)*(xil^2));
  fxi  = double(polinomio(1)*(xi^4)  -polinomio(3)*(xi^2));
  fxip = double(polinomio(1)*(xip^4) -polinomio(3)*(xip^2)); 
  
  vector_da(i) = double((fxip-fxi)/(xip-xi));
  vector_dd(i) = double((fxi-fxil)/(xi-xil));
  vector_c (i) = double((fxip-fxil)/(2*vector_h(i)));

  #Excepcion para i = 1, no existe error pues no contamos
  #con una aproximacion anterior para calcular el error
  if (i==1)
    error_da(i)  = 0;
    error_dd(i)  = 0;
    error_c (i)  = 0;
  else
    error_da(i)  = abs(((vector_da(i-1)-vector_da(i))/(vector_da(i)))*100);
    error_dd(i)  = abs(((vector_dd(i-1)-vector_dd(i))/(vector_dd(i)))*100);
    error_c (i)  = abs(((vector_c (i-1)-vector_c (i))/(vector_c(i)))*100);
  endif
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

#}
