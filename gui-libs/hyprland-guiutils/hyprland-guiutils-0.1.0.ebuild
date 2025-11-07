EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Hyprland GUI utilities"
HOMEPAGE="https://github.com/hyprwm/hyprland-guiutils"
SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/hyprlang
	gui-libs/hyprtoolkit
	gui-libs/hyprutils:=
	x11-libs/libdrm
	x11-libs/pixman
	!gui-libs/hyprland-qtutils
"

DEPEND="${RDEPEND}"

src_prepare() {
	# See readme.txt of repository for more...
	filter-ldflags -Wl,--as-needed
	cmake_src_prepare
}

