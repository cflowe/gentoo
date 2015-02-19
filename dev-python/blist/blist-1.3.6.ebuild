# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2} )

inherit distutils-r1 eutils

DESCRIPTION="A list-like type with better asymptotic performance and similar performance on small lists"
HOMEPAGE="http://stutzbachenterprises.com/blist"
SRC_URI="https://pypi.python.org/packages/source/b/${PN}/${P}.tar.gz"

LICENSE="BSD"
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
