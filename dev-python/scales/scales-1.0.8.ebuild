# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_4} )

inherit distutils-r1 eutils

DESCRIPTION=""
HOMEPAGE="https://www.github.com/Cue/scales"
SRC_URI="https://pypi.python.org/packages/source/s/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#DEPEND=""
#RDEPEND="${DEPEND}"

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install
}
