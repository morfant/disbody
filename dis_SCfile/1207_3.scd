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
timeMul = 1, ampMul = 3,
onebar = 0.5;

s.prepareForRecord; // you have to call this first
s.record;

SystemClock.sched(
	onebar*24*timeMul, {|time|
		time.postln;
		"Recording stop.".postln;
		s.stopRecording;
	}
);

Pbind(
	\instrument,        \hat,
	\dur,    Pseq([
		onebar, onebar*2, onebar, onebar, onebar
	]*timeMul, inf),
	\legato, Pseq(0.25/timeMul*[0.8, 1.4], inf),
	\freq, Pseq([100], inf),
	\amp, 0.7*ampMul
).play;



Pbind(
	\instrument,        \bass,
	\dur,    Pseq([
		onebar, onebar*2, onebar, onebar, onebar
	]*timeMul, inf),
	\amp, Pseq([
		0, 0.1, 0, 0, 0.1
	]*ampMul*2, inf),
	\legato, Pseq(0.25/timeMul*[0.8, 1.4], inf),
	\freqs, Ptuple([Pwhite(bassFreq, bassFreqMax ! 4)], inf)

).play;



Pbind(
	\instrument,        \tak,
		\dur,    Pseq([
		onebar, onebar*2, onebar, onebar, onebar
	]*timeMul, inf),
	\amp, Pseq([
		0, 0.3, 0, 0.3, 0
	]*ampMul, inf),
	\freq, Pseq(([
		0, 83, 0, 76, 0
	]-24).midicps, inf),
	\filfreq, 700,
	\pan, Pseq([0, -0.8, 0, 0.8, 0], inf)
).play;


Pbind(
	\instrument,        \tak,
		\dur,    Pseq([
		onebar, onebar, onebar
	]*timeMul, inf),
	\amp, Pseq([
		0.2, 0.3, 0.3, 0.2, 0.3, 0.1
	]*ampMul*0.2, inf),
	\freq, Pseq(([
		76, 76, 76
	]).midicps, inf),
	\susTime, 0.1,
	\filfreq, 700
).play;


Pbind(
	\instrument,        \hat,
	\dur,    Pseq([
		onebar, onebar*2, onebar, onebar, onebar
	]*timeMul, inf),
	\amp, Pseq([
		0, 1, 0, 1, 0.5
	]*ampMul, inf),
	\legato, Pseq(0.25/timeMul*[0.8, 1.4], inf),
	\freq, Pseq([200, 1000, 200, 600, 500], inf)
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
a= Synth(\tak, [\freq, 63.midicps])

a = Synth(\tak, [\freq, 83.midicps])
a = Synth(\tak, [\freq, 76.midicps])




76.midicps



