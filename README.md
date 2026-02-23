# claude-code-demo

Scripts and tools built with [Claude Code](https://claude.ai/claude-code).

---

## organize_downloads.sh

Sorts loose files in `~/Downloads` into named category folders, and sends installers to the Trash. Existing subdirectories are left untouched.

### Folders created

| Folder | Extensions |
|--------|-----------|
| `PDFs/` | `.pdf` |
| `Images/` | `.jpg` `.jpeg` `.png` `.gif` `.heic` `.webp` `.svg` |
| `Videos/` | `.mp4` `.mov` `.mkv` `.avi` |
| `Audio/` | `.mp3` `.wav` `.aac` `.m4a` |
| `Documents/` | `.doc` `.docx` `.txt` `.pages` |
| `Spreadsheets/` | `.xls` `.xlsx` `.csv` `.numbers` |
| `Archives/` | `.zip` `.rar` `.tar` `.gz` `.7z` |
| `Data/` | `.json` `.xml` `.db` `.sql` |
| `Fonts/` | `.ttf` `.otf` `.woff` |
| `Misc/` | anything else / no extension |

`.dmg` and `.pkg` installers are sent to the Trash. `.DS_Store` and `.localized` are left in place.

### Usage

```bash
bash organize_downloads.sh
```

### Requirements

- macOS (uses `/usr/bin/trash` for safe deletion)
- Bash 3.2+ (ships with macOS)
