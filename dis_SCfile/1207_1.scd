FreqScope.new

(
//Synth 2
SynthDef(\tak, {| freq = 300, amp = 0.6, amp2 = 0.9, filfreq = 600, rq = 0.2, gate = 1, atTime = 0.5, relTime = 2.9 |
	var sig, env, sig2, del, mod;
	mod = SinOsc.kr(5);
	sig = LFCub.ar(freq);

	sig2 = Impulse.ar(0, mul: amp2);

	sig = BPF.ar((sig+sig2), filfreq, rq, sig*0.3);

	sig = DelayC.ar(sig, 0.4, 0.3, add: sig*0.05);

	env = EnvGen.kr(Env.perc(atTime,relTime), gate, doneAction: 2);
	Out.ar(0, Pan2.ar((sig) * env, 0, amp));
}).add;
)

a = Synth(\tak);


s.recHeaderFormat = 'wav';
s.prepareForRecord; // you have to call this first
s.record;
s.stopRecording;

(//Pattern
var onebar = 0.1,
bassFreq = 60, bassFreqMax = 80,
hatFreq = 1000,
timeMul = 1, ampMul = 1;

 Pbind(
 	\instrument,        \tak,
 	\dur,            Pseq([
 		Pseq([onebar/4, onebar*(15/4)]*timeMul, 3),
 		Pseq([onebar/4, onebar*(2)]*timeMul, 1),
 		Pseq([onebar/3, onebar/3, onebar/3, (1)*onebar]*timeMul, 1)
 	], inf),
	\atTime, 0.1,
	\relTime, 0.3,
 	\freq, Pseq([63,63, 68,63, 63,63, 68,63, 59,61,62,63].midicps, inf),
 	\amp, 0.3*ampMul
 ).play;


Pbind(
	\instrument,        \tak,
	\dur,            Pseq([
		Pseq([onebar/4, onebar*(15/4)]*timeMul, 3),
		Pseq([onebar/4, onebar, onebar, onebar*2]*timeMul, 1)
	], inf),
	\atTime, 0.1,
	\relTime, 0.3,
	\freq, Pseq([59,63, 63,61, 59,63, 63,61,59,61].midicps, inf),
	\amp, 0.1*ampMul
).play;
)

(//Pattern
var onebar = 0.3,
bassFreq = 60, bassFreqMax = 80,
hatFreq = 1000,
timeMul = 8, ampMul = 3;

 Pbind(
 	\instrument,        \tak,
 	\dur,            Pseq([
 		Pseq([onebar/4, onebar*(15/4)]*timeMul, 3),
 		Pseq([onebar/4, onebar*(2)]*timeMul, 1),
 		Pseq([onebar/3, onebar/3, onebar/3, (1)*onebar]*timeMul, 1)
 	], inf),
 	\freq, Pseq([63,63, 68,63, 63,63, 68,63, 59,61,62,63].midicps, inf),
 	\amp, 0.3*ampMul
 ).play;


Pbind(
	\instrument,        \tak,
	\dur,            Pseq([
		Pseq([onebar/4, onebar*(15/4)]*timeMul, 3),
		Pseq([onebar/4, onebar, onebar, onebar*2]*timeMul, 1)
	], inf),
	\freq, Pseq([59,63, 63,61, 59,63, 63,61,59,61].midicps, inf),
	\amp, 0.1*ampMul
).play;


Pbind(
	    \instrument,        \bass,
	    \dur,            Pseq([0.3, 0.3, 0.3, 0.3]*timeMul, inf),
	\legato, timeMul.reciprocal - 0.01,
	\freqs, Ptuple([Pwhite(bassFreq, bassFreqMax ! 4)], inf),
	\amp, 0.02*ampMul
).play;


Pbind(
	\instrument,        \hat,
	\dur,            Pseq([0.9, 1.5]*timeMul, inf),
	\legato, Pseq(0.25/timeMul*[0.8, 1.4], inf),
	\freq, Pseq([13000, 12000, 13000, 10000], inf),
	\amp, 1.0*ampMul
).play;


Pbind(
	\instrument,        \hat,
	\dur,            Pseq([0.15]*timeMul, inf),
	\legato, (timeMul/2).reciprocal - 0.01,
	//	\freq, Pseq([300, 300, 400, 300], inf),
	\freq, Pseq([Pwhite(400, 500)], inf),
	\amp, Pseq([
		1.0, 0.4, 0.4, 0.4,
		0.4, 1.0, 0.4, 0.4,
		1.0, 0.5, 0.5, 1.0,
		0.5, 0.5, 1.0, 0.7
	]*ampMul, inf)

).play;

)

)

s.meter

59,63, 63,61, 59,63, 63,61,59,61, 59

a = Synth(\tak, [\freq, 59.midicps])
a = Synth(\tak, [\freq, 59.midicps])
a = Synth(\tak, [\freq, 61.midicps])
a = Synth(\tak, [\freq, 62.midicps])
a = Synth(\tak, [\freq, 63.midicps])


63.midicps

64.midicps

73.midicps

440.cpsmidi


69 = A

