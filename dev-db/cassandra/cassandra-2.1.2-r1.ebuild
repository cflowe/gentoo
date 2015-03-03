# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=(python2_7)
DISTUTILS_SINGLE_IMPL=1

inherit eutils java-pkg-2 java-ant-2 user distutils-r1

DESCRIPTION="A highly scalable second-generation distributed database"
HOMEPAGE="http://cassandra.apache.org/"
SRC_URI="mirror://apache/cassandra/${PV}/apache-cassandra-${PV}-src.tar.gz
http://mirrors.advancedhosters.com/apache/cassandra/${PV}/apache-cassandra-${PV}-src.tar.gz
http://archive.apache.org/dist/${PN}/${PV}/apache-cassandra-${PV}-src.tar.gz"
S="${WORKDIR}/apache-cassandra-${PV}-src"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
JAVA_PKG_IUSE="doc"
IUSE="doc +examples +python"

DEPEND=">=virtual/jdk-1.7 dev-java/ant"
RDEPEND=">=virtual/jre-1.7
	!dev-db/cassandra-bin
	virtual/python-futures
"

pkg_setup() {
	enewgroup cassandra
	enewuser cassandra -1 -1 -1 cassandra

	use python && python-single-r1_pkg_setup
}

java_prepare() {
	rm -f "${S}/bin/"*.bat "${S}/bin/"*.ps1 \
		|| die "Cleanup of ${S}/bin failed"
}

src_prepare() {
	default

	if use python; then
		pushd ${S}/pylib >/dev/null
		distutils-r1_src_prepare
		popd >/dev/null
	fi&
}

src_compile() {
	ANT_TASKS="all"
	java-pkg-2_src_compile
}

src_install() {
	dobin bin/* || die "dobin failed"
	rm "${D}/usr/bin/cassandra.in.sh" \
		|| die "Failed to remove the default /usr/bin/cassandra.in.sh"

	insinto /usr/share/${PN}
	doins \
		${FILESDIR}/root/usr/share/cassandra/* \
		interface/cassandra.thrift \
		|| die "Failed to install files into /usr/share/${PN}"

	insinto /usr/share/${PN}/lib
	java-pkg_dojar lib/*.jar build/tools/lib/*.jar \
		|| die "Installation of jar dependencies failed"

	java-pkg_newjar \
		build/apache-${P}-SNAPSHOT.jar \
		apache-${PN}.jar \
		|| die "Failed to install apache-${PN}.jar"

	java-pkg_newjar \
		build/apache-${PN}-clientutil-${PV}-SNAPSHOT.jar \
		apache-${PN}-clientutil.jar \
		|| die "Failed to install apache-${PN}-clientutil.jar"

	java-pkg_newjar \
		build/apache-${PN}-thrift-${PV}-SNAPSHOT.jar \
		apache-${PN}-thrift.jar \
		|| die "Failed to install apache-${PN}-thrift.jar"

	insinto /etc/cassandra
	doins conf/*.{properties,yaml,xml,txt,sh} \
		|| die "Failed to install some config files"

	doins conf/hotspot_compiler \
		|| die "Failed to install /etc/cassandra/hotspot_compiler"

	insinto /etc/cassandra/triggers
	doins conf/triggers/* \
		|| die "Failed to setup the /etc/cassandra/triggers directory"

	newconfd "${FILESDIR}/root/etc/conf.d/cassandra" cassandra \
		|| die "Failed to install /etc/conf.d/cassandra"

	newinitd "${FILESDIR}/root/etc/init.d/cassandra" cassandra \
		|| die "Failed to install /etc/init.d/cassandra"

	insinto /etc/security/limits.d/cassandra.conf
	doins "${FILESDIR}/root/etc/security/limits.d/cassandra.conf" \
		|| die "Failed to install /etc/security/limits.d/cassandra.conf"

	insinto /etc/logrotate.d
	doins "${FILESDIR}/root/etc/logrotate.d/cassandra.disabled" \
		|| die "Failed to install /etc/logrotate.d/cassandra.disabled"

	if use python; then
		einfo 'Install Python library ...'
		pushd ${S}/pylib >/dev/null
		#distutils-r1_python_install
		esetup.py install "--root=${D}"
		popd >/dev/null
	fi

	keepdir \
		/var/log/cassandra/ \
		/var/log/cassandra/heapdump \
		/var/lib/cassandra/commitlog \
		/var/lib/cassandra/data \
		/var/lib/cassandra/saved_caches \
		|| die "keepdir failed"

	fowners -R cassandra:cassandra \
		"/var/lib/cassandra" \
		"/var/log/cassandra" \
		|| die "chown failed"

	dodoc \
		CHANGES.txt \
		LICENSE.txt \
		NEWS.txt \
		NOTICE.txt \
		README.asc \
		interface/cassandra.thrift \
		|| die "dodoc failed"

	use examples && (dodoc -r \
		conf/cqlshrc.sample \
		conf/metrics-reporter-config-sample.yaml \
		examples/ \
		|| die "Failed to install example files"
		)

	docinto licenses
	dodoc lib/licenses/* || die "dodoc failed"
	use doc && (java-pkg_dojavadoc build/javadoc/ || die "dojavadoc failed")
}
