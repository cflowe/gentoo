# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=(python3_3 python3_2 python2_7)
#PYTHON_COMPAT+=" python3_3"
#PYTHON_COMPAT+=" python3_2"

inherit distutils-r1
#inherit distutils

#PYTHON_COMPAT="python2_6 python2_7 python3_1 python3_2 python3_3"

MY_PN="pyDatalog"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A pure-python implementation of Datalog, a truly declarative language derived from prolog.  Run logic queries on databases or python objects, and use logic clauses to define python classes."
HOMEPAGE="https://sites.google.com/site/pydatalog/"
SRC_URI="https://pypi.python.org/packages/source/p/pyDatalog/${MY_P}.zip"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""
DEPEND="app-arch/unzip"
