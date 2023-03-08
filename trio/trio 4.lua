---trio 4, jf, w/syn, and crow

s = sequins

a = s{2,5,7,s{s{-7,-5,-3,-10},-10,-12,-7,-14},4,5,9,7,14,12,5}
b = s{-7,-3,s{-7,-5,-3,-10},-10,-12,-7,-14,-12}
c = s{-7,-5,s{5,s{-10,-12,-7,-14,-12},7},-3,-10}

clock.tempo = 122

ii.jf.run_mode(1)
ii.wsyn.ar_mode(1)

output[1].slew = .02
output[2]:clock(1/2)
output[3]:clock(1/2)


note = function()
    ii.jf.play_note(a()/12, 1.8)
end

withnote = function()
    ii.wsyn.play_note(a:step(b())()/12, 1)
end


jfstrum = function()
    t = 0.2
    tm = 0.1
    for i=1,9 do
        note()
        clock.sync(4)
        t = tm * 0.3
    end
end

with = function()
    wt = 0.1
    wtm = 0.05
    for i=1,3 do
        withnote()
        clock.sync(16)
        t = wtm * wt
    end
end

bass = function()
    output[1].volts = c()/12

end

rep = function()
    while true do
        clock.sync(16)
        clock.run(jfstrum)
        clock.run(with)
        clock.run(bass)
    end
end

clock.run(rep)
