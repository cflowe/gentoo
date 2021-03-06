# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qgis/qgis-1.7.0.ebuild,v 1.7 2014/01/06 14:52:37 jlec Exp $

EAPI=5

PYTHON_COMPAT=(python2_7)
PYTHON_REQ_USE="sqlite"

inherit python-single-r1 cmake-utils eutils multilib

DESCRIPTION="User friendly Geographic Information System"
HOMEPAGE="http://www.qgis.org/"
SRC_URI="http://qgis.org/downloads/${P}.tar.bz2
	examples? ( http://download.osgeo.org/qgis/data/qgis_sample_data.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples gps grass gsl postgres python spatialite test"

RDEPEND="
	examples? (
		app-text/txt2tags
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-genericrecommended
	)
	dev-libs/expat
	sci-geosciences/gpsbabel
	>=sci-libs/gdal-1.6.1[geos,python_targets_python2_7,spatialite?]
	>=sci-libs/libspatialindex-1.8
	sci-libs/geos
	sci-libs/gsl
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
	dev-qt/qtsql:4
	dev-qt/qtwebkit:4
	dev-python/PyQt4[webkit]
	x11-libs/qwt:5[svg]
	x11-libs/qwtpolar
	grass? ( >=sci-geosciences/grass-6.0.0[python?] )
	postgres? ( >=dev-db/postgresql-base-8.4 dev-python/psycopg )
	python? ( dev-python/PyQt4[X,sql,svg] dev-python/qscintilla-python )
	spatialite? (
		dev-db/sqlite:3
		dev-db/spatialite
	)"

DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

DOCS=( BUGS ChangeLog CODING README )

# Does not find the test binaries at all
RESTRICT="test"

PATCHES=(
	"${FILESDIR}"/patches/${PN}-2.0.1-pdflatex.patch
)

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	local mycmakeargs+=(
		"-DQGIS_MANUAL_SUBDIR=/share/man/"
		"-DBUILD_SHARED_LIBS=ON"
		"-DBINDINGS_GLOBAL_INSTALL=ON"
		"-DQGIS_LIB_SUBDIR=$(get_libdir)"
		"-DQGIS_PLUGIN_SUBDIR=$(get_libdir)/qgis"
		"-DWITH_INTERNAL_SPATIALITE=OFF"
		"-DWITH_INTERNAL_QWTPOLAR=OFF"
		"-DPEDANTIC=OFF"
		"-DWITH_APIDOC=OFF"
		$(cmake-utils_use_with postgres POSTGRESQL)
		$(cmake-utils_use_with grass GRASS)
		$(cmake-utils_use_with python BINDINGS)
		$(cmake-utils_use python BINDINGS_GLOBAL_INSTALL)
		$(cmake-utils_use_with spatialite SPATIALITE)
		$(cmake-utils_use_enable test TESTS)
	)
	use grass && mycmakeargs+=( "-DGRASS_PREFIX=/usr/" )

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newicon images/icons/qgis-icon.png qgis.png || die
	make_desktop_entry qgis "Quantum GIS" qgis

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${WORKDIR}"/qgis_sample_data/* || die "Unable to install examples"
	fi
}

pkg_postinst() {
	if use postgres; then
		elog "If you don't intend to use an external PostGIS server"
		elog "you should install:"
		elog "   dev-db/postgis"
	fi
}
