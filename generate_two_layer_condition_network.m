function XY = generate_two_layer_condition_network(segments_in_layer,L,min_spasing,d_alpha,angle)
max_iterations = 10000000;
iteration=0;
XY = zeros(segments_in_layer*2,4);
for i=1:segments_in_layer
    gen = 1;
    
    while (gen&&(iteration<max_iterations))
        iteration=iteration+1;
        % create verticaly aligned wires
        sin_a= sind( -d_alpha + 2*d_alpha*rand);
        cos_a=sqrt(1-sin_a*sin_a);
        x=L/2*abs(sin_a)+(1-L*abs(sin_a))*rand;
        y=L/2*abs(cos_a)+(1-L*abs(cos_a))*rand;
        
        x1=x+L/2*sin_a;
        y1=y+L/2*cos_a;
        x2=x-L/2*sin_a;
        y2=y-L/2*cos_a;
        gen = 0;
        if i>1
            for ii=1:(i-1)
                x0 = (XY(ii,1)+XY(ii,3))/2;
                y0 = (XY(ii,2)+XY(ii,4))/2;
                %cond1 = ((x+y)<(x0+y0))&&((x-y)<(x0-y0));
                %cond2 = ((x+y)>(x0+y0))&&((x-y)>(x0-y0));
                cond3 = -min_spasing<(x-x0);
                cond4 = (x-x0)<min_spasing;
                cond5 = -L<(y-y0);
                cond6 = (y/2)<+L;
                if  (cond3&&cond4&&cond5&&cond6)
                    gen = 1;
                    break;
                end
            end
        end
    end
    if iteration==max_iterations
        fprintf(1,'Warning! Max iterations for generating spaced wires (wire%d from %d)\n',i,segments_in_layer);
    end
    XY(i,:)=[x1 y1 x2 y2];
end
iteration=0;
for i=segments_in_layer+1:2*segments_in_layer
    gen = 1;
    if i>1
        while (gen&&(iteration<max_iterations))
            iteration=iteration+1;
            % create horisontaly aligned wires
            cos_a= cosd( -d_alpha + 2*d_alpha*rand + angle);
            sin_a=sqrt(1-cos_a*cos_a);
            x=L/2*abs(sin_a)+(1-L*abs(sin_a))*rand;
            y=L/2*abs(cos_a)+(1-L*abs(cos_a))*rand;
            
            x1=x+L/2*sin_a;
            y1=y+L/2*cos_a;
            x2=x-L/2*sin_a;
            y2=y-L/2*cos_a;
            gen = 0;
            for ii=1:(i-1)
                x0 = (XY(ii,1)+XY(ii,3))/2;
                y0 = (XY(ii,2)+XY(ii,4))/2;
                %cond1 = ((x+y)<(x0+y0))&&((x-y)>(x0-y0));
                %cond2 = ((x+y)>(x0+y0))&&((x-y)<(x0-y0));
                cond3 = -min_spasing<(y-y0);
                cond4 = (y-y0)<+min_spasing;
                cond5 = -L<(x-x0);
                cond6 = (x-x0)<L;
                if  (cond3&&cond4&&cond5&&cond6)
                    gen = 1;
                    break;
                end
            end
        end
        
        
    end
    if iteration==max_iterations
        fprintf(1,'Warning! Max iterations for generating spaced wires (wire%d from %d)\n',i,segments_in_layer);
    end
    XY(i,:)=[x1 y1 x2 y2];
end
