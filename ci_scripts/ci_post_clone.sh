#!/bin/sh

#  ci_post_clone.sh
#  SeaLens
#
#  Created by Handy Handy on 15/11/25.
#

#!/bin/bash
set -euxo pipefail

# Install Tuist
curl -Ls https://install.tuist.io | bash

# Add Tuist to PATH
export PATH="$HOME/.tuist/bin:$PATH"

# Check version (optional)
tuist version

# Generate the Xcode project/workspace
tuist generate --no-open
