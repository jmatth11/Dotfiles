{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jmatth11";
  home.homeDirectory = "/home/jmatth11";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/jmatth11/Dotfiles/nvim";

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jmatth11/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "nvim";
  };

  # enable bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
    	source ~/git/jmatth11/Dotfiles/aliases.sh
    	source ~/git/jmatth11/Dotfiles/ps1.sh
    '';
  };

  # enable git
  programs.git = {
    enable = true;
    ignores = [
	# Python specific
	".mypy_cache/"
	".pytest_cache/"
	"__pycache__/"
	".hypothesis/"
	".ruff_cache/"
	".ropeproject/"

	# Zig specific
	".zig-cache/"
	"zig-out/"
	
	# node
	"node_modules"
    ];
    settings = {
      user = {
        name = "Joshua Matthews";
        email = "jmatth93@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
      blame = {
        coloring = "highlightRecent";
        date = "relative";
      };
      diff = {
        context = 3;
        renames = "copies";
        interHunkContext = 10;
      };
      log.graphColors = "blue,yellow,cyan,magenta,green,red";
      push = {
        autoSetupRemote = true; # easier to push new branches
        default = "current"; # push only current branch by default
        followTags = true; # push also tags
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      font-size = 10;
    };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "tmux-256color";
    focusEvents = true;
    escapeTime = 10;
    extraConfig = ''
	set-option -sa terminal-overrides ",xterm-256color:RGB"
	bind -r k select-pane -U
	bind -r j select-pane -D
	bind -r h select-pane -L
	bind -r l select-pane -R
    '';
  };

  programs.fzf = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
