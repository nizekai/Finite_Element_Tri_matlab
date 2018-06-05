clear all;clc;
global E Mu t precision totalMatrix;

%---------Basic VARIABLES INPUT--------------
%       E     means the Young's/Elastic modulus
%       Mu    means the Poisson ratio
%       t     means the thickness of the plate
%   precision means the decimal precision
%
    E = 2.1*10^5; Mu = 0.5; t = 0.1; precision = 7;
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
    b = node(100,0);
    c = node(200,0);
    d = node(300,0);
    e = node(400,0,'y');
    f = node(0,100);
    g = node(100,100);
    h = node(200,100);
    i = node(300,100);
    j = node(400,100);
   	h.force(0,-50);
    e1 = Element(a,b,f);
    e2 = Element(b,f,g);
    e3 = Element(b,c,g);
    e4 = Element(g,c,h);
    e5 = Element(c,d,h);
    e6 = Element(d,h,i);
    e7 = Element(d,e,i);
    e8 = Element(e,i,j);
%-------------------------------------------


%----------------RUN OUT--------------------
    calculate;
    
%----------------PRINT RESULT---------------
    printDisplacement;
    
%   Or you want singly see one node's strain,
%   try command : [node].dispStrain()
