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
	atTime = 0.1, susTime = 2.0, relTime = 0.9 |
	var sig, env, sig2, del, mod;
	mod = SinOsc.kr(modfreq);
	sig = LFCub.ar(freq, mul: mod);

	sig2 = Impulse.ar(0, mul: amp2);

	sig = BPF.ar((sig+sig2), filfreq, rq, sig*0.3);

	sig = DelayN.ar(sig, 0.4, 0.3, add: sig*0.1);

	env = EnvGen.kr(Env.linen(atTime, susTime, relTime), gate, doneAction: 2);
	Out.ar(0, Pan2.ar((sig) * env, 0, amp));
}).add;

)


FreqScope.new
s.recHeaderFormat = 'wav';
s.prepareForRecord; // you have to call this first
s.record;
s.stopRecording;

(//Pattern
var bassFreq = 76, bassFreqMax = 80,
hatFreq = 1000,
timeMul = 4, ampMul = 7,
onebar = 0.5;

s.record;

SystemClock.sched(
	onebar*32*timeMul, {|time|
		time.postln;
		"Recording stop.".postln;
		s.stopRecording;
	}
);

Pbind(
	\instrument,        \hat,
	\dur,    Pseq([
		onebar, onebar*2, onebar*(5-0.25), onebar*0.25,
		onebar*2.25, onebar*1, onebar*0.5, onebar*0.5, onebar*0.5, onebar*3.25,
		onebar, onebar*1.75, onebar*0.25, onebar*(5),
		onebar*1, onebar*1.75, onebar*0.25, onebar*1.75, onebar*0.25, onebar*1, onebar*2

	]*timeMul, inf),
	\legato, Pseq(0.25/timeMul*[0.8, 1.4], inf),
	\freq, Pseq([10], inf),
	\amp, 1*ampMul
).play;



Pbind(
	\instrument,        \bass,
	\dur,    Pseq([
		onebar*0.25, onebar*2.25, onebar*1.5, onebar*4,
				onebar*0.25, onebar*2.25, onebar*0.5, onebar*5,
		onebar*2.5, onebar*1.5, onebar*4,
				onebar*0.5, onebar*1.5, onebar*0.5, onebar*2.25, onebar*3.25

	]*timeMul, inf),
	\amp, Pseq([
		0, 0.1, 0, 0.1,
		0, 0.1, 0, 0.1,
		0.1, 0, 0.1,
		0.1, 0.1, 0.1, 0.1, 0.1
	]*ampMul, inf),
	\legato, Pseq(0.25/timeMul*[0.8, 1.4], inf),
	\freqs, Ptuple([Pwhite(bassFreq, bassFreqMax ! 4)], inf)

).play;



/* Pbind(
 	\instrument,        \tak,
 	\dur,            Pseq([
 		Pseq([onebar, onebar*2.5, onebar*0.5, onebar*6]*timeMul/3*4, 1),
 		Pseq([onebar, onebar, onebar, onebar, onebar, onebar*0.25, onebar*0.75, onebar*6]*timeMul/3*4, 1)
 	], inf),
	\atTime, 0.1,
	\relTime, 0.3,
 	\freq, Pseq(([
	68, 71, 68, 63,
	66, 64, 63, 61, 63, 64, 61, 63
]+24).midicps, inf),
 	\amp, 1*ampMul
 ).play;


 Pbind(
 	\instrument,        \tak,
 	\dur,            Pseq([
 		Pseq([onebar, onebar*2.5, onebar*0.5, onebar*6]*timeMul/3*4, 1),
 		Pseq([onebar, onebar, onebar, onebar, onebar, onebar*0.25, onebar*0.75, onebar*6]*timeMul/3*4, 1)
 	], inf),
	\atTime, 0.1,
	\relTime, 0.3,
 	\freq, Pseq(([
	68, 71, 63, 63,
	66, 64, 63, 64, 63, 61, 61, 63
]-24).midicps, inf),
	\filfreq, 200,
	\modfreq, 1,
	\susTime, 4.0,
	\amp, Pseq([
		0.0, 0.0, 0.1, 0.1,
		0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.0
	]*ampMul*6, inf)
 ).play;*/

 Pbind(
 	\instrument,        \tak,
 	\dur,            Pseq([
 		Pseq([onebar*3, onebar*2, onebar*1, onebar*6]*timeMul/3*2, 1),
 		Pseq([onebar, onebar, onebar, onebar, onebar, onebar*0.25, onebar*0.75, onebar*6]*timeMul/3*2, 1)
 	], inf),
	\atTime, 0.1,
	\relTime, 0.3,
 	\freq, Pseq(([
	68, 71, 68, 63,
	66, 64, 63, 61, 63, 64, 61, 63
]-24).midicps, inf),
	\filfreq, 200,
 	\amp, 1*ampMul
 ).play;


 Pbind(
 	\instrument,        \tak,
 	\dur,            Pseq([
 		Pseq([onebar*3, onebar*2, onebar*1, onebar*6]*timeMul/3*2, 1),
 		Pseq([onebar, onebar, onebar, onebar, onebar, onebar*0.25, onebar*0.75, onebar*6]*timeMul/3*2, 1)
 	], inf),
	\atTime, 0.1,
	\relTime, 0.3,
 	\freq, Pseq(([
	68, 71, 63, 63,
	66, 64, 63, 64, 63, 61, 61, 63
]+24).midicps, inf),
	\modfreq, 1,
	\susTime, 4.0,
	\amp, Pseq([
		0.0, 0.0, 0.1, 0.1,
		0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.0
	]*ampMul*1, inf)
 ).play;


CmdPeriod.doOnce{
	s.stopRecording;
}

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
a = Synth(\tak, [\freq, 63.midicps])









