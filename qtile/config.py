from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import qtile

# Define mod key
mod = "mod4"  # Super/Windows key
terminal = "kitty"

# Key bindings for navigation
keys = [
    # Switching between windows in the layout
    Key([mod], "h", lazy.layout.left(), desc="Move focus left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Shifting windows in the layout
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Resizing windows
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Layout management
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Close window"),
    # Fullscreen toggle
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    # Open terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Qtile controls
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]

# Define groups (workspaces)
groups = [Group(i) for i in "12345"]

for i, group in enumerate(groups, 1):
    keys.extend(
        [
            Key(
                [mod],
                str(i),
                lazy.group[group.name].toscreen(),
                desc=f"Switch to group {group.name}",
            ),
            Key(
                [mod, "shift"],
                str(i),
                lazy.window.togroup(group.name),
                desc=f"Send window to group {group.name}",
            ),
        ]
    )

# Layout configuration
layouts = [
    # Three-column layout for the 49" screen
    layout.Columns(
        border_focus="#ff0000",
        border_width=2,
        margin=10,
        num_columns=3,
        ratios=[0.5, 0.25, 0.25],  # Adjust these for your needs
    ),
    # Stacked layout for the laptop screen
    layout.Stack(num_stacks=1, border_focus="#00ff00", margin=10),
    # Floating layout for special windows
    layout.Floating(),
]

# Rules for floating windows
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="pavucontrol"),  # Example: floating PulseAudio control
        Match(wm_class="Thunderbird"),  # Floating Thunderbird email composer
        Match(wm_class="Picture-in-Picture"),  # Floating PiP windows
    ]
)

# Screen configuration
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.Systray(),
            ],
            24,
        ),
    ),
]

# Mouse controls for floating windows (if you use the mouse occasionally)
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# Configuration settings
dgroups_key_binder = None
dgroups_app_rules = []
auto_fullscreen = True
focus_on_window_activation = "smart"


# Autostart script for apps like music player
@lazy.function
def autostart():
    import os

    home = os.path.expanduser("~")
    os.system(f"{home}/.config/qtile/autostart.sh")


# Starting Qtile
if __name__ in ["config", "__main__"]:
    qtile.start()
