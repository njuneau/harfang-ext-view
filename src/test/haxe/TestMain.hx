/*
 * Copyright (c) Nicolas Juneau
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *  - Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *  - Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

package ;

import neko.Lib;

import harfang.ext.view.View;

import unit2.TestRunner;
import unit2.TestCase;
import unit2.output.OutputWriter;
import unit2.output.TextOutputWriter;

/**
 * Main test class
 */
class TestMain extends TestCase {

    /**
     * Tests basic template rendering
     */
    @Test
    public function testRenderWithContext() : Void {
        var parentView : View = new View("parent");
        var childView : View = new View("child", parentView);
        var ctx = {username:"Bob", pclass:"Alice"};
        var output : String = childView.render(ctx, this);
        this.assertEquals("<p class=\"Alice\">Hello Bob!</p>", output);
    }

    /**
     * Test template macro
     */
    public function tplMacro(resolve : String->Dynamic, args : Dynamic) : String {
        return "!";
    }

    /**
     * Launches the tests
     */
    public static function main() : Void {
        var testRunner = new TestRunner();
        testRunner.add(TestMain);
        testRunner.run();
        var testOutput : TextOutputWriter = new TextOutputWriter();
        Lib.print(testOutput.writeResults(testRunner));
    }

}