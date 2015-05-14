function XY = generate_two_layer_network_disp(segments_in_layer,L1,L2,perc,d_alpha,angle)
 
 XY = zeros(segments_in_layer*2,4);
 l2_count = round(segments_in_layer*perc);
 for i=1:segments_in_layer
         % create verticaly aligned wires
         if l2_count>0
            L=L2;
            l2_count=l2_count-1;
         else
            L=L1;
         end
         sin_a= sind( -d_alpha + 2*d_alpha*rand);
         cos_a=sqrt(1-sin_a*sin_a);
         x=L/2*abs(sin_a)+(1-L*abs(sin_a))*rand;
         y=L/2*abs(cos_a)+(1-L*abs(cos_a))*rand;
      
         x1=x+L/2*sin_a;
         y1=y+L/2*cos_a;
         x2=x-L/2*sin_a;
         y2=y-L/2*cos_a;
                    
         XY(i,:)=[x1 y1 x2 y2];
 end
 l2_count = round(segments_in_layer*perc);
 for i=segments_in_layer+1:2*segments_in_layer
         if l2_count>0
            L=L2;
            l2_count=l2_count-1;
         else
            L=L1;
         end
         % create horisontaly aligned wires
         cos_a= cosd( -d_alpha + 2*d_alpha*rand + angle);
         sin_a=sqrt(1-cos_a*cos_a);
         x=L/2*abs(sin_a)+(1-L*abs(sin_a))*rand;
         y=L/2*abs(cos_a)+(1-L*abs(cos_a))*rand;
      
         x1=x+L/2*sin_a;
         y1=y+L/2*cos_a;
         x2=x-L/2*sin_a;
         y2=y-L/2*cos_a;
             
         XY(i,:)=[x1 y1 x2 y2];
end    
       
  