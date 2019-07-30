function nFilesWritten = WriteNotes2FilesByTags(dirName,dat)
% function nFilesWritten = WriteNotes2FilesByTags(dirName,dat)
% write the notes for each tag to separate files
% file name is tag
% if note has 2 tags, it gets written to first tag in JSON items only
% notes with no tags are written to noTag.txt
% inputs:
%     dirName: path to directory to write files. Must exist--NOT created by function
%     dat: a struct from the exported JSON file with data. see LoadStdNoteFromJSON
% outputs:
%     nFilesWritten: the number of files written
% REA 25/Jul/2019 10:22
% COPYRIGHT: © Robert E. Alvarez, 2019. All rights reserved.

validateattributes(dirName,{'char'},{'nonempty'},mfilename,'dirName',1);
if dirName(end) ~= filesep;
    dirName(end+1) = filesep;
end
validateattributes(dat,{'struct'},{'nonempty'},mfilename,'dat',2);

nFilesWritten = 0;
  % write note to only 1 file so keep track whether already written
noteWritten2File = false(dat.nItems,1); % true if note has been written to a file

   % go through tags to write their notes to file
for idx2tag = dat.idx2Tags(:)'
    if dat.isTrashed(idx2tag) % do not processed trashed tags
        continue
    end
    tagItem = dat.items{idx2tag}; % the tag struct
    assert(strcmpi(tagItem.content_type,'tag')); % make sure got tag data
    refs = tagItem.content.references;
    nrefs = length(refs);
    assert(nrefs>0); % tag should point to at least one note
    fp = []; % pointer to file for this tag. will create if necessary
    for kref = 1:nrefs
        uuid = refs{kref}.uuid;
        idx2note = find(ismember(dat.uuids,uuid)); % find the idx of note with the uuid
        assert(numel(idx2note)==1); % uuid is unique so only one match
                % do not write if ref is a trashed note or already written
       if (~dat.isTrashed(idx2note)) && (~noteWritten2File(idx2note))
               % if have not started writing to a file for this tag, create one
                if isempty(fp)
                    nFilesWritten = nFilesWritten+1;
                    fname = [dirName cleanTitleLoc(tagItem.content.title) '.txt'];
                    fp = fopen(fname,'w'); % open for writing
                    assert(fp>0); % no error on open
                end
                noteItem = dat.items{idx2note}; % the selected note struct
                assert(strcmpi(noteItem.content_type,'note')); % should be a note
                  % write note out
                fprintf(fp,'\n--------------- %s -------------\n',noteItem.content.title);
                WriteStdNote(fp,noteItem); % write out the noteItem including tags to a file
                noteWritten2File(idx2note) = true;                          
        end
    end    
    if ~isempty(fp)
        fclose(fp);
    end
end
      % write out untrashed notes with no tags i.e. not written to any file yet
allNotes = false(dat.nItems,1);
allNotes(dat.idx2Notes) = true;
notesNotWritten = allNotes & (~noteWritten2File) & (~dat.isTrashed);
if any(notesNotWritten)
    idx2NotesNotWritten = find(notesNotWritten);
    assert(numel(idx2NotesNotWritten)>0); % should be at least one note not written
    nFilesWritten = nFilesWritten+1;
    fname = [dirName 'noTags.txt'];
    fp = fopen(fname,'w'); % open for writing
    assert(fp>0); % no error on open
    for ki = idx2NotesNotWritten(:)'
        noteItem = dat.items{ki}; % the selected note struct
        assert(strcmpi(noteItem.content_type,'note')); % should be a note
          % write note out
        fprintf(fp,'\n--------------- %s -------------\n',noteItem.content.title);
        WriteStdNote(fp,noteItem); % write out the noteItem including tags to a file
        noteWritten2File(idx2note) = true;
    end
    fclose(fp);
end
        

%----------- LOCAL FUNCTIONS -------------------
function tclean = cleanTitleLoc(title)
    fnameStripRegExp = '[ ]+|[-]+'; % regular expression for symbols to delete from file name
       % clean a title to be used as a filename
    
    title = regexprep(title,fnameStripRegExp,'_');
       % get rid of more illegal symbols from file name
    title = regexprep(title,'\?','_'); % question mark
    title = regexprep(title,'\\','_'); % backward slash
    title = regexprep(title,'\/','_'); % forward slash
    tclean = regexprep(title,'\"','_'); % quotation mark
   
