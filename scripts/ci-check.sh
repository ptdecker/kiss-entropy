#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

echo "Running CI checks from project root: $PROJECT_ROOT"
echo

echo "==> Checking rustfmt..."
cargo fmt --all -- --check

echo "==> Running Clippy (all targets, all features)..."
cargo clippy --all-targets --all-features -- -D warnings

echo "==> Running tests..."
cargo test --all-targets --all-features --verbose

echo "==> Building docs..."
cargo doc --all-features --no-deps

echo
echo "All local CI checks passed."
