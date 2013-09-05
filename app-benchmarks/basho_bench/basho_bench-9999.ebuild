# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Basho Bench is a benchmarking tool created to conduct accurate and repeatable performance tests and stress tests, and produce performance graphs."
HOMEPAGE="https://github.com/basho/basho_bench"
SRC_URI="https://github.com/basho/basho_bench/archive/master.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="primaryuri"

DEPEND=">=dev-lang/erlang-5.2.3.1
>=dev-lang/R-2
app-arch/unzip"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-master"

src_compile() {
  emake all || die "Make failed!"
}

src_install() {
  insinto /usr/bin

  insopts -m555
  doins basho_bench
  newins priv/compare.r compare.r
  newins priv/gp_latencies.sh gp_latencies.sh
  newins priv/gp_throughput.sh gp_throughput.sh
  newins priv/gp_throughput.sh gp_throughput.sh

  insopts -m444
  newins priv/common.r common.r

  # prime the needed R packages
  #
  # Probably shouldn't be done this way - atleast the packages are installed
  # into R's cellar.  These packages are left behind after
  # 'brew uninstall basho_bench'
  einfo "Installing required R packages"
  Rscript --vanilla /usr/bin/common.r
}
