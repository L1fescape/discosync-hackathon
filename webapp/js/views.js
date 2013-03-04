// Room Views
var RoomFullView = Backbone.View.extend({
	el : ".app_room",
	events : {
		"click .back" : "back"
	},
	
	initialize : function() {
		//this.render();
	},

	clear : function() {
		$(this.el).html();
	},

	back : function() {
		var dj = window.location.hash.replace("#", "");
		var count = (rooms[dj].listeners > 0) ? rooms[dj].listeners - 1 : 0;
		disco.child('rooms').child(dj).update({'listeners' : count});
		window.location.hash = "";
		this.clear();
	},

	update : function(room) {
	},

	render : function(djName) {
		var dj = rooms[djName];
		$(this.el).html(Mustache.to_html(templates.fullRoom(), dj));
	}
});

var RoomListView = Backbone.View.extend({
	el : ".app_roomlist",
	events : {
		"click .roomlist_item" : "openRoom"
	},
	
	initialize : function() {
		//this.render();
	},

	openRoom : function(e) {
		var dj = $(e.target).parent().attr('key');
		var count = rooms[dj].listeners + 1;
		disco.child('rooms').child(dj).update({'listeners' : count});
		window.location.hash = dj;
	},

	clear : function() {
		$(this.el).html();
	},

	append : function(djName) {
		var dj = rooms[djName];
		$(this.el).append(Mustache.to_html(templates.itemRoom(), { name : djName, val : dj }));
	},

	render : function() {
		this.clear();
		for (var i in rooms) {
			this.append(i)
		}
	}
		
});
