function XY = generate_random_network(segments_number,L)

XY = zeros(segments_number,4);
for i=1:segments_number
        % [x y] center of new segment rotated by random angle
        sin_a= sind(180*rand-90);
        cos_a=sqrt(1-sin_a*sin_a);
        x=L/2*abs(sin_a)+(1-L*abs(sin_a))*rand;
        y=L/2*abs(cos_a)+(1-L*abs(cos_a))*rand;
        
        % [x1 y1] and [x2 y2] coordinates of segment vertexes  
        x1=x+L/2*sin_a;
        y1=y+L/2*cos_a;
        x2=x-L/2*sin_a;
        y2=y-L/2*cos_a;
        % add new segment to array
        XY(i,:)=[x1 y1 x2 y2];
end