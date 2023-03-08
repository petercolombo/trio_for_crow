---trio 3 for just friends, w/syn, and crow

s = sequins

a = s{4,8,-1,s{20,16,11},-1,s{-8,11,6},s{4,-1,-8,11,6},8,3}
b = s{4,8,1,4,s{4,-1,s{20,16,11},-8,11,6},-1,-8,18,13,11,6,8}
c = s{4,s{8,-1,4,-1},-8,s{-4,16,11},11,6}

clock.tempo =104

ii.jf.run_mode(1)
ii.wsyn.ar_mode(1)

output[1].slew = .02
output[2]:clock(1/2)
output[3]:clock(1/4)

note = function()
    ii.jf.play_note(a()/12, 1.2)
end

withnote = function()
    ii.wsyn.play_note(a:step(b())()/12, 0.8)
end

jfstrum = function()
    t = 0.3
    tm = 3
    for i=1,9 do
        note()
        clock.sync(1/6)
        t = tm * 0.3
    end
end

with = function()
    wt = 0.2
    wtm = 0.3
    for i=1,3 do
        withnote()
        clock.sync(12)
        t = wtm * wt
    end
end

bass = function()
    output[1].volts = c()/12
    output[2].action = pulse(0.01,5,1)
end

rep = function()
    while true do
        clock.sync(6)
        clock.run(jfstrum)
        clock.run(with)
        clock.run(bass)
    end
end

clock.run(rep)
