clear all;clc;
global E Mu t precision totalMatrix;

%---------Basic VARIABLES INPUT--------------
%       E     means the Young's/Elastic modulus
%       Mu    means the Poisson ratio
%       t     means the thickness of the plate
%   precision means the decimal precision
%
    E = 2.1*10^5; Mu = 0.3; t = 1; precision = 7;
%--------------------------------------------

%-------------NODES & ELEMENT----------------
%   1. Create ur nodes 
%      
%   2. Set your nodes' constrains by:
%       [node].constraint(xConstrain,yConstrain)   True for restrained and false for free
%   3. Set forces for ur nodes with:
%       [node].force(xForce,yForce);
%   4. Set ur nodes into elemnts:
%       Element([node],[node],[node]) 
%        with no requirment to the order of the node inputments
%   P.S more usage is introduced in Class node (file node.m)
    a = node(0,0,'xy');
    b = node(1000,0);
    c = node(2000,0);
    d = node(0,1000,'xy');
    e = node(1000,1000);
    f = node(2000,1000);
    c.force(0,50); f.force(0,50);
    e1 = Element(a,b,d,e);e2 = Element(b,c,e,f);
%-------------------------------------------


%----------------RUN OUT--------------------
    calculate;
    
%----------------PRINT RESULT---------------
    printDisplacement;
    
%   Or you want singly see one node's strain,
%   try command : [node].dispStrain()
