__author__    = "Michel Anders (varkenvarken)"
__version__   = "1.0 2009/07/28"
__copyright__ = "copyright 2009,2010 Michel J. Anders."
__url__       = ["author's site, http://www.swineworld.org"]

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


from Blender import Scene,Mesh,Window,Camera,Lamp,Text3d,World
from csv import DictReader
import sys

from math import pi

def label(text,position,orientation='z'):
	"""
	  draw a label
	  """
	txt=Text3d.New('label')
	txt.setText(text)
	ob=Scene.GetCurrent().objects.new(txt)
	ob.setLocation(*position)
	if orientation=='x':
		ob.setEuler(-pi/2.0,0,0)
	elif orientation=='z':
		ob.setEuler(0,0,pi/2.0)
	print 'label %s at %s along %s' %(text,position,orientation)
    
def bar(value,position,shape='Cube'):
	"""
	  draw a 3D bar
	  """
	print 'bar'
	me = Mesh.Primitives.Cube(1.0)
	print 'mesh added'
	sc = Scene.GetCurrent()
	print 'got scene'
	ob = sc.objects.new(me,'Mesh')
	print 'object added'
	ob.setLocation(position[0],position[1]+float(value)/2,position[2])
	print 'location set'
	ob.setSize(0.9,float(value),0.9)
	print '%s-bar height %s at %s' %(shape,value,position)

def barchart(filename):
	"""
	  draw the bar-chart and return the center position of the chart
	  """    
	csv = open(filename)
	data = DictReader(csv)#standard csv Python module to read the data 
	
	xlabel = data.fieldnames[0]#column headers
	print xlabel
	rows = [d for d in data]#other data
	print rows
	#find the extremes of the data
	maximum = max([float(r[n]) for n in data.fieldnames[1:] for r in rows])
	minimum = min([float(r[n]) for n in data.fieldnames[1:] for r in rows])
	print maximum
	print minimum
				
	for x,row in enumerate(rows):
	    lastx=x
	    label(row[xlabel],(x,10,0))#draw row label
	    for y,ylabel in enumerate(data.fieldnames[1:]):
	        bar(10.0*(float(row[ylabel])-minimum)/maximum,(x,0,y+1))#draw the bar for each column of row x
	x = lastx+1
	for y,ylabel in enumerate(data.fieldnames[1:]):
	    label(ylabel,(x,0,y+0.5),'x')#draw column label
	    
	#Window.RedrawAll()
	
	return (lastx/2.0,5.0,0.0)#return the center position of the chart


def removeobjects():
	sc = Scene.GetCurrent()
	for ob in sc.objects:
		sc.objects.unlink(ob)
		
def addcamera(center):
	sc = Scene.GetCurrent()
	ca = Camera.New('persp','Camera')
	ca.angle=75.0
	ob = sc.objects.new(ca)
	ob.setLocation(center[0],center[1],center[2]+12.0)
	sc.objects.camera=ob

def addlamp(loc=(0.0,0.0,10.0)):
	sc = Scene.GetCurrent()
	la = Lamp.New('Lamp')
	ob = sc.objects.new(la)
	ob.setLocation(*loc)


if __name__ == '__main__':
	w=World.New('BarWorld')
	w.setHor([1,1,1])
	w.setZen([1,1,1])
	csv = sys.argv[-1]#get the input file name
	if csv.endswith('.csv'):
		sc=Scene.New('BarScene')
		sc.world=w
		sc.makeCurrent()
		center = barchart(sys.argv[-1])
		addcamera(center)
		addlamp()
		#render and save the image
		context=sc.getRenderingContext()
		context.setImageType(Scene.Render.PNG)
		context.render()
		context.setRenderPath('')
		context.saveRenderedImage(csv[:-4]+'.png')
		
	else:
		print 'input file has no .csv extension'
else:
	print __name__
