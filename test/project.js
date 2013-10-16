test("sanity check", 1, function() {
  ok(true);
});


module("countdown with invalid input", {
  setup:function() {
    var $fixture = $('#qunit-fixture');
    $fixture.append('<p class="target-date">Invalid Date</p>');
  }
});


asyncTest("error callback should receive expected variables", 2, function() {
  $('p.target-date').countdown({
    onError: function(data) {
      equal((data.el instanceof jQuery), true, 'el should be a jQuery element' );
      equal(data.error, 'Invalid Date could not be parsed to valid DateTime.', 'text should contain appropriate error message');
      start();
    }
  });
});


asyncTest("error event should receive expected variables", 2, function() {
  $(document).on('countdown.error', function(event, data) {
    equal((data.el instanceof jQuery), true, 'el should be a jQuery element' );
    equal(data.error, 'Invalid Date could not be parsed to valid DateTime.', 'text should contain appropriate error message');
    start();
  });
  $('p.target-date').countdown();
});


module("countdown with valid input", {
  setup:function() {
    var $fixture = $('#qunit-fixture');
    $fixture.append('<p class="target-date">' + moment().add('seconds', 7).format('YYYY-MM-DDTHH:mm:ss') + '</p>');
  }
});


asyncTest("callbacks should receive expected variables", 7, function() {
  $('p.target-date').countdown({
    onUpdate: function( data ) {
      equal((data.el instanceof jQuery), true, 'el should be a jQuery element' );
      equal(typeof(data.remainingMilliseconds), 'number', 'remainingMilliseconds should be a number');
      equal(typeof(data.parsedDate), 'object', 'parsedDate should be an object');
      equal(typeof(data.timerId), 'number', 'timerId should be a number');
    },
    onEnd: function( data ) {
      equal((data.el instanceof jQuery), true, 'el should be a jQuery element' );
      equal(typeof(data.remainingMilliseconds), 'number', 'remainingMilliseconds should be a number');
      equal(typeof(data.parsedDate), 'object', 'parsedDate should be an object');
      start();
    }
  });
});


asyncTest("events should receive expected variables", 7, function() {
  $(document).on('countdown.update', function(event, data) {
    equal((data.el instanceof jQuery), true, 'el should be a jQuery element' );
    equal(typeof(data.remainingMilliseconds), 'number', 'remainingMilliseconds should be a number');
    equal(typeof(data.parsedDate), 'object', 'parsedDate should be an object');
    equal(typeof(data.timerId), 'number', 'timerId should be a number');
  });

  $(document).on('countdown.end', function(event, data) {
    equal((data.el instanceof jQuery), true, 'el should be a jQuery element' );
    equal(typeof(data.remainingMilliseconds), 'number', 'remainingMilliseconds should be a number');
    equal(typeof(data.parsedDate), 'object', 'parsedDate should be an object');
    start();
  });

  $('p.target-date').countdown();
});
