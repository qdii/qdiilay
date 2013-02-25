# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils autotools subversion cmake-utils games

DESCRIPTION="Heroes of Might and Magic III game engine rewrite"
HOMEPAGE="http://forum.vcmi.eu/index.php"

ESVN_REPO_URI="https://vcmi.svn.sourceforge.net/svnroot/vcmi/tags/${PV}"
SRC_URI=""
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">dev-libs/boost-1.44.0
		media-libs/libsdl[video]
		media-libs/sdl-mixer
		media-libs/sdl-image
		media-libs/sdl-ttf
		sys-libs/zlib
		virtual/ffmpeg
		virtual/pkgconfig"
RDEPEND="games-strategy/vcmi-data
		media-libs/libsdl[video]
        media-libs/sdl-mixer
        media-libs/sdl-image
        media-libs/sdl-ttf
		virtual/ffmpeg"

src_unpack() {
	subversion_src_unpack
	cd "${S}"
}

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

pkg_postinst() {
	elog For the game to work properly, please copy your 
	elog \"Heroes Of Might and Magic: The Wake  Of Gods\" 
	elog game directory into ${GAMES_DATADIR}/${PN} .
	elog For more information, please visit:
	elog http://wiki.vcmi.eu/index.php?title=Installation_on_Linux
}
