(
//Synth 1
SynthDef(\bass, {| amp = 0.2, lf = 100, rq = 0.9, envdur = 0.1, gate = 1,
	freqs = #[220, 440, 880, 1760],
    amps=#[0.1, 0.23, 0.12, 0.05],
    phases=#[1, 1.5, 2, 2.5]|
	var env, sig;
	env = EnvGen.kr(Env.sine(envdur), gate, doneAction: 2);
	sig = DynKlang.ar(`[freqs, amps, phases]);
	sig = RLPF.ar(sig, lf, rq);
	Out.ar(0, Pan2.ar(sig * env, 0, amp));
}).add;

//Synth 2
SynthDef(\hat, {| freq = 6000, amp = 0.6, amp2 = 0.9, filfreq = 5000, rq = 0.2, gate = 1 |
	var sig, env, sig2;
	sig = LFPar.ar(freq);
	sig = RHPF.ar(sig, filfreq, rq, sig*0.1);
	sig2 = Impulse.ar(0, mul: amp2);
	env = EnvGen.kr(Env.perc(0.05, 0.2), gate, doneAction: 2);
	Out.ar(0, Pan2.ar(sig2 + sig * env, 0, amp));
}).add;

//Synth 3
SynthDef(\tak, {| freq = 300, modfreq = 5, amp = 0.6, amp2 = 0.9, filfreq = 3200, rq = 0.1, gate = 1,
	atTime = 0.1, susTime = 2.0, relTime = 0.9, pan = 0 |
	var sig, env, sig2, del, mod;
	mod = LFSaw.kr(1/10, add: 1);
	sig = LFCub.ar(freq, mod);

	sig2 = Impulse.ar(0, mul: amp2);

	sig = BPF.ar((sig+sig2), filfreq, rq, sig*0.3);

	sig = DelayN.ar(sig, 0.4, 0.1, add: sig*0.3);

	env = EnvGen.kr(Env.linen(atTime, susTime, relTime), gate, doneAction: 2);
	Out.ar(0, Pan2.ar((sig) * env, pan, amp));
}).add;



//Synth 4
SynthDef(\dd, {| freq = 1, modfreq = 5, amp = 0.6, amp2 = 0.9, filfreq = 300, rq = 0.1, gate = 1,
	atTime = 0.1, susTime = 0.1, relTime = 0.9, pan = 0 |
	var sig, env, sig2, del, mod;
	sig = Blip.ar(freq);

	sig2 = Impulse.ar(0, mul: amp2);
	sig = LPF.ar(sig, filfreq);
	env = EnvGen.kr(Env.linen(atTime, susTime, relTime), gate, doneAction: 2);
	//env = EnvGen.kr(Env.perc(atTime, relTime), gate, doneAction: 2);
	Out.ar(0, Pan2.ar((sig + sig2) * env, pan, amp));
}).add;



)

{Blip.ar(2, 80, mul: 0.05)!2}.play;

a = Synth(\dd, [\freq, 1, \amp, 1])

s.meter;

FreqScope.new
s.recHeaderFormat = 'wav';
s.prepareForRecord; // you have to call this first
s.record;
s.stopRecording;

(//Pattern
var bassFreq = 76, bassFreqMax = 80,
hatFreq = 1000,
timeMul = 3, ampMul = 13,
onebar = 0.5;

/*
s.prepareForRecord; // you have to call this first
s.record;
SystemClock.sched(
	onebar*26*timeMul, {|time|
		time.postln;
		"Recording stop.".postln;
		s.stopRecording;
	}
);
*/


//Melody
 Pbind(
 	\instrument,        \tak,
 	\dur,    Pseq([
 		onebar*3, onebar*2, onebar*1, onebar*3, onebar*4
 	]*timeMul, inf),
	\susTime, Pseq([3, 4, 2, 4, 3], inf),
 	\amp, Pseq([
		0.4, 0.5, 0.3, 0.3, 0.5
 	]*ampMul, inf),
 	\freq, Pseq(([
		36, 40, 36, 35, 31
 	]).midicps, inf),
 	\filfreq, 100,
	\pan, Pseq([-0.6, -0.6, -0.2, 0.3, -0.4], inf)
 ).play;


//Bass
Pbind(
 	\instrument,        \dd,
 	\dur,    Pseq([
 		onebar*1, onebar*1, onebar*1, onebar*1, onebar*1, onebar*1,
		onebar*1, onebar*1, onebar*1, onebar*1, onebar*1, onebar*1, onebar*1
 	]*timeMul, inf),
 	\amp, Pseq([
		0.8
 	]*ampMul, inf),
 	\freq, Pseq(([
		1
 	]), inf),
 	\filfreq, 90,
	\pan, Pseq([0.3, 0.4, -0.6, 0.6, 0.4], inf)
 ).play;



CmdPeriod.doOnce{ s.stopRecording;}

)

s.meter
[
	68, 71, 68, 63,
	66, 64, 63, 61, 63, 64, 61, 63
]



a = Synth(\tak, [\freq, 59.midicps])
a = Synth(\tak, [\freq, 59.midicps])
a = Synth(\tak, [\freq, 61.midicps])
a = Synth(\tak, [\freq, 62.midicps])
a = Synth(\tak, [\freq, 63.midicps])

a = Synth(\tak, [\freq, 68.midicps])
a = Synth(\tak, [\freq, 71.midicps])
a = Synth(\tak, [\freq, 68.midicps])
a = Synth(\tak, [\freq, 63.midicps])

a = Synth(\tak, [\freq, 66.midicps])
a = Synth(\tak, [\freq, 64.midicps])
a = Synth(\tak, [\freq, 63.midicps])
a = Synth(\tak, [\freq, 61.midicps])
a = Synth(\tak, [\freq, 63.midicps])
a = Synth(\tak, [\freq, 64.midicps])
a = Synth(\tak, [\freq, 61.midicps])
a= Synth(\tak, [\freq, 63.midicps])

a = Synth(\tak, [\freq, 83.midicps])


a = Synth(\tak, [\freq, 52.midicps, \filfreq, 300])
a = Synth(\tak, [\freq, 56.midicps, \filfreq, 300])
a = Synth(\tak, [\freq, 57.midicps, \filfreq, 300])
a = Synth(\tak, [\freq, 52.midicps, \filfreq, 300])
a = Synth(\tak, [\freq, 50.midicps, \filfreq, 300])
a = Synth(\tak, [\freq, 52.midicps, \filfreq, 300])

[
	52, 56, 57, 52, 50, 52
]



a = Synth(\tak, [\freq, 28.midicps, \filfreq, 100, \amp, 8])
a = Synth(\tak, [\freq, 33.midicps, \filfreq, 100, \amp, 8])
a = Synth(\tak, [\freq, 31.midicps, \filfreq, 100, \amp, 8])
a = Synth(\tak, [\freq, 32.midicps, \filfreq, 100, \amp, 8])

[28, 33, 31, 32]

a = Synth(\tak, [\freq, 28.midicps, \filfreq, 100, \amp, 4])
a = Synth(\tak, [\freq, 28.midicps, \filfreq, 100, \amp, 4])
a = Synth(\tak, [\freq, 28.midicps, \filfreq, 100, \amp, 4])
a = Synth(\tak, [\freq, 40.midicps, \filfreq, 300, \amp, 4])

a = Synth(\tak, [\freq, 41.midicps, \filfreq, 300, \amp, 4])
a = Synth(\tak, [\freq, 45.midicps, \filfreq, 300, \amp, 4])
a = Synth(\tak, [\freq, 41.midicps, \filfreq, 300, \amp, 4])
a = Synth(\tak, [\freq, 40.midicps, \filfreq, 300, \amp, 4])
a = Synth(\tak, [\freq, 36.midicps, \filfreq, 300, \amp, 4])


a = Synth(\tak, [\freq, (41-5).midicps, \filfreq, 300, \amp, 4])
a = Synth(\tak, [\freq, (45-5).midicps, \filfreq, 300, \amp, 4])
a = Synth(\tak, [\freq, (41-5).midicps, \filfreq, 300, \amp, 4])
a = Synth(\tak, [\freq, (40-5).midicps, \filfreq, 300, \amp, 4])
a = Synth(\tak, [\freq, (36-5).midicps, \filfreq, 300, \amp, 4])

[
	36, 40, 36, 35, 31
]



a = Synth(\tak, [\freq, 36.midicps, \filfreq, 300, \amp, 4])

FreqScope.new

76.midicps



