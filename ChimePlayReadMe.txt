CHIMEPLAY and CHIMEPLAYAUTO - Sugar Activity/Linux version - Notes
Art Hunkins
abhunkin@uncg.edu
www.arthunkins.com


Working with User Soundfiles

The ChimePlay utility series includes ChimePlay (requiring a MIDI
controller) and ChimePlayAuto (which is self-performing and needs no
MIDI device). Both can handle mono or stereo soundfiles, up to 8
chime or bell samples and a single optional background loop. The
files can be of any sample rate and a variety of uncompressed formats
including WAV and AIFF; also Ogg/Vorbis, but not MP3. The Ogg/Vorbis
format is only possible when the Sugar version is later than 0.84;
this excludes the original XO-1 and SoaS (Sugar-on-a-Stick)
Strawberry.

*However*, the ogg vorbis format (which is written by later versions
of the Record activity) *can* be used by SoaS (Strawberry) 0.84 if
libsndfile is updated. This can be done while connected to the
internet by issuing the following commands in the Terminal:
  su <Enter>
  yum update libsndfile <Enter>
Neither the XO-1.5, nor XO-1 upgraded to Sugar 0.84 require this mod.

Students are encouraged to create their own soundfiles, especially to
make their own windchime or bell collections. (This is the primary
intent behind these utilities.) The two 6-chime sets included here
are from the St. Francis Prayer Center in Stoneville, NC (USA). Set
one consists of recordings of chimes located under an interior cupola
opposite the Chapel. The second is a set found on the patio of the
Center's main building. Soundin.1 through soundin.6 and background
loop soundin.0 comprise set one (the inside set); soundin.11 through
soundin.16 and ambient loop soundin.10 are set two (the outside
chimes). Soundin.7, 8, 17 and 18 are dummy samples that complete the
possible sets of 8. The optional ambient loops can help mask and
"homogenize" unwanted noise that may be present in the samples.

These samples were created with a high-quality handheld digital
recorder (at 44100Hz sample rate stereo, uncompressed WAV) using its
built-in mike. Sounds were then selected, edited and looped in
Audacity (see below). It was important to record all sounds in the
same environment and at the same level. An ambient background loop
of the location helped mask unwanted noise (as did the high pass
filter effect available in Audacity - cutoff frequency = 661Hz).

The natural vehicle for soundfile creation is the Record activity.
This activity is fairly simple and straightforward; the only problem
is that many versions of it do not work with various incarnations of
Sugar. The following pairings of Record with Sugar seem to work
reliably: v86 with XO-1.5 and XO-1 upgraded to Sugar 0.84, Sugar-on-
a-Stick Strawberry (0.84) and Blueberry (0.86). Sugar 0.86 and above
(as of 3/2012) are compatible with Record v90, including XO's
updated to at least 0.90. Please note that Record prior to v74
(except for v61-64) produce ogg *speex* files; these files are
incompatible with ChimePlay. Though the Record activity produces
mono files only, at 16000Hz, such samples are nevertheless quite
useable.

Soundfiles must be moved into the folder where this file resides,
and be renamed soundin.0 or soundin.10 (for the background loop) and
soundin.1 or soundin.11 through soundin.8 or .18 (for the samples).
Rename them in the Journal (where Record deposits its files), then
click/drag samples to an external USB stick.

Unfortunately, no other Sugar activity (including TimeLapse,
ShowNTell, and most importantly, Etoys) produces soundfiles useable
by ChimePlay. Either they write files other than Ogg Vorbis or wav,
or are restricted to Sugar 0.82.

More advanced users may wish to record their soundfiles on some other
system, and copy the files to a USB drive with an appropriate
soundin.x filename. Then recopy the samples (in the Terminal, from
the ChimePlay.activity folder) to their new location.
[cp /media/USBname/soundin.x soundin.x]

Otherwise, adventurous users may run the fine Audacity application to
record and edit. (Happily, none of the limitations of the Record
activity apply here.) In the Terminal, connected to the web, enter:
  su <Enter>
  yum import audacity <Enter>
  ...
  audacity <Enter>
(you are now running Audacity from the Terminal).

When you are finished recording and editing (including auditioning
the background loop in loop mode), pay particular attention to making
the loop point as inconspicuous as possible), "Export" the file in
wav or ogg vorbis format, saving it to a USB drive with appropriate
filename (soundin.x). It can then be copied to your
ChimePlay.activity folder. Since your chime/bell sets are on a
USB drive they can easily be shared with other students.


MIDI Controller Hints (ChimePlay only)

Important: The controller must be attached AFTER boot, and BEFORE
the MIDI version is selected. It is assumed that the controller is a
USB device.

ChimePlay was specifically designed for minimal (8-9 key) velocity-
sensitive MIDI keyboards, preferably those with 1 or 2 additional
sliders or modulation wheels (rotary knobs are OK, but not as easy to
work with). Suggested inexpensive USB models: Alesis Q25, Akai LPK25
(no sliders/knobs), Korg nanoKey (no sliders/knobs and rather flimsy
construction), M-audio O2, and M-audio Oxygen8.

The Korg nanoKontrol is an adequate, if not ideal mini-controller for
ChimePlay; unfortunately, its numerous buttons, which can issue MIDI
note data (it has no pads or keys), are not velocity-sensitive. One of
its four "Scenes" must be significantly reprogrammed by the Korg
Kontrol Editor to function with ChimePlay. Though it has a multitude
of programmable sliders and knobs, unfortunately the buttons are not
laid out well for ChimePlay performance.


No Sound - Sample Rate Issues

On a few systems, e.g. the Intel Classmate PC, the specified sr
(sample rate) of 44100 may not produce audio. Substitute a rate of
48000 (or, if necessary, 32000) toward the beginning of each .csd
file, using a text editor. (The sample rate, sr, is specified on
line 24 of ChimePlay.csd, and line 19 of ChimePlayAuto.csd.)


Audio Glitching/Breakup

If you get audio glitching, open Sugar's Control Panel, and turn off
Extreme power management (under Power) or Wireless radio (under
Network). A more drastic solution is to reduce textural density
(fewer chimes, fewer chimes ringing simultaneously). It is also
possible to lower the sample rate to 32000 or even 24000 (see above).

Stereo headphones (an inexpensive set will work fine) or external
amplifier/speaker system are highly recommended. Speakers built into
computers are fairly worthless musically.


Resizing the Font

The font display of this activity can be resized in csndsugui.py,
using any text editor. Further instructions are found toward the
beginning of csndsugui.py. (Simply change the value of the "resize"
variable (= 0), plus or minus.)


Further relevent items of interest may be found in the document
ChimePlay.txt on the author's website. (It is the text file
associated with the *all-platform* non-Sugar version of ChimePlay.)
