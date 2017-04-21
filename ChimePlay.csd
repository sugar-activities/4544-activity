; CHIMEPLAY (2012) for realtime Csound5 - by Arthur B. Hunkins
;   Custom version of SAMPLEPLAY for chime and bell samples (up to 8)
; Requires MIDI device with up to 8 keys, buttons or pads
;   optionally, keys/button/pads velocity sensitive
;   optionally, 1 additional key/button/pad and/or 1-3 MIDI knobs or sliders
; 0-1 background loop, 1-8 single-shot samples of minimum 3-second duration
;   Files may be mono or stereo, must have same Sample Rate and agree with this SR.
;   They may be a variety of uncompressed types including WAV and AIFF; also
;   Ogg/Vorbis (with Sugar 0.86/Blueberry or later, or Sugar 0.84/Strawberry
;   with updated libsndfile) but not MP3.
; Choice of two chime sets; both default sets include 6 chimes and an ambient loop. 
;   Background loop must be named soundin.0 (set 1) or soundin.10 (set 2),
;   and samples labeled soundin.1 and up (set 1), or soundin.11 and up (set 2).
;   They must be placed in the same folder as this file.

<CsoundSynthesizer>
<CsOptions>

-odac -+rtaudio=alsa -+rtmidi=alsa -M hw:1,0 -m0d --expression-opt -b128 -B2048 -+raw_controller_mode=1

</CsOptions>
<CsInstruments>

sr      = 44100
; change sample rate to 48000 (or 32000 if necessary) when 44100 gives no audio.
; (Necessary for Intel Classmate PC and some other systems.)
ksmps   = 100
nchnls  = 2

        seed    0
        massign 0, 0

gichan    chnexport "Chan", 1
gibackgnd chnexport "Backgnd", 1
gibgmax   chnexport "Bgmax", 1
gistctrl  chnexport "Stctrl", 1
gistnote  chnexport "Stnote", 1
gistfade  chnexport "Stfade", 1
gisamps   chnexport "Samps", 1
gisset    chnexport "Sset", 1
gisampamp chnexport "Sampamp", 1
girndrang chnexport "Rndrange", 1
gismpctrl chnexport "Smpctrl", 1
gisampdur chnexport "Sampdur", 1
gimidi1   chnexport "MIDI1", 1
gipanpos  chnexport "Panpos", 1
gipanctrl chnexport "Panctrl", 1

	instr 1

gkfreq  init   0
gkpan   init   .5
kflag   init   0
        if ((gibackgnd == 0) || (kflag == 1)) goto skip
kinstr  =      (gisset == 0? 2: 12)
        event  "i", kinstr, 0, -1
kflag   =      1
skip:
gkstat,gkchan,gkd1,gkd2 midiin
        if ((gkstat == 0) || (gkchan != gichan)) goto end               
        if ((gkstat != 144) || ((gkstat == 144) && (gkd2 == 0))) goto end               
	if ((gkd1 < gimidi1) || (gkd1 > (gimidi1 + (gisamps - 1)))) goto end       
kbase   =      gkd1 - gimidi1 + 1
kinstr  =      (gisset == 0? kbase + 2: kbase + 12)
        if gisampamp > 0 goto skip2
kamp    =      1
        goto skip3
skip2:
        if gisampamp > 1 goto skip4
kamp    random girndrang * .01, 1
        goto skip3
skip4:                                
        if gisampamp > 2 goto skip5                                                                    
kamp    =      gkd2 / 127
        goto skip3
skip5:        
kamp    ctrl7  gichan, gismpctrl, 0, 1
skip3:        
        if gipanpos = 0 goto skip6
        if gipanpos > 1 goto skip7       
gkpan   linrand 1
        goto skip6
skip7:
        if gipanpos > 2 goto skip8
gkpan   =      gkd2 / 127
        goto skip6        
skip8:
gkpan   ctrl7   gichan, gipanctrl, 0, 1
skip6:
        goto skip9
skip10:
isamp   =       i(kinstr) - 2
ilen    filelen isamp
        rireturn
skip9:        
        reinit skip10
        event  "i", kinstr, 0, ilen, kamp * .5, gkpan

end:    endin

        instr 2, 12

isamp   =      p1 - 2
kamp    init   0
ibgmax  =      gibgmax * .1 
ichans  filenchnls isamp
        if gibackgnd == 2 goto skip
        if ((gkstat == 144) && (gkd1 == gistnote) && (gkd2 > 0)) goto skip2
        goto skip3        
skip2:        
kamp    =      (kamp == 0? ibgmax: 0)
skip3:
kamp2   lineto kamp, gistfade
kamp2   =      (kamp2 < .01? 0: kamp2)
        goto skip4
skip:        
kamp2	ctrl7  gichan, gistctrl, 0, ibgmax
skip4:
        if ichans == 2 goto skip5
aout    diskin2 isamp, 1, 0, 1
        outs    aout * kamp2, aout * kamp2
        goto end
skip5:
a1, a2  diskin2 isamp, 1, 0, 1
        outs    a1 * kamp2, a2 * kamp2

end:    endin

        instr 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15, 16, 17, 18, 19, 20

isamp   =       p1 - 2
ichans  filenchnls isamp
ilen    =       ((gisampdur == 2) || (gisampdur > p3)? p3: gisampdur)
kamp    linsegr  0, .025, p4, ilen - 2.025, p4, 2, 0
        if ichans == 2 goto skip
aout    diskin2 isamp, 1
a1,a2,a3,a4 pan aout, p5, 1, 1, 1
        outs    a1 * kamp, a2 * kamp
        goto skip2
skip:
aout,aout2 diskin2 isamp, 1
a1,a2,a3,a4 pan aout, p5, 1, 1, 1
a5,a6,a7,a8 pan aout2, p5, 1, 1, 1
        outs    (a1 + a5) * kamp, (a2 + a6) * kamp
skip2:    
ktime   timeinsts
        if ktime < (ilen - 2) goto end
        turnoff
                
end:    endin
       
</CsInstruments>

<CsScore>

f1 0 8193 9 .25 1 0
i1 0 3600

e

</CsScore>
</CsoundSynthesizer>
