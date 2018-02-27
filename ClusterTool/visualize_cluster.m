function visualize_cluster(p_U, p_centers, p_data, p_options)

%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% CALCULATE VISUALIZATION VARIABLES (colors etc)
% ==================================================================

colormap_space = prism(size(p_centers, 1));
colormap_flat = prism(size(p_centers, 1));

COLOR_CURVATURE = zeros( size(p_data.POINTS, 1) , 3, 'double');
COLOR_POINT = zeros( size(p_data.POINTS, 1) , 3, 'double');
COLOR_FLAT = zeros( size(p_data.POINTS, 1) , 3, 'double');

color_map = prism( size(p_centers, 1) );

% define colors
for k = 1:size(p_centers, 1)
    
    for i = 1:size( p_data.POINTS, 1 )
        COLOR_POINT( i, 1 ) = COLOR_POINT( i, 1 ) + (p_U(k, i) * colormap_space(k, 1));
        COLOR_POINT( i, 2 ) = COLOR_POINT( i, 2 ) + (p_U(k, i) * colormap_space(k, 2));
        COLOR_POINT( i, 3 ) = COLOR_POINT( i, 3 ) + (p_U(k, i) * colormap_space(k, 3));
    end
end

for k = 1:size(p_data.POINTS, 1)
    COLOR_FLAT(k, 1) = p_data.NX(k, 1) * p_options.SIZE_NORMALS_COEF;
    COLOR_FLAT(k, 2) = p_data.NY(k, 1) * p_options.SIZE_NORMALS_COEF;
    COLOR_FLAT(k, 3) =p_data. NZ(k, 1) * p_options.SIZE_NORMALS_COEF;
end

for k = 1:size(p_data.POINTS, 1)
    COLOR_CURVATURE(k, 1) = p_data.K1(k, 1);
    COLOR_CURVATURE(k, 2) = p_data.K1(k, 1);
    COLOR_CURVATURE(k, 3) = p_data.K1(k, 1);
end
 
%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% VISUALIZATION
% ================================================================== 
clf('reset');

figure(1)
    % main data
    scatter3(p_data.X, p_data.Y, p_data.Z, p_options.SIZE_POINT, COLOR_POINT, 'filled');
    hold on 
        % stems to ground
%         stem3(p_centers(:,p_data.INDEX_X ), p_centers(:, p_data.INDEX_Y), p_centers(:, p_data.INDEX_Z));

        view(p_options.VIEW_ISO);
    hold off


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% INTERACTIVE FIGURE
% ==================================================================   

data = cell(size(p_centers, 1), 2 );
for cl = 1:size(p_centers, 1) 
    data{cl, 1} = cl;
    data{cl, 2} = false;
end
% 
fig = figure(2);

show_clusters = [];

scatter(p_data.X, p_data.Y, p_options.SIZE_POINT, COLOR_POINT, 'filled');
set(gca,'Position',[.05 .05 .90 .94])

t = uitable(fig, 'CellEditCallback',@drawSelectedCluster);

function drawSelectedCluster(hObject, callBackData)
    
    if callBackData.EditData 
        show_clusters = [show_clusters callBackData.Indices(1)];
    else
        show_clusters = show_clusters(find(show_clusters~=callBackData.Indices(1)));
    end
    
    show_points = [];
    
    % determine point assigned to clusters
    for i = 1:size( p_U, 2 )
        % iterate over all rows
        for j = 1:size( show_clusters, 1 )

            if p_U(show_clusters(j), i) > p_options.INFLUANCE_MINIMAL
                show_points = [show_points i];
            end
        end
    end
    
    if size(show_points) > 0
        scatter(p_data.X(show_points), p_data.Y(show_points), p_options.SIZE_POINT, COLOR_POINT(show_points), 'filled');
        set(gca,'Position',[.05 .05 .90 .94])
        hold on
            scatter( p_centers(show_clusters, p_data.INDEX_X), p_centers(show_clusters, p_data.INDEX_Y), p_options.SIZE_CLUSTER_FLAT, 'ob');
        hold off
        set(gca,'Position',[.05 .05 .90 .94]);
    else
        scatter( p_centers(show_clusters, p_data.INDEX_X), p_centers(show_clusters, p_data.INDEX_Y), p_options.SIZE_CLUSTER_FLAT, 'ob');
        set(gca,'Position',[.05 .05 .90 .94]);
    end
    
end
t.ColumnEditable = true;
t.InnerPosition = [0 0 200 200];
t.Data = data;

% fig_cluster = figure(2);
%     scatter(p_data.X, p_data.Y, p_options.SIZE_POINT, COLOR_POINT, 'filled');
%     set(gca,'Position',[.05 .05 .90 .94])
%     
%     hold on 
%         scatter( p_centers(:, p_data.INDEX_X), p_centers(:, p_data.INDEX_Y), p_options.SIZE_CLUSTER_FLAT, 'ob' );
%     hold off 
%     set(gca,'Position',[.05 .05 .90 .94])
% 
%     jList = java.util.ArrayList;  
%     for cl = 1:size(p_centers, 1) 
%         jList.add(cl);
%     end
%     jCBList = com.mathworks.mwswing.checkboxlist.CheckBoxList(jList);
%     jScrollPane = com.mathworks.mwswing.MJScrollPane(jCBList);
%     [jhCBList,hContainer] = javacomponent(jScrollPane,'East',gcf);
%     set(jCBList, 'ValueChangedCallback', {@change_cluster_callback,...
%                                           jCBList, ...
%                                           p_U,...
%                                           p_options.INFLUANCE_MINIMAL,...
%                                           p_data.X,...
%                                           p_data.Y,...
%                                           p_data.INDEX_X,...
%                                           p_data.INDEX_Y,...
%                                           p_options.SIZE_POINT,...
%                                           COLOR_POINT,...
%                                           p_centers,...
%                                           p_options.SIZE_CLUSTER_FLAT});
%     jCBModel = jCBList.getCheckModel;
%     jCBModel.uncheckAll;

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% INTERACTIVE FIGURE
% ================================================================== 

figure(3)

    scatter(p_data.X, p_data.Y, p_options.SIZE_POINT, COLOR_CURVATURE, 'filled');

figure(4)

    scatter(p_data.X, p_data.Y, p_options.SIZE_POINT, COLOR_FLAT, 'filled');

figure(5)

    quiver(p_data.X, p_data.Y, p_data.NX, p_data.NY, p_options.SIZE_NORMAL_ARROW);
    view(p_options.VIEW_UP);

end