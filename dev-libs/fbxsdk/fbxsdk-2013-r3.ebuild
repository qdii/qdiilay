# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Autodesk FBX"
HOMEPAGE="http://usa.autodesk.com/fbx/"
MY_PN="${PN%sdk}"
MY_PR="${PR#r}"
MY_PV="${MY_PN}${PV}${MY_PR}"
SRC_URI="http://images.autodesk.com/adsk/files/${MY_PV}_${PN}_linux.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack()
{
	unpack "$A"
	S="${WORKDIR}"
}

src_prepare()
{
	echo "y
yes
n" > "${T}"/dummy_input
}

src_compile()
{
	./${MY_PV}_${PN}_linux < "${T}"/dummy_input -w "$T" "$S" &>/dev/null
}

src_install()
{
	cd "$S"
	dodoc License.txt
	dohtml FBX_SDK_Online_Documentation.html
	doheader -r include/*
	dolib.so lib/gcc4/x64/lib${PN}-${PV}.${MY_PR}d.so 
	dolib.so lib/gcc4/x64/lib${PN}-${PV}.${MY_PR}.so
	dolib.a lib/gcc4/x64/lib${PN}-${PV}.${MY_PR}-static.a
	dolib.a lib/gcc4/x64/lib${PN}-${PV}.${MY_PR}-staticd.a
}
