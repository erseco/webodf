Pagination and headers/footers in the WebODF viewer

Overview
- The viewer (`viewer/index.html`) implements client-side pagination for ODT text documents and renders page headers and footers per OASIS OpenDocument v1.4.
- Page size and margins are read from `style:page-layout-properties`.
- Header and footer content is taken from `style:master-page` regions (`style:header`, `style:header-left`, `style:footer`, `style:footer-left`).
- Page fields `text:page-number` and `text:page-count` are resolved after pagination (two-pass approach).

Supported ODF elements/attributes
- Page/layout: `style:master-page`, `style:page-layout`, `style:page-layout-properties` (`fo:page-width`, `fo:page-height`, `fo:margin-*`, optional `style:page-usage`).
- Header/footer regions: `style:header`, `style:footer`, variants `style:header-left`, `style:footer-left`.
- Region properties: `style:header-style` / `style:footer-style` → `style:header-footer-properties` with `fo:min-height`, `fo:margin-*`, `fo:padding-*`.
- Content: `text:p`, `draw:frame`, `draw:image` with `svg:width/height`, optional `svg:x/y` and `text:anchor-type`.
- Page fields: `text:page-number` (supports `text:select-page=current|previous|next`, `style:num-format=1|i|I|a|A`, `text:fixed=true`), `text:page-count` (supports `style:num-format`).

Algorithm summary
1) Parse styles
   - Discover the default `style:master-page` and its `style:page-layout-properties` and optional `style:next-style-name`.
   - Build an in-memory layout descriptor with size, margins, min header/footer heights and region nodes.

2) Paginate
   - Prefer explicit `text:soft-page-break` markers (first pass).
   - If none produce more than one page, fall back to height-based pagination for A4 using a hidden measuring page to detect overflow.
   - Create a DOM wrapper per page: `div.odf-page-wrapper > div.odf-page` and move the chunk of content inside.

3) Render header/footer
   - For each page, select region variants: first page via `style:next-style-name`; left/right using `style:page-usage=mirrored`.
   - Clone region children into positioned boxes `.odf-header`/`.odf-footer`, apply region margins/paddings and ensure images are loaded.
   - Images: for each `draw:image`, resolve the package part using `odfCanvas.odfContainer().getPart(href)` and set `background-image` to the loaded blob URL.
   - Position `draw:frame` using `svg:x/y` and `svg:width/height` if present.
   - Adjust page CSS variables `--header-height`/`--footer-height` to the measured content height when it exceeds the minimum.

4) Resolve fields (second pass)
   - Replace `text:page-number` and `text:page-count` with formatted values (roman, alpha, decimal) based on `style:num-format`.

Known limitations
- Hard page breaks via `fo:break-before/after` on paragraph styles are not yet parsed; soft breaks are fully respected.
- Widow/orphan control (`fo:orphans`, `fo:widows`) is not enforced; expect ±1 page difference from LibreOffice in edge cases.
- Multiple master-page switches within a document body are not handled; the default master and its `next-style-name` are supported.

Manual verification
- Run `make build-viewer` then open `build/viewer/index.html` and drag `viewer/examples/sample3.odt` into the drop zone.
- Confirm: header text and image are visible on page 1; footer shows `1 / N`; subsequent pages use left/right variants when defined; margins are respected.

