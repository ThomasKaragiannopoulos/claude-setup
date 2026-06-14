# claude-setup

New machine? Clone this repo, cd into it, open Claude, and say **"set yourself up"**.
Claude will read `CLAUDE.md`, explain what each prerequisite is, check what's missing, run `setup.ps1`, and walk you through the rest.

> [!WARNING]
> **Review before running.** `setup.ps1` overwrites existing configs without backup:
> `~/.claude/CLAUDE.md`, `~/.claude/settings.json`, your PowerShell profile,
> Windows Terminal `settings.json`, and VS Code `settings.json`.
> If you have customizations in any of these, back them up first.
> The script is safe to re-run — it will overwrite with repo versions each time.

---

## Prerequisites

Install these before running setup. Claude will explain each one when you run "set yourself up".

| Prerequisite | Why |
|---|---|
| [Obsidian](https://obsidian.md) | Claude's memory system lives in an Obsidian vault. Notes persist across sessions. |
| [Node.js 18+](https://nodejs.org) | Required for `claude-mem` (session memory plugin) and `npx`. |
| [Windows Terminal](https://aka.ms/terminal) | The color schemes and Claude tab profile only work in Windows Terminal. |
| [Cascadia Code](https://github.com/microsoft/cascadia-code/releases) | Font used in the terminal profiles. Install via the `.ttf` files in the release. |
| [Python 3](https://www.python.org/downloads) | Used by the `cbm-code-discovery-gate` hook to parse JSON. |
| [Git](https://git-scm.com) | To clone this repo. |
| [Visual Studio C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools) | Needed by `codebase-memory-mcp` to build native modules. Non-fatal without it — falls back gracefully. |
| [gh CLI](https://cli.github.com) | GitHub CLI. Used by Claude for PR/issue operations. Needs `gh auth login` after install. |
| [Claude Code](https://claude.ai/code) | The CLI itself. `npm install -g @anthropic-ai/claude-code` |
| [VS Code](https://code.visualstudio.com) | Editor. Install the **JellyFish** extension for the theme. |

---

## What gets set up

### VS Code
- `settings.json` — JellyFish theme + Claude Code panel location
- Install the **JellyFish** extension manually from the VS Code marketplace after setup



### Claude Code config (`~/.claude/`)
| File | Purpose |
|---|---|
| `CLAUDE.md` | Global instructions — memory-first, minimal diffs, no co-author commits. Merged with [Karpathy's coding guidelines](https://github.com/multica-ai/andrej-karpathy-skills). |
| `settings.json` | Model (sonnet), plugins, MCP hooks, autoMemoryDirectory |
| `hooks/cbm-session-reminder` | Reminds Claude to use codebase-memory-mcp on every session start |
| `hooks/cbm-code-discovery-gate` | Blocks raw file reads on first use per session, nudges toward graph tools |

### Windows Terminal
- 8 color schemes: `RetroNeonGreen`, `linuxarchcolors`, `BloodMatrix`, `Ghost`, `Corrupted`, `Killswitch`, `HexDump`, `Static`
- Default profile (PowerShell) → neon green
- `Claude` profile → arch blue — used when you type `claude` in the terminal

### PowerShell profile
- PSReadLine colors (neon green syntax highlighting)
- `claude` function — opens Claude in a new tab using the arch blue profile instead of switching the current window

---

## Manual steps after setup

Setup can't do these — they need an interactive session:

```bash
# Install plugins
claude plugin install caveman@caveman
npx claude-mem install
```

```powershell
# Install codebase-memory-mcp
Invoke-WebRequest -Uri https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.ps1 -OutFile install.ps1; .\install.ps1
```
Then in a new terminal: `codebase-memory-mcp install`

Finally:
- Set `autoMemoryDirectory` in `~/.claude/settings.json` to your Obsidian vault path
- Install the **JellyFish** extension in VS Code
- Run `gh auth login` if you haven't already
