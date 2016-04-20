# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit golang-build golang-vcs-snapshot

DESCRIPTION="A fast and powerful open source alternative to grep"
HOMEPAGE="https://sift-tool.org/"

EGIT_COMMIT="v${PV}"
EGO_PN='github.com/svent/sift'

SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/go"
RDEPEND="${DEPEND}"

src_install() {
  dobin sift
}
