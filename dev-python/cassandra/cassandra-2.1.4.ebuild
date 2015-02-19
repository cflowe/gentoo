# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 eutils

DESCRIPTION="A Python driver for Cassandra"
HOMEPAGE="https://github.com/datastax/python-driver"
SRC_URI="https://github.com/datastax/python-driver/archive/${PV}.tar.gz"
S="${WORKDIR}/python-driver-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+lz4 snappy scales +blist +event_loop doc examples"

DEPEND=">=dev-python/six-1.6[${PYTHON_USEDEP}]
lz4? ( dev-python/lz4[${PYTHON_USEDEP}] )
snappy? ( dev-python/snappy[${PYTHON_USEDEP}] )
scales? ( dev-python/scales[${PYTHON_USEDEP}] )
blist? ( dev-python/blist[${PYTHON_USEDEP}] )
event_loop? ( >=dev-libs/libev-4 )
"
RDEPEND="${DEPEND}"

python_compile() {
	distutils-r1_python_compile
}

python_compile_all() {
	if use doc; then
		cd docs || die

		local -x PYTHONPATH="${BUILD_DIR}"/build/lib:${PYTHONPATH}

		SPHINXBUILD="${PYTHON} sphinx-build" \
			make html || die
	fi
}

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	distutils-r1_python_install_all

	use examples && dodoc example.py
}
