# process-standardnotes-archive

[Standard notes](https://standardnotes.org/ "Standard Notes") is a notes app that is available on the desktop (Windows, Mac, Linux) and on portable devices (android and iOS).  It's free, open source and completely encrypted.  It also has a minimalist design, which is a good thing, but I want to extend its capabilities to export the notes.  
The app provides two decrypted formats.: One is a zip file with a text file for every note.  The other is a standard JSON archive with all the notes, tags and other elements of the database.
This repository contains functions to read in the JSON archive and convert the data:
1. Add the tags for each note item
2. Output the notes to separate files  with all the notes for each tag 
3. Output the notes, with tags, to separate text files for each note.

The code uses functions from the JSONlab package that is available for download on the Matlab file exchange

[JSONlab package download](https://www.mathworks.com/matlabcentral/fileexchange/33381-jsonlab-a-toolbox-to-encode-decode-json-files "JSONlab download")
