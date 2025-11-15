#!/bin/sh

#  ci_post_clone.sh
#  SeaLens
#
#  Created by Handy Handy on 15/11/25.
#

#!/bin/bash
# Install Tuist
brew tap tuist/tuist

# Check version (optional)
tuist version

# Generate the Xcode project/workspace
tuist generate --no-open
