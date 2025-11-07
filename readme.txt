| hyprland-alt gentoo overlay.
Alternative hyprland ebuilds.

All ebuils based on ::gentoo.
See https://github.com/gentoo-mirror/gentoo

USAGE:
  1. Add repository using eselect-repository
      # eselect repository add hyprland-alt git https://github.com/Amchik/hyprland-alt.git
  2. Sync it:
      # emaint -r hyprland-alt sync
  (or sync all repositories using `emerge --sync`)
  3. Update hyprland:
      # emerge --update --deep hyprland

REMOVAL:
  1. Remove repository using eselect-repository:
      # eselect repository remove hyprland-alt
  2. Update hyprland:
      # emerge --deep --update hyprland
      It may downgrade hyprland, by the way.

KNOWN ISSUES:
- gui-libs/hyprtoolkit does not compiles under gcc-14
  Solution: use >=gcc-15. Maybe clang will work too
- gui-libs/hyprland-guiutils sometimes may throw segfault.
  Solution: unset `-Wl,--as-needed` key.
  Alt. solution: do not compile it with -O3 and linker optimizations.
  I think it should reported to gui-libs/hyprland-guiutils issues...

CONFIGURATION:
All packages from this overlay has ~amd64 keyword (if it not, it is bug lol).
So you may add `*/*::hyprland-alt ~amd64` to /etc/portage/package.accept_keywords.
Also, >=hyprland-0.50 and hyprtoolkit doesn't compiles under gcc-14, so you need
to either use >=gcc-15 or compile it with new gcc. There is my configuration:
+--[ /etc/portage/package.env ]-------------------------+
| >=gui-wm/hyprland-0.50                compiler-gcc-15 |
| gui-libs/hyprtoolkit::hyprland-alt    compiler-gcc-15 |
+-------------------------------------------------------+
+--[ /etc/portage/env/compiler-gcc-15 ]-----------------+
| CC="gcc-15"                                           |
| CXX="g++-15"                                          |
| CPP="gcc-15 -E"                                       |
| AR="ar"                                               |
| NM="nm"                                               |
| RANLIB="ranlib"                                       |
+-------------------------------------------------------+

Unchanges ebuilds:
- dev-libs/hyprland-protocols    - version bump
- dev-libs/hyprlang
- gui-libs/aquamarine            - version bump
- dev-libs/hyprgraphics          - version bump, deps fix
- gui-libs/hyprcursor
- gui-libs/hyprutils             - version bump
- gui-wm/hyprland                - version bump
- gui-libs/xdg-desktop-portal-hyprland - version bump

New ebuilds:
- gui-libs/hyprtoolkit
- gui-libs/hyprland-guiutils

Removed ebuilds:
- gui-libs/hyprland-qtutils      - replaced by gui-libs/hyprland-guiutils

