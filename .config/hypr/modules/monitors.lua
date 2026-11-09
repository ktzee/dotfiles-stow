monitor1 = "DP-1"
monitor2 = "DP-2"
monitor3 = "HDMI-A-2"
hl.monitor({
	output = monitor1,
	mode = "2560x1440@239.97",
	position = "0x0",
	scale = "1",
	vrr = 0,
	supports_hdr = -1,
})
hl.monitor({ output = monitor2, mode = "2560x1440@120", position = "0x-1440", scale = "1", vrr = 0, supports_hdr = -1 })
hl.monitor({
	output = monitor3,
	mode = "2560x1440@120",
	position = "2560x-720",
	scale = "1",
	transform = 3,
})
