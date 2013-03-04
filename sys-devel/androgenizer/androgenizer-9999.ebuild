# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 autotools

DESCRIPTION="Androgenizer tool for porting libtoolized software to Android"
HOMEPAGE="https://github.com/qdii/androgenizer.git"
EGIT_REPO_URI="git://github.com/qdii/${PN}.git"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND=""
RDEPEND=""

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable debug)
}
