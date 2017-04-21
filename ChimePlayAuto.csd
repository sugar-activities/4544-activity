; CHIMEPLAYAUTO (2012) for realtime Csound5 - by Arthur B. Hunkins
;   A custom autoplay version of SAMPLEPLAY for chime and bell samples (up to 8)
; ChimePlayAuto.csd - no MIDI device required
; 0-1 background loop, 1-8 single-shot samples of minimum 3-second duration
;   Files may be mono or stereo, must have same Sample Rate and agree with this SR.
; Choice of two chime sets; both default sets include 6 chimes and an ambient loop. 
;   Background loop must be named soundin.0 (set 1) or soundin.10 (set 2),
;   and samples labeled soundin.1 and up (set 1), or soundin.11 and up (set 2).
;   They must be placed in the same folder as this file.

<CsoundSynthesizer>
<CsOptions>

-odac -+rtaudio=alsa -m0d --expression-opt -b128 -B2048

</CsOptions>
<CsInstruments>

sr      = 44100
; change sample rate to 48000 (or 32000 if necessary) when 44100 gives no audio.
; (Necessary for Intel Classmate PC and some other systems.)
ksmps   = 100
nchnls  = 2

        seed    0
gifirst init    1
gilen   init    0

gibackgnd chnexport "Loop", 1
gibgmax   chnexport "Bgmax", 1
gistfade  chnexport "Stfade", 1
gisamps   chnexport "Samps", 1
gisset    chnexport "Sset", 1
girndsamp chnexport "Rndsamp", 1
girndrang chnexport "Rndrange", 1
gisampdur chnexport "Sampdur", 1
gipanpos  chnexport "Panpos", 1
gitotdur  chnexport "Totaldur", 1

gimindur1 chnexport "Min1", 1
gimaxdur1 chnexport "Max1", 1
gimindur2 chnexport "Min2", 1
gimaxdur2 chnexport "Max2", 1
gimindur3 chnexport "Min3", 1
gimaxdur3 chnexport "Max3", 1
gimindur4 chnexport "Min4", 1
gimaxdur4 chnexport "Max4", 1
gimindur5 chnexport "Min5", 1
gimaxdur5 chnexport "Max5", 1
gimindur6 chnexport "Min6", 1
gimaxdur6 chnexport "Max6", 1
gimindur7 chnexport "Min7", 1
gimaxdur7 chnexport "Max7", 1
gimindur8 chnexport "Min8", 1
gimaxdur8 chnexport "Max8", 1

	instr 1

kflag   init   0
kflag1  init   0
kflag2  init   0
kflag3  init   0
kflag4  init   0
kflag5  init   0
kflag6  init   0
kflag7  init   0
kflag8  init   0
ktime1  init   0
ktime2  init   0
ktime3  init   0
ktime4  init   0
ktime5  init   0
ktime6  init   0
ktime7  init   0
ktime8  init   0
kinst3  init   3
kinst4  init   4
kinst5  init   5
kinst6  init   6
kinst7  init   7
kinst8  init   8
kinst9  init   9
kinst10 init   10
gidur   =      (gitotdur == 0? 30: gitotdur * 60)
gktime  times
ibase   =       (gisset == 0? 0: 10)
        if gisamps == 0 igoto skip
ilen3   filelen 1 + ibase       
gilen   =       ilen3
        if gisamps == 1 igoto skip
ilen4   filelen 2 + ibase
gilen   =       (ilen4 > gilen? ilen4: gilen)
        if gisamps == 2 igoto skip        
ilen5   filelen 3 + ibase
gilen   =       (ilen5 > gilen? ilen5: gilen)
        if gisamps == 3 igoto skip        
ilen6   filelen 4 + ibase
gilen   =       (ilen6 > gilen? ilen6: gilen)
        if gisamps == 4 igoto skip        
ilen7   filelen 5 + ibase
gilen   =       (ilen7 > gilen? ilen7: gilen)
        if gisamps == 5 igoto skip        
ilen8   filelen 6 + ibase
gilen   =       (ilen8 > gilen? ilen8: gilen)
        if gisamps == 6 igoto skip        
ilen9   filelen 7 + ibase
gilen   =       (ilen9 > gilen? ilen9: gilen)
        if gisamps == 7 igoto skip        
ilen10  filelen 8 + ibase
gilen   =       (ilen10 > gilen? ilen10: gilen)
skip:        
        if ((gibackgnd == 0) || (kflag == 1)) goto skip2
kinstr  =       (gisset == 0? 2: 12)
        event  "i", kinstr, 0, gidur        
kflag   =      1
skip2:
        if gisamps == 0 goto end
ifade   =      (gibackgnd == 0? 0: gistfade)
        if gktime > (gidur - ifade - gilen) goto end        
        if gktime < ifade goto end
        if kflag1 == 1 goto skip3
k1      random gimindur1, gimaxdur1
ktime1  =      gktime + k1
kflag1  =      1
skip3:
        if gktime < ktime1 goto skip4
klen    =      (gisampdur < 3? ilen3: gisampdur) 
        event  "i", kinst3, 0, klen
kflag1  =      0
skip4:        
        if gisamps < 2 goto end      
        if kflag2 == 1 goto skip5
k2      random gimindur2, gimaxdur2
ktime2  =      gktime + k2
kflag2  =      1
skip5:
        if gktime < ktime2 goto skip6
klen    =      (gisampdur < 3? ilen4: gisampdur) 
        event  "i", kinst4, 0, klen
kflag2  =      0
skip6:        
        if gisamps < 3 goto end      
        if kflag3 == 1 goto skip7
k3      random gimindur3, gimaxdur3
ktime3  =      gktime + k3
kflag3  =      1
skip7:
        if gktime < ktime3 goto skip8
klen    =      (gisampdur < 3? ilen5: gisampdur) 
        event  "i", kinst5, 0, klen
kflag3  =      0
skip8:        
        if gisamps < 4 goto end      
        if kflag4 == 1 goto skip9
k4      random gimindur4, gimaxdur4
ktime4  =      gktime + k4
kflag4  =      1
skip9:
        if gktime < ktime4 goto skip10
klen    =      (gisampdur < 3? ilen6: gisampdur) 
        event  "i", kinst6, 0, klen
kflag4  =      0
skip10:        
        if gisamps < 5 goto end      
        if kflag5 == 1 goto skip11
k5      random gimindur5, gimaxdur5
ktime5  =      gktime + k5
kflag5  =      1
skip11:
        if gktime < ktime5 goto skip12
klen    =      (gisampdur < 3? ilen7: gisampdur) 
        event  "i", kinst7, 0, klen
kflag5  =      0
skip12:        
        if gisamps < 6 goto end      
        if kflag6 == 1 goto skip13
k6      random gimindur6, gimaxdur6
ktime6  =      gktime + k6
kflag6  =      1
skip13:
        if gktime < ktime6 goto skip14
klen    =      (gisampdur < 3? ilen8: gisampdur) 
        event  "i", kinst8, 0, klen
kflag6  =      0
skip14:        
        if gisamps < 7 goto end      
        if kflag7 == 1 goto skip15
k7      random gimindur7, gimaxdur7
ktime7  =      gktime + k7
kflag7  =      1
skip15:
        if gktime < ktime7 goto skip16
klen    =      (gisampdur < 3? ilen9: gisampdur) 
        event  "i", kinst9, 0, klen
kflag7  =      0
skip16:        
        if gisamps < 8 goto end      
        if kflag8 == 1 goto skip17
k8      random gimindur8, gimaxdur8
ktime8  =      gktime + k8
kflag8  =      1
skip17:
        if gktime < ktime8 goto end
klen    =      (gisampdur < 3? ilen10: gisampdur) 
        event  "i", kinst10, 0, klen
kflag8  =      0

end:    endin

        instr 2, 12

isamp   =       p1 - 2
ichans  filenchnls isamp
ibgmax =       gibgmax * .1   
kamp    linseg  0, gistfade, ibgmax, gidur - (gistfade * 2), ibgmax, gistfade, 0 
        if ichans == 2 goto skip
aout    diskin2 isamp, 1, 0, 1
        outs    aout * kamp, aout * kamp
        goto end
skip:
a1, a2  diskin2 isamp, 1, 0, 1
        outs    a1 * kamp, a2 * kamp

end:    endin

        instr 3, 4, 5, 6, 7, 8, 9, 10

isamp   =       (gisset == 0? p1 - 2: p1 + 8)
ichans  filenchnls isamp
ilen    filelen isamp
ilen    =       ((gisampdur == 2) || (gisampdur > ilen)? ilen: gisampdur)
;gilen   =       (ilen > gilen? ilen: gilen)
        if girndsamp > 0 goto skip
iamp    =      1
        goto skip2
skip:
iamp    random girndrang * .01, 1
iamp    =      (gifirst == 1? 1: iamp)
gifirst =      0
skip2:        
        if gipanpos = 0 goto skip3
ipan    linrand 1
        goto skip4
skip3:
ipan    =       .5
skip4:
kamp    linseg  0, .025, iamp * .5, p3 - 2.025, iamp * .5, 2, 0
        if ichans == 2 goto skip5
aout    diskin2 isamp, 1
a1,a2,a3,a4 pan aout, ipan, 1, 1, 1
        outs    a1 * kamp, a2 * kamp
        goto end
skip5:
aout,aout2 diskin2 isamp, 1
a1,a2,a3,a4 pan aout, ipan, 1, 1, 1
a5,a6,a7,a8 pan aout2, ipan, 1, 1, 1
        outs    (a1 + a5) * kamp, (a2 + a6) * kamp
                
end:    endin
       
</CsInstruments>

<CsScore>

f1 0 8193 9 .25 1 0
i1 0 3600

e

</CsScore>
</CsoundSynthesizer>
