# Claude Code + Windows Terminal setup script
# Run from repo root. Idempotent — safe to re-run.

$ErrorActionPreference = "Stop"
$REPO = Split-Path -Parent $MyInvocation.MyCommand.Definition

function Info($msg) { Write-Host "=> $msg" -ForegroundColor Cyan }
function Ok($msg)   { Write-Host "   OK: $msg" -ForegroundColor Green }
function Warn($msg) { Write-Host "   WARN: $msg" -ForegroundColor Yellow }

# ── Prerequisites check ──────────────────────────────────────────────────────

Info "Checking prerequisites"

if (!(Get-Command claude -ErrorAction SilentlyContinue)) {
    Warn "Claude Code not found — run: npm install -g @anthropic-ai/claude-code"
} else { Ok "Claude Code found" }

if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    Warn "Node.js not found — claude-mem and npx will not work. Install from https://nodejs.org"
} else { Ok "Node.js $(node --version)" }

if (!(Get-Command gh -ErrorAction SilentlyContinue)) {
    Warn "gh CLI not found — Claude won't be able to run GitHub operations. Install from https://cli.github.com, then run: gh auth login"
} else { Ok "gh CLI found" }

if (!(Get-Command python3 -ErrorAction SilentlyContinue) -and !(Get-Command python -ErrorAction SilentlyContinue)) {
    Warn "Python 3 not found — cbm-code-discovery-gate hook will silently fail. Install from https://python.org"
} else { Ok "Python found" }

if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Warn "Git not found. Install from https://git-scm.com"
} else { Ok "Git $(git --version)" }

$wtPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (!(Test-Path $wtPath)) {
    Warn "Windows Terminal not found — terminal color schemes will not be applied. Install from https://aka.ms/terminal"
}

Write-Host ""

# ── 1. Claude config ────────────────────────────────────────────────────────

Info "Copying CLAUDE.md"
Copy-Item "$REPO\claude\CLAUDE.md" "$HOME\.claude\CLAUDE.md" -Force
Ok "~/.claude/CLAUDE.md"

Info "Copying settings.json"
$settingsDest = "$HOME\.claude\settings.json"
Copy-Item "$REPO\claude\settings.json" $settingsDest -Force
Ok "~/.claude/settings.json"
Write-Host "   NOTE: Set autoMemoryDirectory in $settingsDest to your Obsidian vault path" -ForegroundColor Yellow

Info "Copying hooks"
$hooksDir = "$HOME\.claude\hooks"
if (!(Test-Path $hooksDir)) { New-Item -ItemType Directory -Path $hooksDir | Out-Null }
Copy-Item "$REPO\claude\hooks\cbm-session-reminder" $hooksDir -Force
Copy-Item "$REPO\claude\hooks\cbm-code-discovery-gate" $hooksDir -Force
# Make executable via WSL/bash if available
bash -c "chmod +x ~/.claude/hooks/cbm-session-reminder ~/.claude/hooks/cbm-code-discovery-gate" 2>$null
Ok "hooks"

# ── 2. Windows Terminal ──────────────────────────────────────────────────────

Info "Copying Windows Terminal settings"
$wtSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
if (Test-Path (Split-Path $wtSettings)) {
    Copy-Item "$REPO\terminal\windows-terminal-settings.json" $wtSettings -Force
    Ok "Windows Terminal settings.json"
} else {
    Write-Host "   SKIP: Windows Terminal not installed" -ForegroundColor Yellow
}

# ── 3. PowerShell profile ────────────────────────────────────────────────────

Info "Copying PowerShell profile"
$psProfileDir = Split-Path $PROFILE
if (!(Test-Path $psProfileDir)) { New-Item -ItemType Directory -Path $psProfileDir | Out-Null }
Copy-Item "$REPO\terminal\powershell-profile.ps1" $PROFILE -Force
Ok $PROFILE

# ── 4. VS Code ───────────────────────────────────────────────────────────────

Info "Copying VS Code settings"
$vsCodeSettings = "$env:APPDATA\Code\User\settings.json"
if (Test-Path (Split-Path $vsCodeSettings)) {
    Copy-Item "$REPO\vscode\settings.json" $vsCodeSettings -Force
    Ok "VS Code settings.json"
    Write-Host "   NOTE: Install the JellyFish extension in VS Code manually" -ForegroundColor Yellow
} else {
    Warn "VS Code not found — skipping"
}

# ── Done ─────────────────────────────────────────────────────────────────────

Write-Host ""
Write-Host "Setup complete." -ForegroundColor Green
Write-Host ""
Write-Host "Remaining manual steps:" -ForegroundColor Yellow
Write-Host "  1. Set autoMemoryDirectory in ~/.claude/settings.json to your Obsidian vault path"
Write-Host "  2. claude plugin install caveman@caveman"
Write-Host "  3. npx claude-mem install"
Write-Host "  4. Install codebase-memory-mcp (see CLAUDE.md)"
Write-Host "  5. Restart terminal"
