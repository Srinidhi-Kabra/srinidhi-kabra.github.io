#!/bin/bash

set -e

echo "🧹 Cleaning old Hugo build..."
rm -rf public
rm -rf resources/_gen

echo "🚀 Building Hugo site..."
HUGO_ENV=production hugo --gc --minify

echo "📦 Adding changes..."
git add .

if ! git diff --cached --quiet; then
    git commit -m "Update website"
    echo "📤 Pushing main..."
    git push origin main
else
    echo "✨ No changes to commit."
fi

echo "🌐 Deploying public/ to gh-pages..."

git subtree push --prefix public origin gh-pages

echo "✅ Website deployed successfully!"