# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libopkele/libopkele-2.0.4.ebuild,v 1.1 2012/10/12 06:49:13 patrick Exp $

EAPI="4"

inherit eutils

DESCRIPTION="A C++ implementation of an OpenID decentralized identity system"
HOMEPAGE="http://kin.klever.net/libopkele/"
SRC_URI="http://kin.klever.net/dist/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="app-text/htmltidy
	dev-libs/libpcre
	dev-libs/openssl
	net-misc/curl"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-header-for-exit.patch
	epatch "${FILESDIR}"/${P}-multimap-insert-argument-lookup.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	if use doc ; then
		emake dox
		dodoc -r "$S"/doxydox
	fi
	dodoc AUTHORS NEWS ChangeLog INSTALL README NEWS
}


