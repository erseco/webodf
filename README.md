## WebODF

WebODF is a ODF JavaScript library originally created by KO GmbH.

It makes it easy to add Open Document Format (ODF) support to your website and to your mobile or desktop application. It uses HTML and CSS to display ODF documents.

### Project status

WebODF still works as a client-side ODF viewer/editor library in modern browsers, but it is no longer maintained by KO GmbH and there is currently no dedicated active maintainer for this repository.

The library remains useful if you need browser-based ODF rendering or want to build on its modular components, but you should expect some areas of the bundled UI to feel dated and some larger feature gaps to remain open unless they are picked up by the community.

If you need a more actively developed, server-backed online office stack, LibreOffice Online / Collabora Online are the closest alternatives mentioned by the community. Community projects built on top of WebODF are also occasionally shared in the issue tracker.
## Quick Start

The fastest way to get productive from a fresh checkout is:

1. **Build the library**

       make build

   The first build configures CMake, downloads the Closure Compiler, and writes the library to `build/webodf/webodf.js`.

2. **Run the demo locally**

       make serve

   This builds the library, copies the demo assets into `build/`, and serves the viewer at `http://127.0.0.1:8080/viewer/`.

3. **Load an `.odt` file**

   * Open the local viewer and drag an `.odt` or `.fodt` file onto the drop zone, or click it to browse for a file.
   * To open one of the bundled examples directly, visit `http://127.0.0.1:8080/viewer/?file=examples/sample1.odt`.

4. **Embed the viewer in another page**

   * Start from the existing example in [`webodf/embedodf.html`](webodf/embedodf.html) or the simple loader in [`webodf/odf.html`](webodf/odf.html).
   * After building, include `build/webodf/webodf.js` and load a document with `odf.OdfCanvas`:

         <div id="odf"></div>
         <script src="build/webodf/webodf.js"></script>
         <script>
           const canvas = new odf.OdfCanvas(document.getElementById("odf"));
           canvas.load("path/to/document.odt");
         </script>

Need build prerequisites or contributor details? See [README-Building.md](README-Building.md) for platform-specific setup and [CONTRIBUTING.md](CONTRIBUTING.md) for project structure, tests, coding expectations, and release notes.

* Visit the project homepage at: [WebODF](https://webodf.org)
* Want some live demos? Visit: [WebODF Demos](https://webodf.org/demos/)
* Get in contact:
  * Slack: webodf.slack.com, use the [self-invite](https://join.slack.com/t/webodf/shared_invite/enQtNTQ1NDAyNDU1NjY2LWFlZDg1NzBjY2IzY2RmMzhhMTcwZjM1YjJjOTRmMjM4Yzg1MzhjODY5N2MwOWQwMWNiNzhlZTVlYjI3MDY5YTc)
  * [mailing list](https://lists.opendocsociety.org/mailman/listinfo/webodf) or
  * IRC (#webodf on freenode, [Web access](http://webchat.freenode.net/?nick=webodfcurious_gh&channels=webodf))

### Reporting faults

Recurring issues in the upstream `webodf/WebODF` tracker cluster around four parts of the library:

* document rendering and layout
* editor, input and collaboration behavior
* API and framework integration
* build, packaging and CI/tooling

Use the matching issue form in this repository so the report includes the right reproduction details for the affected part of WebODF.

### Public viewer API

For browser integrations, treat `odf.OdfCanvas` as the supported viewer API and
`odf.OdfContainer` state constants as the supported way to detect load success
or failure. Internal modules under `webodf/lib/core`, `webodf/lib/gui`, and the
rest of `webodf/lib/odf` are implementation details and can change without
notice.

See [PUBLIC-API.md](PUBLIC-API.md) for:

* the documented public API surface
* examples for loading from a URL or `File`
* event handling and teardown patterns
* a compatibility table for document types and viewer features

Minimal browser example:

```html
<div id="viewer"></div>
<script src="webodf/webodf.js"></script>
<script>
  const canvas = new odf.OdfCanvas(document.getElementById("viewer"));

  canvas.addListener("statereadychange", function (container) {
    if (container.state === odf.OdfContainer.DONE) {
      console.log("Document loaded.");
    } else if (container.state === odf.OdfContainer.INVALID) {
      console.error("Document could not be loaded.");
    }
  });

  canvas.load("/documents/example.odt");
</script>
```

### License

WebODF is a Free Software project. All code is available under the AGPL.

If you are interested in using WebODF in your commercial product
(and do not want to disclose your sources / obey AGPL),
get in touch at [the license page](https://webodf.org/about/license.html) for a license suited to your needs.


### Creating webodf.js...

webodf.js is compiled by using the Closure Compiler. This compiler concatenates and compacts all JavaScript files, so that they are smaller and execute faster. CMake is used to setup the buildsystem, so webodf.js can be created:

    git clone https://github.com/kogmbh/WebODF.git webodf
    mkdir build
    cd build
    cmake ../webodf
    make webodf.js-target

A successful run will yield the file "webodf.js" in the subfolder "build/webodf/" (among other things), from where you can then copy it and use for your website.

For more details about preparing the build of webodf.js , e.g. on Windows or OSX, please study ["README-Building.md"](README-Building.md).

### ... and more

This repository not only contains code for the library webodf.js, but also a few products based on it. Here is the complete list:

build target                 | output location (in build/)           | description                        | download/packages
-----------------------------|---------------------------------------|------------------------------------|-----
webodf.js-target             | webodf/webodf.js                      | the library                        | (see product-library)
product-library              | webodf.js-x.y.z.zip                   | zip file with library and API docs | [WebODF homepage](http://webodf.org/download)
product-wodotexteditor       | wodotexteditor-x.y.z.zip              | simple to use editor component     | [WebODF homepage](http://webodf.org/download)
product-wodocollabtexteditor | wodocollabtexteditor-x.y.z.zip        | collaborative editor component     | [WebODF homepage](http://webodf.org/download)
product-firefoxextension     | firefox-extension-odfviewer-x.y.z.xpi | ODF viewer Firefox add-on          | [Mozilla's Add-on website](https://addons.mozilla.org/firefox/addon/webodf/)

("x.y.z" is a placeholder for the actual version number)

For more details about the different products, please study ["README-Products.md"](README-Products.md).
