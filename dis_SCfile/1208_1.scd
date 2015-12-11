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

	sig = DelayN.ar(sig, 0.4, 0.3, add: sig*0.3);

	env = EnvGen.kr(Env.linen(atTime, susTime, relTime), gate, doneAction: 2);
	Out.ar(0, Pan2.ar((sig) * env, pan, amp));
}).add;

)


s.meter;

FreqScope.new
s.recHeaderFormat = 'wav';
s.prepareForRecord; // you have to call this first
s.record;
s.stopRecording;

(//Pattern
var bassFreq = 76, bassFreqMax = 80,
hatFreq = 1000,
timeMul = 1, ampMul = 5,
onebar = 0.5;

s.prepareForRecord; // you have to call this first
s.record;

SystemClock.sched(
	onebar*44*timeMul, {|time|
		time.postln;
		"Recording stop.".postln;
		s.stopRecording;
	}
);


//Tik
Pbind(
	\instrument,        \hat,
	\dur,    Pseq([
		onebar, onebar, onebar, onebar, onebar,
		onebar, onebar, onebar, onebar, onebar,
		onebar
	]*timeMul, inf),
	\legato, Pseq(0.25/timeMul*[0.8, 1.4], inf),
	\freq, Pseq([
		10000, 100, 100, 100, 100,
		100, 100, 100, 100, 100,
		8000
	], inf),
	\amp, 0.7*ampMul
).play;


//Additional random tik
Pbind(
	\instrument,        \hat,
	\dur,    Pseq([
		Pwhite(0.0, 11.0, inf)*onebar
	]*timeMul, inf),
	\freq, Pseq([
		100
	], inf),
	\amp, 0.7*ampMul
).play;


//Fixed tone
Pbind(
	\instrument,        \tak,
		\dur,    Pseq([
		onebar, onebar, onebar
	]*timeMul, inf),
	\amp, Pseq([
		0.2, 0.3, 0.3, 0.2, 0.3, 0.1
	]*ampMul*0.2, inf),
	\freq, Pseq(([
		76, 76, 76, 76, 76, 76, 76, 76, 76, 76, 76
	]).midicps, inf),
	\susTime, 0.1,
	\filfreq, 700
).play;



//melody loop
Pbind(
	\instrument,        \tak,
		\dur,    Pseq([
		onebar*2, onebar*2, onebar, onebar, onebar, onebar*4
	]*timeMul, inf),
	//\legato, Pseq([1, 1, 0.2, 0.2, 1, 1], inf),
	\susTime, Pseq([0.1, 0.1, 0.01, 0.01, 0.2, 0.6], inf),
	\atTime, Pseq([0.1, 0.1, 0.1, 0.1, 0.2, 0.6], inf),
    \relTime, Pseq([0.9, 0.9, 0.3, 0.3, 0.9, 0.9], inf),
	\amp, Pseq([
		0.2, 0.3, 0.3, 0.2, 0.3, 0.1
	]*ampMul, inf),
	\freq, Pseq(([
		52, 56, 57, 52, 50, 52
		]).midicps, inf),
	\susTime, 0.1,
	\filfreq, 300
).play;


//Bass
 Pbind(
 	\instrument,        \tak,
 	\dur,    Pseq([
 		onebar*5, onebar, onebar*5,
		onebar*5, onebar, onebar*5
 	]*timeMul, inf),
 	\amp, Pseq([
		0, 3, 0,
		0, 3, 0.6
 	]*ampMul, inf),
 	\freq, Pseq(([
 		0, 28, 0,
		0, 28, 40
 	]).midicps, inf),
 	\filfreq, 100
 ).play;


/*
//Not used
 Pbind(
 	\instrument,        \tak,
 	\dur,    Pseq([
 		onebar*2, onebar*2, onebar, onebar*6
 	]*timeMul, inf),
 	\amp, Pseq([
 		4
 	]*ampMul, inf),
 	\freq, Pseq(([
 		28, 33, 31, 32
 	]).midicps, inf),
 	\filfreq, 100
 ).play;
*/

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


FreqScope.new

76.midicps



