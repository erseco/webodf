/**
 * Copyright (C) 2026 Erseco
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
 * @source: https://github.com/erseco/webodf/
 */

/*jslint node: true*/

"use strict";

var assert = require("assert"),
    getWebodfRuntimePath = require("./runtimepath");

assert.strictEqual(getWebodfRuntimePath("/viewer/index.html"), "../webodf/webodf.js");
assert.strictEqual(getWebodfRuntimePath("/viewer/"), "../webodf/webodf.js");
assert.strictEqual(getWebodfRuntimePath("/webodf/index.html"), "./webodf/webodf.js");
assert.strictEqual(getWebodfRuntimePath("/webodf/pr-preview/pr-1/index.html"), "./webodf/webodf.js");

console.log("viewer runtime path tests passed");
