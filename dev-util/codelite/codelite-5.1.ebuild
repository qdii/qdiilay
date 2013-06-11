# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WX_GTK_VER="2.9"
MY_PN="${PN}git"

inherit cmake-utils wxwidgets git-2

DESCRIPTION="powerful open-source, cross platform IDE for the C/C++"
HOMEPAGE="http://www.codelite.org"
EGIT_REPO_URI="git://git.code.sf.net/p/${PN}/${MY_PN}"
EGIT_COMMIT="5.1"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug clang"

DEPEND="x11-libs/wxGTK:${WX_GTK_VER}[X]
	dev-vcs/git
	dev-util/astyle"

RDEPEND="x11-libs/wxGTK:${WX_GTK_VER}[X]
	dev-util/astyle"

src_prepare()
{
	epatch "${FILESDIR}"/${P}-honor-user-flags.patch
	epatch "${FILESDIR}"/${P}-CodeFormatter-relies-on-system-libastyle.patch
}

src_configure()
{
	if use debug ; then
		CMAKE_BUILD_TYPE=Gentoo_Debug
	else
		CMAKE_BUILD_TYPE=Gentoo_Release
	fi
	cmake-utils_use_use clang CLANG
	cmake-utils_src_configure
}
