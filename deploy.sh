#!/bin/bash

# Exit immediately if any command exits with a non-zero status
set -e

echo "🧹 Cleaning old build files..."
rm -rf public

echo "🚀 Building site with Hugo..."
hugo --minify

echo "📦 Committing project source changes to main branch..."
git add .
# Prevents script from crashing if there's nothing new to commit on main
git diff-index --quiet HEAD || git commit -m "Update source content"
git push origin main

echo "🌐 Force-deploying public folder to gh-pages branch..."
# The bulletproof subtree force-push mechanism
git push origin `git subtree split --prefix public main`:gh-pages --force

echo "✅ Site updated: https://srinidhi-kabra.github.io"