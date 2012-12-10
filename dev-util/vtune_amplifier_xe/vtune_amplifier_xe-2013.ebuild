# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit multilib user

DESCRIPTION="Intel integrated performance analysis and tuning environment"
HOMEPAGE="http://software.intel.com/en-us/intel-vtune-amplifier-xe"
SRC_URI="http://registrationcenter-download.intel.com/akdlm/irc_nas/2734/vtune_amplifier_xe_2013.tar.gz"

LICENSE="intel-vtune2013"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"
MY_P="${PN}_${PV}"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup()
{
    enewgroup 'vtune'
}

src_unpack()
{
	unpack "${A}"
	S="${WORKDIR}/${MY_P}"
}

src_configure()
{
    if [ -z "$VTUNE2013_SERIAL" ]
    then
        eerror "================================================"
    	eerror "VTune requires a serial key that will be checked"
    	eerror "by intel during the intallation process"
        eerror "Please set your VTUNE2013_SERIAL env variable to"
        eerror "your serial (something like XXXX-XXXXXXXX)."
        eerror "================================================"
        die "VTUNE2013_SERIAL is not set"
    else
        serial="$VTUNE2013_SERIAL"
        sed -e 's/ACTIVATION=exist_lic/ACTIVATION=serial_number/' \
            -e "s/#PSET_SERIAL_NUMBER=xxxx-xxxxxxxx/PSET_SERIAL_NUMBER=$VTUNE2013_SERIAL/" \
            -e 's/INSTALL_MODE=RPM/INSTALL_MODE=NONRPM/' \
            -e "s#PSET_INSTALL_DIR=/opt/intel/vtune_amplifier_xe_2013#PSET_INSTALL_DIR="${T}"/install#" \
            -i silent.cfg
    fi
}

src_compile()
{
    local libdir=$(get_libdir)

    # intel's installer needs a temporary directoy
    local tmp_compdir="${T}"/temp_install
    mkdir -p "${tmp_compdir}"

    # run the intel installer to extract the rpms into /opt directory
    ./install.sh -t "${tmp_compdir}" -s silent.cfg &>/dev/null

    # create launchers
    echo ". /opt/intel/${MY_P}/amplxe-vars.sh quiet
amplxe-gui" >> "${T}"/vtune-gui || die

    echo ". /opt/intel/${MY_P}/amplxe-vars.sh quiet
amplxe-cl" >> "${T}"/vtune-cl || die

    # modify intel environment variable script
    sed -i -e "s#export VTUNE_AMPLIFIER_XE_2013_DIR=.*#export VTUNE_AMPLIFIER_XE_2013_DIR=/opt/intel/${MY_P}#" \
           -e "s#export PATH=.*#export PATH=/opt/intel/${MY_P}/$(echo $libdir | sed s/lib/bin/):\$PATH#" \
           -e '/export MANPATH=.*/d' "${T}"/install/amplxe-vars.sh
}

src_install()
{
    local libdir=$(get_libdir)

    cd "${T}"/install
    
    insopts "-g vtune -m 0054"
    insinto /opt/intel/${MY_P}
    doins -r *
    insopts "-g vtune -m 0055"

    #pin needs to be run by other people
    insinto /opt/intel/${MY_P}/bin64
    doins bin64/pin
    doman man/man1/*.1

    #pin needs to be run by other people
    insinto /opt/intel/${MY_P}/bin32
    doins bin32/pin
    doman man/man1/*.1

#   dosbin -r "$(echo $libdir | sed s/lib/bin/)"
    dosbin "${T}"/vtune-gui
    dosbin "${T}"/vtune-cl

    dodoc support.txt
    dodoc -r documentation
}

#	echo
#	einfo "Serial format is: XXXX-XXXXXXXX"
#	while true ; do
#		einfo "Please enter your serial:"
#		read CDKEY1
#		einfo "Please re-enter your serial:"
#		read CDKEY2
#		if [[ -z ${CDKEY1} ]] || [[ -z ${CDKEY2} ]] ; then
#			echo "You entered a blank serial. Try again."
#		else
#			if [[ ${CDKEY1} == ${CDKEY2} ]] ; then
#               echo ENTERED SERIAL:
#				echo "${CDKEY1}" | tr [:lower:] [:upper:]
#				einfo "Thank you!"
#				break
#			else
#				eerror "Your serial entries do not match. Try again." 
#			fi
#		fi
#	done
