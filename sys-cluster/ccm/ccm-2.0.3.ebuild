# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=(python2_7)
DISTUTILS_SINGLE_IMPL=1

inherit eutils java-pkg-2 java-ant-2 user distutils-r1

DESCRIPTION="A tool to easily create and destroy an Apache Cassandra cluster on localhost"
HOMEPAGE="https://github.com/pcmanus/ccm"
SRC_URI="https://github.com/pcmanus/${PN}/archive/${P}.tar.gz"
S="${WORKDIR}/${PN}-${P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+python"

DEPEND=">=virtual/jre-1.7 dev-java/ant"
RDEPEND=">=virtual/jre-1.7
	dev-python/six
	dev-python/pyyaml
	dev-java/ant-core
	dev-python/psutil
"

pkg_setup() {
	enewgroup cassandra
	enewuser cassandra -1 -1 -1 cassandra

	use python && python-single-r1_pkg_setup
}

python_compile_all() {
	distutils-r1_python_compile_all
}

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	distutils-r1_python_install_all
}
