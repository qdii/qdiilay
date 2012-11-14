# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools

DESCRIPTION="A header-only cross-platform logging library"
HOMEPAGE="https://github.com/qdii/qlog"
SRC_URI="http://qdii.dodges.it/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="test? ( dev-libs/unittest-cpp )"
RDEPEND="${DEPEND}"
DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install

	# install regular doc files
	for d in AUTHORS ChangeLog COPYING INSTALL NEWS README ; do
	    [[ -s "${d}" ]] && dodoc "${d}"
	done

	# install html documentation
	dodoc -r doc/html
}
