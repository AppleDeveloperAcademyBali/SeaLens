#!/bin/sh

#  ci_post_clone.sh
#  SeaLens
#
#  Created by Handy Handy on 15/11/25.
#

#!/bin/sh
echo "👉 Start CI Script"
set -e
echo "1️⃣ set -e done"
cd ..
echo "2️⃣ cd.."

curl https://mise.run | sh
echo "👉 curl https://mise.run | sh done"
export PATH="$HOME/.local/bin:$PATH"
echo "1️⃣ PATH HOME done"
mise install tuist
echo "2️⃣ install tuist done"
eval "$(mise activate bash --shims)" # Addds the activated tools to $PATH
echo "👉 Setting mise globally:"
mise use -g tuist
echo "1️⃣ mise use -g tuist done"

# Runs the version of Tuist indicated in the .mise.toml file {#runs-the-version-of-tuist-indicated-in-the-misetoml-file}
mise exec -- tuist install --path ../ # `--path` needed as this is run from within the `ci_scripts` directory
echo "1️⃣ tuist install done"

BASEDIR=$(dirname $0)
echo "Script location: ${BASEDIR}"

mise exec -- tuist generate -p ../ --no-open # `-p` needed as this is run from within the `ci_scripts` directory
echo "1️⃣ tuist generate done"

