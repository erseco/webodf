# WebODF public viewer API

WebODF exposes many modules internally, but the browser-facing viewer
integration should start with the small public surface documented here.

## Public API surface

| API | Purpose | Common entry points |
| --- | --- | --- |
| `new odf.OdfCanvas(element[, viewport])` | Create a viewer inside an existing DOM element | `load(url)`, `addListener(eventName, handler)`, `getElement()`, `destroy(callback)` |
| `odf.OdfContainer` state constants | Inspect viewer lifecycle inside `statereadychange` handlers | `LOADING`, `DONE`, `INVALID`, `SAVING`, `MODIFIED` |
| `odf.OdfContainer.DocumentType` | Create empty text, presentation, or spreadsheet containers programmatically | `TEXT`, `TEXT_TEMPLATE`, `PRESENTATION`, `PRESENTATION_TEMPLATE`, `SPREADSHEET`, `SPREADSHEET_TEMPLATE` |

### Public vs. internal modules

The following integration points are public and intended for application code:

* `odf.OdfCanvas`
* `odf.OdfContainer` state constants and `DocumentType`

The following directories are internal implementation modules and should not be
treated as stable application APIs:

* `webodf/lib/core`
* `webodf/lib/gui`
* most files in `webodf/lib/odf`

In particular, prefer calling `odf.OdfCanvas` instead of wiring together lower
level classes from `core`, `gui`, or undocumented `odf.*` modules.

## Common setup

```html
<div id="viewer"></div>
<script src="webodf/webodf.js"></script>
<script>
  const targetElement = document.getElementById("viewer");
  const canvas = new odf.OdfCanvas(targetElement);
</script>
```

## Examples

### Render from URL

```html
<div id="viewer"></div>
<script src="webodf/webodf.js"></script>
<script>
  const canvas = new odf.OdfCanvas(document.getElementById("viewer"));
  canvas.load("/documents/example.odt");
</script>
```

### Render from `File` object

`odf.OdfCanvas.load()` expects a URL string. In the browser, pass a `File`
object by creating an object URL first.

```html
<input id="file-input" type="file" accept=".odt,.fodt,.odp,.ods">
<div id="viewer"></div>
<script src="webodf/webodf.js"></script>
<script>
  const canvas = new odf.OdfCanvas(document.getElementById("viewer"));
  let currentObjectUrl = null;

  document.getElementById("file-input").addEventListener("change", function (event) {
    const file = event.target.files && event.target.files[0];
    if (!file) {
      return;
    }

    if (currentObjectUrl) {
      URL.revokeObjectURL(currentObjectUrl);
    }

    currentObjectUrl = URL.createObjectURL(file);
    canvas.load(currentObjectUrl);
  });
</script>
```

### Render inside a target element

```js
const host = document.querySelector("[data-webodf-viewer]");
const canvas = new odf.OdfCanvas(host);
canvas.load("/documents/example.odt");
```

### Listen for load and error events

WebODF reports viewer lifecycle changes through the `statereadychange` event.
The event handler receives the active `odf.OdfContainer`.

```js
const canvas = new odf.OdfCanvas(document.getElementById("viewer"));

canvas.addListener("statereadychange", function (container) {
  if (container.state === odf.OdfContainer.LOADING) {
    console.log("Loading...");
    return;
  }

  if (container.state === odf.OdfContainer.DONE) {
    console.log("Document loaded.");
    return;
  }

  if (container.state === odf.OdfContainer.INVALID) {
    console.error("Document could not be loaded.");
  }
});

canvas.load("/documents/example.odt");
```

### Destroy or unmount the viewer

Call `destroy(callback)` before removing the host element or navigating away
from a single-page application route.

```js
function destroyViewer(canvas, currentObjectUrl) {
  canvas.destroy(function (err) {
    if (currentObjectUrl) {
      URL.revokeObjectURL(currentObjectUrl);
    }

    if (err) {
      console.error("Viewer cleanup failed.", err);
      return;
    }

    console.log("Viewer destroyed.");
  });
}
```

## Compatibility

The viewer API is source-agnostic: if a document type can be loaded by
`odf.OdfCanvas`, the same lifecycle methods (`load`, `addListener`,
`getElement`, `destroy`) apply whether the source is a normal URL or an object
URL created from a `File`.

| Document type | Typical extensions | Render in `odf.OdfCanvas` | Load from URL | Load from `File` object | `statereadychange` load/error handling | Destroy/unmount | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Text documents | `.odt`, `.fodt` | Yes | Yes | Yes | Yes | Yes | Primary viewer use case |
| Presentations | `.odp` | Yes | Yes | Yes | Yes | Yes | Use `showFirstPage`, `showNextPage`, `showPreviousPage`, or `showPage(n)` for page navigation |
| Spreadsheets | `.ods` | Yes | Yes | Yes | Yes | Yes | Rendered through the same viewer lifecycle API |

## Related APIs

Once a document is loaded, `odf.OdfCanvas` also exposes helper methods for:

* zooming (`setZoomLevel`, `getZoomLevel`, `fitToContainingElement`,
  `fitToWidth`, `fitToHeight`, `fitSmart`)
* presentation page navigation (`showFirstPage`, `showNextPage`,
  `showPreviousPage`, `showPage`)
* canvas refresh (`refreshCSS`, `refreshSize`)

Those methods are part of the public viewer object, but they are optional for
the common loading and embedding scenarios above.
