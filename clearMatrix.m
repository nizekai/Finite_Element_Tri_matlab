function fc = clearMatrix(matrix)
    i = 1;
    while i <= length(matrix)
        if matrix(i,:) == -999999
            matrix(i,:)=[];
            matrix(:,i)=[];
        else
            i = i+1;
        end
    end
    fc = matrix;
end