# CHIMEPLAY - Chime and Bell Player Utilities for Children (2011)
#    Custom versions of SAMPLEPLAY for windchime and bell sample sets
# Art Hunkins (www.arthunkins.com)
#   
#    ChimePlay is licensed under the Creative Commons Attribution-Share
#    Alike 3.0 Unported License. To view a copy of this license, visit
#    http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to
#    Creative Commons, 171 Second Street, Suite 300, San Francisco,
#    California, 94105, USA.
#
#    It is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# version 2:
#    bug fix

import csndsugui
from sugar.activity import activity
import gtk
import os

class ChimePlay(activity.Activity):

 def __init__(self, handle):
  
   activity.Activity.__init__(self, handle)

   red = (0xDDDD, 0, 0)
   brown = (0x6600, 0, 0)
   green = (0, 0x5500, 0)

   win = csndsugui.CsoundGUI(self)
   width = gtk.gdk.screen_width()
   height = gtk.gdk.screen_height()
   if os.path.exists("/etc/olpc-release") or os.path.exists("/sys/power/olpc-pm"):
     adjust = 78
   else:
     adjust = 57
   screen = win.box()
   screen.set_size_request(width, height - adjust)
   scrolled = gtk.ScrolledWindow()
   scrolled.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
   screen.pack_start(scrolled)
   all = gtk.VBox()
   all.show()
   scrolled.add_with_viewport(all)
   scrolled.show()

   win.text("<big><b><big><u>CHIMEPLAY</u> - Chime and Bell Player \
Utilities for Children (2012)</big></b>\n\
\t\t\t    Art Hunkins (www.arthunkins.com)</big>", all)

   win.text("\
<b>ChimePlay</b> and <b>ChimePlayAuto</b> are custom versions of SAMPLEPLAY \
for sets of up to 8 windchimes or bells.\t\t\n\
Two sets of 6 chimes (plus ambient loop) are included. \
You are urged to create your own (see ChimePlayReadMe.txt).  ", all, brown)
   win.text("<b>ChimePlay</b> requires MIDI controller, \
one key/button/pad per active chime and loop (optionally velocity-sensitive);\t\nalso \
(optionally) an additional key/button/pad and/or 1-2 MIDI knobs/sliders. \
All samples/MIDI notes are consecutive.\t", all, green)
   win.text("\
<i><b>MIDI</b>: plug in controller after boot &amp; before selecting version. \
Zero controls before start; reset pan to .5 afterward.</i>\t", all, green)
   win.text("<b>ChimePlayAuto</b> doesn't involve MIDI. \
You specify the random range in seconds between \
repeats of a given chime.\t", all, brown)

   nbox = win.box(False, all)
   self.b2box = win.box(False, all)
   self.b3box = win.box(False, all)
   but1 = win.cbbutton(nbox, self.version1, "     1 ChimePlay      ")
   but1.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   but1.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))
   but2 = win.cbbutton(nbox, self.version2, " 2 ChimePlayAuto ")
   but2.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   but2.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))
   win.text("<b>    MIDI DEVICE REQUIRED</b> for ChimePlay", nbox, green)

   bbox = win.box(False, all)
   self.bb = bbox
   bbox2 = win.box(False, all)
   self.bb2 = bbox2
   self.w = win
   self.r = red
   self.g = green
   self.br = brown
   self.ver = 0

 def playcsd(self, widget):
   if self.p == False:
     self.p = True
     self.w.play()
     self.but.child.set_label("STOP !")
     self.but.child.set_use_markup(True)
     self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0xFFFF, 0, 0))
     self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0xFFFF, 0, 0))
   else:
     self.p = False
     self.w.recompile()
     self.w.channels_reinit()
     self.but.child.set_label("START !")
     self.but.child.set_use_markup(True)
     self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
     self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))

 def version1(self, widget):
   if self.ver != 0:
     self.box1.destroy()
     self.box2.destroy()
     self.box3.destroy()
   self.ver = 1
   self.box1 = self.w.box(True, self.bb)
   self.w.text("", self.box1)
   self.box2 = self.w.box(True, self.bb)
   self.f = self.w.framebox(" <b>1 - ChimePlay</b> ", False, self.box2, self.r)
   self.b1 = self.w.box(True, self.f)
   self.b2 = self.w.box(True, self.f)
   self.b3 = self.w.box(True, self.f)
   self.b4 = self.w.box(True, self.f)
   self.b5 = self.w.box(True, self.f)
   self.b6 = self.w.box(True, self.f)
   self.w.reset()
   self.w.csd("ChimePlay.csd")
   self.w.spin(1, 1, 16, 1, 1, self.b1, 0, "Chan", "Channel #")
   self.w.spin(2, 0, 2, 1, 1, self.b1, 0, "Backgnd", "Background Loop\n\
[0=none 1=note\n  2=controller]")
   self.w.spin(10, 0, 20, 1, 1, self.b1, 0, "Bgmax", "Loop Lev [10=norm]")
   self.w.spin(7, 0, 127, 1, 1, self.b2, 0, "Stctrl", "Loop Controller #") 
   self.w.spin(84, 0, 127, 1, 1, self.b2, 0, "Stnote", " Loop Note\n\
(start/stop)")
   self.w.spin(5, 1, 30, 1, 1, self.b2, 0, "Stfade", "Start/Stop Secs")
   self.w.spin(6, 0, 8, 1, 1, self.b3, 0, "Samps", "# of Samples")
   self.w.spin(1, 0, 3, 1, 1, self.b3, 0, "Sampamp", "Sample Level Ctrl\n\
[0=none 1=rand\n2=note vel 3=ctrl]")
   self.w.spin(21, 0, 127, 1, 1, self.b3, 0, "Smpctrl", "Samp Lev Ctrl #")
   self.w.spin(10, 10, 100, 1, 1, self.b4, 0, "Rndrange", "Lowest Rand Amp\n\
    Level [as %]")
   self.w.spin(2, 2, 20, 1, 1, self.b4, 0, "Sampdur", "   Chime Duration\n\
[2=natural  >2=dur\nin secs if < natural]")
   self.w.spin(60, 0, 120, 1, 1, self.b5, 0, "MIDI1", "1st MIDI Note #")
   self.w.spin(0, 0, 3, 1, 1, self.b5, 0, "Panpos", " Pan Pos Control\n\
[0=none 1=rand\n2=note vel 3=ctrl]")
   self.w.spin(20, 0, 127, 1, 1, self.b5, 0, "Panctrl", "Pan Position Ctrl #")
   self.w.button(self.b6, "Sset", "Chime Set 2?")
   self.p = False
   self.w.text("\n<i>Select options first </i>", self.b6, self.g)
   self.but = self.w.cbbutton(self.b6, self.playcsd, "START !")
   self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))

 def version2(self, widget):
   if self.ver != 0:
     self.box1.destroy()
     self.box2.destroy()
     self.box3.destroy()
   self.ver = 2
   self.box1 = self.w.box(True, self.bb)
   self.w.text("    ", self.box1)
   self.box2 = self.w.box(True, self.bb)
   self.f = self.w.framebox(" <b>2 - ChimePlayAuto</b> ", False, self.box2, self.r)
   self.b1 = self.w.box(True, self.f)
   self.b2 = self.w.box(True, self.f)
   self.b3 = self.w.box(True, self.f)
   self.b4 = self.w.box(True, self.f)
   self.b5 = self.w.box(True, self.f)
   self.b6 = self.w.box(True, self.f)
   self.w.reset()
   self.w.csd("ChimePlayAuto.csd")
   self.w.spin(1, 0, 60, 1, 1, self.b1, 0, "Totaldur", "Total Dur (mins)\n\
  [0=30 secs]")
   self.w.button(self.b1, "Loop", "Background Loop?", 1)
   self.w.spin(10, 0, 30, 1, 1, self.b2, 0, "Bgmax", "Loop Lev [10=norm]")
   self.w.spin(5, 1, 30, 1, 1, self.b2, 0, "Stfade", "Start/Stop Seconds")
   self.w.spin(6, 0, 8, 1, 1, self.b3, 0, "Samps", "# of Samples")
   self.w.button(self.b3, "Rndsamp", "Rand Samp Lev?", 1)
   self.w.spin(10, 0, 100, 1, 1, self.b4, 0, "Rndrange", "Lowest Random\n\
Amp Lev [as %]")
   self.w.button(self.b4, "Sset", "Chime Set 2?")
   self.w.spin(2, 2, 20, 1, 1, self.b5, 0, "Sampdur", "   Sample Dur\n   [2=natural\n\
>2=dur in secs\n  if < natural]")
   self.w.button(self.b6, "Panpos", "Rand Pan Pos?")
   self.w.text("<i> Select options\n\tfirst</i>", self.b6, self.g)
   self.but = self.w.cbbutton(self.b6, self.playcsd, "START !")
   self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))
   self.p = False

   self.box3 = self.w.box(False, self.bb2)
   self.b7 = self.w.box(True, self.box3)
   self.b8 = self.w.box(True, self.box3)
   self.b9 = self.w.box(True, self.box3)
   self.b10 = self.w.box(True, self.box3)
   self.b11 = self.w.box(True, self.box3)
   self.b12 = self.w.box(True, self.box3)
   self.b13 = self.w.box(True, self.box3)
   self.b14 = self.w.box(True, self.box3)
   self.b15 = self.w.box(True, self.box3)
   self.w.text("Min/Max\nRandom\nSeconds\n\
between\nChimes", self.b7, self.br)
   self.w.spin(2, 1, 30, 1, 1, self.b8, 0, "Min1")
   self.w.spin(5, 1, 30, 1, 1, self.b8, 0, "Max1")
   self.w.spin(2, 1, 30, 1, 1, self.b9, 0, "Min2")
   self.w.spin(5, 1, 30, 1, 1, self.b9, 0, "Max2")
   self.w.spin(2, 1, 30, 1, 1, self.b10, 0, "Min3")
   self.w.spin(5, 1, 30, 1, 1, self.b10, 0, "Max3")
   self.w.spin(2, 1, 30, 1, 1, self.b11, 0, "Min4")
   self.w.spin(5, 1, 30, 1, 1, self.b11, 0, "Max4")
   self.w.spin(2, 1, 30, 1, 1, self.b12, 0, "Min5")
   self.w.spin(5, 1, 30, 1, 1, self.b12, 0, "Max5")
   self.w.spin(2, 1, 30, 1, 1, self.b13, 0, "Min6")
   self.w.spin(5, 1, 30, 1, 1, self.b13, 0, "Max6")
   self.w.spin(2, 1, 30, 1, 1, self.b14, 0, "Min7")
   self.w.spin(5, 1, 30, 1, 1, self.b14, 0, "Max7")
   self.w.spin(2, 1, 30, 1, 1, self.b15, 0, "Min8")
   self.w.spin(5, 1, 30, 1, 1, self.b15, 0, "Max8")
