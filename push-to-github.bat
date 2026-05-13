@echo off
set GITHUB_USER=jeff435
set REPO_NAME=Printex-inventory.com

echo.
echo  PRINTEX - Push to GitHub (jeff435)
echo  Repo: Printex-inventory.com
echo.
echo  You need a GitHub Personal Access Token (PAT).
echo  Get one: github.com - Settings - Developer settings
echo  - Personal access tokens (classic) - Generate new token
echo  - Check "repo" scope - Copy the token
echo.
set /p GITHUB_TOKEN="Paste your GitHub PAT: "
if "%GITHUB_TOKEN%"=="" ( echo No token. Exiting. & pause & exit /b 1 )

set REPO_URL=https://%GITHUB_USER%:%GITHUB_TOKEN%@github.com/%GITHUB_USER%/%REPO_NAME%.git

if not exist ".git\" ( git init & git branch -M main )
git config user.name "Printex Jeff"
git config user.email "jeff435@users.noreply.github.com"

git remote get-url origin >nul 2>&1 && git remote set-url origin %REPO_URL% || git remote add origin %REPO_URL%

git add -A
git diff --cached --quiet && (echo Nothing to commit.) || (
  set /p MSG="Commit message [Enter=default]: "
  if "%MSG%"=="" set MSG=update: Printex Engineers Ltd
  git commit -m "%MSG%"
)

echo Pushing to GitHub...
git push -u origin main --force
if %ERRORLEVEL%==0 (
  echo.
  echo  SUCCESS! Code is now on GitHub
  echo  github.com/jeff435/Printex-inventory.com
  echo  Vercel deploys in ~60s, Render in ~2 min
) else (
  echo  FAILED - Check repo exists on GitHub and PAT has repo scope
)
pause
