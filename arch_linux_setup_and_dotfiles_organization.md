
# Arch Linux Setup and Dotfiles Organization

## Dotfiles Management
- **Tool**: GNU Stow for managing dotfiles.
- **Structure**: Separate folders for different aspects (core, GUI, multimedia, programming, etc.).
- **Integration**: Integrate with Ansible for automating the setup.

## OS Setup
- **Automation**: Using Ansible playbooks for application setup and dotfiles management.
- **Categories**:
  - Desktop
  - CLI
  - GUI Tools

### Desktop Setup
- **Window Manager**: XMonad
- **Menus**: Rofi for launchers, window changing, etc.
- **Appearance**: Background image, screensaver, fonts, icons, mouse pointers.
- **Widgets**: Eww and Rofi for widgets.
- **Status Bar**: Polybar for system information and controls.
- **Notifications**: Managed in widgets to avoid clutter in the system tray.
- **System Controls**: Volume, audio, Bluetooth, network, and USB stick management in the bar.
- **Password Manager**: Pass and gopass for local, Bitwarden for cloud.
- **Keyboard Control**: Tool like Katana or Kmonad for keyboard consistency.

### CLI Setup
- **General Settings**: Tmux, Zsh (with aliases, functions, plugins, prompt), minimalistic Bash config, and generic shell config.
- **Development Tools**: fzf, bat, rg, delta, forgit, asdf for version management, Git.
- **Neovim**: Main development tool, configured in Lua, with plugins and language servers.
- **Security**: fail2ban
- **Styling**: pywal
- **Monitoring**: htop, gotop, ..

### Specific Development Tools
- **Languages**: Python, Haskell, Rust, Go, Java, Scala sbt, JavaScript.
- **Tools**: Apache Spark, cmake, llvm, Docker, VirtualBox, Vagrant, Terraform, Ruby.
- **Miscellaneous**: GitLab Runner, Minikube with K9s for Kubernetes.

### Style and Theming
- **Configuration**: Define color themes and styles in a separate, untracked folder.
- **Implementation**: Configs reference the style folder; use default styles if not specified.

### GUI/Desktop Tools
- **General Tools**: Evince, Firefox, Chromium, Postman, VLC, image and audio players, Spotify.
- **Development Tools**: Android Studio, Arduino Studio, FPGA dev tools, KiCad Pro, OpenSCAD.
- **Multimedia Tools**: GIMP, Audacity, video editing software, diagramming program with mermaid support. Inkscape,
  FreeCad, Ardout, LMMS, Kdenlive, Shotcut.

