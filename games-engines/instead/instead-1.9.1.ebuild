# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="INSTEAD quest engine"
HOMEPAGE="http://instead.sourceforge.net"
SRC_URI="mirror://sourceforge/instead/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-lang/lua-5.1*
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}" || die "Cannot unpack archive"
	cd "${S}" || die "Directory ${S} doesn't exist"
	cp Rules.make.system Rules.make || die "Cannot copy Rules.make.system"
	sed 's/lua5.1/lua/;'  -i Rules.make || die "Cannot patch Rules.make"
	sed 's:PREFIX=.*:PREFIX=/usr:' -i Rules.make || die "Cannot patch Rules.make"
	sed 's:BIN=.*:BIN=$(DESTDIR)'"${GAMES_BINDIR}:" -i Rules.make || die "Cannot patch Rules.make"
	sed 's:STEADPATH=$(DESTDIR)$(PREFIX)/share:STEADPATH=$(DESTDIR)'"${GAMES_DATADIR}:" -i Rules.make || die "Cannot patch Rules.make"
	sed 's:DOCPATH=$(DESTDIR)$(PREFIX)/share:DOCPATH=$(DESTDIR)'"${GAMES_DATADIR}:" -i Rules.make || die "Cannot patch Rules.make"
}

src_install() {
	emake DESTDIR="${D}"  install || die "emake install failed"
	prepgamesdirs
}
