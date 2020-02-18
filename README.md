# process-standardnotes-archive

[Standard notes](https://standardnotes.org/ "Standard Notes") is a notes app that is available on the desktop (Windows, Mac, Linux) and on portable devices (android and iOS).  It's free, open source and completely encrypted.  It also has a minimalist design, which is a good thing, but I want to extend its capabilities to export the notes to make it easy to import them to my desktop personal information manager (PIM) , Infoselect.  This can probably be used with other PIMs or notes apps.

To do this, I wrote Matlab code to write the notes for each tag to separate files. Then I can manually import the tags that interest me to Infoselect or other applications. The functions can be modified abd code added to export them to import them directly to your favorite app. Infoselect has poor import capabilities so I use the manual method.

The code should execute with the free, open source, Octave program although I haven't tested it.
https://www.gnu.org/software/octave/

StandardNotes provides two decrypted formats.: (1)a zip file with a text file for every note or (2) a standard JSON archive with all the notes, tags and other elements of the database.

The code in this repository uses the JSON archive. The code contains functions to read in the JSON archive then process all the notes
1. If a note has a tag, it is written to a separate text files for the tag. If the note has more than one tag, it is written to the text file for the first tag. If a note does not have a tag, it is written to the 'noTags.txt' file
2. The tag (or tags) are text strings and are prepended to the text for the note

The code is implemented in the Matlab ExportNotes2tags.m script. Other Matlab functions called are included in the code library.

The code uses functions from the JSONlab package that is available for download on the Matlab file exchange. This should be downloaded and the files placed on the Matlab path. It is NOT included with the code library here on Github

[JSONlab package download](https://www.mathworks.com/matlabcentral/fileexchange/33381-jsonlab-a-toolbox-to-encode-decode-json-files "JSONlab download")
