---trio based on strum for just friends, w/syn, and crow,
---tempo synced and scales changed by p colombo

s = sequins

a = s{-7,-2,-4,s{5,-7,-12,-9,-4,-2,3,0},-12,s{0,3,5,7,8,10}}
b = s{5,8,7,s{3,5,0,3,3,5,s{8,0,1,3,5},0,17},s{5,15,7,8,10}}
c = s{8,0,1,3,5,-7,-12,-9,-4,-2,3,0}


clock.tempo = 40

ii.wsyn.ar_mode(1)

output[1].slew = .02
output[2].action = pulse(0.01,5,1)
output[3].action = pulse(0.01,5,1)

note = function()
    ii.jf.play_note(a()/12, 3.5)
end

withnote = function()
    ii.wsyn.play_note(a:step(b())()/12, 0.7)
end

jfstrum = function()
    t = 0.3
    tm = 3
    for i=1,9 do
        note()
        clock.sync(1/4)
        t = tm * 0.3
    end
end

with = function()
    wt = 0.2
    wtm = 0.3
    for i=1,3 do
        withnote()
        clock.sync(2)
        t = wtm * wt
    end
end

bass = function()
    output[1].volts = c()/12
    output[2]()
end

rep = function()
    while true do
        clock.sync(1)
        clock.run(jfstrum)
        clock.run(with)
        clock.run(bass)
    end
end

clock.run(rep)

