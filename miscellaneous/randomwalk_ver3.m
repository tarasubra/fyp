%Author: Tarane Subramaniam
%Date: 23/5/2022
%TITLE: ASYMETRICAL DIVISION OF HSCs SIMULATION

clc;
clearvars;
close all;


M = 1; %No. of cell divisions
C = power(2,M); %No. of cells after division
N = 50; %No. of diffusion steps / no. of rows per matrix
no_of_cols = 2;
z = cell(C, 1); %Pre-allocate C cells of N x no_of_cols matrices
finalx = 0; %initialise end points x and y
finaly = 0;

v = VideoWriter('randomwalk2.avi');
open(v);

%% plotting the 1st cell diffusion.
    m = zeros(N, no_of_cols); % individual N x no_of_cols matrix;
    m(1,1) = finalx;
    m(1,2) = finaly;
    
    %determine direction of diffusion
    deltax = randi([-1, 1], 1, N * 18/4);
    deltay = randi([-1, 1], 1, N * 18/4);
    % Get rid of any cases where BOTH x and y change by + or - 1, OR
    % where both equal zero. (no diagonal steps)
    goodIndexes = (abs(deltax) + abs(deltay)) == 1;
    % In theory, 4/9th of them should be good.  To make sure we didn't run out of them, we asked for twice as many as we would need (9/4 X 2).
    % Extract ONLY the good ones.
    deltax = deltax(goodIndexes);
    deltay = deltay(goodIndexes);
    % Extract the exact number we want.
    deltax = deltax(1 : N);
    deltay = deltay(1 : N);
    
    %determine coordinate position
	for step = 2 : N
		% Walk in the x direction.
		m(step, 1) = m(step-1, 1) + deltax(step);
		% Walk in the y direction.
		m(step, 2) = m(step-1, 2) + deltay(step);
        % Now plot the walk so far.
 		xCoords = m(1:step, 1);
 		yCoords = m(1:step, 2);
        plot(xCoords, yCoords, '.-r', 'MarkerSize', 9);
        xlim([-10 10]);
        ylim([-10 10]);
        axis equal
        frame = getframe(gcf);
        writeVideo(v,frame);
        hold on
        
    end
    
    z{1} = m; % Put into the k-th cell
    
    %end-point of 1st matrix will be the start points of 1st and 2nd matrix
    finalx = m(N,1);
    finaly = m(N,2);
    


%% plotting the diffusion of daughter cells from 1st parent cell
z = cell(C,1);
for k = 1 : 2
    
    
    m = zeros(N, no_of_cols); % individual N x no_of_cols matrix;
    m(1,1) = finalx;
    m(1,2) = finaly;
    
    
    %determine direction of diffusion
    deltax = randi([-1, 1], 1, N * 18/4);
    deltay = randi([-1, 1], 1, N * 18/4);
    % Get rid of any cases where BOTH x and y change by + or - 1, OR
    % where both equal zero. (no diagonal steps)
    goodIndexes = (abs(deltax) + abs(deltay)) == 1;
    % In theory, 4/9th of them should be good.  To make sure we didn't run out of them, we asked for twice as many as we would need (9/4 X 2).
    % Extract ONLY the good ones.
    deltax = deltax(goodIndexes);
    deltay = deltay(goodIndexes);
    % Extract the exact number we want.
    deltax = deltax(1 : N);
    deltay = deltay(1 : N);
    
    %determine coordinate position
	for step = 2 : N
		% Walk in the x direction.
		m(step, 1) = m(step-1, 1) + deltax(step);
		% Walk in the y direction.
		m(step, 2) = m(step-1, 2) + deltay(step);
        % Now plot the walk so far.
 		
        
    end
    
    z{k} = m; % Put into the k-th cell
       
end

z{1}
z{2}
for step = 2 : N
    % Now plot the walk so far.
      plot(z{1}(1:step, 1),z{1}(1:step, 2), '.-r', z{2}(1:step, 1),z{2}(1:step, 2) , '.-b','MarkerSize', 9);
      xlim([-10 10]);
      ylim([-10 10]);
      axis equal
      frame = getframe(gcf);
      writeVideo(v,frame);
      hold on
end

finalx = z{1}(N,1);
finaly = z{1}(N,2);

close(v);

%% plotting the next diffusions //work in progress. 
z = cell(C,1);
for k = 1 : 4
    
    if k == 1 || k == 3
    m = zeros(N, no_of_cols); % individual N x no_of_cols matrix;
    m(1,1) = finalx;
    m(1,2) = finaly;
    
    
    %determine direction of diffusion
    deltax = randi([-1, 1], 1, N * 18/4);
    deltay = randi([-1, 1], 1, N * 18/4);
    % Get rid of any cases where BOTH x and y change by + or - 1, OR
    % where both equal zero. (no diagonal steps)
    goodIndexes = (abs(deltax) + abs(deltay)) == 1;
    % In theory, 4/9th of them should be good.  To make sure we didn't run out of them, we asked for twice as many as we would need (9/4 X 2).
    % Extract ONLY the good ones.
    deltax = deltax(goodIndexes);
    deltay = deltay(goodIndexes);
    % Extract the exact number we want.
    deltax = deltax(1 : N);
    deltay = deltay(1 : N);
    
    %determine coordinate position
	for step = 2 : N
		% Walk in the x direction.
		m(step, 1) = m(step-1, 1) + deltax(step);
		% Walk in the y direction.
		m(step, 2) = m(step-1, 2) + deltay(step);
        % Now plot the walk so far.
 		
        
    end
    
    z{k} = m; % Put into the k-th cell
    end
       
end

for step = 2 : N
    % Now plot the walk so far.
      plot(z{1}(1:step, 1),z{1}(1:step, 2), '.-', z{3}(1:step, 1),z{3}(1:step, 2) , '.-','MarkerSize', 9);
      xlim([-10 10]);
      ylim([-10 10]);
      axis equal
      %pause(0.2)
      hold on
end
