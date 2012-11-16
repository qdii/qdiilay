# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils

MY_P="UnitTest++"
DESCRIPTION="Unit testing framework for C++"
HOMEPAGE="http://unittest-cpp.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${MY_P}/${PVR}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
DOCS="COPYING INSTALL README docs/UnitTest++.html"

src_unpack()
{
	unpack "${A}"
	S="${WORKDIR}"/${MY_P}
}
src_prepare()
{
	epatch "${FILESDIR}"/${P}-autoconf-build-system.patch
	eautoreconf
}
