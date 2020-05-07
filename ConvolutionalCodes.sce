clear ;
clc ;
g1= input("Enter top adder sequence: ")     //[1 0 0 1]
g2= input("Enter lower adder sequence: ")   //[1 0 1 1]
m=input("Enter message sequence: ")         //[1 0 0 1 1 1]

l=length(g1)          //length of top adder sequence
k=length(g2)         //length of lower adder sequence
z1=zeros(1,l-1)     //creating a zeros vector of size length of adder-1
m1=[z1 m z1]       //concatenating message with zeros in the front and the back

x1=[] //empty matrix
i=1  //initialising i=1
while (i ~= (length(m1)-k+2))
    tempmat=m1((i:i+l-1))         //extracting l bits at a time from m1
    temp=modulo((g1*tempmat'),2) //take modulo 2 multiplication of top adder and l message bits
    x1=[x1 temp]                //storing in x1
    i=i+1                      //incrementing i
end

x2=[] //empty matrix
i=1  //initialising i=1
while (i ~= (length(m1)-k+2))
    tempmat=m1(i:(i+k-1))           //extracting k bits at a time from m1
    temp=modulo((g2*tempmat'),2)  //take modulo 2 multiplication of lower adder and k message bits
    x2=[x2 temp]                //storing in x2
    i=i+1                      //incrementing i
end
op= [x1' x2']
disp(op, "Output of Convolutional Encoder")
b=length(op)                //Total elements in the matrix 
disp(b,"Total number of parity bits generated")

//Using convol () for checking 
g1=flipdim(g1,2)
g2=flipdim(g2,2)
x1 = round(convol(g1,m))   //convolution of top adder and message
x2 = round(convol(g2,m))//convolution of lower adder and message
x1 = modulo(x1,2)        //converting to binary
x2 = modulo(x2,2)  

op1=[x1' x2']
disp(op1, "Output of Convolutional Encoder (Using convol() function)")
b1=length(op1)
disp(b1,"Total number of parity bits generated")
clear ;
clc ;
g1= input("Enter top adder sequence: ")     //[1 0 0 1]
g2= input("Enter lower adder sequence: ")   //[1 0 1 1]
m=input("Enter message sequence: ")         //[1 0 0 1 1 1]

l=length(g1)          //length of top adder sequence
k=length(g2)         //length of lower adder sequence
z1=zeros(1,l-1)     //creating a zeros vector of size length of adder-1
m1=[z1 m z1]       //concatenating message with zeros in the front and the back

x1=[] //empty matrix
i=1  //initialising i=1
while (i ~= (length(m1)-k+2))
    tempmat=m1((i:i+l-1))         //extracting l bits at a time from m1
    temp=modulo((g1*tempmat'),2) //take modulo 2 multiplication of top adder and l message bits
    x1=[x1 temp]                //storing in x1
    i=i+1                      //incrementing i
end

x2=[] //empty matrix
i=1  //initialising i=1
while (i ~= (length(m1)-k+2))
    tempmat=m1(i:(i+k-1))           //extracting k bits at a time from m1
    temp=modulo((g2*tempmat'),2)  //take modulo 2 multiplication of lower adder and k message bits
    x2=[x2 temp]                //storing in x2
    i=i+1                      //incrementing i
end
op= [x1' x2']
disp(op, "Output of Convolutional Encoder")
b=length(op)                //Total elements in the matrix 
disp(b,"Total number of parity bits generated")

//Using convol () for checking 
g1=flipdim(g1,2)
g2=flipdim(g2,2)
x1 = round(convol(g1,m))   //convolution of top adder and message
x2 = round(convol(g2,m))//convolution of lower adder and message
x1 = modulo(x1,2)        //converting to binary
x2 = modulo(x2,2)  

op1=[x1' x2']
disp(op1, "Output of Convolutional Encoder (Using convol() function)")
b1=length(op1)
disp(b1,"Total number of parity bits generated")
