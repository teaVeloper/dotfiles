from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import os
import subprocess

mod = "mod4"  # Use Super instead of Alt
terminal = "kitty"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Resize windows
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Launch terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Rofi application launcher
    Key([mod], "p", lazy.spawn("rofi -show drun"), desc="Run application"),
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Run application"),
    # Open specific apps
    Key([mod], "f", lazy.spawn("firefox"), desc="Launch Firefox"),
    Key([mod], "e", lazy.spawn("thunderbird"), desc="Launch Thunderbird"),
    Key([mod], "t", lazy.spawn("teams"), desc="Launch MS Teams"),
    Key([mod], "s", lazy.spawn("spotify"), desc="Launch Spotify"),
    Key([mod], "z", lazy.spawn("zotero"), desc="Launch Zotero"),
    # Lock screen
    Key([mod, "shift"], "l", lazy.spawn("i3lock"), desc="Lock screen"),
    # Multimedia keys
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    # Switch focus between monitors
    Key([mod], "w", lazy.to_screen(1), desc="Move focus to the next screen"),
    Key(
        [mod, "shift"], "w", lazy.to_screen(0), desc="Move focus to the previous screen"
    ),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    layout.Max(),
    layout.MonadTall(),
    layout.MonadWide(),
    layout.Matrix(),
    layout.Bsp(),
    layout.Tile(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.QuickExit(),
            ],
            24,
        ),
    ),
]


# Define how Qtile should handle specific windows
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])


# Manage specific windows
def window_rules():
    return [
        Match(title="Picture-in-Picture", floating=True),
        Match(wm_class="confirmreset", role="GtkFileChooserDialog", floating=True),
        Match(title="branchdialog", role="Dialog", floating=True),
    ]


floating_layout = layout.Floating(float_rules=window_rules())

auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "LG3D"
