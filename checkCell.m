function out = checkCell(arrCell)
%   Make sure that ervery element in arrCell is exclusive
    for i=arrCell
        arrs=findInCell(i{:},arrCell);
        if length(arrs)>1
            arrCell(arrs(2:end))=[];
        end
    end
    out = arrCell(not(cellfun(@isempty,arrCell)));
end