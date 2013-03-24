jquery-countdown
================

The jquery-countdown plugin:
1. Continuously measures the milliseconds between the current Date ( according to the browser )
   and a given future Date specified in the elements on which the plugin is initialized.

2. Emits the following events:
   countdown.update - emitted if the milliseconds until the future Date are less than the epoch milliseconds of the
                      current Date.

   countdown.end    - emitted if the milliseconds until the future Date are equal to or greater than the epoch
                      milliseconds of the current Date.

3. Executes the following callbacks ( which receive references to both element and milliseconds remaining ):
   onUpdate         - executed if the milliseconds until the future Date are less than the epoch milliseconds of the
                      current Date.

   onEnd            - executed if the milliseconds until the future Date are equal to or greater than the epoch
                      milliseconds of the current Date.

Usage
=====

You should have one or more elements in which a valid ISO8601 Date is specified, like so:

        <p>Sun Mar 24 2013 11:43:28 GMT-0400 (EDT)</p>

You may initialize this plugin on those elements using the following jQuery:

        $('p').countdown();

To bind to events on those elements:

        $('p').bind("countdown.update", function() { $(this).css("background-color", "#ffc" ); });

        $('p').bind("countdown.end", function() { $(this).css("background-color", "#f66" ); });

To initialize with custom callbacks and a custom interval:

        $('p').countdown({
                onUpdate: function( el, remainingMilliseconds ) { el.css("background-color", "#ffc"); },
                onEnd: function( el, remainingMilliseconds ) { el.css("background-color", "#f66"); },
                interval: 10000
        });

License
=======

This plugin was written in 2013 by Jon Fuller and is released under the MIT license.