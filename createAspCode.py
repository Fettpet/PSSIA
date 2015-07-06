asp = "%trafficlightgreen(light l, timestamp t)\n\n"

# in seconds
timeDuration = 30
startTime = (1 / timeDuration) * 6 * 60 * 60
endTime = (1 / timeDuration) * 21 * 60 * 60


for l in range(1, 9):
    asp += "trafficlightgreen({:.0f},{:.0f}..{:.0f}).".format(l,
                                                              startTime, endTime) + "\n"

asp += "\n"


# let there be time
asp += "%follow(time t, time t+1)\n"
asp += "follow({:.0f}..{:.0f}, {:.0f}..{:.0f}).".format(startTime,
                                                        endTime, startTime + 1, endTime + 1) + "\n"


fh = open("asp.lp", "w")
fh.write(asp)
fh.close()

print(asp)
