###
jquery-countdown
================
See https://github.com/ratchetcat/jquery-countdown

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