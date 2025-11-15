#!/bin/zsh

#  ci_post_clone.sh
#  SeaLens
#
#  Run by Xcode Cloud in Post-clone phase
#

#!/bin/sh
echo "👉 Start CI Script"
set -e
echo "1️⃣ set -e done"

BASEDIR=$(dirname "$0")
echo "Script location (script file): ${BASEDIR}"

cd ..
echo "📂 Current working directory: $(pwd)"
echo "2️⃣ cd.."

curl -fsSL https://mise.run | sh
echo "👉 curl https://mise.run | sh done"

export PATH="$HOME/.local/bin:$PATH"
echo "1️⃣ PATH HOME done"

mise install tuist
echo "2️⃣ install tuist done"

eval "$(mise activate bash --shims)"
echo "👉 Setting mise globally:"

mise use -g tuist
echo "1️⃣ mise use -g tuist done"

# Run tuist from repo root (NO ../ here)
CI=0 mise exec -- tuist install
echo "1️⃣ tuist install done"

CI=0 mise exec -- tuist generate --no-open
echo "1️⃣ tuist generate done"
