// Room Views
var RoomFullView = Backbone.View.extend({
	el : ".app_room",
	model : {},
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
		window.location.hash = "";
		this.clear();
	},

	render : function(djName) {
		console.log(djName)
		var dj = rooms[djName];
		var html = '<div class="back">sync to a different disco</div>';
		html += '<div class="djname">'+dj.name+'</div>';
		html += '<div class="genre">'+dj.genre+'</div>';
		html += '<div class="listening">'+dj.listening+' people listening</div>';
		html += '<div class="roomsound"><audio controls autoplay><source src="'+dj.songurl+'" type="audio/mpeg"></audio></div>';
		$(this.el).html(html);
	}
});

var RoomListView = Backbone.View.extend({
	el : ".app_roomlist",
	model : {},
	events : {
		"click .roomlist_item" : "openRoom"
	},
	
	initialize : function() {
		//this.render();
	},

	openRoom : function(e) {
		window.location.hash = $(e.target).parent().attr('key');
	},

	clear : function() {
		$(this.el).html();
	},

	append : function(djName) {
		var dj = rooms[djName];
		var room = "<div class='roomlist_item' key='"+djName+"'>";
		room += "<div class='djname'>"+dj.name+"</div>";
		room += "<div class='genre'>"+dj.genre+"</div>";
		room += "<div class='listening'>"+dj.listeners+" people listening</div>";
		room += "<div class='carrot'></div>";
		room += "</div>";
		$(this.el).html($(this.el).html() + room);
	},

	render : function() {
		this.clear();
		for (var i in rooms) {
			var dj = rooms[i];
			var room = "<div class='roomlist_item' key='"+i+"'>";
			room += "<div class='djname'>"+dj.name+"</div>";
			room += "<div class='genre'>"+dj.genre+"</div>";
			room += "<div class='listening'>"+dj.listeners+" people listening</div>";
			room += "<div class='carrot'></div>";
			room += "</div>";
			$(this.el).html($(this.el).html() + room);
		}
	}
		
});



$(document).ready(function(){
	$(".letsDJ").click(function(){
		$(".frame").animate({opacity : 0}, "slow" );
		$(".frame").css({display : "none"});
		$(".app_main").animate({width : "1000px"}, "slow" );
		$(".letsDJ").animate({opacity : 1}, "slow");
		$(".closeDJ").animate({opacity : 0.5}, "slow");
		$(".interfaceDJ").animate({opacity : 1, top : "100px"}, 1000);
		$(".letsDJ").animate({opacity : 0.4}, "slow");
		$(".dim").animate({opacity : 0.7}, 500 );
	});
	$(".closeDJ").click(function(){
		$(".app_main").animate({width : "600px"}, "slow" );
		$(".letsDJ").animate({opacity : 0.5}, "slow");
		$(".frame").css({display : "block"});
		$(".frame").animate({opacity : 1}, "slow" );
		$(".closeDJ").animate({opacity : 0}, "slow");
		$(".interfaceDJ").animate({opacity : 0}, "fast");
		$(".interfaceDJ").animate({top : "1000px"}, "fast");
		$(".dim").animate({opacity : 0}, "slow" );
		$(".app_roomlist").animate({opacity : 1}, "slow" );
		$(".slider").css({left : 0});
	});
	$(".interfaceDJ").click(function(){
		$(".app_main").animate({width : "600px"}, "slow" );
		$(".letsDJ").animate({opacity : 0.5}, "slow");
		$(".frame").css({display : "block"});
		$(".frame").animate({opacity : 1}, "slow" );
		$(".closeDJ").animate({opacity : 0}, "slow");
		$(".interfaceDJ").animate({opacity : 0}, "fast");
		$(".interfaceDJ").animate({top : "1000px"}, "fast");
		$(".dim").animate({opacity : 0}, "slow" );
		$(".app_roomlist").animate({opacity : 1}, "slow" );
		$(".slider").css({left : 0});
	});
	$(".aboutButton").click(function(){
		$(".app_main").animate({top : "-1000px"}, 500 );
		$(".aboutButton").animate({opacity : 0}, "slow" );
		$(".aboutButton").css({display : "none"});
		$(".aboutX").css({display : "block"});
		$(".aboutX").animate({opacity : 0.8}, "slow" );
	});
	$(".aboutClose").click(function(){
		$(".app_main").animate({top : "0px"}, 500 );
		$(".aboutX").animate({opacity : 0}, "slow" );
		$(".aboutX").css({display : "none"});
		$(".aboutButton").css({display : "block"});
		$(".aboutButton").animate({opacity : 1}, "slow" );
	});
	$(".aboutX").click(function(){
		$(".app_main").animate({top : "0px"}, 500 );
		$(".aboutX").animate({opacity : 0}, "slow" );
		$(".aboutX").css({display : "none"});
		$(".aboutButton").css({display : "block"});
		$(".aboutButton").animate({opacity : 1}, "slow" );
	});

});
