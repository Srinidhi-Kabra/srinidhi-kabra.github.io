#!/bin/bash

# Exit immediately if any command exits with a non-zero status
set -e

echo "🧹 Cleaning old build files..."
rm -rf public

echo "🚀 Building site with Hugo..."
hugo --minify

echo "📦 Committing project source changes to main branch..."
git add .
# Check if there are changes to commit so the script doesn't crash if nothing changed
git diff-index --quiet HEAD || git commit -m "Update source content"
git push origin main

echo "🌐 Deploying public folder to gh-pages branch..."
# Added the -f flag at the end to overwrite the remote branch history automatically
git subtree push --prefix public origin gh-pages -f

echo "✅ Site updated: https://srinidhi-kabra.github.io"