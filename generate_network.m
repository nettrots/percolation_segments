
function XY = generate_network(network_type,segments_number,L,params)


%'random', 'aligned', spaced
switch network_type
   case 'random'
      XY = generate_random_network(segments_number,L);
   case 'aligned'
      XY = generate_two_layer_network(segments_number/2,L,...
                params('alpha'),params('angle'));
   case 'spaced'
      XY = generate_two_layer_condition_network(segments_number/2,L,...
                L*params('distance'),params('alpha'),params('angle')) ;
   case 'regular'
      XY = generate_regular_network(segments_number/2,L,...
                params('rel_distance')) ;  
   otherwise
      XY = zeros(segments_number,4);
end

end
