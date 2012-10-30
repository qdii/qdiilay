# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 autotools

DESCRIPTION="Parser for tatoeba database"
EGIT_REPO_URI="git://github.com/qdii/${PN}.git"
HOMEPAGE="https://github.com/qdii/tatoeba_parser"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-libs/boost[icu]"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable debug) $(use_enable debug limit-mem)
}
