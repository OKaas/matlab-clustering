function [DATA] = load_data(p_filePath, p_samplingData, p_printStatistics)

DATA = struct;
DATA.INDEX_X = 1;
DATA.INDEX_Y = 2;
DATA.INDEX_Z = 3;
DATA.INDEX_NX = 4;
DATA.INDEX_NY = 5;
DATA.INDEX_NZ = 6;
DATA.INDEX_K1 = 7;
DATA.INDEX_K2 = 8;
      
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LOAD DATA
% ==================================================================

DATA.POINTS = datasample(csvread(p_filePath), p_samplingData);

DATA.X = DATA.POINTS(:, DATA.INDEX_X);
DATA.Y = DATA.POINTS(:, DATA.INDEX_Y);
DATA.Z = DATA.POINTS(:, DATA.INDEX_Z);

DATA.NX = DATA.POINTS(:, DATA.INDEX_NX);
DATA.NY = DATA.POINTS(:, DATA.INDEX_NY);
DATA.NZ = DATA.POINTS(:, DATA.INDEX_NZ);

DATA.K1 = DATA.POINTS(:, DATA.INDEX_K1);
DATA.K2 = DATA.POINTS(:, DATA.INDEX_K2);

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% STATISTICS
% ==================================================================
DATA.maxX = max(DATA.X);
DATA.maxY = max(DATA.Y);
DATA.maxZ = max(DATA.Z);

DATA.minX = min(DATA.X);
DATA.minY = min(DATA.Y);
DATA.minZ = min(DATA.Z);

DATA.maxNX = max(DATA.NX);
DATA.maxNY = max(DATA.NY);
DATA.maxNZ = max(DATA.NZ);

DATA.minNX = min(DATA.NX);
DATA.minNY = min(DATA.NY);
DATA.minNZ = min(DATA.NZ);

DATA.maxK1 = max(DATA.K1);
DATA.maxK2 = max(DATA.K2);

DATA.minK1 = min(DATA.K1);
DATA.minK2 = min(DATA.K2);

if p_printStatistics
    fprintf('max X: %6.2f min X: %6.2f\n', DATA.maxX, DATA.minX);
    fprintf('max Y: %6.2f min Y: %6.2f\n', DATA.maxY, DATA.minY);
    fprintf('max Z: %6.2f min Z: %6.2f\n', DATA.maxZ, DATA.minZ);

    fprintf('max NX: %6.2f min NX: %6.2f\n', DATA.maxNX, DATA.minNX);
    fprintf('max NY: %6.2f min NY: %6.2f\n', DATA.maxNY, DATA.minNY);
    fprintf('max NZ: %6.2f min NZ: %6.2f\n', DATA.maxNZ, DATA.minNZ);

    fprintf('max K1: %6.2f min K1: %6.2f\n', DATA.maxK1, DATA.minK1);
    fprintf('max K2: %6.2f min K2: %6.2f\n', DATA.maxK2, DATA.minK2);
end