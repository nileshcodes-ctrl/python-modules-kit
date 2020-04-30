# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3+ pypy3 )
inherit distutils-r1

DESCRIPTION="sphinx extension to support coroutines in markup"
HOMEPAGE="https://github.com/aio-libs/sphinxcontrib-asyncio"
SRC_URI="https://files.pythonhosted.org/packages/03/52/14e11f82a263a6b4c3c66738952f557ee78cde51077cbd949fbf739fa9b4/sphinxcontrib-asyncio-0.2.0.tar.gz -> sphinxcontrib-asyncio-0.2.0.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="doc"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
"
RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/namespace-sphinxcontrib[${PYTHON_USEDEP}]"

python_compile_all() {
	use doc && emake -C docs html
}

python_install() {
	rm "${BUILD_DIR}"/lib/sphinxcontrib/__init__.py || die
	distutils-r1_python_install --skip-build
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
	# clean up pth files bug #623852
	find "${ED}" -name '*.pth' -delete || die
}