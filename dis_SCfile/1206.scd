(
//Synth 1
SynthDef(\bass, {| amp = 0.2, lf = 100, rq = 0.9, gate = 1,
	freqs = #[220, 440, 880, 1760],
    amps=#[int_15, 0.23, 0.12, 0.05],
    phases=#[1, 1.5, 2, 2.5]|
	var env, sig;
	env = EnvGen.kr(Env.linen(0.1, 0.1, 0.1), gate, doneAction: 2);
	sig = DynKlank.ar(`[freqs, amps, phases]);
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

)

s.recHeaderFormat = 'wav';
s.prepareForRecord; // you have to call this first
s.record;
s.stopRecording;

(//Pattern
var bassFreq = 60, bassFreqMax = 80,
hatFreq = 1000,
timeMul = 8, ampMul = 3;

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


//http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/Passing-arrays-as-Pbind-arguments-for-envelopes-td7605924.html
I use Ptuple to send an array of arguments in a EventStream:
(
SynthDef(\thig, {arg i_out = 0, freqs = #[200,300,400,500], gate=1, amp;
    var sig, env;
    env = Linen.kr(gate, 0.6, releaseTime:2, doneAction: 2);
    sig = DynKlang.ar(`[freqs, ExpRand().dup(4)], 1.0);
    Out.ar(i_out, sig * env * amp ! 2)
}).add
)
(
Pdef(\thiggy, Pbind(
    \instrument, \thig,
    \dur, 3.0,
    \freqs, Ptuple([Pwhite(100.0, 500.0 ! 4)], inf)
)).play;
)



Pwhite(60, 80 ! 4) - 10




s.nodeMap