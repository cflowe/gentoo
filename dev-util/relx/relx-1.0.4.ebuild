# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Sane, simple release creation for Erlang"
HOMEPAGE="http://relx.org/"
SRC_URI="http://github.com/erlware/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="primaryuri"

DEPEND="dev-lang/erlang dev-vcs/git >=dev-util/rebar-2"
RDEPEND="dev-lang/erlang"

src_prepare() {
  epatch "${FILESDIR}/1.0.4-notparallel.patch"
}

src_install() {
	dobin relx
	dodoc examples/relx.config examples/relx_simple.config
}
