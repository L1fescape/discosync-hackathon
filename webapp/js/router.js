var WorkspaceRouter = Backbone.Router.extend({
	routes : {
		""          : "index",
		":djName" : "room"
	},

	index : function() {
		$(".slider").animate({left : "0"}, "fast" );
		$(".app_room").animate({opacity : 0}, "fast" );
		$(".app_roomlist").animate({opacity : 1}, "slow" );
		$(".dim").animate({opacity : 0}, "slow" );
		$(".letsDJ").animate({opacity : 0.8}, "fast" );
	},

	room : function(djName) {
		RoomFull.render(djName);
		$(".slider").animate({left : "-500px"}, "fast" );
		$(".app_roomlist").animate({opacity : 0}, "fast" );
		$(".app_room").animate({opacity : 1}, "slow" );
		$(".dim").animate({opacity : 0.7}, 500 );
		$(".letsDJ").animate({opacity : 0}, "fast" );
	}
});
