{ config, pkgs, serpantinum, ... } : {
	home = {
		username = "vimyoung";
		homeDirectory = "/home/vimyoung";
		stateVersion = "26.05";
		packages = with pkgs; [
				fastfetch
				cava
				yazi
				libreoffice
				#libresprite
				python3
				telegram-desktop
				vesktop
				#osu-lazer
		];
	};
	
	xdg.configFile."kitty/kitty.conf".force = true;

	imports = [
		serpantinum.homeManagerModules.default
	];

	programs.bash = {
		enable = true;
		shellAliases = {
			nix-build = "sudo nixos-rebuild switch";
			nix-hm = "home-manager switch";
			nix-flake = "sudo nixos-rebuild switch --flake ~/.config/nix#vimyoung";
			ff = "clear && fastfetch";
			xmcl = "nix run github:x45iq/xmcl-nix";
			};
	};

	programs.kitty = {
		enable = true;
		settings = {
			confirm_os_window_close = 0;	
			background_opacity = "0.50";
		};
		extraConfig = ''
			include /home/vimyoung/.config/kitty/colors.conf
			'';
	};

	programs.serpantinum = {
		enable = true;
		systemd.enable = true;

		settings = {
			wallpaperDir = "/home/username/.wallpapers";

			general = {
				language = "ru";
				weatherUnit = "metric";
				weatherInterval = 30;
			};

			bar = {
				position = "top";
				style = "solid";
				width = 40;
				workspaceCount = 5;
				modules = {
					left = [ "workspaces" ];
					center = [ "time" ];
					right = [ "tray" [ "kb" "wifi" "bt" "vol" "bat" ] ];
				};
			};

			theme = {
				fontFamily = "Adwaita Mono";
				borderRadius = 12;
				matugen = true;
			};

			notifications = {
				dnd = false;
				position = "top right";
				sound = true;
			};
		};
	};

	home.pointerCursor = {
		enable = true;
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Classic";
		size = 22;

		gtk.enable = true;
		x11.enable = true;
	};

	programs.neovim = {
		enable = true;
		initLua = ''
			vim.opt.termguicolors = true
			vim.opt.background = "dark"

			vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
			'';
	};

	programs.firefox = {
		enable = true;
	};

	programs.git = {
		enable = true;

		settings = {
			user = {
				name = "vimyoung";
				email = "zezero1233@gmail.com";
			};

			init.defaultBranch = "main";
			core.editor = "nvim";

			pull.rebase = true;
			push.autoSetupRemote = true;
			fetch.prune = true;

			alias = {
				st = "status";
				co = "checkout";
				br = "branch";
				lg = "log --oneline --graph --decorate";
			};
		};
	};
}
