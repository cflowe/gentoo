# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_4 python3_5 python3_6 )

inherit distutils-r1

DESCRIPTION="Graphical journal with calendar, templates, tags and keyword searching"
HOMEPAGE="http://rednotebook.sourceforge.net"
SRC_URI="https://github.com/jendrikseipp/rednotebook/archive/v${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="libyaml"

#	>=dev-python/pygtk-2.16[${PYTHON_USEDEP}]
RDEPEND="
	>=dev-python/pyyaml-3.05[libyaml?,${PYTHON_USEDEP}]
	>=dev-python/pywebkitgtk-1.1.8-r2[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
