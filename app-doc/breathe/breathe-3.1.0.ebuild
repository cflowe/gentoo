# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="ReStructuredText and Sphinx bridge to Doxygen"
HOMEPAGE="https://github.com/michaeljones/breathe"
SRC_URI="http://github.com/michaeljones/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="primaryuri"

DEPEND=""
RDEPEND=">=dev-python/docutils-0.11
>=dev-python/sphinx-1.2.2
>app-doc/doxygen-1.5.1
"
