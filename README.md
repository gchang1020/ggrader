# Presentation Grader

A local HTML/JavaScript grading tool for Canvas-based group presentations.

## Files

- `index.html` — the grading application. No server or installation is required.
- `rubric.csv` — example rubric file. Replace/edit this with your actual rubric, keeping the same column headers (see "CSV format requirements" below).

That's the whole set — share just these two files with co-faculty. The roster CSV comes straight from Canvas each time and doesn't need to travel with the app.

## CSV format requirements

Any CSV that has these columns will work — it doesn't have to come from Canvas. Column name matching ignores case and treats spaces, underscores, and dashes as the same thing (so `group_name`, `Group Name`, and `group-name` all match).

**Roster CSV** — one row per student:

- `name` — **Required.** Student's display name.
- `group_name` — **Required.** The presentation group's name — students who share this value are grouped together (unless `canvas_group_id` is also present; see below).
- `canvas_user_id` — Recommended. A unique student ID. Used to tell apart two students with the same name, and included in the exported CSV to make matching back to Canvas safer. If omitted, the app falls back to matching by name.
- `canvas_group_id` — Optional. A unique group ID. If present, this — not `group_name` — is used to group students, which protects against two different groups accidentally sharing the same name.
- `login_id`, `sections` — Optional. Carried through if present; not used for grading logic.

Minimal example:

```csv
name,group_name
Ball Jessie,Team A
Headlam Camille,Team A
Crivella Tyler,Team B
```

**Rubric CSV** — one row per rubric item:

- `index` — **Required.** Display order / label for the rubric item (e.g. `1`, `2`, ...).
- `rubric text` — **Required.** The full rubric description. Its first word is used as the compact column heading in the grading table (e.g. "Content and accuracy" → shown as `Content (5)`).
- `max points` — **Required.** The maximum score for that item; scores must be a whole number from 0 to this value.

Minimal example (this is what `rubric.csv` already contains):

```csv
index,rubric text,max points
1,Content and accuracy,5
2,Analysis,5
```

If a required column is missing from either file, **Load files** will refuse to load it and tell you which column is missing, rather than loading with wrong or blank data.

## Use

1. Open `index.html` in Chrome or Edge.
2. On **Setup**, enter a **Class name/ID/code** (e.g. `PSCI-3350-001`). This is required — it's what keeps different courses/sections from ever being confused with each other, and it prefixes the exported CSV's filename (step 12).
3. Download/export the Canvas roster CSV containing at least:
   - `name`
   - `group_name`
   - preferably `canvas_user_id`
4. Select the Canvas roster CSV and `rubric.csv`.
5. Click **Load files**. If nothing was saved yet for this exact roster+rubric, it just loads. If a save already exists (last saved at some timestamp), you're asked to pick one: **Same score sheet** (continue, restoring those scores) or **New score sheet** (erase them and start this roster+rubric blank).
6. Use:
   - **Rubrics** to confirm the rubric.
   - **Students & Scores** to see all students and scores.
   - **Groups** to see group membership.
   - **GRADING** to grade presentations.
7. In GRADING, groups are randomized once for the session.
8. Select a group. Members are displayed alphabetically.
9. Rubric headings use `FirstWord (MaxPoints)`. Click a heading to see the full rubric text.
10. Enter integer scores from 0 through the rubric's maximum. Typing alone does **not** save anything — see "The three GRADING buttons" below.
11. Click **Save Group** to actually record the scores you just typed.
12. Click **Export Scores CSV** to create `<classID>-scores-YYYY-MM-DD.csv`.

## The three GRADING buttons

They do three different things, and only one of them writes anything:

- **Save Group** — validates the scores currently typed for the *selected group* and is the only thing that actually records them (into the app's memory and the browser's local storage). Nothing you type is kept until you click it. If any field is invalid, it's highlighted red, listed by name below the table, and the save is blocked until you fix it. Switching to a different group, leaving the Grading tab, or clicking Export while you have unsaved typed values will ask you to confirm first, since doing so discards anything not yet saved.
- **Clear Current Group** — after a confirmation prompt, erases all *saved* scores for every member of the *selected group only*. It does not touch any other group.
- **Export Scores CSV** — downloads a CSV snapshot of every group's *saved* scores (not just the selected one). If the group on screen has unsaved typed values, you'll be warned that they won't be in the export unless you Save Group first. This is a one-way export for your records/Canvas upload; export as many times as you like.

## Where files are saved

- **Scores while grading**: kept only in this browser's local storage, in a slot keyed to the *exact content* of the roster and rubric CSVs you loaded (not just their filenames). Reloading the same two files later — even next week — will bring those same scores back on purpose, so an accidental tab close never loses your work. It's not a file and isn't in this folder; it won't show up in a different browser or on a different computer.
  - **If you ever reuse the exact same roster+rubric files for a different grading round** (e.g. finals presentations, same class), the app can't tell the two rounds apart by file content alone — so **Load files** will stop and ask you to choose **Same score sheet** or **New score sheet** (see step 5 above) instead of silently picking one for you.
- **Exported Scores CSV**: a normal browser download. It goes wherever your browser is configured to save downloads (commonly a `Downloads` folder), *not* automatically into this `PresentationGrader` folder — a webpage can't write directly into an arbitrary folder on your computer for security reasons. After exporting, move/copy the CSV into this folder yourself, or set your browser to "Ask where to save each file" (Chrome/Edge: Settings → Downloads) so you can choose this folder every time you export.

## Important

The application is completely local. Student data and grades are processed in the browser and are not sent to a web server.

The exported CSV includes `canvas_user_id` in addition to the requested student name, group name, and rubric columns. This makes later matching with Canvas safer.

## iPhone / mobile use

**Don't download the files onto the phone** (not from Drive, OneDrive, Email, or AirDrop). A downloaded copy is just a local file with no web address, and iOS sometimes displays a local HTML file as a static, non-interactive preview — the page loads and looks right, but none of the buttons do anything, even with the phone's JavaScript setting on.

**Instead, open the app's real web link** in Safari:

https://claude.ai/artifact/SgmXCoVBR1j5B8Nky5Wpwq

That's a genuine webpage (never downloaded), so it always runs correctly. The roster and rubric CSVs are still picked on the phone itself and never leave the browser — this link changes nothing about privacy, only how the app is reached.

Optional, to make it feel like an app: in Safari, tap the Share icon → **Add to Home Screen**. That adds an icon that opens the page full-screen with no address bar.

**Each phone's scores stay separate** — nothing is shared or synced between different people's phones just because they use the same link, same as loading local files on a computer.

**Keeping this link up to date**: this published link is a separate copy of `index.html`, not the same file as this folder's. Editing `index.html` here does not change the link — whoever maintains it needs to ask Claude to republish it with the latest version.

**Landscape / rotating the screen**: if the grading table feels cramped, turn the phone sideways. If it doesn't rotate, iOS's rotation lock is probably on: Settings → Control Center → **Customize Controls** → add **Rotation Lock** (on some iOS versions this is labeled **Portrait Orientation Lock**) → then swipe down from the top-right corner of the screen and tap that icon off.

### Mobile / iPhone layout
The grading screen is optimized for narrow phone screens:
- presentation groups are always listed one per row (this is true on desktop too, to keep the list easy to scan);
- rubric headings show `FirstWord (max)`;
- score-entry columns use fixed, compact widths so all rubric columns stay visible without horizontal scrolling;
- other wide tables (Students, Groups, Rubrics) scroll horizontally instead of squeezing their columns unreadably thin;
- validation messages appear in their own row below the grading table (never squeezed beside it), and name the specific student and rubric item, plus whether the problem is the data type (not a whole number) or the value being out of the rubric's 0–max range — e.g. "Ball, Jessie — Analysis: out of range (must be 0–5)."
