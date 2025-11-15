#!/bin/sh

#  ci_post_clone.sh
#  SeaLens
#
#  Created by Handy Handy on 15/11/25.
#

#!/bin/bash
set -euxo pipefail

# Install Tuist (if you use the recommended installer)
curl -Ls https://install.tuist.io | bash

# Make sure tuist is in PATH
export PATH="$HOME/.tuist/bin:$PATH"

# Verify
tuist version

# Generate the Xcode project / workspace
tuist generate --no-open
