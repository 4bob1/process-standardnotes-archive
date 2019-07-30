% ExportNotes2tags.m
% output individual notes to text files for each tag
%
% To use:
%   1. enter the path to the JSON file from StandardNotes as fnameJSON
%   2. enter the path to the directory for the output files as dir4Files
%   3. execute this script
%
% COPYRIGHT: © Robert E. Alvarez, 2019. All rights reserved.
% REA 30/Jul/2019 9:36

%% load the stdnotes output JSON archive
% fnameJSON = 'L:\StandardNotes\BU24Jan2019.txt';
 % remove the 'addtag2notes' argument if you do not want the tags added to the note data
jsonDat = LoadStdNoteFromJSON(fnameJSON,'addtag2notes');

%% write out notes for each tag to files
% dir4Files = 'L:\L_SmallData\Projects\Learn\StandardNotes\tags\';
assert(exist(dir4Files,'dir')>0);
nFilesWritten = WriteNotes2FilesByTags(dir4Files,jsonDat);

