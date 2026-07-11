# Figure Extraction Reference

How `scripts/extract_itpec.py` crops diagrams, flowcharts, and visual content from PDFs.

## Table of contents

- [Extraction approach](#extraction-approach)
- [What gets extracted](#what-gets-extracted)
- [What gets excluded](#what-gets-excluded)
- [Figure grouping](#figure-grouping)
- [False positive prevention](#false-positive-prevention)
- [Verified crop overrides](#verified-crop-overrides)
- [Output format](#output-format)

## Extraction approach

The figure detector evolved through three iterations:

1. **Full-page screenshots** — accurate but too large.
2. **Full-question crops** — smaller but included prose, code, and choices.
3. **Visual-region extraction** (final) — detects visual elements and crops only those regions.

The final detector uses:

- Embedded image blocks (raster images in the PDF)
- Vector drawing paths (lines, curves, shapes)
- Connected-component grouping (nearby visual elements)
- Nearby labels and captions
- Table-region exclusion
- Blank-placeholder exclusion

Figures are rendered as **WebP at 160 DPI** — small files with readable labels.

## What gets extracted

| Element | Extracted? | Notes |
|---|---|---|
| Flowcharts | Yes | Merged if vertically aligned |
| Timing diagrams | Yes | Merged if horizontally aligned with shared vertical bands |
| Network diagrams | Yes | Including captions |
| ER diagrams | Yes | Including labels |
| Graphs (social, etc.) | Yes | Including legend and caption |
| Option figures (a–d images) | Yes | Stored as individual files |
| Embedded raster images | Yes | PNG/JPEG inside the PDF |
| Vector drawings | Yes | Lines, curves, shapes |

## What gets excluded

| Element | Excluded? | Detection method |
|---|---|---|
| Blank boxes / placeholders | Yes | Small empty rectangular regions |
| A/B blank underscores | Yes | Underscore placeholders and single-letter boxes |
| White PDF rectangles | Yes | Non-stroked white layout artifacts |
| Table grids | Yes | Regions detected as tables |
| Prose text | Yes | Not visual content |
| Code blocks | Yes | Semantic content, not figures |
| Section headings | Yes | Including `[Program]` markers |

## Figure grouping

### Problem: flowcharts split into files

A single flowchart may have nodes and connectors detected as separate visual elements.

**Solution:** Merge vertically aligned components and connectors. If two visual regions
share horizontal overlap and are close vertically, they're part of the same diagram.

### Problem: timing diagrams split into lanes

Timing diagrams have horizontal lanes that may be detected separately.

**Solution:** Merge horizontally aligned components with shared vertical bands.

### Problem: labels and captions clipped

Figure labels (e.g., "Figure 1") and captions may sit just outside the crop region.

**Solution:** Include nearby label bounding boxes. Captions must begin with `Figure`
to distinguish from prose mentioning "figure."

## False positive prevention

| False positive | Prevention |
|---|---|
| Prose mentioning "Figure" treated as caption | Require captions to begin with `Figure` |
| `[Program]` heading included below figure | Exclude semantic section headings |
| Question text included above figure | Limit label association, add verified overrides |
| Empty output boxes stored as images | Detect small empty rectangular placeholders |
| A/B blank boxes stored as images | Detect underscore placeholders and single-letter boxes |
| Invisible white PDF rectangles | Ignore non-stroked white layout artifacts |
| Table grids treated as figures | Exclude regions detected as tables |

## Verified crop overrides

For layouts where generic geometry cannot disambiguate reliably, manual overrides are
stored in `PAGE_FIGURE_OVERRIDES` in `extract_itpec.py`.

Keyed by: `(exam_session, subject, question_number, source_page)`

### Current overrides

| Exam | Question | Page | Crop regions | Notes |
|---|---|---|---|---|
| 2021-April-A | Q08 | 5 | `(70,532,525,676)` | Binary tree only |
| 2021-April-A | Q21 | 9 | `(90,500,525,593)` | Complete half-adder |
| 2021-April-A | Q22 | 10 | 4 regions | Four option figures stored separately |
| 2021-April-A | Q46 | 17 | `(120,492,480,590)` | DFD without textual choices |
| 2021-April-B | Q01 | 5 | `(70,470,525,735)` | Complete Table 8 |
| 2021-April-B | Q02 | 9 | 3 regions | Scheduling figures and captions |
| 2021-April-B | Q04 | 15 | `(75,260,525,558)` | Network diagram and caption |
| 2021-April-B | Q05 | 19 | `(130,298,475,646)` | Complete ER diagram |
| 2021-April-B | Q06 | 24 | `(145,360,430,525)` | Social graph, legend, caption |

Pages with empty overrides `[]` are explicitly excluded (false positive prevention).

### Adding new overrides

When a new exam is extracted and figures are incorrectly cropped:

1. Inspect the PDF page visually
2. Determine the correct crop coordinates (x0, y0, x1, y1) in PDF points
3. Add to `PAGE_FIGURE_OVERRIDES` with the correct key
4. Re-run extraction for that paper
5. Verify the output images

## Output format

Figures are saved as:

```
resources/exams/{year}-{season}-{subject}/images/{exam_session}-{subject}-q{number}-figure{n}.webp
```

Example: `2021-april-a-q08-figure1.webp`

Graphical answer choices reference their individual files:

```json
{
  "label": "a",
  "image": "2021-april-a-q22-figure1.webp"
}
```

The `images` array on each question lists all figure filenames for that question.
