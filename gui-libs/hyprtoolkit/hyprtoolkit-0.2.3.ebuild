EAPI=8

inherit cmake

DESCRIPTION="A modern C++ Wayland-native GUI toolkit"
HOMEPAGE="https://github.com/hyprwm/hyprtoolkit"
SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=gui-libs/aquamarine-0.9.5:=
	x11-libs/cairo
	dev-libs/glib:2
	>=dev-libs/hyprgraphics-0.3.0:=
	dev-libs/hyprlang
	>=gui-libs/hyprutils-0.9.0:=
	dev-libs/iniparser:=
	x11-libs/libdrm
	media-libs/libglvnd
	x11-libs/libxkbcommon
	media-libs/mesa
	x11-libs/pango
	x11-libs/pixman
	dev-libs/wayland
"

DEPEND="${RDEPEND}"

RESTRICT="test"

src_configure() {
	MYCMAKEARGS="-DDISABLE_TESTS=ON"
	cmake_src_configure
}

