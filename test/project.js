module

module("Date", {
	setup: function() {},
	teardown: function() {}
});

test("getDateString", function() {
	expect(2);
	
	var ms = Date.parse("Feb 2, 2011");
	var f = new Date(ms);
	equal( f instanceof Date, true );
	equal( f.getDateString(), "Wed 2 February 2011" );
});

module("Project", {
	setup:function() {},
	teardown: function() {}
});

test("getDate", function() {
	expect(1);
	var p = new Project("foo");
	var d = new Date();
	same( d, p.getDate() );
});

test("start", function() {
	expect(1);

	var p = new Project("foo");
	p.start("Feb 2, 2011");
	same(
		p.toObject(), 
		{
			"foo":{
				"Wed 2 February 2011":{
					start:1296622800000,
					total:0
				}
			}
		}
	);
});

test("stop", function() {
	expect(1);

	var p = new Project("foo");
	p.start("Feb 2, 2011 20:03");
	p.stop("Feb 2, 2011 21:03");
	same(
		p.toObject(),
		{
			"foo": {
				"Wed 2 February 2011": {
					"start": 1296694980000,
					"total": 3600000
				}
			}
		} 
	);
});



module("Timer", {
	setup: function() {
		this.t = new Timer();
		this.t.load = function() {
			ok(true, 'load');
		};
		this.t.initialized = function(currentProject) {
			ok(true, 'initialized');
		};
		this.t.findCurrentProject = function( days ) {
			ok(true, 'findCurrentProject');
		};
	},
	teardown: function() {
		this.t = null;
	}
});

test("init", function() {
	expect(4);

	this.t.init();
	// should call this.t.load
	// should call this.t.initialized

	//equal(this.t.currentProject, null, 'currentProject');

	var d = new Date();
	//equal(this.t.currentDay, d.getDateString(), 'currentDay');
});

test("findCurrentProject", function() {
	expect(2);

	var days = null;

	days =	{"Wed 2 February 2011":
			{
				"Foo":{
					running:true,
					start:1296622800000,
					total:0
				}
			}
		};
	//equal(this.t.findCurrentProject( days ), "Foo");


	days =	{"Wed 2 February 2011":
			{
				"Foo":{
					start:1296622800000,
					total:0
				}
			}
		};
	//equal(this.t.findCurrentProject( days ), null);
});



/*
test("start", function() {
	expect(2);
	equal( this.t.start("foo", "Feb 2, 2011"), true );	
	same(
		this.t.getProjects(), 
		{"foo":
			{"Wed 2 February 2011":
				{
					start:1296622800000,
					total:0
				}
			}
		}
	);
});
*/
