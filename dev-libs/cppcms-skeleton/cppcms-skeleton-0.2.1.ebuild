# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

MY_PN="cppcmsskel"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A framework over cppcms"
HOMEPAGE=""
SRC_URI="http://www.reblochon.be/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

USE="debug"

src_unpack()
{
    unpack "${A}"
	S="${WORKDIR}/${MY_P}"
}

src_prepare()
{
	epatch "${FILESDIR}"/${P}-honor-cxxflags.patch
}
