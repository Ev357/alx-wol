{
  lib,
  stdenv,
  kernel,
}:
stdenv.mkDerivation rec {
  pname = "alx-wol";
  version = kernel.version;

  src = builtins.path {
    path = ../.;
    name = pname;
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildPhase =
    # bash
    ''
      make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$PWD modules
    '';

  installPhase =
    # bash
    ''
      mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
      cp alx.ko $out/lib/modules/${kernel.modDirVersion}/extra/
    '';

  meta = {
    description = "Atheros ALX Wake-on-LAN kernel module patch";
    homepage = "https://github.com/Ev357/alx-wol/tree/main";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.linux;
  };
}
