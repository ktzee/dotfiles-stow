hl.window_rule({ name = "ws-firefox", match = { class = "firefox" }, workspace = "2 silent" })
hl.window_rule({ name = "ws-telegram", match = { class = "org.telegram.desktop" }, workspace = "3 silent" })
hl.window_rule({ name = "ws-chrome", match = { class = "google-chrome" }, workspace = "2 silent" })
hl.window_rule({ name = "ws-edge", match = { class = "Microsoft-edge" }, workspace = "2 silent" })
hl.window_rule({ name = "ws-thunderbird", match = { class = "org.mozilla.Thunderbird" }, workspace = "3 silent" })
hl.window_rule({ name = "brave", match = { class = "brave-browser" }, workspace = "name:q silent" })
hl.window_rule({ name = "steam", match = { class = "steam" }, workspace = "name:s silent" })
hl.window_rule({ name = "lutris", match = { class = "net.lutris.Lutris" }, workspace = "name:s silent" })
hl.window_rule({ name = "signal", match = { class = "signal" }, workspace = "name:3 silent" })

hl.window_rule({
	name = "fifo-for-games",
	match = { title = "Deadlock|VRising|Path of Exile|Path of Exile 2|^(steam_app_.*)|^(bms_linux)" },
	immediate = true,
	no_shadow = true,
	no_anim = true,
	allows_input = true,
})

hl.window_rule({
	name = "ff-pip-float",
	match = { class = "^(firefox)$", title = "^(Picture-in-Picture)$" },
	float = true,
})
hl.window_rule({ name = "ff-pip-pin", match = { class = "^(firefox)$", title = "^(Picture-in-Picture)$" }, pin = true })
hl.window_rule({
	name = "ff-sharing-indicator",
	match = { class = "^(firefox)$", title = "^(Firefox — Sharing Indicator)$" },
	float = true,
})

hl.window_rule({
	name = "telegram-media-fullscreen",
	match = { class = "^(org.telegram.desktop)$", title = "^(Media viewer)$" },
	fullscreen = true,
})

hl.window_rule({ name = "file-roller-float", match = { class = "^(file-roller)$" }, float = true })
hl.window_rule({ name = "file-roller-center", match = { class = "^(file-roller)$" }, center = true })

hl.window_rule({ name = "modal-open", match = { title = "^(Open)$" }, float = true })
hl.window_rule({ name = "modal-choose-files", match = { title = "^(Choose Files)$" }, float = true })
hl.window_rule({ name = "modal-save-as", match = { title = "^(Save As)$" }, float = true })
hl.window_rule({ name = "modal-confirm-replace", match = { title = "^(Confirm to replace files)$" }, float = true })
hl.window_rule({ name = "modal-file-op-progress", match = { title = "^(File Operation Progress)$" }, float = true })
hl.window_rule({
	name = "chrome-open-files",
	match = { class = "^(google-chrome)$", title = "^(Open Files)$" },
	float = true,
})
hl.window_rule({
	name = "chrome-open-file",
	match = { class = "^(google-chrome)$", title = "^(Open File)$" },
	float = true,
})

hl.window_rule({ name = "pavucontrol-center", match = { class = "pavucontrol" }, center = true })
hl.window_rule({ name = "pavucontrol-float", match = { class = "pavucontrol" }, float = true })

hl.window_rule({ name = "idle-inhibit-firefox", match = { class = "firefox" }, idle_inhibit = "fullscreen" })
hl.window_rule({ name = "idle-inhibit-mpv", match = { class = "mpv" }, idle_inhibit = "fullscreen" })

hl.window_rule({
	name = "fix-xwayland-drags",
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

hl.workspace_rule({ workspace = "1", no_rounding = true, monitor = monitor1 })
hl.workspace_rule({ workspace = "2", no_rounding = true, monitor = monitor1 })
hl.workspace_rule({ workspace = "3", no_rounding = true, monitor = monitor1 })
hl.workspace_rule({ workspace = "4", no_rounding = true, monitor = monitor1 })
hl.workspace_rule({ workspace = "5", no_rounding = true, monitor = monitor1 })
hl.workspace_rule({ workspace = "name:q", no_rounding = true, monitor = monitor2 })
hl.workspace_rule({ workspace = "name:w", no_rounding = true, monitor = monitor2 })
hl.workspace_rule({ workspace = "name:e", no_rounding = true, monitor = monitor2 })
hl.workspace_rule({ workspace = "name:a", no_rounding = true, monitor = monitor1 })
hl.workspace_rule({ workspace = "name:s", no_rounding = true, monitor = monitor1 })
