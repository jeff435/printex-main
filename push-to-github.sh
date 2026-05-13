#!/bin/bash
GITHUB_USER="jeff435"
REPO_NAME="Printex-inventory.com"

echo ""
echo "╔═══════════════════════════════════════════════════╗"
echo "║  PRINTEX — Push to GitHub (jeff435)               ║"
echo "║  Repo: Printex-inventory.com                      ║"
echo "╚═══════════════════════════════════════════════════╝"
echo ""
echo "📋 You need a GitHub Personal Access Token (PAT)."
echo "   Get one: github.com → Settings → Developer settings"
echo "   → Personal access tokens (classic) → Generate"
echo "   → Select 'repo' scope → copy the token"
echo ""
read -s -p "🔑 Paste your GitHub PAT (hidden): " GITHUB_TOKEN; echo ""

if [ -z "$GITHUB_TOKEN" ]; then echo "❌ No token. Exiting."; exit 1; fi

REPO_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${REPO_NAME}.git"

[ ! -d ".git" ] && git init && git branch -M main
git config user.name "Printex Jeff" && git config user.email "jeff435@users.noreply.github.com"

git remote get-url origin &>/dev/null && git remote set-url origin "$REPO_URL" || git remote add origin "$REPO_URL"

git add -A
if git diff --cached --quiet; then
  echo "✅ Nothing new to commit."
else
  read -p "💬 Commit message [Enter=default]: " MSG
  MSG="${MSG:-update: Printex Engineers Ltd $(date '+%Y-%m-%d')}"
  git commit -m "$MSG"
fi

echo "⬆️  Pushing..."
git push -u origin main --force && echo "
╔═══════════════════════════════════════╗
║ ✅ SUCCESS! Code is now on GitHub     ║
║  github.com/jeff435/Printex-inventory ║
║  Vercel deploys in ~60s              ║
║  Render deploys in ~2 min            ║
╚═══════════════════════════════════════╝" || echo "
╔═══════════════════════════════════════╗
║ ❌ Push failed — check that:          ║
║  1. Repo exists on GitHub (empty)     ║
║  2. PAT has 'repo' scope              ║
╚═══════════════════════════════════════╝"
