function ws = GetWorkspace()
%    function ws = GetWorkspace()
%        returns a struct with field names of variables in workspace of calling function
%        and values equal to their values
%    REA 8/Apr/2014 10:32
%    COPYRIGHT: © Robert E. Alvarez, 2014. All rights reserved.

vars = evalin('caller','who');  % cell array of field names

% initialise a structure
ws = struct;

% use dynamic fieldnames
for index = 1:numel(vars)
    ws.(vars{index}) = evalin('caller',vars{index});
end 
