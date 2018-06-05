function printDisplacement()
    global arrNode;
    for i = 1:length(arrNode)
        fprintf(1,'Node number %d\t: ',i);
        arrNode{i}.dispDisplacement();
    end
end