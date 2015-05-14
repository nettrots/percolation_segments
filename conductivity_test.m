
m=round(rand(2000,3)*1000);
m(:,3)=0;
m=m+1;
i=1;
m=unique(m,'rows');
while i<size(m,1)
   if m(i,1)==m(i,2)
       m(i,:)=[];
   end
   [~,indx]=ismember([m(i,2) m(i,1) 1],m,'rows');
   if indx>0
    m(indx,:)=[];
   end
   i=i+1;
end
m=sortrows(m);
tic
r = resistance_calculator(m,[min(m(:)),max(m(:))])
toc