# Obsidian theme compatibility (research)

Researched 2026-09-30 against official developer docs, official changelogs, `obsidianmd/obsidian-releases`, this repo, and a live **Obsidian 1.13.7** desktop session (disposable vault, AnuPpuccin + dark Macchiato, `app.css` + computed CSS). Goal: maintenance modernization for current stable desktop, preserving dark **Macchiato** palette values.

**Baseline vs later work.** The first pass recorded the then-current tree (`manifest.json` **1.5.0**, `minAppVersion` **1.6.0**, duplicate `obsidian.css`, no package/lock/CI) and live DOM against that compiled CSS. This note keeps those live findings, then records packaging/source work applied afterward. Do not read baseline “this repo” rows as the current tree.

Live baseline session: vault note `Compatibility.md` in Live Preview (YAML properties, note callout, table, checkboxes). Settings opened in a pop-out window. Web viewer core plugin was off; no `.base` file was mounted. Later live re-query (same 1.13.7, Macchiato, **accent toggle off**) confirmed stock `--accent-h/s/l` and `--table-selection-border-color`.

## Current official versions

| Channel | Version | Date | Source |
| --- | --- | --- | --- |
| Latest **public** desktop (stable) | **1.13.7** | 2026-08-12 | [Desktop 1.13.7](https://obsidian.md/changelog/2026-08-12-desktop-v1.13.7/), [changelog index](https://obsidian.md/changelog) |
| 1.13 feature drop (public) | 1.13.4 | 2026-07-30 | [Desktop 1.13 public](https://obsidian.md/changelog/2026-07-30-desktop-v1.13.4/) |
| Latest **catalyst** desktop | 1.14.3 | 2026-09-29 | [Desktop 1.14.3 early access](https://obsidian.md/changelog/2026-09-29-desktop-v1.14.3/) |

Live Settings UI showed **Version 1.13.7**. 1.13.8 public exists for **mobile only**. Do not treat 1.14 CSS prefixes (`--tooltip-`, `--notice-`, `--hotkey`, `--tab-inner-`) as a current requirement; they were empty on this 1.13.7 body.

Official sample theme uses `minAppVersion` `1.10.6` ([obsidian-sample-theme/manifest.json](https://github.com/obsidianmd/obsidian-sample-theme/blob/master/manifest.json)). Upstream GitHub release [v1.5.0](https://github.com/AnubisNekhet/AnuPpuccin/releases/tag/v1.5.0) is 2024-05-10. This fork’s current `manifest.json` is **1.6.0** / `minAppVersion` **1.13.0** (see Applied).

## Official author requirements (current)

Authoritative pages:

- [Theme guidelines](https://docs.obsidian.md/Themes/App+themes/Theme+guidelines) ([source](https://github.com/obsidianmd/obsidian-developer-docs/blob/master/en/Themes/App%20themes/Theme%20guidelines.md))
- [Build a theme](https://docs.obsidian.md/Themes/App+themes/Build+a+theme)
- [Submit your theme](https://docs.obsidian.md/Themes/App+themes/Submit+your+theme)
- [Release with GitHub Actions](https://docs.obsidian.md/Themes/App+themes/Release+your+theme+with+GitHub+Actions)
- [Embed fonts and images](https://docs.obsidian.md/Themes/App+themes/Embed+fonts+and+images+in+your+theme)
- [Manifest](https://docs.obsidian.md/Reference/Manifest)
- [Developer policies](https://docs.obsidian.md/community-directory/developer-policies)
- [Manage your plugin or theme](https://docs.obsidian.md/community-directory/manage-entry)
- [CSS variables](https://docs.obsidian.md/Reference/CSS+variables/CSS+variables) / [About styling](https://docs.obsidian.md/Reference/CSS+variables/About+styling) / [Colors](https://docs.obsidian.md/Reference/CSS+variables/Foundations/Colors)
- [RTL](https://docs.obsidian.md/Plugins/User+interface/Right-to-left) (themes included; new in 1.6)
- [Obsidian October theme checklist](https://docs.obsidian.md/oo/theme) (self-critique, not a listing gate)

**Required for directory listing**

| Item | Official rule | This repo (current) |
| --- | --- | --- |
| `manifest.json` | Required: `name`, `version` (`x.y.z`), `minAppVersion`, `author`. Optional: `authorUrl`, `fundingUrl`. `description` is **plugin-only**. Theme `name` cannot change after listing. | Present. `version` **1.6.0**, `minAppVersion` **1.13.0**. No `fundingUrl`. |
| Root files | `README.md`, `LICENSE`, screenshot, `manifest.json` | Present. `preview.png` is 461×288 (recommended community thumbnail is 512×288). |
| Release assets | GitHub release whose **tag equals** `manifest.json` `version`; attach `manifest.json` + `theme.css` | Upstream listed tag remains `v1.5.0` vs then-manifest `1.5.0`. This fork has not published a 1.6.0 GitHub release (build CI does **not** publish). New releases SHOULD use unprefixed `x.y.z`. |
| No remote assets | Themes MUST NOT load network fonts/images; bundle as data URLs | No `url(http…)` in CSS. |
| License | `LICENSE` file required | GPL-3.0 (`LICENSE`). |
| Forks | New directory listings of forks need original-author approval, or 6 months unmaintained + 30-day notice, plus credit | Community JSON still points at `anubisnekhet/AnuPpuccin`. This clone is `TheAnachronism/AnuPpuccin`. Do not submit a second listing. |

**Recommended, not listing-blocking**

- Override CSS variables on `body` / `.theme-dark` / `.theme-light`; keep selectors low-specificity.
- Avoid `!important`.
- Sass is an allowed preprocessor ([embed assets](https://docs.obsidian.md/Themes/App+themes/Embed+fonts+and+images+in+your+theme)). This repo now pins Dart Sass **1.105.1** via `package.json` + `bun.lock`; README / Makefile wrap `bun run build` and `bun run build:snippets`. There is still **no** required Node toolchain in Obsidian’s own docs.
- Optional GitHub Actions *release* workflow attaches `manifest.json` + `theme.css` on tag push (`actions/checkout@v7` in current docs). This repo has **build CI only** (`.github/workflows/build.yml`: install, `build`, `build:snippets`). No release publishing.
- New community directory also accepts listing screenshots up to 5 desktop images at 1200×800 ([manage entry](https://docs.obsidian.md/community-directory/manage-entry)). App install list is still `community-css-themes.json` in [obsidian-releases](https://github.com/obsidianmd/obsidian-releases).

**Not a theme requirement**

- [`versions.json`](https://docs.obsidian.md/Reference/Versions) is documented for **plugins**. Theme submit docs do not mention it. This repo keeps it as an analog; parent added `"1.6.0": "1.13.0"`. Keep or drop independently of directory listing.

AnuPpuccin remains listed:

```json
{ "name": "AnuPpuccin", "author": "anubisnekhet", "repo": "anubisnekhet/AnuPpuccin", "screenshot": "preview.png", "modes": ["dark", "light"] }
```

Source: [community-css-themes.json](https://github.com/obsidianmd/obsidian-releases/blob/master/community-css-themes.json).

## Palette / variable contract (this theme)

Catppuccin maps are hex in SCSS (`src/modules/Core/colorschemes/macchiato.scss`) and emitted as **RGB triplets** (`R, G, B`) on `--ctp-*` (`src/modules/Core/default-colorschemes.scss`). Semantic Obsidian vars are then wrapped with `rgb()` / `rgba()` in `src/modules/Core/default-variables.scss`.

Live Macchiato body had `--ctp-blue: 138, 173, 244` and `--color-blue: rgb(138, 173, 244)`. That triplet encoding is an existing snippet/Style Settings contract. Do **not** blanket-convert `--ctp-*` to hex/OKLCH.

Without Style Settings, `.theme-dark` falls back to **Mocha**, not Macchiato. Macchiato is `body.theme-dark.ctp-macchiato` (Style Settings id `anuppuccin-theme-dark`, default `ctp-mocha`). The live vault applied `ctp-macchiato`. Preserve Macchiato by leaving the Macchiato hex map unchanged while fixing official-variable assignments.

Installable CSS is **`theme.css`**. Legacy `obsidian.css` was removed (README + Makefile). Do not claim a current duplicate output.

## Applied since baseline

| Change | Where | Status |
| --- | --- | --- |
| `manifest.json` 1.6.0 / `minAppVersion` 1.13.0 | `manifest.json` | Applied |
| `versions.json` `"1.6.0": "1.13.0"` | `versions.json` | Applied (plugin analog, not a theme listing gate) |
| README maintenance, install, 1.6.0 changelog | `README.md` | Applied |
| Remove unused `obsidian.css` | repo root; Makefile no longer emits it | Applied |
| Pin Sass 1.105.1; Bun scripts; lockfile | `package.json`, `bun.lock` (`sass@1.105.1`) | Applied |
| Make wrappers for theme + all snippet targets | `Makefile` (`build`, `snippets`) | Applied |
| Build CI, no GitHub release publish | `.github/workflows/build.yml` (Bun 1.4.2, `bun install --frozen-lockfile`, `build`, `build:snippets`) | Applied |
| `--mono-rgb-100` consumption in translucency | `src/modules/Workspace/translucency.scss` now `color-mix(in oklch, var(--color-base-100) 30%, transparent)` | Applied in source. Assignment `--mono-rgb-100: var(--ctp-text)` remains in `default-variables.scss` (core still publishes the alias). |
| `--callout-color` full-color assignment/consumption | `Callouts/colors.scss` uses `rgb(var(--ctp-*))`; style files use `var(--callout-color)` / `color-mix` | Applied in **source** (historical live break was against pre-patch compiled CSS) |
| Properties hide/button/banner retarget | `metadata.scss`, `metadata-button.scss`, `general-ui.scss`, `cursor-modifications.scss` → `.metadata-container` / `.metadata-properties-heading` / `--metadata-display-*` | Applied in **source**. `properties.scss` stays empty on purpose. |
| Drop `--color-accent-hsl` mixes in theme rules | metadata-button, colorful-frame, default-variables `--background-modifier-active`, rainbow/style-settings | Applied in **source** (`color-mix(in oklch, var(--color-accent) …%, transparent)`). Core still **publishes** `--color-accent-hsl`. |

`theme.css` has been rebuilt from this SCSS and exercised in Obsidian 1.13.7; see Build and live verification below. Never distribute failed or mid-rebuild artifacts.

## Historical live gaps (1.13.7 baseline)

These were verified against live DOM/`app.css` **before** the source patches above. They remain the reason for the 1.13 contract work; do not re-open them as missing source unless a post-rebuild live pass regresses.

### H1. `--callout-color` triplet was invalid on 1.13 (breaking)

[1.13 public changelog](https://obsidian.md/changelog/2026-07-30-desktop-v1.13.4/) and [Callout variables](https://docs.obsidian.md/Reference/CSS+variables/Editor/Callout): `--callout-color` is a **full CSS color**. Core `app.css` consumes it as a color:

```css
.callout {
  --callout-color: var(--callout-default);
  border-color: color-mix(in oklch, var(--callout-color) calc(var(--callout-border-opacity) * 100%), transparent);
  background-color: color-mix(in oklch, var(--callout-color) 10%, transparent);
}
.callout-title { color: var(--callout-color); }
.callout-icon .svg-icon { color: var(--callout-color); }
```

Type aliases are already full colors (`--callout-default: var(--color-blue)`, …). Live Macchiato: `--callout-info: rgb(138, 173, 244)`.

Baseline compiled theme overwrote `--callout-color` with a triplet (`--callout-color: var(--ctp-blue)`). Live `.callout[data-callout="note"]`:

| Check | Result |
| --- | --- |
| Computed `--callout-color` | `138, 173, 244` |
| `CSS.supports("color", that)` | **false** |
| `color-mix(in oklch, 138, 173, 244 10%, transparent)` | **false** |
| `background-color` | `rgba(0, 0, 0, 0)` |
| `.callout-title` color | `rgb(197, 207, 245)` (`--text-normal`, not blue) |

**Source now:** `--callout-color: rgb(var(--ctp-blue))` (keep `--ctp-*` as triplets). Optional later: assign `--callout-info` / `--callout-bug` / … instead of per-`data-callout` rules. Not required.

### H2. `.frontmatter-container` gone; hide/button missed the DOM

[1.4](https://obsidian.md/changelog/2023-08-31-desktop-v1.4.5/) added `--metadata-*`. Current list: [Properties](https://docs.obsidian.md/Reference/CSS+variables/Editor/Properties).

Live 1.13.7 (Live Preview, two properties):

| Selector / var | Result |
| --- | --- |
| `.frontmatter-container` | **0** in DOM; **0** matches in `app.css` |
| `.metadata-container` | 1 |
| Heading | `.metadata-properties-heading` (“Properties”) |
| Rows | `.metadata-property[data-property-key]` (`tags`, `status`) |
| `--metadata-display-editing` / `--metadata-display-reading` | `block` (core default) |
| `anp-toggle-metadata` on `body` (baseline CSS) | yes, but container still `display: block` |

Core uses `display: var(--metadata-display-editing)` / `--metadata-display-reading` on `.metadata-container`. Parent later confirmed the live theme loads and those Properties nodes exist.

**Source now:** `.anp-toggle-metadata { --metadata-display-editing: none; --metadata-display-reading: none; }` plus a `.metadata-container` hide; compact button retargets `.metadata-properties-heading`. Banner padding uses `.metadata-container`.

**Do not** add extra `--metadata-*` or `--bases-*` aliases merely because the theme does not name them. Live/`app.css`: `--metadata-*` and `--bases-*` already inherit theme `--background-*` / `--text-*` / `--color-*`. Empty `properties.scss` is correct.

## Remaining actionable items

### 1. Build and live verification (completed)

`bun install --frozen-lockfile`, `bun run build`, and `bun run build:snippets` succeeded with Bun 1.4.2 / Dart Sass 1.105.1. All eight snippet outputs were regenerated. Existing Sass `@import`, global builtin, and color-function deprecation warnings remain visible; the pinned compiler avoids an uncontrolled upgrade to Sass 3.

The rebuilt `theme.css` was installed in a disposable vault in actual Obsidian **1.13.7** on Linux:

- Macchiato base remained `36, 39, 58` (`#24273A`), text `197, 207, 245` (`#C5CFF5`).
- Default palette callouts now have complete colors, colored titles/icons, and nontransparent washes.
- Thirty rendered callout combinations covered core/sleek/block/vanilla-normal/vanilla-plus, color toggle off/on, full custom hex color, and title opacity `0`, `0.1`, `1`.
- Global and per-note Properties hiding/button classes worked in Reading and Live Preview. Hide wins when button and hide are enabled together.
- The compact button is 32×32, placed at inline-end in LTR and RTL, without overlapping property rows. Mouse click and native **ArrowLeft / ArrowRight** keyboard collapse/expand were exercised; Enter/Space are not the core heading's collapse keys.
- Empty in-note Properties are hidden; the File Properties sidebar remains available. Global compact-button styling is restricted to note views, not the sidebar.
- Twelve frame combinations covered native/palette accent, unset/custom frame color, and opacity `0`, `0.5`, `1`.
- A core Bases table was opened; its headers/cells inherited Macchiato text colors without additional aliases.

Native Electron screenshots were inspected for visual proof. Style Settings controls were exercised through their actual CSS classes/custom properties; third-party plugin UI itself was not installed or verified.

### 2. `--color-accent` HSL contract vs table selection (documented, not a missing alias)

[Colors](https://docs.obsidian.md/Reference/CSS+variables/Foundations/Colors): the user accent is `--accent-h` / `--accent-s` / `--accent-l` (defaults **258 / 88% / 66%**, Settings → Appearance). Core composes:

```css
--color-accent: hsl(var(--accent-h), var(--accent-s), var(--accent-l));
--color-accent-hsl: var(--accent-h), var(--accent-s), var(--accent-l); /* deprecated, kept */
```

`--color-accent-1` / `--color-accent-2` are `hsl(calc(var(--accent-h) …))` shifts. `--text-accent` is documented as accent **text**. `--color-accent-hsl` is deprecated as of 1.13 (use `color-mix` on `--color-accent`).

Core `app.css` 1.13.7:

```css
--table-selection: color-mix(in oklch, var(--color-accent) 10%, transparent);
--table-selection-border-color: var(--interactive-accent);
```

[Table variables](https://docs.obsidian.md/Reference/CSS+variables/Editor/Table) list `--table-selection-border-color` as “Selection border color”; they do not require themes to redefine it.

Live 1.13.7, Macchiato, **`.anuppuccin-accent-toggle` off** (theme default):

| Variable | Computed |
| --- | --- |
| `--accent-h/s/l` | `258` / `88%` / `66%` (stock) |
| `--color-accent` | `hsl(258, 88%, 66%)` |
| `--interactive-accent` | `hsl(258, 88%, 66%)` |
| `--table-selection-border-color` | `hsl(258, 88%, 66%)` |
| `--text-accent` | `hsl(calc(258 - 3), calc(88% * 1.02), calc(66% * 1.15))` (`--color-accent-1`) |
| `--ctp-mauve` | `198, 160, 246` (palette purple; not wired to accent unless toggle on) |
| `--ctp-accent` | empty (toggle off) |

Stock interactive purple (`hsl(258, 88%, 66%)` ≈ the live settings toggle `rgb(138, 92, 245)`) therefore differs from Catppuccin mauve/text. That is the **Appearance picker** contract, not a broken `--table-selection-*` variable.

Theme remaps `--color-accent` / `--interactive-accent` / `--text-accent` only under `.anuppuccin-accent-toggle` (`rgb(var(--ctp-accent))`). It does **not** set `--accent-h/s/l`. With the toggle on, `--table-selection-border-color` follows `--interactive-accent` (inherited). Leftover core `hsl(var(--accent-h)…)` siblings can stay stock unless those HSL components are also updated.

**Do:** if a visual pass wants table selection to match Catppuccin, use the existing accent toggle (inheritance) or also set `--accent-h/s/l` from the chosen accent. **Do not** add a redundant `--table-selection-border-color` alias just because the theme omits the name.

### 3. Distribution still behind listing/release docs

- No documented *release* workflow (build CI only; intentional).
- README now documents `theme.css` install, Bun/Make, and unprefixed tags.
- Updating the live directory entry still needs the existing `anubisnekhet/AnuPpuccin` listing (or a policy-compliant transfer), not a fork listing.

## Inspected: not current 1.13.7 breaks

Do **not** treat these as required compatibility work.

| Topic | Live / `app.css` | Recommendation |
| --- | --- | --- |
| `--color-accent-hsl` | Still published (`258, 88%, 66%`). Deprecated-but-kept ([Colors](https://docs.obsidian.md/Reference/CSS+variables/Foundations/Colors)). Theme source no longer consumes it. | Leave core alias. Optional: set `--accent-h/s/l` when accent toggle is on (item 2). |
| `--metadata-*` / `--bases-*` unset by theme | Properties DOM is `.metadata-container` / `.metadata-property` / `.metadata-properties-heading`. Core `--metadata-*` and `--bases-*` inherit theme bases. | Do **not** add unused aliases. Hide/button already use the display vars + live selectors. |
| Settings chrome | Pop-out `body.is-popout-window.is-popout-modal`. Modal class still `modal mod-settings mod-sidebar-layout`. Search `.setting-search-container`. | No selector rewrite. Optional visual pass. Linux session; macOS 26 native toggles untested. |
| File explorer / tabs | `.nav-file-title`, `.workspace-tab-header` / `-inner` present. | Keep. Do not rename. |
| `--color-*-rgb` / `--mono-rgb-*` | Theme still **sets** both full colors and RGB vars. Core still publishes RGB aliases. Translucency no longer *consumes* `--mono-rgb-100`. | Keep dual assignment; no extra aliases. |
| 1.14 prefixes | `--tab-inner-background`, `--tooltip-background`, `--notice-background` empty. | Ignore until public 1.14. `--tab-container-background` exists on 1.13. |
| `--blur-translucency-s` | Empty; `--blur-opacity-s: 65%`. Unused by theme. | None. |
| `--traffic-lights-offset-x` | `40px` present. Theme does not set it. | Optional frame polish only. |

Settings toggle snapshot (accent toggle off): `.checkbox-container.is-enabled` background `rgb(138, 92, 245)` (core accent). Theme `general-ui.scss` still matches `.checkbox-container`; do not delete it without a dedicated visual pass.

## Newer UI surfaces (optional)

Official [CSS variable index](https://docs.obsidian.md/Reference/CSS+variables/CSS+variables) still has **no Bases or Web viewer pages**. Core `app.css` defines `--bases-*` and web-viewer selectors. Semantic colors already flow through.

| Surface | Since | Live / `app.css` | Action |
| --- | --- | --- | --- |
| Properties editor | [1.4](https://obsidian.md/changelog/2023-08-31-desktop-v1.4.5/) | `.metadata-container` + `--metadata-*` | Source patched (H2). No extra aliases. |
| RTL / `.mod-rtl` / `--direction` / `--bold-modifier` | [1.6](https://obsidian.md/changelog/2024-06-07-desktop-v1.6.2/), [RTL guide](https://docs.obsidian.md/Plugins/User+interface/Right-to-left) | `--direction: 1`, `--bold-modifier: 200`. Theme `rtl.scss` still uses `.markdown-rendered.rtl` and physical `left`/`right`. | Optional when editing those rules. Do **not** mass-rename directional CSS. |
| Web viewer | [1.8](https://obsidian.md/changelog/2025-01-30-desktop-v1.8.3/) | Plugin off. Selectors: `.workspace-leaf-content[data-type="browser"]`, `.webviewer-container`, `.webviewer-address`. | Optional after enabling the plugin. |
| Bases | [1.9.10](https://obsidian.md/changelog/2025-08-18-desktop-v1.9.10/), [1.10](https://obsidian.md/changelog/2025-10-01-desktop-v1.10.0) | Core table opened in the disposable vault; headers/cells inherited Macchiato text (`rgb(197, 207, 245)`). | No extra `.bases-*` restyles needed for the exercised table. Other view types untested. |
| Image lightbox | [1.13](https://obsidian.md/changelog/2026-07-30-desktop-v1.13.4/) | `.modal.mod-image-lightbox`; `--lightbox-background`, `--lightbox-titlebar-color`, `--lightbox-titlebar-display`. Not opened. | Optional. |
| Workspace RTL flip / highlight colors | 1.14 catalyst | — | Wait for public 1.14. |

Kanban under `src/modules/Integrations/kanban/` is the **community plugin**, not core Bases kanban. Out of scope.

## Guidelines vs bugs (do not treat as compatibility work)

- Compiled `theme.css` historically had 20 `!important`s (guidelines / October checklist). Remove only when a specific snippet override is required.
- `:has()` appears in a handful of layout/integration files. Checklist warns about Canvas performance; not a version break. Baseline CSS also had `.frontmatter-container:not(:has(.frontmatter-section))` (dead).
- `rgba(var(255, 255, 255), 0.09)` in `default-variables.scss` is invalid CSS. Pre-existing; not an Obsidian API change.
- Plugin integrations (Excalidraw, Make.md, Style Settings, Dataview, banners) are optional compatibility, not core requirements.
- Style Settings default dark flavor is Mocha. Changing the default to Macchiato is a product choice, not an Obsidian requirement.

## Remaining limits

Not exercised in the live passes:

- Stacked tabs, Canvas, additional Bases view types, Web viewer, image lightbox open state.
- macOS native controls and mobile (session was `mod-linux`); third-party plugin integrations.
- Whether the community installer strips a `v` prefix from GitHub tags (`v1.5.0` vs `1.5.0`).
- In-app Settings with “Open settings in new window” **off**. Pop-out path still has `.modal.mod-settings`.

Prefer variable overrides. Avoid speculative class renames and unused official-variable aliases.

## Recommended sequence

1. The compatibility source is compiled and H1/H2 are verified on 1.13.7; keep `--ctp-*` triplets and the Macchiato hex map intact.
2. Future changes should repeat the live Reading/Live Preview, callout, and Properties checks before release.
3. Treat `--table-selection-border-color` as inherited `--interactive-accent`. Only touch `--accent-h/s/l` or the existing accent toggle if a visual pass wants Catppuccin on table chrome; do not add table/metadata/bases aliases.
4. Leave 1.14 prefixes, blanket RTL/logical-property edits, `!important` sweeps, and Bases/Web viewer restyles unless a later visual pass shows a break.
5. Directory release (optional, not CI): unprefixed tag matching manifest, attach `manifest.json` + `theme.css`.
