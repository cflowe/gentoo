# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="counting pipe"
HOMEPAGE="http://cpipe.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -W -Wall -pedantic \
		-o cpipe {cmdline,cpipe}.c -lm || die "compiling cpipe failed"
}

src_install() {
	dobin cpipe
	doman cpipe.1
	dodoc CHANGES
	mv index.html.in index.html
	dohtml index.html
}
