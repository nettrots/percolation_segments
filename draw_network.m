function draw_network(XY,X_intersect,Y_intersect,network_type,intersections,n_lines)

    % Show the intersection points.
    X_intersect(isnan(X_intersect))=0;
    Y_intersect(isnan(Y_intersect))=0;
    
    %figure('Position',[10 100 500 500],'Renderer','zbuffer');
    
    axes_properties.box             = 'on';
    axes_properties.XLim            = [0 1];
    axes_properties.YLim            = [0 1];
    axes_properties.DataAspectRatio = [1 1 1];
    axes_properties.NextPlot        = 'add';
    
    axes(axes_properties,'parent',gcf);
    
    line([XY(1:n_lines,1)';XY(1:n_lines,3)'],[XY(1:n_lines,2)';XY(1:n_lines,4)'],'Color','k');

   
    
    scatter(X_intersect(:),Y_intersect(:),4,'r');
    title(sprintf('Sample of %s networks of %d wires. \nIntersections: %d',network_type,n_lines,intersections));


    %figure('Position',[30 80 500 500],'Renderer','zbuffer');
    %axes_properties.box             = 'on';
    %axes_properties.XLim            = [0 max_iterations];
    %axes_properties.YLim            = [0 max(res(:,1))];
    %%axes_properties.DataAspectRatio = [1 1 1];
    %axes_properties.NextPlot        = 'add';
    %scatter(res(2:iteration,2),res(2:iteration,1),[]);