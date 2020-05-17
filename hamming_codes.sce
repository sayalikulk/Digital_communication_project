clear;
clc; 
//ENCODING 
k = 4; //message bits length 
n = 7; // block length 
m = n-k;//Number of parity bits 
I = eye(k,k); // identity matrix 

disp(I,'identity matrix') 
P = [1 1 0;0 1 1 ;1 1 1;1 0 1];// coefficient matrix 
disp(P,'coefficient matrix ') 
G = [P I]; // generator matrix 
disp(G, 'generator matrix G') 
H = [eye(k-1,k-1) P'];// parity check matrix 
disp(H, 'parity check matrix H')
//message bits

m = [0 0 0 0;0 0 0 1;0 0 1 0;0 0 1 1; 0 1 0 0;0 1 0 1;0 1 1 0;0 1 1 1; 1 0 0 0;1 0 0 1;1 0 1 0;1 0 1 1; 1 1 0 0;1 1 0 1;1 1 1 0;1 1 1 1] ;

C = m*G; 
C = modulo(C,2);
disp(C, 'Code words of  Hamming code')

weight=[]
for i=1:16
    count =0
    for j=1:7
        if C(i,j)==1 //C is Code  Word matrix
            count=count+1
         end
    end
    weight=[weight;count]
end
disp(weight,'Hamming weight')
MinHamDist= weight(2)-weight(1)

//Calculation of error detection capability (t)
ErrDet=(MinHamDist -1)/2
disp (ErrDet,'error correction capability - t :' ) //1 for Hamming codes
//Calculation of error correction capability 
ErrCorr= (MinHamDist -1)
disp(ErrCorr, "error detection capability") //2 for Hamming codes

// Create recieved code word
ReceivedCodeWordMat=C
R= [ReceivedCodeWordMat(round(16*rand()),:)]
disp(R,'Randomly generated Recieved Code word R')

// Generate error at random bit position 
ErrPos=round(8*rand()) //Get random number between 0 to 7
disp(ErrPos,"error position")
if ErrPos==0 then
else
     if R(ErrPos)==0 then
          R(ErrPos)=1// Invert bit at Erroneous Bit Position 
     else
         R(ErrPos)=0// Invert bit at Erroneous Bit Position 
     end
end   

y=R //Received code word with error

//DECODING
//Error correction
//Find syndrome for finding out the error
syndrome=modulo(y*(H)',2)

//Add the correction factor according to the syndrome achieved
if(syndrome==[0 0 0]) then
    q=modulo([0 0 0 0 0 0 0]+y,2)
    message=[q(4) q(5) q(6) q(7)]
elseif(syndrome==[1 0 0]) then 
     q=modulo([1 0 0 0 0 0 0]+y,2)
     message=[q(4) q(5) q(6) q(7)]
elseif(syndrome==[0 1 0]) then
     q=modulo([0 1 0 0 0 0 0]+y,2)
     message=[q(4) q(5) q(6) q(7)]
elseif(syndrome==[0 0 1]) then
     q=modulo([0 0 1 0 0 0 0]+y,2)
     message=[q(4) q(5) q(6) q(7)]
elseif(syndrome==[1 1 0]) then
     q=modulo([0 0 0 1 0 0 0]+y,2)
     message=[q(4) q(5) q(6) q(7)]
elseif(syndrome==[0 1 1]) then
     q=modulo([0 0 0 0 1 0 0]+y,2)
     message=[q(4) q(5) q(6) q(7)]
elseif(syndrome==[1 1 1]) then
     q=modulo([0 0 0 0 0 1 0]+y,2)
     message=[q(4) q(5) q(6) q(7)]
else
     q=modulo([0 0 0 0 0 0 1]+y,2)
     message=[q(4) q(5) q(6) q(7)]
end

//Display messages
disp("The syndrome is:")
disp(syndrome)
disp("The corrected sequence is:")
disp(q)
disp("The message decoded is:")
disp(message)
