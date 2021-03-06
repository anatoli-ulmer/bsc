classdef icosahedron<scatterObjects.polyhedron
    properties (Constant)
        % coordinates
        % use values given by P. Bourke, see:
        % http://paulbourke.net/geometry/platonic/
        coords = ([ ...
            0  1/((1+sqrt(5))/2) -1;    1/((1+sqrt(5))/2)  1  0;   -1/((1+sqrt(5))/2)  1  0; ...
            0  1/((1+sqrt(5))/2)  1;   -1/((1+sqrt(5))/2)  1  0;    1/((1+sqrt(5))/2)  1  0; ...
            0  1/((1+sqrt(5))/2)  1;    0 -1/((1+sqrt(5))/2)  1;   -1  0  1/((1+sqrt(5))/2); ...
            0  1/((1+sqrt(5))/2)  1;    1  0  1/((1+sqrt(5))/2);    0 -1/((1+sqrt(5))/2)  1; ...
            0  1/((1+sqrt(5))/2) -1;    0 -1/((1+sqrt(5))/2) -1;    1  0 -1/((1+sqrt(5))/2); ...
            0  1/((1+sqrt(5))/2) -1;   -1  0 -1/((1+sqrt(5))/2);    0 -1/((1+sqrt(5))/2) -1; ...
            0 -1/((1+sqrt(5))/2)  1;    1/((1+sqrt(5))/2) -1  0;   -1/((1+sqrt(5))/2) -1  0; ...
            0 -1/((1+sqrt(5))/2) -1;   -1/((1+sqrt(5))/2) -1  0;    1/((1+sqrt(5))/2) -1  0; ...
            -1/((1+sqrt(5))/2)  1  0;   -1  0  1/((1+sqrt(5))/2);   -1  0 -1/((1+sqrt(5))/2); ...
            -1/((1+sqrt(5))/2) -1  0;   -1  0 -1/((1+sqrt(5))/2);   -1  0  1/((1+sqrt(5))/2); ...
            1/((1+sqrt(5))/2)  1  0;    1  0 -1/((1+sqrt(5))/2);    1  0  1/((1+sqrt(5))/2); ...
            1/((1+sqrt(5))/2) -1  0;    1  0  1/((1+sqrt(5))/2);    1  0 -1/((1+sqrt(5))/2); ...
            0  1/((1+sqrt(5))/2)  1;   -1  0  1/((1+sqrt(5))/2);   -1/((1+sqrt(5))/2)  1  0; ...
            0  1/((1+sqrt(5))/2)  1;    1/((1+sqrt(5))/2)  1  0;    1  0  1/((1+sqrt(5))/2); ...
            0  1/((1+sqrt(5))/2) -1;   -1/((1+sqrt(5))/2)  1  0;   -1  0 -1/((1+sqrt(5))/2); ...
            0  1/((1+sqrt(5))/2) -1;    1  0 -1/((1+sqrt(5))/2);    1/((1+sqrt(5))/2)  1  0; ...
            0 -1/((1+sqrt(5))/2) -1;   -1  0 -1/((1+sqrt(5))/2);   -1/((1+sqrt(5))/2) -1  0; ...
            0 -1/((1+sqrt(5))/2) -1;    1/((1+sqrt(5))/2) -1  0;    1  0 -1/((1+sqrt(5))/2); ...
            0 -1/((1+sqrt(5))/2)  1;   -1/((1+sqrt(5))/2) -1  0;   -1  0  1/((1+sqrt(5))/2); ...
            0 -1/((1+sqrt(5))/2)  1;    1  0  1/((1+sqrt(5))/2);    1/((1+sqrt(5))/2) -1  0; ...
            ]);

        NFaces=20;
        NEdgesPerFace=3;
        NEdges=30;

    end

    methods
        %uses methods defined in polyhedron
        function this=icosahedron(varargin)
            this=this@scatterObjects.polyhedron(varargin{:});
        end

    end

end

