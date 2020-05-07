clc
clear

k=int(input("Enter message length: ")) //Message length eg.k=4
n=int(input("Enter Code word Length: ")) //Code word length eg.n=7

P=input("Enter Parity matrix: ") //P = [1 1 0;0 1 1 ;1 1 1;1 0 1]
disp (P ,'Parity matrix P' )

G = [ P eye(k,k) ] // Generator Matrix
disp (G ,'Generator Matrix G' )

H =[ eye(n-k,n-k) P' ] //Parity Check Matrix
disp (H ,'Parity Check Matrix H' )

//Generation of codewords from message bits

//Generation of all message bits
All_M=[]
for i=0:2^k-1
    temp=dec2bin(i,k)   //decimal to binary conversion
    temp=mstr2sci(temp) //string of matrix to string of characters conversion
    temp=strtod(temp)   //string to decimal matrix conversion 
    All_M=[All_M;temp]  //Updating Matrix
end
disp(All_M,"All Message Combinations")

//Calculation of code words
CodeWordMat= All_M * G
CodeWordMat= modulo(CodeWordMat,2) 
disp(CodeWordMat ,'Codewords Matrix')

//Calculation of minimum distance/weight
weight=[]
for i=2:2^k
    count =0
    for j=1:n
        if CodeWordMat(i,j)==1 //Checking for 1s in the code word
            count=count+1      //incrementing count if 1 is present
         end
    end
    weight=[weight;count]      //updating weight matrix
end
MinWeight= min(weight)      //finding non zero minimum element in the weight vector
weight=[0;weight]           //concatenating zero as weight of first codeword is zero
disp(weight,'Weights of the codes (number of 1s in each code)')
disp(MinWeight,"Minimum distance (dmin)")

//Calculation of error correction capability (t)
t =ceil((MinWeight -1)/2)
disp (t,'Error correction capability (t)' )

//Calculation of error detection capability
ErrDet= MinWeight -1
disp(ErrDet,"Error detection capability")

printf("enter %i-bit message",k)
M=input("","string")//M=1010

//Extracting code word corresponding to the message bit
z=bin2dec(M)+1              //Converting binary message to decimal and adding 1 (indexing starts from 1)
CodeWord=CodeWordMat(z,:)   //Extracting corresponding Code word 
disp(CodeWord, "Error free Code Word")

e=round((n-1)*rand())+1     //Generating a random error position from 1-n
disp(e,"The randomly generated error is at postion: ")
if CodeWord(e)==0 then
   CodeWord(e)=1
elseif CodeWord(e)==1 then
   CodeWord(e)=0
end
disp(CodeWord,"CodeWord with error")

//Received erroneous encoded message
Y = CodeWord

//Syndrome Calculation
Syn= Y *(H')
Syn=modulo(Syn,2)
disp(Syn,"The Syndrome is:")

//Error Detection
ErrPattern=zeros(1,n)       //Creating a vector of zeros

if ErrPattern==Syn then
    disp("There is no error in the received code word")
    disp(CodeWord,"Received Error free code word")
else
      ErrPos=1 //Initialize erroneous bit position 
      d=[H(:,ErrPos)]'// Transpose of first coloumn of H matrix
       while ~(isequal(d,Syn)) do  //Check element wise inequality for any element
            ErrPos=ErrPos+1       // Increment erroneous bit position 
            d=[H(:,ErrPos)]'     // Transpose of next coloumn of H matrix 
       end 
       ErrPattern(ErrPos)=1  //Updating Error Pattern
       disp(ErrPos , 'Erroneous Bit Position')
       disp(ErrPattern, "Error Pattern ")
end

//Error Correction
CorrectedCodeWord= [CodeWord + ErrPattern] //adding error pattern to received codeword 
CorrectedCodeWord= modulo (CorrectedCodeWord,2)
disp(CorrectedCodeWord,'Corrected Code Word')
//Decoding
DecodedMessage= CorrectedCodeWord(n-k+1:n) //displaying decoded message
disp(DecodedMessage, "Decoded Message")
