###
jQuery-Countdown

This plugin continuously measures the milliseconds between the current Date ( according to the browser ) and
a given future Date specified in the elements on which the plugin is initialized.

The interval at which this measurement occurs is configurable. The default interval is 5000ms ( 5 seconds ).
Note that the interval time will vary somewhat depending on the browser executing the code.

Each time the measurement is taken, the plugin will emit one of two events for each element being measured:
  countdown.update - The given future Date is still in the future.
  countdown.end    - The given future Date is equal to the current Date ( or equal to past Dates ).

Additionally, the plugin accepts two callbacks on initialization:
  onUpdate( el, remainingMilliseconds ) - Executed when the given future Date is still in the future.
  onEnd( el, remainingMilliseconds )    - Executed when the given future Date is equal to the current Date
                                          ( or equal to past Dates )

Note that each callback receives both a reference to the element in which a future Date is specified, and the number
of remaining milliseconds.

Usage:
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

License:

This plugin is copyright 2013 by Jon Fuller and is released under the MIT license.

###

# reference jQuery
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend
  countdown: (options) ->

    defaults = {
      eventPrefix: 'countdown.'
      interval: 5000
      onEnd: (el, remainingMilliseconds)->
      onUpdate: (el, remainingMilliseconds)->
    };
    settings = $.extend defaults, options

    millisecondsToEnd = ( date, options )->
      return 0 if !(date instanceof Date)
      return new Date().getTime() - date

    return @each ()->
      el = $(@)
      text = el.text()

#      updateListener = setInterval(
#        ->
#          date = new Date( text )
#          if ( ( Math.abs(remainingMilliseconds(date)) < settings.interval ) || ( remainingMilliseconds( date ) > 0 ) )
#            clearInterval( updateListener )
#            el.text( text )
#            el.trigger( "end" )
#          else
#            el.text( text + " (" + remainingMilliseconds(date) + ")" )
#            el.trigger( "update" )
#        ,
#        settings.interval
#      )

      update = ->
        remainingMilliseconds = millisecondsToEnd( new Date( text ) )

        if ( ( Math.abs( remainingMilliseconds ) < settings.interval ) || ( remainingMilliseconds > 0 ) )
          el.trigger( settings.eventPrefix + "end", el )
          settings.onEnd( el, remainingMilliseconds )
        else
          el.trigger( settings.eventPrefix + "update", el )
          settings.onUpdate( el, remainingMilliseconds )
          setTimeout(
            ->
              update()
            , settings.interval
          )

      update()