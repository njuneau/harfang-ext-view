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

package harfang.ext.view;

import haxe.Template;
import haxe.Resource;

/**
 * A View object is part of a composite. You can combine as many as you want,
 * they are structured in a hierarchical manner. All of the view's parameters
 * are passed up to the parents.
 *
 * In order to render the contents of a sub-view in a view, you must reserve
 * a template variable named "__child_template"
 */
class View {

    private var parentView : View;
    private var resourceName : String;

    /**
     * Constructs a new view
     * @param resourceName The template's resource identificator
     * @param parentView This view's parent, optional
     */
    public function new(resourceName : String, ?parentView : View) {
        this.resourceName = resourceName;
        this.parentView = parentView;
    }

    /**
     * Renders the template as a string
     *
     * @param context Context variables
     * @param macros Template macros
     * @return The rendered template
     */
    public function render(? context : Dynamic, ? macros : Dynamic) : String {
        var result : String = this.renderTemplate(context, macros);

        if(context == null) {
            context = {};
        }

        // Set child view in the template context
        context.__child_template = result;

        // If this view has a parent view, render it
        if(this.parentView != null) {
            result = this.parentView.render(context, macros);
        }

        // Return the result
        return result;
    }

    /**
     * Renders the template as a string
     *
     * @param context Context variables
     * @param macros Template macros
     * @return The rendered template
     */
    private function renderTemplate(context : Dynamic, ? macros : Dynamic) : String {
        var template : Template = new Template(Resource.getString(this.resourceName));
        return template.execute(context, macros);
    }

}