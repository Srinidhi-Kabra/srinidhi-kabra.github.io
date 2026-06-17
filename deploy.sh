#!/bin/bash

# Exit immediately if any command exits with a non-zero status
set -e

echo "🧹 Cleaning old build files and Hugo caches..."
rm -rf public
rm -rf resources/_gen

echo "🚀 Building site with optimized production flags..."
# HUGO_ENV=production tells Blowfish to optimize asset pipelines
# --gc triggers garbage collection to wipe stale cached resources
# --minify compresses everything for fast loading on GitHub Pages
HUGO_ENV=production hugo --gc --minify

echo "📦 Committing project source changes to main branch..."
git add .

# Prevents script from crashing if there's nothing new to commit on main
if ! git diff-index --quiet HEAD --; then
    git commit -m "Update source content and academic styles"
    echo "📤 Pushing source code to main..."
    git push origin main
else
    echo "✨ No source changes to commit."
fi

echo "🌐 Force-deploying public folder to gh-pages branch..."
# Splits the freshly generated public folder and pushes it directly
git push origin `git subtree split --prefix public main`:gh-pages --force

echo "✅ Deployment complete! Clean your browser cache (Ctrl+F5) to view changes."
echo "🔗 Site URL: https://srinidhi-kabra.github.io"