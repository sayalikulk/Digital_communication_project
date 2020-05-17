clc
clear
D = poly(0, 'D'); 
// generator polynomial 
g = 1+D+0+D^3;
//Empty message vector
msg=[]
//Taking input of the message
for i=1:7
    x=input("Enter symbol:");
    msg=[msg x]
end
//Forming the polynomial representation of the received codeword
C1=msg(1)*1+msg(2)*D+msg(3)*D^2+msg(4)*D^3+msg(5)*D^4+msg(6)*D^5+msg(7)*D^6;
disp('The polynomial representation of the entered codeword:')
disp(C1);
//Dividing the received codeword with generator polynomial
//r1-> remainder, q1-> Quotient
[r1,q1] = pdiv(C1,g);
//If remainder is zero, then the syndrome is [0 0 0]
if(r1==0) then
    S1=[0 0 0]
else
    S1 = coeff(r1); 
    //Converting the syndrome into modulo 2 form
    S1 = abs(modulo(S1,2));
    
end
//Adjusting the zeroes of syndrome
if(length(S1)==1) then
        S1=[S1 0 0]
    elseif(length(S1)==2) then
        S1=[S1 0]
end
//Displaying output
disp(r1, 'Remainder in polynomial form') 
disp(S1,'Syndrome bits are:' )
