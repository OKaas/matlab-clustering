% Cluster again -> false = debug visualization
CLUSTER = true;

if CLUSTER == true
    % clear data
    clear
    % setup for future :)
    CLUSTER = true;
end

profile on

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ADD NECESSARY PATHS
% ==================================================================
addpath('..\ClusterTool');

% big data set
FILENAME = 'D:\__gDrive\__PHD\Data\Output\ArtefactDetection\Clustering_MeanShift\Matlab\05CSMEstimator_scaled.xyznxnynzk1k2';

% OUTPUTFILE = 'D:\__gDrive\__PHD\Data\Output\ArtefactDetection\Clustering_MeanShift\Matlab\Output\05CSMEstimator.xyzc';

% small data set
% FILENAME = 'D:\__gDrive\__PHD\Data\Output\ArtefactDetection\Clustering_MeanShift\Matlab\05CSMEstimator_small_random.txt';

% FILENAME = 'D:\__gDrive\__PHD\Data\Output\ArtefactDetection\Clustering_MeanShift\Matlab\01RusinkiewiczEstimator_small_random.txt';


NUMBER_OF_CLUSTERS = 5;
INFLUANCE_MINIMAL = 0.2;

SAMPLING_DATA = 2;
BANDWIDTH = 0.1;

% VISUALIZATION
OPTION_VISUALIZATION = struct;
OPTION_VISUALIZATION.SIZE_CLUSTER_CENTER    = 60;
OPTION_VISUALIZATION.SIZE_POINT             = 5;
OPTION_VISUALIZATION.SIZE_NORMAL_ARROW      = 25;
OPTION_VISUALIZATION.SIZE_CLUSTER_FLAT      = 200;
OPTION_VISUALIZATION.SIZE_NORMALS_COEF      = 20;
OPTION_VISUALIZATION.INFLUANCE_MINIMAL      = 0.1;

OPTION_VISUALIZATION.VIEW_UP                = [0 90];
OPTION_VISUALIZATION.VIEW_ISO               = [50 30];

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LOAD DATA
% ==================================================================
DATA = load_data(FILENAME, SAMPLING_DATA, true);

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% CLUSTERING
% ==================================================================

if CLUSTER == true
    
    tic
    data = [DATA.X, DATA.Y, DATA.Z].';
    [centers,point2cluster,clustMembsCell] = MeanShiftCluster(data,BANDWIDTH);

    centers = centers.';

    toc
end

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% POST-CLUSTERING STATISTIS
% ==================================================================

fprintf('Clusters: %d\n', size(centers, 1));

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% POST-CLUSTERING CREATION MATRIX OF ASSOCIATION U
% ==================================================================

U = zeros(size(centers, 1), size(data, 2));

for k = 1:size(point2cluster, 2)
    U(point2cluster(k), k) = 1;
end

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% VISUALIZE
% ==================================================================
visualize_cluster(U, centers, DATA, OPTION_VISUALIZATION);  