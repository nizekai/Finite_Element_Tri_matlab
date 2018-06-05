function simplifyMatrix(varargin)
    global totalMatrix forceMatrix dsMatrixCallback;
    for i = 1:nargin
        if varargin{i} == 0
            continue;
        end
        index = varargin{i};
        totalMatrix(index,:) = -999999;
        totalMatrix(:,index) = -999999;
        dsMatrixCallback{index}={};
        forceMatrix(index) = -999999;
    end
end