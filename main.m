T = 8; %no. of days
beta = 0.2; %inverse temperature
Mratio = 0;
viewsize = 500;

exM=2*exp(T); %equation to define growth of AML population (no. of cells increases exponentially)

freq=100;
L=1000;
N=10000;
dt=1/10;
div_rate=1*dt/1440; %1day-1
motile_ratio=Mratio; %ratio between the motile and immotile populations
diff1=.2564*dt;    %cell length^2/min (d^2/t)
diff2=.0145*dt;    %cell length^2/min
D1=diff1*4; %=0.10256 %diffusion coeff (explorative cells)
D2=diff2*4; %=0.0058 %diffusion coeff (non explorative cells)
T=T*1440/dt; %T = Time (no. of days) x 1/Division rate
Mmax=15;
x=linspace(-5*L/2,5*L/2,L); %returns a vector of L evenly spaced points in the interval -5*L/2 to 5*L/2 
[X,Y]=meshgrid(x,x); %returns square grid coordinate with grid size length(x) by length(x)
M=[[1 0];
   [0 -1];
   [-1 0];
   [0 1]]; %directions vector (down, left, up, right)
freq=T/freq; %no.of days/freq
flag=0;
K = 10; %no. of trial runs
sH_values = zeros(K,1);
cov_values = zeros(K,1);
count = 0;

for i = 1:K
    while flag==0 %as long as flag == 0, we repeat the code
        %v = VideoWriter('Model1.avi');
        %open(v);
        flag
        n=2;
        H=zeros(L,L); %1000x1000 matrix
        R=zeros(N,2); %10000x2 matrix
        R(1,:)=[L/2 L/2]; %fill in first row of both columns of R with the value 500
        R(2,:)=[L/2+1,L/2]; %fill in 2nd row of both columns of R with the value 501 and 500
        R2=zeros(N,2); %create another 10000x2 matrix called R2
        m=0;
        for k=1:n
            a=R(k,:);   %define a variable a to store the values of the kth row and both cols of R matrix
            H(a(1),a(2))=H(a(1),a(2))+1; %fill these positions in the H matrix with the value 1
        end
        for t=1:T  %repeats for each no.of day
            Ra=rand(n,1); %returns a random 2x1 vector
            for k=1:n
                if Ra(k)<D1 %if random kth value in Ra vector is lesser than D1 = 0.10256
                    ra=ceil(4*Ra(k)/D1); %multiply that random value by 4 and divide by D1 and round up the value and store it in a variable called ra
                    mov=R(k,:)+M(ra,:); %define a variable mov to store the coordinate of the next position
                    if H(mov(1),mov(2))<Mmax %if the value in this position is less than 15
                        dH=compare_N(H,R(k,:),mov); %define a variable dH to store the compare_N result
                        if rand<exp(-beta*dH) %if a random value is less than exponential(-beta*dH)
                            H(R(k,1),R(k,2))=H(R(k,1),R(k,2))-1; %-1 from the value at this position
                            H(mov(1),mov(2))=H(mov(1),mov(2))+1; %+1 from the value at this position
                            R(k,:)=mov; %update the R vector values to the new position values
                        end
                    end
                end
            end
            %same exact chunk of code from above (only differences are m,
            %D2,R2)
            Ra=rand(m,1); %returns a random 2x1 vector
            for k=1:m
                if Ra(k)<D2 %if random kth value is lesser than D2 = 0.0058
                    ra=ceil(4*Ra(k)/D2);
                    mov=R2(k,:)+M(ra,:);
                    if H(mov(1),mov(2))<Mmax
                        dH=compare_N(H,R2(k,:),mov);
                        if rand<exp(-beta*dH)
                            H(R2(k,1),R2(k,2))=H(R2(k,1),R2(k,2))-1;
                            H(mov(1),mov(2))=H(mov(1),mov(2))+1;
                            R2(k,:)=mov;
                        end
                    end
                end
            end
            n2=n; %make new variable n2 equal to n
            m2=m; %make new variable m2 equal to m
            r=rand(n,1); %random 2x1 vector
            for k=1:n
                if r(k)<div_rate  %if random kth value is lesser than the div rate
                    r2=ceil(4*rand); %create new variable r2 that stores 4*random number and round that up
                    if rand<motile_ratio %if random number is lesser than the motile ratio that we set
                        mov=R(k,:)+M(r2,:);
                        if H(mov(1),mov(2))<Mmax %if the value at this position of the H matrix is lesser than 15
                            n2=n2+1;
                            R(n2,:)=mov; %update R vector (row n2 and both cols)
                            H(mov(1),mov(2))=H(mov(1),mov(2))+1;
                        end
                    else %if random number is bigger than motile ratio
                        mov=R(k,:)+M(r2,:); %do the same thing as above
                        if H(mov(1),mov(2))<Mmax %if the value at this position of the Hmatrix is lesser than 15
                            m2=m2+1;    %but here we update m2
                            R2(m2,:)=mov; %update R2 vector (row m2 and both cols)
                            H(mov(1),mov(2))=H(mov(1),mov(2))+1;
                        end
                    end
                end
            end
            %same exact chunk of code as above but now using m instead of n
            r=rand(m,1);
            for k=1:m
                if r(k)<div_rate
                    r2=ceil(4*rand);
                    if rand<motile_ratio
                        mov=R2(k,:)+M(r2,:);
                        if H(mov(1),mov(2))<Mmax
                            n2=n2+1;
                            R(n2,:)=mov;
                            H(mov(1),mov(2))=H(mov(1),mov(2))+1;
                        end
                    else
                        mov=R2(k,:)+M(r2,:);
                        if H(mov(1),mov(2))<Mmax
                            m2=m2+1;
                            R2(m2,:)=mov;
                            H(mov(1),mov(2))=H(mov(1),mov(2))+1;
                        end
                    end
                end
            end
            n=n2;
            m=m2;
            %uncomment to view figure
            %         if mod(t,freq)==0 || t==1 %to make the movie (not every time step)
            %             h=pcolor(X,Y,H);
            %             colormap([1 1 1;jet(14)])
            %             xlabel('\mu m');
            %             ylabel('\mu m')
            %             %title('Cell number');
            %             axis equal
            %             axis tight
            %             xlim([-viewsize viewsize]);
            %             ylim([-viewsize viewsize]);
            %             colorbar
            %             set(h, 'EdgeColor', 'none');
            %             caxis([0 15]) %sets the colormap limits for the current axes
            %             %frame = getframe(gcf);
            %             %writeVideo(v,frame);
            %         end
        end
        %close(v);
        sH=sum(sum(H));
        sH
        if sH<1.2*exM && sH>.8*exM % +/- 20% of expected no. of cells
            
            flag=1;
            sH_values(i,1) = sH;
            for p=1:L
                for j=1:L
                    if H(p,j) > 0
                        count = count + 1;
                    else
                        count = count + 0;
                    end
                end
            end
            
            coverage = (count/(L*L))*100; %in percentage
            cov_values(i,1) = coverage;
            count =0;
          
        end
    end
    flag = 0;
    
end

%uncomment to view figure
%histogram(cov_values)
%histfit(cov_values)
% boxplot(sH_values)
% title('Distribution of the number of immotile cells by Day 8')
% xlabel('Immotile Cells')
% ylabel('No. of cells')

