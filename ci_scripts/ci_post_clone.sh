#!/bin/sh

#  ci_post_clone.sh
#  SeaLens
#
#  Created by Handy Handy on 15/11/25.
#

#!/bin/sh

#!/bin/sh
set -e
cd ..

curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"
mise install tuist
eval "$(mise activate bash --shims)" # Addds the activated tools to $PATH
echo "👉 Setting mise globally:"
mise use -g tuist

# Runs the version of Tuist indicated in the .mise.toml file {#runs-the-version-of-tuist-indicated-in-the-misetoml-file}
mise exec -- tuist install --path ../ # `--path` needed as this is run from within the `ci_scripts` directory
mise exec -- tuist generate -p ../ --no-open # `-p` needed as this is run from within the `ci_scripts` directory

