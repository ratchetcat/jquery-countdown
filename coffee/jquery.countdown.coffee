###
jquery-countdown
================

The jquery-countdown plugin:
- Continuously measures the milliseconds between the current Date ( according to the browser )
   and a given future Date specified in the elements on which the plugin is initialized.

- Emits the following events:
   - countdown.update - emitted if the milliseconds until the future Date are less than the epoch milliseconds of the
                      current Date.
   - countdown.end    - emitted if the milliseconds until the future Date are equal to or greater than the epoch
                      milliseconds of the current Date.

- Executes the following callbacks ( which receive references to both element and milliseconds remaining ):
   - onUpdate         - executed if the milliseconds until the future Date are less than the epoch milliseconds of the
                      current Date.
   - onEnd            - executed if the milliseconds until the future Date are equal to or greater than the epoch
                      milliseconds of the current Date.

Usage
=====

You should have one or more elements in which a valid Date ( see important notes below ) is specified, like so:

        <span>2011/04/01</span>

You may initialize this plugin on those elements using the following jQuery:

        $('span').countdown();

To bind to events on those elements:

        $('span').bind("countdown.update", function() { $(this).css("background-color", "#ffc" ); });

        $('span').bind("countdown.end", function() { $(this).css("background-color", "#f66" ); });

To initialize with custom callbacks and a custom interval:

        $('span').countdown({
                onUpdate: function( el, remainingMilliseconds ) { el.css("background-color", "#ffc"); },
                onEnd: function( el, remainingMilliseconds ) { el.css("background-color", "#f66"); },
                interval: 10000
        });

While this plugin should correctly parse most datetime strings in the format YYYY-MM-DD HH:mm:ss, you may pass a custom
datetime parsing function into the initializer if your datetime strings require special handling or to take advantage
of third-parting parsing libraries.

        $('span').countdown({
                parseDateTime: function( input ) {
                    var temp = ('' + input).replace(/-/g,"/").replace(/[TZ]/g," ");
                    return new Date( temp );
                }
        });

License
=======

This plugin was written in 2013 by Jon Fuller and is released under the MIT license.
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
      parseDateTime: ( input ) ->
        # parse datetime consistently across browsers...
        # example: 2013-03-24T14:26:54
        # example: 2013-03-24 14:26:54
        temp = ('' + input).replace(/-/g,"/").replace(/[TZ]/g," ")
        new Date( temp )
    };
    settings = $.extend defaults, options

    millisecondsToEnd = ( date, options )->
      return 0 if !(date instanceof Date)
      return new Date().getTime() - date

    return @each ()->
      el = $(@)
      text = el.text()

      # return immediately if parsedDate is invalid
      try
        parsedDate = settings.parseDateTime( text )
        throw text + " is not valid DateTime." if ( parsedDate.toString().match( /Invalid/ ) )
      catch error
        parsedDate = null
      return if parsedDate == null

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
        remainingMilliseconds = millisecondsToEnd( parsedDate )

        # if remainingMilliseconds are less than interval or parsedDate has passed, trigger end event and execute onEnd
        # otherwise, trigger update event, execute on Update, and reschedule
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