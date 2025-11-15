#!/bin/zsh

#  ci_post_clone.sh
#  SeaLens
#
#  Run by Xcode Cloud in Post-clone phase
#

set -euxo pipefail

echo "👉 Start CI Script"

# 1. Move from ci_scripts to repo root: /Volumes/workspace/repository
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."
echo "📂 Working directory: $(pwd)"

# 2. Install mise
curl -fsSL https://mise.run | sh
echo "✅ mise installer done"

# 3. Add mise to PATH & activate for this shell
export PATH="$HOME/.local/bin:$PATH"
eval "$("$HOME/.local/bin/mise" activate zsh --shims)"
echo "✅ mise activated"

# 4. Install tuist (based on your .mise.toml, if any)
mise install tuist
echo "✅ mise install tuist done"

# 5. Run Tuist from the repo root (NO ../ here)
mise exec -- tuist fetch
echo "✅ tuist fetch done"

mise exec -- tuist generate --no-open
echo "✅ tuist generate done"

echo "🎉 CI post-clone script finished successfully"
