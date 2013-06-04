# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sparkleshare/sparkleshare-0.8.4.ebuild,v 1.2 2012/05/05 03:20:40 jdhore Exp $

EAPI="4"

GCONF_DEBUG="no" # --enable-debug does not do anything
PYTHON_DEPEND="2"

inherit gnome2

DESCRIPTION="Git-based collaboration and file sharing tool"
HOMEPAGE="http://www.sparkleshare.org"
SRC_URI="http://bitbucket.org/hbons/sparkleshare/downloads/${PN}-linux-${PV}-tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug" 

COMMON_DEPEND=">=dev-lang/mono-2.8
	>=dev-dotnet/glib-sharp-2.12.7
	>=dev-dotnet/gtk-sharp-2.12.10
	dev-dotnet/notify-sharp
	dev-dotnet/webkit-sharp
"
RDEPEND="${COMMON_DEPEND}
	>=dev-vcs/git-1.8.0
	gnome-base/gvfs
	net-misc/curl[ssl]
	net-misc/openssh
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40.6
	virtual/pkgconfig
"

pkg_postinst()
{
	gnome2_icon_cache_update
}

pkg_postrm()
{
	gnome2_icon_cache_update
}
