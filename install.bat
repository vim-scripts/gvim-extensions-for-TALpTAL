@echo off
echo Please install gvim before running this script.
echo Change VIMHOME variable to point to the installation directory.

set VIMHOME="C:\Program Files\Vim\vim71"

mkdir c:\ttags

copy /Y ttags\* c:\ttags\*
copy /Y makemenu.vim %VIMHOME%
copy /Y synmenu.vim %VIMHOME%
copy /Y filetype.vim %VIMHOME%
copy /Y tal.vim %VIMHOME%\syntax 
copy /Y plugin\* %VIMHOME%\plugin
