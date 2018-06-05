function fillGSM(elmt)  
%   Fill the Global Stiffness Matrix
%  
    global  E Mu t totalMatrix arrNode;
    a=elmt.a;
    b=elmt.b;
    c = E*t/4/(1-Mu^2);
    d = (1-Mu)/2;
    syms XiR XiS EtaR EtaS;
    baseMatrix = sym('b',2);
    baseMatrix(1,1) = c*(b/a*XiR*XiS*(1+1/3*EtaR*EtaS)+(1-Mu)/2*a/b*EtaR*EtaS*(1+1/3*XiR*XiS));
    baseMatrix(1,2) = c*(Mu*XiR*EtaS+(1-Mu)/2*EtaR*XiS);
    baseMatrix(2,1) = c*(Mu*EtaR*XiS+(1-Mu)/2*XiR*EtaS);
    baseMatrix(2,2) = c*(a/b*EtaR*EtaS*(1+1/3*XiR*XiS)+(1-Mu)/2*b/a*XiR*XiS*(1+1/3*EtaR*EtaS));
    arrElmt =  [elmt.i,elmt.j,elmt.l,elmt.m];
    Xi = [-1,1,1,-1];
    Eta= [-1,-1,1,1];
    for i = 1:4
        startX = findInCell(arrElmt(i),arrNode)*2-1;
        for j = 1:4
            startY = findInCell(arrElmt(j),arrNode)*2-1;
            XiR  = Xi(i) ; XiS  = Xi(j) ;
            EtaR = Eta(i); EtaS = Eta(j); 
            totalMatrix(startX:startX+1,startY:startY+1) = ...
                totalMatrix(startX:startX+1,startY:startY+1)+eval(baseMatrix);
        end
        
    end

end

