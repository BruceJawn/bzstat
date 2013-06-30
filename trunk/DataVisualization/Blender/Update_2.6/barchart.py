__author__    = "Bruce Zhou"
__version__   = "0.1 2013/06/16"
__copyright__ = "copyright 2013 Bruce Zhou."
__url__       = ["author's site, http://bzstat.wordpress.com"]

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


import bpy
from csv import DictReader
from math import pi
import sys


def label(text,position,orientation='z'):
       """
       draw a label
       """
       bpy.ops.object.text_add(location=position,rotation=(pi/2,0,pi))
       ob = bpy.context.object
       ob.name = 'LabelText'
       tcu = ob.data
       tcu.name = 'LabelTextData'
       # TextCurve attributes
       tcu.body = text

       if orientation=='x':
              ob.rotation_euler=(-pi/2.0,0,0)
       elif orientation=='z':
              ob.rotation_euler=(0,0,pi/2.0)
       print('label %s at %s along %s' %(text,position,orientation))


def bar(value,position,shape='Cube'):
       """
       draw a 3D bar
       """
       bpy.ops.mesh.primitive_cube_add(view_align=False,enter_editmode=False,
                                       location=(0,0,0),rotation=(0.0, 0.0, 0.0)) 
       ob = bpy.context.object
       ob.dimensions.xyz = (0.9, float(value), 0.9)
       ob.location =(position[0],position[1]+float(value)/2,position[2])
       print ('%s-bar height %s at %s' %(shape,value,position))

def barchart(filename):
       """
       draw the bar-chart and return the center position of the chart   
       """
       csv = open(filename)
       data = DictReader(csv)#standard csv Python module to read the data 
       
       xlabel = data.fieldnames[0]#column headers
       print (xlabel)
       rows = [d for d in data]#other data
       print (rows)
	#find the extremes of the data
       maximum = max([float(r[n]) for n in data.fieldnames[1:] for r in rows])
       minimum = min([float(r[n]) for n in data.fieldnames[1:] for r in rows])
       print (maximum)
       print (minimum)
       
       for x,row in enumerate(rows):
              lastx=x
              label(row[xlabel],(x,10,0))#draw row label
              for y,ylabel in enumerate(data.fieldnames[1:]):
                     bar(10.0*(float(row[ylabel])-minimum)/maximum,(x,0,y+1))#draw the bar for each column of row x
       x = lastx+1
       for y,ylabel in enumerate(data.fieldnames[1:]):
              label(ylabel,(x,0,y+1),'x')#draw column label
       return (lastx/2.0,6.0,0.0)#return the center position of the chart

def removeobjects():
       sc = bpy.context.scene
       for ob in sc.objects:
              sc.objects.unlink(ob)
              
def addcamera(center):
       sc =  bpy.context.scene
       bpy.ops.object.add(type='CAMERA',location=(center[0],center[1],center[2]+28.0),rotation=(0,0,0))

       ob = bpy.context.object
       ob.name = 'MyCamOb'
       cam = ob.data
       cam.name = 'MyCam'
       cam.type = 'PERSP'
       #cam.angle = -75
       sc.camera=ob

def addlamp(loc=(0.0,0.0,10.0)):
       sc = bpy.context.scene
       bpy.ops.object.add(type='LAMP',location=loc)
       #ob = bpy.context.object
       #lamp = ob.data

if __name__ == '__main__':
       removeobjects()
       w=bpy.context.scene.world
       w.horizon_color = (1, 1, 1)
       w.zenith_color = (1, 1, 1)
       csv = sys.argv[-1]#get the input file name
       if csv.endswith('.csv'):
              sc=bpy.context.scene
              sc.world=w
              center = barchart(sys.argv[-1])
              addcamera(center)
              addlamp()
              bpy.ops.render.render()
              bpy.data.images['Render Result'].save_render(filepath=csv[:-4]+'.png') 
       else:
              print ('input file has no .csv extension')
else:
       print (__name__)
