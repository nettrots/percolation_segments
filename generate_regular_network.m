function XY = generate_regular_network(segments_number,L,rel_distance)
        XY1 = zeros(segments_number,4);
        
        m = rel_distance/L;%1/L grid
        n = segments_number;%number of elements; n<m*m
        
        temp = [ones(n,1); zeros(m*m-n,1)];
        temp = reshape(temp,m,m);
        temp(:) = temp(randperm(numel(temp))) ;
        [row,col] = find(temp == 1);
        row = row./m;
        col = col./m;
        
        for i=1:segments_number
            XY1(i,:)=[row(i) col(i)+L/2 row(i) col(i)-L/2];
        end
        
        temp = [ones(n,1); zeros(m*m-n,1)];
        temp = reshape(temp,m,m);
        temp(:) = temp(randperm(numel(temp))) ;
        [row,col] = find(temp == 1);
        row = row./m;
        col = col./m;
        
        XY2 = zeros(segments_number,4);
        for i=1:segments_number
            XY2(i,:)=[row(i)+L/2 col(i) row(i)-L/2 col(i)];
        end
        XY=[XY1;XY2];
end