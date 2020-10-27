function [membership, centres] = Kmeans(X, n_cluster)

if n_cluster > 5
    disp ('You have set too many clusters.');
    disp ('Set the number of clusters to be 1-2.');
    return;
end

% Initialize the figure
figure('position', [200, 200, 600, 500]);
    
%get the number of datapoints and features from the dataset
[n_sample, n_feat] = size(X); 

% Randomly initialize the starting cluster centres.
rng('shuffle');
up_bound = max(X);
lw_bound = min(X);
centres = lw_bound + (up_bound-lw_bound).*rand(n_cluster, n_feat);

disp('Start K-means clustering ... ');

%Initially assign all points to cluster one before beginning
old_membership = ones(n_sample, 1);

%Initial cluster centres displayed in the figure
show(X, old_membership, n_cluster, centres, 'Initial cluster centres')

while true
   %calculate euclidian distance in order to find what cluster each point
   %belongs to
    distance = pdist2(X, centres,"SquaredEuclidean"); 
    
    [~, membership] = min(distance, [], 2);
    
    %Points reassigned to closest clusters
    show(X, membership, n_cluster, centres, 'Datapoints reallocated')

   %Find the new cluster centres
    for j = 1:n_cluster
        centres(j, :) = mean(X(membership == j, :));
    end
    
    %Show updated cluster centres
    show(X, membership, n_cluster, centres, 'Cluster centers updated!')
    
    %Stop when there is no difference between steps
    if sum(membership ~= old_membership)==0
        show(X, membership, n_cluster, centres, 'Done! ');
        break;
    end
    
    old_membership = membership;
end
end
%Draws the points and clusters in a figure
function show(X, c_pred, n_cluster, centres, txt)
    symbol = ['ro'; 'gp'; 'bd'; 'k^'; 'r*'];
    hold off;
        
    for i = 1:n_cluster
        marker = mod(i,5);
        if i > 5            
            disp('Program is only meant to find 2 clusters');
        end
        plot(X(c_pred==i, 1), X(c_pred==i, 2), symbol(marker,:));
        hold on;
        plot(centres(i, 1), centres(i, 2), symbol(marker,2), 'MarkerFaceColor',symbol(marker,1));
        xlabel('Homeruns');
        ylabel('Runs Batted In');
    end
    text(4.2, 5.4, txt);
    drawnow;
    
 
    pause(2);
end
