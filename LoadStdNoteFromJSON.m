function dat = LoadStdNoteFromJSON(fname,varargin)
% function dat = LoadStdNoteFromJSON(fname,varargin)
% load data from JSON file exported by StandardNotes
% inputs:
%     fname: the path to the JSON file
%     addTag2Notes: (optional = false) if present adds tags to note items
% outputs:
%     dat: a struct with the data. See code for fields
% REA 27/Jul/2019 13:21
% COPYRIGHT: © Robert E. Alvarez, 2019. All rights reserved.

validateattributes(fname,{'char'},{'nonempty'},mfilename,'fname',1);
   % process optional arguments
addTag2Notes = false;
nreqargs = 1;
if(nargin>nreqargs)
  i=1;
  while(i<=size(varargin,2))
     switch lower(varargin{i})
     case lower('addTag2Notes');          
         addTag2Notes = true;
    otherwise
      error('Unknown argument %s given',varargin{i});
     end
     i=i+1;
  end
end
   % laod the JSON file.
d = loadjson(fname);
items = d.items; % a cell array of the items in the JSON file
clear d
nItems = length(items);

    % scan items array to find the note and tag items. get uuids for each item
idx2Notes = []; % indexes into items for the notes data
idx2Tags = [];% indexes into items for the tag data
isTrashed = false(nItems,1);% true for the trashed items
uuids = cell(nItems,1); % accumulate all uuids here
for ki = 1:nItems
    item = items{ki};
    uuids{ki} = item.uuid;
    type = item.content_type;
    if strcmpi(type,'note')
        idx2Notes = [idx2Notes; ki];
    elseif strcmpi(type,'tag')
        idx2Tags = [idx2Tags; ki];
    end
    if isfield(item.content,'trashed')
          % record trashed items
            isTrashed(ki) = true;
    end
    
end

if addTag2Notes
          % go through tag items to add the tag to each note referenced
    for idx2tag = idx2Tags(:)'
         if isTrashed(idx2tag) % do not process trashed tags
            continue
         end
        tagItem = items{idx2tag}; % the tag struct
        assert(strcmpi(tagItem.content_type,'tag')); % make sure got tag data
        refs = tagItem.content.references;
        nrefs = length(refs);
        for kref = 1:nrefs
              % for each reference add the tag title to the tagItem.content.tags struct field
            uuid = refs{kref}.uuid;
            idx2note = find(ismember(uuids,uuid)); % find the idx of note with the uuid
            assert(numel(idx2note)==1); % uuid is unique so only one match
            if isTrashed(idx2note) % do not process trashed notes
                continue
            end
            noteItem = items{idx2note}; % the selected note struct
            assert(strcmpi(noteItem.content_type,'note')); % should be a note
            if isfield(noteItem.content,'tags')
                  % if note already has tags field, append the current tag
                noteItem.content.tags = sprintf('%s,%s',noteItem.content.tags,tagItem.content.title);
            else
                noteItem.content.tags = tagItem.content.title; % make tags field with current tag
            end
            items{idx2note} = noteItem; % overwrite the old item with new one with tags field
        end 
    end
end

dat = GetWorkspace;