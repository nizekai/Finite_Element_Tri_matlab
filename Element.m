classdef Element < handle
    %   Create a triangle element:
    %       a = Element(i,j,l,m)
    %   You can also input nodes out of order,the program will make them in
    %   correct order.
    %
    %   Properties:
    %       j
    %        .
    %        . .
    %      b .   .
    %        .     .
    %        . . . . . 
    %      m     a     i   
        
    properties
        i;j;l;m;
        a;b;
    end
    
    methods
        
        function obj = Element(i,j,l,m)
            if ~obj.isHL(i,j,m)
                error('Element:err','Inputments cannot make a right triangle');
            end
            [obj.i,obj.j,obj.l,obj.m] = obj.ordering(i,j,l,m);
            [obj.a,obj.b] = obj.i.distanceTo(obj.j,obj.m);
            obj.a = obj.a/2; obj.b = obj.b/2;
            global arrElement;
            arrElement{end+1} = obj;
        end
        
        function fc = isHL(~,a,b,c)
            % return if it's a right triangle
            fc = round(a.distanceTo(b)^2+b.distanceTo(c)^2-c.distanceTo(a)^2,4) == 0 || ...
                round(abs(a.distanceTo(b)^2-b.distanceTo(c)^2)-c.distanceTo(a)^2,4) == 0;
        end
        
        function [i,j,l,m] = ordering(obj,varargin)
            flag = false;
            range = perms([1,2,3,4]);
            for id = 1:length(range)
                if obj.ifInOrder(varargin{range(id,1:4)})
                    [i,j,l,m] = varargin{range(id,1:4)};
                    flag = true;
                    break
                end
            end
            if ~flag
                err('Element:err','not a rectangle');
            end
        end
        
        function fc = ifInOrder(obj,f,a,b,c)
            if f.x ~= min([a.x,b.x,c.x]) || f.y~= min([a.y,b.y,c.y])
                fc = false;
                return;
            end
            [~,dot] = obj.calCD([b,a,c]);
            [cross,~] = obj.calCD([a,b,c]); 
            fc = (dot == 0 && cross > 0);            
        end
        
        function [cross,dot] = calCD(obj,arr)
            vect1 = [arr(2).x-arr(1).x,arr(2).y-arr(1).y];
            vect2 = [arr(3).x-arr(1).x,arr(3).y-arr(1).y];
            cross = vect1(1)*vect2(2)-vect1(2)*vect2(1);
            dot   = vect1(1)*vect2(1)+vect1(2)*vect2(2);
        end

    end 
end

