%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Quantisierung / 2er-Komplement %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Normierung [-1,1] %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%  x     : Eingangssignal %%%%%%%%%%%%%%%%%%%%%
%%%%%  w     : Wordbreite (# bits) %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  Rundungsverfahren/-optionen %%%%%%%%%%%%% 
%   TMode : truncation mode %%%%%%%%%%%%%%%%%%%%%%%
%'t' - truncation (rounding towards minus infinity)  
%'r' - rounding to nearest quantization level
% xq    : quantisiertes signal %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [xq] = quant2c(x,w,TMode)
LSB = 2^(-w+1);            % LSB
xq = max(-1,min(1-LSB,x)); % clipping (saturation)
% Quantizer
if TMode == 't', xq = floor(xq/LSB)*LSB;
elseif TMode == 'r', xq = round(xq/LSB)*LSB;
else error('quant2c - invalid mode')
end