# process-standardnotes-archive

[Standard notes](https://standardnotes.org/ "Standard Notes") is a notes app that is available on the desktop (Windows, Mac, Linux) and on portable devices (android and iOS).  It's free, open source and completely encrypted.  It also has a minimalist design, which is a good thing, but I want to extend its capabilities to export the notes to make it easy to import them to my desktop personal information manager (PIM) , Infoselect.  This can probably be used with other PIMs or notes apps.

To do this, I wrote Matlab code to write the notes for each tag to separate files. Then I can manually import the tags that interest me to Infoselect or other applications. The functions can be modified abd code added to export them to import them directly to your favorite app. Infoselect has poor import capabilities so I use the manual method.

The code should execute with the free, open source, Octave program although I haven't tested it.
https://www.gnu.org/software/octave/

The app provides two decrypted formats.: One is a zip file with a text file for every note.  The other is a standard JSON archive with all the notes, tags and other elements of the database.

The code in this repository contains functions to read in the JSON archive and convert the data:
1. Add the tags for each note item
2. Output the notes, with tags, to separate text files for each note. This is implemented in the ExportNotes2tags.m script

The code uses functions from the JSONlab package that is available for download on the Matlab file exchange. This should be downloaded and the files placed on the Matlab path. 

[JSONlab package download](https://www.mathworks.com/matlabcentral/fileexchange/33381-jsonlab-a-toolbox-to-encode-decode-json-files "JSONlab download")
