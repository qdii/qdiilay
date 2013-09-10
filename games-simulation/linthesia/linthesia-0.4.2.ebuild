# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-2 gnome2-utils

DESCRIPTION="A piano-learning game"
EGIT_REPO_URI="git://github.com/qdii/${PN}.git"
HOMEPAGE="http://sourceforge.net/projects/linthesia/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-cpp/gtkmm
		x11-libs/pango
		dev-cpp/pangomm
		x11-libs/gtkglext
		dev-cpp/gtkglextmm
		x11-libs/libX11"
RDEPEND="${DEPEND}"

QA_DESKTOP_FILE="${GAMES_DATADIR}/${PN}/${PN}.desktop"

src_install() { 
	emake DESTDIR="${D}" install

	doicon graphics/${PN}.xpm
	domenu graphics/${PN}.desktop

	prepgamesdirs
}
