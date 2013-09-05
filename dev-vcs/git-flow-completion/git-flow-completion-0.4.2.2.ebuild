# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#!/bin/bash

EAPI=5

inherit bash-completion-r1

DESCRIPTION="Bash and Zsh completion support for git-flow."
GITHUB_USER="bobthecow"
GITHUB_TAG="${PV}"
HOMEPAGE=https://github.com/${GITHUB_USER}/${PN}""
SRC_URI="https://github.com/${GITHUB_USER}/${PN}/tarball/${GITHUB_TAG} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x64 ~x86"
IUSE=""
RESTRICT="primaryuri"

DEPEND=">=dev-vcs/git-1.7.1"
RDEPEND="${DEPEND}"

src_install() {
	newbashcomp "${PN}.bash" git-flow
}

pkg_postinst() {
	elog "Run following to enable bash completion for git-flow:"
	elog "  eselect bashcomp enable git && eselect bashcomp enable git-flow"
}
