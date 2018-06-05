function x = findInCell(var,arrCell)
    x = find(cellfun(@(x)eq(x,var),arrCell));
end
