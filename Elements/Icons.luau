local Icons = {}

local fetched = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/main/Main.lua"))()

Icons.Names = {
	"house", "settings", "user", "users", "search",
	"bell", "heart", "star", "trash", "edit",
	"plus", "minus", "x", "check", "arrow-right",
	"arrow-left", "arrow-up", "arrow-down", "chevron-right", "chevron-left",
	"chevron-up", "chevron-down", "menu", "grid", "list",
	"eye", "eye-off", "lock", "unlock", "shield",
	"zap", "flame", "shield-check", "target", "crosshair",
	"compass", "map", "map-pin", "navigation", "globe",
	"wifi", "bluetooth", "battery", "cpu", "hard-drive",
	"monitor", "smartphone", "tablet", "keyboard", "mouse-pointer",
	"camera", "image", "video", "film", "music",
	"volume-2", "volume-x", "mic", "headphones", "radio",
	"tv", "play", "pause", "stop-circle", "skip-forward",
	"skip-back", "repeat", "shuffle", "download", "upload",
	"share", "link", "external-link", "copy", "clipboard",
	"file", "folder", "folder-open", "archive", "inbox",
	"send", "mail", "message-circle", "message-square", "phone",
	"phone-call", "calendar", "clock", "timer", "activity",
	"bar-chart-2", "pie-chart", "trending-up", "trending-down", "dollar-sign",
	"credit-card", "gift", "shopping-cart", "tag", "bookmark",
}

function Icons.Get(name)
	local ok, id = pcall(fetched.GetIcon, name)
	return ok and type(id) == "string" and id or "rbxassetid://0"
end

return Icons
