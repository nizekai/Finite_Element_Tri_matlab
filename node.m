classdef node < handle
    % INITIAL-----------------------------------------------------
    %   You can create a new node class by follow commands:
    %       a = node([1,2])
    %       a = node(1,2)
    %       a = node([1 2])
    % CONSTRAINT:-------------------------------------------------
    %   Function [node].constraint() is provided for setting
    %   constarints in both X and Y direction(default none):
    %       a.constraint()      ,a.constraint('xy')     //for both XY constraints
    %       a.constraint(1,0)   ,a.constraint('x')      //for only X constraint
    %       a.constraint('y')                           //for only Y constraint...etc
    %   Or you can set the constraints with creation of a node class:
    %       a = node([1,2],'xy')
    %       a = node(1,2,0,1)   //for only Y constraint
    %       a = node(1,2,'x')   //for only X constraint
    %       a = node([1 2],1,0) //for both XY constraints
    %       ...etc,almost whatever you think it may work,it would work.
    % DISTANCE----------------------------------------------------
    %   Function [node1].distanceTo([node2]) will return the distance 
    %   between two node classes;
    % SET POSITION------------------------------------------------
    %       [node].setXY(x,y)
    
    properties
        x;y;
    end
    properties
        cst_x;cst_y; 
    end
    properties
        force_x;force_y;
        displacement_x=0;displacement_y=0;
    end
    methods
        function obj = node(varargin)
            errF = 0;
            global arrNode;
            obj.force(0,0);
            switch nargin
                case 1
                    if length(varargin{1,1}) ~= 2
                        errF = 1;
                    end
                    obj.setXY(varargin{1,1}(1),varargin{1,1}(2));
                    obj.constraint(false,false);
                case 2
                    obj.setXY(varargin{:});
                    obj.constraint(false,false);
                case 3
                    try
                        obj.setXY(varargin{1:2});
                        obj.constraint(varargin{3});
                    catch 
                        try 
                            obj.setXY(varargin{1}(1),varargin{1}(2));
                            obj.constraint(varargin{2:3});
                        catch err
                            errF = 1;
                        end
                    end
                case 4
                    obj.setXY(varargin{1:2});
                    obj.constraint(varargin{3:4});
                otherwise
                    errF = 1;
            end
            if errF
                error('node:error','Wrong method of initializing a new node class');
            else
                arrNode{end+1} = obj;
                return;
            end 
        end
        function fc = setXY(obj,x,y)
            obj.x = x;
            obj.y = y;
        end
        function fc = eq(a,b)
            % operator override
            fc = a.x==b.x && a.y==b.y && ...
                 a.cst_x==b.cst_x && a.cst_y==b.cst_y && ...
                 a.force_x==b.force_x && a.force_y==b.force_y;
        end
        function varargout = distanceTo(obj,varargin)
            for i=1:nargin-1
                nd = varargin{i};
                if class(varargin{i}) ~= 'node'
                    error('node:error','node type only for inputargument')
                end
                varargout{i} = sqrt((obj.x-nd.x)^2+(obj.y-nd.y)^2);
            end
        end
        
        function fc = constraint(obj,varargin)
            if isempty(varargin)
                obj.cst_x = true; 
                obj.cst_y = true;
            elseif length(varargin) == 2
                 obj.cst_x = boolean(varargin{1});
                obj.cst_y = boolean(varargin{2});
            elseif (length(varargin) == 1) && ischar(class(varargin{1}))
                obj.cst_x = ~isempty(regexp(varargin{1},'x','ONCE'));
                obj.cst_y = ~isempty(regexp(varargin{1},'y','ONCE'));
            end  
        end
        
        function force(obj,fx,fy)
            obj.force_x = fx;
            obj.force_y = fy;
        end
        
        function setDspmtX(obj,val)
            obj.displacement_x = val;
        end
        function setDspmtY(obj,val)
            obj.displacement_y = val;
        end
        function dispDisplacement(obj)
            global precision;
            fprintf(1,['displacement X = %6.' num2str(precision) 'f \t, Y  = %6.' num2str(precision) 'f\n'],obj.displacement_x,obj.displacement_y);
        end
    end
    
end

