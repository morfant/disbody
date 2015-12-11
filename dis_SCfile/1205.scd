(
//Synth 1
SynthDef(\bass, {| amp = 0.2, gate = 1,
	freqs = #[220, 440, 880, 1760],
    amps=#[int_15, 0.23, 0.12, 0.05],
    phases=#[1, 1.5, 2, 2.5]|
	var env;
	env = EnvGen.kr(Env.linen(0.1, 0.1, 0.1), gate, doneAction: 2);

	    Out.ar(0, Pan2.ar(DynKlang.ar(`[freqs, amps, phases]) * env, 0, amp));
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


//Loop
(
var int_1 = 0.3, int_2 = 0.9, bassFreq = 90, bassFreqMax = 100;
fork{
	inf.do{
		d = Synth(\hat, [\freq, 300, \amp2, 0.9]);
		0.2.wait;
		d = Synth(\hat, [\freq, 300, \amp2, 0.9]);
		0.2.wait;
		d = Synth(\hat, [\freq, 300, \amp2, 0.9]);
		0.2.wait;
		d = Synth(\hat, [\freq, 300, \amp2, 0.9]);
		0.2.wait;
		d = Synth(\hat, [\freq, 300, \amp2, 0.9]);
		0.2.wait;

		5.wait;

	}
};

fork{
	inf.do{
		a = Synth(\bass); a.setn(\freqs, Array.rand(4, bassFreq, bassFreqMax));
		c = Synth(\hat, [\freq, 600, \amp2, 0.9]);
		int_1.wait;

		a = Synth(\bass); a.setn(\freqs, Array.rand(4, bassFreq, bassFreqMax));
		int_1.wait;

		a = Synth(\bass); a.setn(\freqs, Array.rand(4, bassFreq, bassFreqMax));
		0.1.wait;
		c = Synth(\hat, [\freq, 600, \amp2, 0.9]);
		0.2.wait;
		//int_1.wait;

		a = Synth(\bass); a.setn(\freqs, Array.rand(4, bassFreq, bassFreqMax));
		int_1.wait;

		b = Synth(\hat);
		0.3.wait;
		c = Synth(\hat, [\freq, 600, \amp2, 0.9]);
		0.6.wait;

		a = Synth(\bass); a.setn(\freqs, Array.rand(4, bassFreq, bassFreqMax));
		c = Synth(\hat, [\freq, 600, \amp2, 0.9]);
		int_1.wait;
		c = Synth(\hat, [\freq, 600, \amp2, 0.9]);
		0.3.wait;
		a = Synth(\bass); a.setn(\freqs, Array.rand(4, bassFreq, bassFreqMax));
		//c = Synth(\hat, [\freq, 600, \amp2, 0.9]);
		int_1.wait;
		a = Synth(\bass); a.setn(\freqs, Array.rand(4, bassFreq, bassFreqMax));
		//c = Synth(\hat, [\freq, 600, \amp2, 0.9]);
		0.2.wait;
		c = Synth(\hat, [\freq, 600, \amp2, 0.9]);
		0.1.wait;
		//int_1.wait;
		a = Synth(\bass); a.setn(\freqs, Array.rand(4, bassFreq, bassFreqMax));
		c = Synth(\hat, [\freq, 600, \amp2, 0.9]);
		int_1.wait;

		b = Synth(\hat);
		int_2.wait;
		0.3.wait;
	}
}
)

s.meter

{SinOsc.ar(300, mul: 0.3)!2}.play;

{DynKlank}

{DynKlang}


(//Pad
{
loop({
    play({
        var mod = SinOsc.kr(Rand(0.1, 0.9), 0, Rand(5, 20));
        Pan2.ar(DynKlang.ar(`[ Array.rand(12, 200.0, 2000.0), 1, mod ]), 1.0.rand)
            * EnvGen.kr(Env.sine(4), 1, 0.02, doneAction: 2);
    });
    2.wait;
})
}.fork;
)


(
SynthDef(\pad, {| freqmin = 200, freqmax = 2000, amp = 0.7, gate = 1 |

	var sig, env, mod;
	mod = SinOsc.kr(Rand(0.1, 0.9), 0, Rand(5, 20));
	sig = DynKlang.ar(`[ Array.rand(12, freqmin, freqmax), 1, mod ]);
	env = EnvGen.kr(Env.sine(6), gate, 0.02, doneAction: 2);
	Out.ar(0, Pan2.ar(sig * env, 0, amp));
}).add
)
a = Synth(\pad);



Server

s.recHeaderFormat = 'wav'

(
SynthDef(\bass, {| amp = 0.7, gate = 1,
	freqs = #[220, 440, 880, 1760],
    amps=#[int_15, 0.23, 0.12, 0.05],
    phases=#[1, 1.5, 2, 2.5]|
	var env;
	env = EnvGen.kr(Env.linen(0.1, 0.2, 0.2), gate, doneAction: 2);

	    Out.ar(0, Pan2.ar(DynKlang.ar(`[freqs, amps, phases]) * env, 0, amp));
}).add
)

a = Synth(\bass);
a.setn(\freqs, Array.rand(4, 1090, 1190));
a = Synth(\bass); a.setn(\freqs, Array.rand(4, 110, 116));


s.recHeaderFormat = 'wav';
s.prepareForRecord; // you have to call this first
s.record;
s.stopRecording; // this closes the file and deallocates the buffer recording node, etc.


s.meter
LFPar
(
SynthDef(\hat, {| freq = 6000, amp = 0.3, amp2 = 0.9, filfreq = 5000, rq = 0.2, gate = 1 |
	var sig, env, sig2;
	sig = LFPar.ar(freq);
	sig = RHPF.ar(sig, filfreq, rq, sig*0.1);
	sig2 = Impulse.ar(0, mul: amp2);
	env = EnvGen.kr(Env.perc(0.05, 0.2), gate, doneAction: 2);
	Out.ar(0, Pan2.ar(sig2 + sig * env, 0, amp));
}).add
)

b = Synth(\hat, [\freq, 6000, \amp2, 0.9])

b = Synth(\hat, [\freq, 600, \amp2, 0.9])


{ LFPar.ar(440) * 0.1 }.play;



Impulse

LFClipNoise








FreqScope.new