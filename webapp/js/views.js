// Room Views
var RoomView = Backbone.View.extend({
	el : ".app_room",
	model : {},
	events : {
		"click .back" : "back"
	},
	
	initialize : function() {
		//this.render();
	},

	back : function() {
		$(".slider").animate({left : "0"}, "fast" );
		$(".app_room").animate({opacity : 0}, "fast" );
		$(".app_roomlist").animate({opacity : 1}, "slow" );
		$(".dim").animate({opacity : 0}, "slow" );
		$(".letsDJ").animate({opacity : 0.8}, "fast" );
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

	openRoom : function() {
		$(".slider").animate({left : "-500px"}, "fast" );
		$(".app_roomlist").animate({opacity : 0}, "fast" );
		$(".app_room").animate({opacity : 1}, "slow" );
		$(".dim").animate({opacity : 0.7}, 500 );
		$(".letsDJ").animate({opacity : 0}, "fast" );
	},

	render : function() {
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
