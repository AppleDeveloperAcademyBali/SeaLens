#!/bin/sh

#  ci_post_clone.sh
#  SeaLens
#
#  Created by Handy Handy on 15/11/25.
#

#!/bin/bash
set -euxo pipefail

# Install Tuist
brew install --formula tuist@x.y.z

# Check version (optional)
tuist version

# Generate the Xcode project/workspace
tuist generate --no-open
