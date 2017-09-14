% Find the number of paths and store different paths in a vector and the
% corresponded indexes


pathsfound=vector.path(:,1);

 for j=1:length(vector.path(1,:))
    % find if element j is already in existing paths
    % if no, add path to array
    test=1;
    for k=1:length(pathsfound(1,:))
        test=norm(vector.path(:,j)-pathsfound(:,k))*test; % if norm = 0 we have a hit
    end;
    if (test~=0)
        pathsfound=[pathsfound vector.path(:,j)]; 
    end;
 end;

% Store the index of the path for each vector

% vector.ipath = [];
% for h = 1:length(pathsfound(1, :))
%     for j =1: length(vector.xin)
% 
%             if(norm(vector.path(:,j)-pathsfound(:,h))==0); 
%                 vector.ipath=  [vector.ipath h];  
%             end
%      end
% end