set -e

cd "${0:A:h:h}"
mise exec -- node scripts/install-nvim-kickstart.mjs
