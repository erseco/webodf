/**
 * Copyright (C) 2026 Erseco <info@ernesto.es>
 *
 * @licstart
 * This file is part of WebODF.
 *
 * WebODF is free software: you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License (GNU AGPL)
 * as published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version.
 *
 * WebODF is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with WebODF.  If not, see <http://www.gnu.org/licenses/>.
 * @licend
 *
 * @source: http://www.webodf.org/
 * @source: https://github.com/kogmbh/WebODF/
 */

const assert = require("assert");
const getEditorRuntimePath = require("./runtimepath.js");

assert.strictEqual(getEditorRuntimePath("/programs/editor/src-localeditor.html"), "../../webodf/lib");
assert.strictEqual(getEditorRuntimePath("/webodf/editor/src-localeditor.html"), "../webodf/lib");
assert.strictEqual(getEditorRuntimePath("/webodf/pr-preview/pr-1/editor/src-localeditor.html"), "../webodf/lib");

console.log("editor runtime path tests passed");
