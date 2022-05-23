function y=compare_N(H,a,b)

M=[[1 0];
   [0 -1];
   [-1 0];
   [0 1]];   %directions matrix

h1=H(a(1),a(2)); %h1 stores the value for the position of 1st cell in H matrix
h2=H(b(1),b(2)); %h2 stores the value for the position of 2nd cell in H matrix
for k=1:4 %because there are 4 directions
    m=M(k,:); %if k =1, m = [1 0], if k =2, m = [0 -1]
    h1=h1+H(a(1)+m(1),a(2)+m(2)); %update h1 value by adding the value from the relevant index position
    h2=h2+H(b(1)+m(1),b(2)+m(2)); %update h2 value by adding the value from the relevant index position
end
y=h1-h2-1; %function returns y
