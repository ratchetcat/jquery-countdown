jquery-countdown
================
The jquery-countdown plugin:
- Continuously measures the milliseconds between the current Date ( according to the browser )
  and a given future Date specified in the elements on which the plugin is initialized.

- Emits the following events:
   - countdown.update - Emitted if the milliseconds until the future Date are less than the epoch milliseconds of the
                        current Date. A data object with references to element, remaining milliseconds, parsed Date, and timer id
                        is sent with the event.

   - countdown.end    - Emitted if the milliseconds until the future Date are equal to or greater than the epoch
                        milliseconds of the current Date. A data object with references to element, remaining milliseconds, parsed Date
                        is sent with the event.

   - countdown.error  - Emitted if the text in the element(s) to which the plugin is applied is not a valid Date.
                        A data object with references to element and error is sent with the event.


- Executes the following callbacks ( which receive references to element, milliseconds remaining, and the parsed Date ):
   - onUpdate         - Executed if the milliseconds until the future Date are less than the epoch milliseconds of the
                        current Date. A data object with references to element, remaining milliseconds, parsed Date, and timer id
                        is sent to the callback.

   - onEnd            - Executed if the milliseconds until the future Date are equal to or greater than the epoch
                        milliseconds of the current Date. A data object with references to element, remaining milliseconds, parsed Date
                        is sent to the callback.

   - onError          - Executed if the text in the element(s) to which the plugin is applied is not a valid Date.
                        A data object with references to element and error is sent with the event.


Usage
=====
Assuming there are one or more elements in which a valid datetime string is specified, like so:

        <span>2013-04-11 04:30</span>

Then initialize this plugin on those elements using the following jQuery:

        $('span').countdown();

Finally, bind to events on those elements:

        $(document).on("countdown.update", function() { $(this).css("background-color", "#ffc" ); });
        $(document).on("countdown.end",    function() { $(this).css("background-color", "#f66" ); });
        $(document).on("countdown.error",  function() { $(this).css("background-color", "#c00" ); });

Or initialize the plugin with custom callbacks and a custom interval:

        $('span').countdown({
                onUpdate: function( data ) { data.el.css("background-color", "#ffc"); },
                onEnd:    function( data ) { data.el.css("background-color", "#f66"); },
                onError:  function( data ) { data.el.css("background-color", "#c00"); },
                interval: 10000
        });

While this plugin should correctly parse most datetime strings in the format YYYY-MM-DD HH:mm:ss, you may pass a custom
datetime parsing function into the initializer if your datetime strings require special handling or take advantage
of third-party parsing libraries.

        $('span').countdown({
                parseDateTime: function( input ) {
                    var temp = ('' + input).replace(/-/g,"/").replace(/[TZ]/g," ");
                    return new Date( temp );
                }
        });

See [index.html](index.html) for an example use of this plugin with the excellent [moment.js javascript date library](http://momentjs.com).


Compatibility
=============
jQuery-countdown was tested with jQuery 1.5.2 and 1.9.1. It may work in earlier versions. YMMV.


License
=======

This plugin was written in 2013 by Jon Fuller and is released under the MIT license.
