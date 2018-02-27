% 0  0.390303909990066 0.761613628283489 0.695406648984759 0.56934679916375 0.503895004393921 0.0148929500476712 0.117551180958772 0.861232157428262

FILENAME = 'D:\__gDrive\__PHD\Output\ArtefactDetection\Clustering_MeanShift\Matlab\fc_1.cmean';
INDEX_GROUP = 1;
INDEX_X = 2;
INDEX_Y = 3;
INDEX_Z = 4;
INDEX_K1 = 8;

% data = csvread(FILENAME);

data = BILO595gseparated;

G = data(:, INDEX_GROUP);
X = data(:, INDEX_X);
Y = data(:, INDEX_Y);
Z = data(:, INDEX_Z);
S = data(:, INDEX_K1);

COLOR = jet( max(G) );

current_color = [zeros(length(G), 1), zeros(length(G), 1), zeros(length(G), 1)];

for index = 1:length(X)
    current_color(index) = COLOR(G(index, :));
end

% PLOT
scatter3(X, Y, Z, 1, COLOR, 'Filled');
view(40, 35);

% plot(CLUSTER(index1,1),CLUSTER(index1,2),'ob')
%hold on
%plot(CLUSTER(index2,1),CLUSTER(index2,2),'or')
%plot(centers(1,1),centers(1,2),'xb','MarkerSize',15,'LineWidth',3)
%plot(centers(2,1),centers(2,2),'xr','MarkerSize',15,'LineWidth',3)
%hold off