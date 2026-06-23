const assert = require("assert");
const getEditorRuntimePath = require("./runtimepath.js");

assert.strictEqual(getEditorRuntimePath("/programs/editor/src-localeditor.html"), "../../webodf/lib");
assert.strictEqual(getEditorRuntimePath("/webodf/editor/src-localeditor.html"), "../webodf/lib");
assert.strictEqual(getEditorRuntimePath("/webodf/pr-preview/pr-1/editor/src-localeditor.html"), "../webodf/lib");

console.log("editor runtime path tests passed");
