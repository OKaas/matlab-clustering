% Pushbutton callback
function change_cluster(src,evt, jList, clustMembsCell, INFLUANCE_MINIMAL, X, Y, INDEX_X, INDEX_Y, SIZE_POINT, COLOR_POINT, centers, SIZE_CLUSTER_FLAT)
    indexies = jList.getCheckedValues;
    show = zeros( indexies.size() , 1, 'uint8');
    
    % build structure for indexies
    for ind = 0:indexies.size()-1
        show(ind+1) = indexies.get(ind);
    end

    scatter( centers(show, INDEX_X), centers(show, INDEX_Y), SIZE_CLUSTER_FLAT, 'ob' );
    hold on
%     scatter(X, Y, SIZE_POINT, COLOR_POINT, 'filled');
%     hold off 
    hold on    
    for k = 1:size(show, 1)
        
        myMembers = clustMembsCell{show(k)};
        % myClustCen = clustCent(:,k);
    
        scatter(X(myMembers), Y(myMembers), SIZE_POINT, COLOR_POINT(myMembers), 'filled');
        
%         set(gca,'Position',[.05 .05 .90 .94])
        
    end
    hold off

end  