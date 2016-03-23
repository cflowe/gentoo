# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="[Experimental] Amazon S3 Transfer Manager for Python"
HOMEPAGE="https://github.com/boto/s3transfer"
SRC_URI="https://github.com/boto/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND=">=dev-python/botocore-1.4.0[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}
    test? (
      >=dev-python/nose-1.3.1[${PYTHON_USEDEP}]
      =dev-python/mock-1.3.0[${PYTHON_USEDEP}]
      =dev-python/coverage-4.0.1[${PYTHON_USEDEP}]
      )"
