# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/shflags/shflags-1.0.3.ebuild,v 1.1 2011/10/15 17:40:57 vapier Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Command-line flags module for Unix shell scripts"
HOMEPAGE="http://code.google.com/p/shflags/"
SRC_URI="http://shflags.googlecode.com/files/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="examples"

src_test() {
	cd src
	./shflags_test.sh || die
}

src_prepare() {
	      epatch "${FILESDIR}"/${PN}-1.0.3-add-support-for-busybox-getopt.patch
}

src_install() {
	dohtml README.html
	dodoc README.txt doc/*.txt
	insinto /usr/$(get_libdir)
	doins src/shflags
	use examples && dodoc examples/*.sh
}
