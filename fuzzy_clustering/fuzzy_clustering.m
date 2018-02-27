%% Cluster again -> false = debug visualization
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

%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% CONSTANTS
% ==================================================================
FILENAME = 'D:\__gDrive\__PHD\Data\Output\ArtefactDetection\Clustering_MeanShift\Matlab\05CSMEstimator_scaled.xyznxnynzk1k2';

NUMBER_OF_CLUSTERS = 10;
SAMPLING_DATA = 20000;
BANDWIDTH = 0.1;

OPTION_CLUSTER = [1.3 NaN NaN false];

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

%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% COMPUTING
% ==================================================================

if CLUSTER == true
    tic
    data = [DATA.X, DATA.Y, DATA.Z, ...
            DATA.NX, DATA.NY, DATA.NZ, ...
            DATA.K1, DATA.K2];
    [cnt,U, objFcn] = fuzzy_modified(data, NUMBER_OF_CLUSTERS, OPTION_CLUSTER);
    centers = cnt;
    toc
end

OPTION_VISUALIZATION.INFLUANCE_MINIMAL = mean(mean(U));

fprintf("Influance minimal: %6.2f\n", OPTION_VISUALIZATION.INFLUANCE_MINIMAL);
fprintf("Clusters: %d\n", size(U, 1));

%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% VISUALIZATION
% ================================================================== 

visualize_cluster(U, centers, DATA, OPTION_VISUALIZATION);