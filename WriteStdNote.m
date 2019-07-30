function [nbytes] = WriteStdNote(fp, item)
% function [nbytes] = WriteStdNote(fp, item)
% write the tags (if any) and note text to a file
% inputs:
%     fp: a fileid from fopen
%     item: an item struct from the exported JSON file
% outputs:
%     nbytes: the number of bytes from the last fprintf write
% REA 25/Jul/2019 10:22
% COPYRIGHT: © Robert E. Alvarez, 2019. All rights reserved.

% validateattributes(fp,{'double'});
% validateattributes(item,{'struct'});

content = item.content;
if isfield(content,'tags')
    % if tags field of content struct exists write them out
    fprintf(fp,'tags:');
    fprintf(fp,' %s',content.tags);
    fprintf(fp,'\n');
end
nbytes = fprintf(fp,content.text);