clear;
%generate timespamp
dt=datestr(now,30);

%system parameters
%modelling cell size is of size of 1
%Segments size is L; if L=0.1 wire is 10 times smaller and cell side
L=0.1;
%small deviation of angle for aligned wires
alpha = 0.5;
progress_bar_enabled = true;
console_output_enabled = true;
draw_figures = true;


%iteration parameters

iterations = 100; %number of iterations
i = 0; % iteration counter
eps = L/20;%small number

% total number of wires; for two layer systems must be even
range=250;
draw_wires = range;
i_r=0; %index counter
network_type = 'regular'; %random/aligned/spaced/regular/other...
params =containers.Map; 
params('alpha')=alpha;
params('angle')=90;
params('distance')=0.01;
params('rel_distance')=2;
par = '';


%initialisztion of arrays
data = zeros(length(range),iterations,5);
avarages=zeros(length(range),13);


if progress_bar_enabled
    h = waitbar(0,'Initializing waitbar...');
end

for segments_number=range
%running index
    i_r=i_r+1;
    i = 0;
    % start timer
    tic
    while (i<iterations)
 
       %progress bar
       if progress_bar_enabled
         perc = round(i/iterations*100);
         waitbar(perc/100,h,sprintf('throwing %d %s wires %d times. %d%% done...',...
         segments_number,network_type,iterations,perc))
       end
       
       i = i + 1; 
       % generate network of segments Types are 'random', 'aligned',
       % 'spaced'
       XY1 = generate_network(network_type,segments_number,L,params) ;
       XY1 = [eps 0 eps 1;1-eps 0 1-eps 1; XY1];
       % search for intersections  
       out = lineSegmentIntersect(XY1,XY1);
       
       % Sparseing AdjacencyMatrix for graph theory calculations
       iam = out.intAdjacencyMatrix;
       iam = iam-diag(diag(iam));
       siam = sparse(iam);
       
       %look is network spans and calculate max flow
       flow = max_flow(siam,1,2);
       	%min_x = edge_segment_index(XY1,@min,'x');
        %max_x = edge_segment_index(XY1,@max,'x');

       iam(1:2,:) = 0;
       iam(:,1:2) = 0;
       siam = sparse(iam);
       
       % Calculate amount and size of clusters 
       [claster_indeces, claster_sizes] = components(siam);
      
        
       %number of intersections
        iam(1:2,:) = 0;
        iam(:,1:2) = 0;
        x_k = nnz(iam)/2;
       
      
       %saving info in iteration
       %intersection/larges claster/average claster/number of clusters/flow
       data(i_r,i,:) = [x_k max(claster_sizes) mean(claster_sizes)...
           length(claster_sizes) flow] ;    
    end
    
    %calc averages over iterations
    avarages(i_r,:) = [segments_number...
                       iterations...
                       mean(data(i_r,:,1),2)...%intersections
                       std(data(i_r,:,1),0,2)...
                       mean(data(i_r,:,2),2)...%max claster size
                       std(data(i_r,:,2),0,2)...
                       mean(data(i_r,:,3),2)...%average claster 
                       std(data(i_r,:,3),0,2)...
                       mean(data(i_r,:,4),2)...%claster number
                       std(data(i_r,:,4),0,2)...
                       mean(data(i_r,:,5),2)...%flow
                       std(data(i_r,:,5),0,2)...
                       nnz(data(i_r,:,5))/iterations% percolation probability
                       ];
                   %nnz(data(i_r,:,5))/iterations
    %save avarages to csv file
    csvwrite(sprintf('%s\\%s_%s_%s.csv','csv',network_type,par,dt),avarages);
    % time off
    dt_1 = toc;
    if console_output_enabled               
        fprintf(1,'Iterations took %.2f seconds for %.0f line segments...\n',dt_1,segments_number);
        fprintf(1,'Average is %.2f and Standard deviation is %.2f based on N = %f iterations\n',avarages(i_r,3:4),iterations);
    end

    if draw_figures&&ismember(segments_number,draw_wires)
        hh = figure();
        draw_network(XY1,out.intMatrixX,out.intMatrixY,network_type,x_k,segments_number);
        saveas(gcf,sprintf('%s\\%s_%ssegm_%s_all.fig','fig',network_type,segments_number,dt),'fig');
        close(hh);
    end
    
end
    %save all interations to csv file
    csvwrite(sprintf('%s\\%s_%s_%s_all.csv','csv',network_type,par,dt),data);
if progress_bar_enabled
    close(h);
end

