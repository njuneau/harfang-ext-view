Harfang extension - View
========================

This extension is used to facilitate the usage of hierarchical views with Haxe's
provided template system.

Although this utility bears Harfang's name, it can be used outside of it.

Installing
----------

The library can either be obtained by source on Github or by using Haxelib:

.. code:: sh

    haxelib install Harfang-ext-view

Usage
-----

Suppose you have two template resources named **child.html** and **parent.html**
, referenced in resources as **child** and **parent**. You want the child
template to be rendered as part of the parent template. This is how you would do
it.

Contents of parent.html
```````````````````````

.. code:: html
    
    <!DOCTYPE html>
    <html>
        <head><title>Parent template</title></head>
        <body>
            ::__child_template::
        </body>
    </html>

Contents of child.html
``````````````````````

.. code:: html

    <p>Hello world!</p>

Sample Haxe code to build the view
``````````````````````````````````

.. code:: haxe

    package hello;

    import harfang.ext.view.View;

    class World {

        public function render() : String {
            var parentView : View = new View("parent");
            var childView : View = new View("child", parentView);
            return childView.render();
        }
        
    }

Calling the *render* method on *childView* would produce the following:

.. code:: html

    <!DOCTYPE html>
    <html>
        <head><title>Parent template</title></head>
        <body>
            <p>Hello world!</p>
        </body>
    </html>
