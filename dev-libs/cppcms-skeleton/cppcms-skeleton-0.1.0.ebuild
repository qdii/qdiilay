# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="A framework over cppcms"
HOMEPAGE=""
SRC_URI="http://www.reblochon.be/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
iRDEPEND="${DEPEND}"

src_prepare()
{
    epatch "${FILESDIR}"/${P}-inline-cause-missing-symbols.patch
	epatch "${FILESDIR}"/${P}-import_sql_file-to-prepare-a-state.patch
}
