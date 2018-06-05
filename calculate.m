function calculate
%
%   [ totalMatrix ]   *   [ dsMatrix ]  =  [ forceMatrix ]
%          |                   |                  |
%   stiffness matrix      displacement          force
%
%   P.S  dsMatrixCallback for callback-fucntion to set node's displacement

    global arrNode arrElement totalMatrix forceMatrix dsMatrixCallback;
    len = length(arrNode);
    totalMatrix = zeros(len*2, len*2);
    forceMatrix = zeros(1, len*2);
    dsMatrixCallback = cell(len,1);
    arrNode = checkCell(arrNode);
    for i = arrElement;
        fillGSM(i{:});    
    end

    for i = 1:len
        dsMatrixCallback{i*2-1} = @(varargin)arrNode{i}.setDspmtX(varargin{:});
        dsMatrixCallback{i*2} = @(varargin)arrNode{i}.setDspmtY(varargin{:});
        forceMatrix(i*2-1:i*2) = [arrNode{i}.force_x;arrNode{i}.force_y];
        simplifyMatrix((arrNode{i}.cst_x)*(i*2-1),(arrNode{i}.cst_y)*(i*2));
    end
    forceMatrix(forceMatrix==-999999)=[];
    dsMatrixCallback(find(cellfun(@(x)~isa(x,'function_handle'),dsMatrixCallback)))=[];
    totalMatrix = clearMatrix(totalMatrix);
    strainResult = forceMatrix/totalMatrix;
    for i = 1:length(strainResult)
        fc = dsMatrixCallback{i};
        fc(strainResult(i));
    end
end

