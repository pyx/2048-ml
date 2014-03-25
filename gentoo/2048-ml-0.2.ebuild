# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="2048 implemented in OCaml"
HOMEPAGE="http://xrefactor.com/projects/2048-ml"
SRC_URI="https://bitbucket.org/pyx/${PN}/get/v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-4.01"
RDEPEND="${DEPEND}"

pkg_setup() {
	export prefix=/usr
}

src_unpack() {
	unpack ${A}
	mv *${PN}* ${P} || die
}
