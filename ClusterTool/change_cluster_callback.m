% Pushbutton callback
function change_cluster_callback(src,evt, jList, U, INFLUANCE_MINIMAL, X, Y, INDEX_X, INDEX_Y, SIZE_POINT, COLOR_POINT, centers, SIZE_CLUSTER_FLAT)
    indexies = jList.getCheckedValues;
    show = zeros( indexies.size() , 1, 'uint8');
    
    % build structure for indexies
    for ind = 0:indexies.size()-1
        show(ind+1) = indexies.get(ind);
    end
    
    show_points = [];
    
    % determine point assigned to clusters
    for i = 1:size( U, 2 )
        % iterate over all rows
        for j = 1:size( show, 1 )

            if U(show(j), i) > INFLUANCE_MINIMAL
                show_points = [show_points i];
            end
        end
    end
    
    if size(show_points) > 0
        scatter(X(show_points), Y(show_points), SIZE_POINT, COLOR_POINT(show_points), 'filled');
        set(gca,'Position',[.05 .05 .90 .94])
        hold on
            scatter( centers(show, INDEX_X), centers(show, INDEX_Y), SIZE_CLUSTER_FLAT, 'ob');
        hold off
        set(gca,'Position',[.05 .05 .90 .94]);
    else
        scatter( centers(show, INDEX_X), centers(show, INDEX_Y), SIZE_CLUSTER_FLAT, 'ob');
        set(gca,'Position',[.05 .05 .90 .94]);
    end
end