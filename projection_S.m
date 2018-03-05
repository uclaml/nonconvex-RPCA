function [Y] = projection_S(S,l)
Y = S;
judge= max(max(abs(Y)));
if judge>l
    Y(abs(Y)>l)=l*sign(Y(abs(Y)>l));
end
end