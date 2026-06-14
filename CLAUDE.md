# Setup Instructions

When the user says "set yourself up":

1. **Explain prerequisites first.** Before touching anything, tell the user what each prerequisite is and why it's needed:
   - **Obsidian** — a local note-taking app. Claude's memory system (context that persists between sessions) is stored as markdown files inside an Obsidian vault. Without it you can set up a plain folder, but Obsidian lets you browse and edit memories manually.
   - **Node.js 18+** — JavaScript runtime. Required to install `claude-mem`, the plugin that saves session context automatically.
   - **Windows Terminal** — Microsoft's modern terminal app. The color schemes (neon green default, arch blue for Claude) only work here — not in the old conhost or PowerShell window.
   - **Cascadia Code** — the font set in the terminal profiles. Without it Windows Terminal falls back to a default font.
   - **Python 3** — used by the `cbm-code-discovery-gate` hook to parse JSON input. The hook will silently fail without it.
   - **Visual Studio C++ Build Tools** — needed to compile native modules for `codebase-memory-mcp`. If missing, it falls back to a slower pure-JS mode — not a blocker.
   - **Git** — to clone and update this repo.
   - **gh CLI** — GitHub's official CLI. Claude uses it for PR creation, issue management, and repo operations. Needs `gh auth login` after install.
   - **Claude Code** — the CLI itself. Install with `npm install -g @anthropic-ai/claude-code`.
   - **VS Code** — editor. Setup copies a `settings.json` with the JellyFish theme and Claude Code panel location. The JellyFish extension must be installed manually from the VS Code marketplace.

2. Ask the user to confirm all prerequisites are installed before continuing.

3. Run setup.ps1 via Bash, then verify each step completed.

## What this repo sets up

1. `~/.claude/CLAUDE.md` — global Claude instructions (memory-first, minimal diffs, no co-author commits)
2. `~/.claude/settings.json` — model, plugins, MCP hooks, autoMemoryDirectory
3. `~/.claude/hooks/cbm-session-reminder` — reminds Claude to use codebase-memory-mcp on session start
4. `~/.claude/hooks/cbm-code-discovery-gate` — blocks raw file reads on first use, nudges toward graph tools
5. Windows Terminal schemes — RetroNeonGreen, linuxarchcolors, BloodMatrix, Ghost, Corrupted, Killswitch, HexDump, Static
6. Windows Terminal profiles — default PowerShell (neon green), Claude tab (arch blue)
7. PowerShell profile — PSReadLine colors + `claude` wrapper that opens Claude in arch-colored tab

## After running setup.ps1

Install plugins manually (setup.ps1 can't do this — requires interactive Claude session):
```bash
claude plugin install caveman@caveman
npx claude-mem install
```

Install codebase-memory-mcp:
```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.ps1 -OutFile install.ps1; .\install.ps1
```
Then in a new terminal: `codebase-memory-mcp install`

Set `autoMemoryDirectory` in `~/.claude/settings.json` to the actual Obsidian vault path.
