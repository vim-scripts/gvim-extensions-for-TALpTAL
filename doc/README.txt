GVIM Extensions for TAL/pTAL - Introduction
-------------------------------------------
These tools provides support in gvim for TAL/pTAL source files with syntax highlighting and tags. HP Nonstop (NSK) users who need to edit TAL/pTAL source files can use all features of gvim with the help of these tools. This is intended for use by developers when the source files have been copied to Windows. Reading and writing of files residing on NSK are not supported.

Syntax highlighting is provided for TAL/pTAL source files, which helps in simplifying complicated code. A tool is provided for building tags for TAL/pTAL source files similar to the tags built by ctags for C code. This helps in easy navigation of multiple source files and jumping directly to procedure definitions.


Installation
------------
Download and install gvim from www.vim.org (ftp://ftp.vim.org/pub/vim/pc/gvim71.exe). These tools are compatible with gvim version 7.1. If installation location is not C:\Program Files\Vim\vim71, change the VIMHOME variable in install.bat to refer to the appropriate directory. Run the install.bat script to copy the files required for the GVIM extensions. Only Windows platform is supported currently.


Syntax Highlighting
-------------------
Any .tal extension file will automatically have syntax highlighting when opened with GVIM.
To get TAL syntax highlighting for files without .tal extension, first choose the "Show filetypes in menu" option under the "Syntax" menu of GVIM and then choose the "Syntax->TUV->TAL" menu option. Alternately, use the ':cal SetSyn("tal")' GVIM command line option.

The below steps are needed only for building tags for your source. They are not required for just viewing your source using gvim.


Building Tags
-------------
If tags are to be built, copy the ttags directory to your machine. The install script copies the directory to c:\ttags.
From command prompt, do
	SET PATH=c:\ttags;%PATH%
Go to the directory containing source files (ex: c:\mysource). Run
	taltags *.tal
This will create a 'tags' file, overwriting any existing tags file in the current directory.
If your source files were not renamed as .tal, then you can run the command as
	taltags S* D*
		(assuming all your source files have names beginning with S or D).

Having all your source files with the .tal extension is better for using GVIM. To rename the source files, run one of these commands from the command prompt
   for %F in (*) do rename %F %F.tal
      or
   for %F in (S* D*) do rename %F %F.tal


Modify the last line of VIMHOME\syntax\tal.vim to change the path for loading tags. For example make it
	set tags=c:/mysource/my_product/tags,c:/mysource/my_product2/tags,./tags

   NOTE: The tags for TAL are built using a source line parser which does keyword matching. Tags are generated for declarations of procedures, subprocedures, literals, defines, structs and sections. Tags are not generated for variable declarations.


Sample Installation Steps 
-------------------------

i)    Execute gvim71.exe to install vim. 
ii)   Run install.bat to install the GVIM extensions.
iii)  FTP all your source files onto windows in ascii mode. Suppose ftp is done to c:\mysource directory. Rename the files to have .tal extension. To rename, run the command
        for %F in (*) do rename %F %F.tal
iv)   Do
	SET PATH=c:\ttags;%PATH%
        cd c:\mysource
        taltags *.tal
v)    Open the file VIMHOME\tal.vim and change the line 'set tags=./tags' to 'set tags=c:/mysource/tags,./tags'
vi)   Repeat steps (iii) to (v) for each directory containing your sources.
vii)  Your setup is done. Add VIMHOME (for example C:\Program Files\Vim\vim71) to your environment PATH variable to be able to start gvim from a command prompt. Or use the 'Edit with Vim' option which is shown by Explorer on right-clicking on any file.


GVIM Tips
---------
  Some useful commands for using GVIM with TAL are listed here. These assume that you have followed all of the steps above and are currently editing a file with .tal extension or have set the TAL syntax option. All these commands are for use in the gvim command mode only.

  * Position to any keyword (procedure name, subproc name, define, literal, structure name or section name). Press 'Ctrl-]' to jump to the first matching tag. Press 'g]' to see a list of matching tags, one among which can be jumped to using the corresponding index number. Press 'Ctrl-T' to go back to the original location before the tag jump.
  
  * Type ':ta tagname' to jump to the first match for tagname.
    Type ':ts tagname' to see a list of all matching tags for tagname.
    Type ':ts /tagname' to search for any tag which has tagname within it. All previous commands were exact searches.

  * Press '[[' to jump to the beginning of the current proc or subproc. If currently not in a proc or subproc, it goes to previous procedure, wrapping around if required.

  * Position to any begin/end statement and press 'Ctrl-M' to jump to the corresponding end/begin statement.
  * For other options, refer gvim help using the ':help' command.


Plugins
-------
  Some plugins are copied by the install script. These plugins have been modified to work with TAL files. The "TAGS" menu option is added by the tagmenu.tal plugin. This option is useful for navigating to any of the procedures or subprocedures of the source file easily. But this plugin can slow down the startup time of GVIM. The plugin can be disabled by renaming the file VIMHOME\plugin\tagmenu.vim to have some other extension.


Disclaimer
----------
  The tools above are provided 'as is where is'. The author is not responsible for any issues faced due to the use of these tools. Contact Ajay Kidave (ajayvk@gmail.com) for questions.
