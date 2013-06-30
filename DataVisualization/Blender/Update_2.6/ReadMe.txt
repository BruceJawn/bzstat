barchart.py
==============
This file is adapted from the "Chapter02/README.txt" of the source code package for the book "Blender 2.49 Scripting".
(https://www.packtpub.com/blender-2-49-scripting-language/book)

Required Environment:

Blender 2.6.x (http://download.blender.org/)

How to run:

To create a barchart from a .csv file run the barchart.py script
(embedded in the barchart.blend file) from the command line (dos box).

Example:

"c:\Program Files\Blender Foundation\Blender\blender.exe" -b barchart.blend -P barchart.py -- data.csv

or,

"c:\Program Files\Blender Foundation\Blender\blender.exe" -P barchart.py -- data.csv

"c:\Program Files\Blender Foundation\Blender\blender.exe" -b -P barchart.py -- data.csv 
(No Blender to pop up.)

Of course your blender.exe might be in another location. The output of the script will be a 
.png file with the same name (but different extension) as the .csv file specified. The .png
file will be created in the current working directory.

Files:

bartchart.py    the bartchart.py script
data.csv	some example data
data.png	example output