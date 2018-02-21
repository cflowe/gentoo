# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_5 python3_6 )
inherit distutils-r1 python-r1 virtualx
#inherit distutils-r1
#inherit autotools-utils python-r1 virtualx

DESCRIPTION="Python bindings for the WebKit GTK+ port"
HOMEPAGE="http://code.google.com/p/pywebkitgtk/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/pywebkitgtk/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="test"

#	dev-python/pygtk:2[${PYTHON_USEDEP}]
RDEPEND="dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-libs/libxslt
	>=net-libs/webkit-gtk-1.1.15:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local myeconfargs=( --disable-static )
	python_foreach_impl autotools-utils_src_configure
}

src_compile() {
	python_foreach_impl autotools-utils_src_compile
}

src_test() {
	testing() {
		local test st=0
		for test in tests/test_*.py; do
			PYTHONPATH="${BUILD_DIR}/.libs" "${PYTHON}" "${test}"
			(( st |= $? ))
		done
		return ${st}
	}
	VIRTUALX_COMMAND=testing python_foreach_impl virtualmake
}

src_install() {
	local AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
	local DOCS=( AUTHORS MAINTAINERS NEWS README )
	python_foreach_impl autotools-utils_src_install
}
