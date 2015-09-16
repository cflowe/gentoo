# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4} )

inherit distutils-r1 eutils

DESCRIPTION="High level Python client for Elasticsearch"
HOMEPAGE="http://elasticsearch-dsl.readthedocs.org/"
SRC_URI="https://github.com/elastic/${PN}-py/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-py-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/elasticsearch-py"
RDEPEND="${DEPEND}"

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install
}
