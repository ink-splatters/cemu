# let
#   crossPkgs = 
#     import <nixpkgs> {
#       # uses GCC and newlib
#       crossSystem = { system = "riscv64-none-elf"; }; 
#     };
# in

# # use crossPkgs' mkShell to use the correct stdenv!
# crossPkgs.mkShell {}

with import <nixpkgs>;

let
  system = "riscv64-embedded";
  pkgsCross = import pkgsCross {
    inherit system;

    overlays = [
      (final: prev: {
        gcc = prev.gcc.overrideAttrs(_oldAttrs: {
          configureFlags = _oldAttrs.configureFlags ++ [
            "--with-arch=rv64imac"
            "--with-abi=lp64"
          ];

        });

      })
    ];

  };

in 
  
  gcc = pkgsCross.riscv64-embedded.gcc.overrideAttrs(_oldAttrs: {

      
    });
  in

  pkgsCross.riscv64-embedded



  # overlays = [
  #   (final:(prev:

  #     let 
  #       inherit (pkgsCross.riscv64-embedded) gcc;
  #     in 
  #     prev.gcc.overrideAttrs(_oldAttrs: {

  #       })

  #     ))

  #   ];

  # }; 



  # riscv-toolchain = pkgs.stdenv.mkDerivation {
  #   name = "riscv-toolchain";

  #   dontPatchELF = true;
  #   fetchSubmodules = true;

  #   src = pkgs.fetchFromGitHub {
  #     owner = "riscv";
  #     repo = "riscv-gnu-toolchain";
  #     rev = "f133b299b95065aaaf040e18b578fea6bbef532e";
  #     sha256 = null;
  #   };

  #   configureFlags = ;
  #   # buildInputs = with pkgs; [ gmp libmpc mpfr gawk bison flex texinfo gperf curl git flock ];