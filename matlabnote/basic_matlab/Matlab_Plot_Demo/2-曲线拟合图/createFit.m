function [fitData,gof,fitCoefficient] = createFit(data)
% Set up fittype and options.
ft = fittype('gauss1'); 
%                    fittype                equation
%                 1:gauss1             Y = a1*exp(-((x-b1)/c1)^2)
%                 2:power2             Y = a*x^b+c
%                 3:exp2               Y = a*exp(b*x)+c*exp(d*x)
%                 4:poly3              Y = p1*x^3+p2*x^2+p3*x+p4
%                 5:sin1               Y = a1*sin(b1*x+c1)
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
[fitData, gof] = fit(data(:,1), data(:,2), ft, opts );
% goodness of fitting
fitCoefficient=coeffvalues(fitData);
