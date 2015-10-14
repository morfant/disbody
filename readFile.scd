

(
//1007
SynthDef(\dot_1,
	{
		arg freq = 125, subfreq = 39, amp = 0.3, time = 0.3, age = -0.3, where = 0, gate = 1;
		var sig, pan, env, subsig;
		subsig = SinOsc.kr(subfreq);
		sig = SinOsc.ar(freq * subfreq, mul: amp);
		env = EnvGen.kr(Env.perc(0.01, time, curve: age), gate, doneAction: 2);
		Out.ar(0, Pan2.ar(sig*env, where, amp));
	}
).add;

//1014
SynthDef(\dot_2,
	{
		arg freq = 125, subfreq = 39, amp = 0.3, time = 0.3, age = -0.3, where = 0, gate = 1;
		var sig, pan, env, subsig;
		subsig = SinOsc.kr(subfreq);
		sig = SinOsc.ar(freq * subfreq, mul: amp);
		env = EnvGen.kr(Env.perc(0.01, time, curve: age), gate, doneAction: 2);
		Out.ar(0, Pan2.ar(sig*env, where, amp));
	}
).add;

SynthDef(\dot_3,
	{
		arg freq = 125, subfreq = 39, amp = 0.3, time = 0.3, age = -0.3, where = 0, gate = 1;
		var sig, pan, env, subsig;
		subsig = SinOsc.kr(subfreq);
		sig = SinOsc.ar(freq * subfreq, mul: amp);
		env = EnvGen.kr(Env.perc(0.01, time, curve: age), gate, doneAction: 2);
		Out.ar(0, Pan2.ar(sig*env, where, amp));
	}
).add;

SynthDef(\dot_4,
	{
		arg freq = 125, subfreq = 39, amp = 0.3, time = 0.3, age = -0.3, where = 0, gate = 1;
		var sig, pan, env, subsig;
		subsig = SinOsc.kr(subfreq);
		sig = SinOsc.ar(freq * subfreq, mul: amp);
		env = EnvGen.kr(Env.perc(0.01, time, curve: age), gate, doneAction: 2);
		Out.ar(0, Pan2.ar(sig*env, where, amp));
	}
).add;


)

(
var files, usingFile, pline, cline, file, freader, fsize, timediv = 100, datares = 0.00001, fts;

files = Array.newClear(5);
files = [
	"/Users/giy/Desktop/disbody/data/411_jindoVTS.txt",
	"/Users/giy/Desktop/disbody/data/416_haesubu3.txt",
	"/Users/giy/Desktop/disbody/data/416_jindoVTS.txt",
	"/Users/giy/Desktop/disbody/data/416_militryradar.txt",
	"/Users/giy/Desktop/disbody/data/416_recovered.txt"
];

usingFile = files[1]; //change file number 0 ~ 4
("######START File:" + usingFile + "######").postln;

fts = {arg time;
    var aa, bb, cc, dd;
    aa = (time).split($:).at(0).asInteger;
    bb = (time).split($:).at(1).asInteger;
    cc = (time).split($:).at(2).asInteger;
    dd = aa*3600 + bb*60 + cc;
};

pline = Array.newClear(5);
cline = Array.newClear(5);

//read file
file = File(files[0], "r");
freader = FileReader.read(file);
fsize = freader.size;
file.close;

("List length: " + fsize).postln;

fork{
	1.do{
	(fsize - 1).do{|i|
        var ff, playtime, lng, lat, flng, flat;

		ff = File(usingFile, "r");
		pline = FileReader.read(ff)[i];
        ff.close;
		ff = File(usingFile, "r");
		cline = FileReader.read(ff)[i+1];
        ff.close;

		lng = cline[2];
		lat = cline[3];
		flng = lng.asFloat.round(datares);
		flat = lat.asFloat.round(datares);

		// flng
		flng = (flng - 120) * 1000;
		flng = flng - 5000;
		flng = flng - 800;

		// flat
		flat = (flat - 34) * 100;
		flat = flat/10;


		//get play time
        playtime = fts.value(cline[1]) - fts.value(pline[1]);
		(pline[1] ++ " - " ++ cline[1]).postln; //timecode
		("idx: " ++ i ++ " / " ++ "dur: " ++ playtime).postln;
		("flng: " ++ flng ++ " / " ++ "flat: " ++ flat).postln;

		1.do{|j|
			a = Synth(\dot_1, [\freq, flng, \subfreq, flat, \amp, 0.9]);
		};
		(playtime/timediv).wait;
	};
	("######END File:" + usingFile + "######").postln;
	}
}


);



//time -> sec
(
f = {arg time;
    a = (time).split($:).at(0).asInteger;
    b = (time).split($:).at(1).asInteger;
    c = (time).split($:).at(2).asInteger;
    d = a*3600 + b*60 + c;
}
)


f.value("06:00:04");


Function


10**3

10-e

a = 125.8671638888889
a.round(0.0001);
a.round(0.001)

a*(10**5).asInt;

a = 0.129341243
(a*10000).round(4);
a.round(5)
19.4