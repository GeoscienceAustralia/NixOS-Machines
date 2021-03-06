{
  allowUnfree = true;

  packageOverrides = super: let self = super.pkgs; in with self; rec {
    # TODO: why doesn't it work without self?
    self.firefox = {
        enableAdobeFlash = true;
    };

    # TODO: move out
    # firefox-unwrapped = super.firefox-unwrapped.override {
    #     enableGTK3 = true;
    # };

    texEnv = self.texlive.combine {
      inherit (self.texlive) scheme-basic;
    };

    squirrelsql = super.callPackage ./pkgs/squirrelsql {};

    eclipse-ee-452 = super.eclipses.buildEclipse {
      name = "eclipse-ee-4.5.2";
      description = "Eclipse EE IDE";
      sources = {
        "x86_64-linux" = super.fetchurl {
          url = http://download.eclipse.org/technology/epp/downloads/release/mars/2/eclipse-jee-mars-2-linux-gtk-x86_64.tar.gz;
          sha256 = "0fp2933qs9c7drz98imzis9knyyyi7r8chhvg6zxr7975c6lcmai";
        };
      };
    };

    eclipse-ee-46 = super.eclipses.buildEclipse {
      name = "eclipse-ee-4.6";
      description = "Eclipse EE IDE";
      sources = {
        "x86_64-linux" = super.fetchurl {
          url = https://eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/neon/R/eclipse-jee-neon-R-linux-gtk-x86_64.tar.gz&r=1;
          sha256 = "1wdq02gswli3wm8j1rlzk4c8d0vpb6qgl8mw31mwn2cvx6wy55rs";
          name = "eclipse-jee-neon-R-linux-gtk-x86_64.tar.gz";
        };
      };
    };

    eclipse-ee-47 = super.eclipses.buildEclipse {
      name = "eclipse-ee-4.7";
      description = "Eclipse EE IDE";
      sources = {
        "x86_64-linux" = super.fetchurl {
          url = https://www.eclipse.org/downloads/download.php?r=1&nf=1&file=/technology/epp/downloads/release/oxygen/R/eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz;
          sha256 = "1w5l1sxqzb6w2akd8bl74qsm5a3bkrhb55fvfa9mlrdbdr5cj7vj";
          name = "eclipse-jee-oxygen-R-linux-gtk-x86_64.tar.gz";
        };
      };
    };

    systemToolsEnv = with super; buildEnv {
      name = "systemToolsEnv";
      paths = [
        ctags
        file
        firefox
        fzf
        gcc
        git
        gitAndTools.hub
        gnumake
        inetutils
        keychain
        nix-prefetch-scripts
        nix-repl
        nload
        shellcheck
        tmux
        tree
        unzip
        vim_configurable
        wget
        which
        xsel
        zip
      ];
    };

    javaEnv = with super; buildEnv {
      name = "javaEnv";
      paths = [
        openjdk
        maven
        eclipse-ee-47
        # idea.idea-ultimate
        # idea.idea-community
        gradle
      ];
    };

    pythonEnv = with super; buildEnv {
      name = "pythonEnv";
      paths = [
        python3
      ];
    };

    awsEnv = with super; buildEnv {
      name = "awsEnv";
      paths = [
        awscli
      ];
    };

    buildTypeScriptEnv = { nodeVersion ? "default" }:
      let
        np = if nodeVersion == "default"
          then super.nodePackages
          else lib.getAttrFromPath [("nodePackages_" + nodeVersion)] super;
        node = if nodeVersion == "default"
          then super.nodejs
          else lib.getAttrFromPath [("nodejs-" + nodeVersion)] super;
      in super.buildEnv {
        name = "typeScriptDevEnv-${nodeVersion}";
        paths = [
          node
          np.typescript
          np.gulp
        ];
      };

    typeScriptEnv = buildTypeScriptEnv { nodeVersion = "4_x"; };

    buildHaskellEnv = { compiler ? "default" }:
      let
        hp = if compiler == "default"
          then super.haskellPackages
          else super.haskell.packages.${compiler};
      in super.buildEnv {
        name = "haskellEnv-${compiler}";
        paths = [
          hp.ghc
          hp.stack
          hp.hdevtools
        ];
      };

    haskellEnv = buildHaskellEnv {};

    haskellEnv-ghc7103 = buildHaskellEnv {
      compiler = "ghc7103";
    };

  };
}
