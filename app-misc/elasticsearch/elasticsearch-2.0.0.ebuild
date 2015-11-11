# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils systemd user

DESCRIPTION="Open Source, Distributed, RESTful, Search Engine"
HOMEPAGE="https://www.elastic.co/products/elasticsearch"
#SRC_URI="https://download.elasticsearch.org/${PN}/release/org/${PN}/distribution/tar/${PN}/${PV}/${P}.tar.gz"
SRC_URI="https://download.elastic.co/${PN}/${PN}/${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

RDEPEND="|| ( virtual/jre:1.7 virtual/jre:1.8 )"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 /bin/bash /var/lib/${PN} ${PN}
}

src_prepare() {
	rm -rf bin/*.{bat,exe}
	rm LICENSE.txt
}

src_install() {
	dodir /etc/${PN}
	dodir /etc/${PN}/scripts

	insinto /usr/share/doc/${P}/examples
	doins config/*
	rm -rf config

	insinto /usr/share/${PN}
	doins -r ./*
	chmod +x "${D}"/usr/share/${PN}/bin/*

	dodir /usr/share/${PN}/plugins

	keepdir /var/{lib,log}/${PN}

	newinitd "${FILESDIR}/elasticsearch.init4" "${PN}"
	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
	systemd_newunit "${FILESDIR}"/${PN}.service4 "${PN}.service"
}

pkg_postinst() {
	elog
	elog "You may create multiple instances of ${PN} by"
	elog "symlinking the init script:"
	elog "ln -sf /etc/init.d/${PN} /etc/init.d/${PN}.instance"
	elog
	elog "Each of the example files in /usr/share/doc/${P}/examples"
	elog "should be extracted to the proper configuration directory:"
	elog "/etc/${PN} (for standard init)"
	elog "/etc/${PN}/instance (for symlinked init)"
	elog
}
