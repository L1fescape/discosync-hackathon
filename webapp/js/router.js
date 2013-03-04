var WorkspaceRouter = Backbone.Router.extend({
	routes : {
		""          : "index",
		":djName" : "room"
	},

	index : function() {
		// Stop all audio
		var audioPlayer = document.getElementsByTagName('audio')[0];
		if (audioPlayer) {
			audioPlayer.pause();
			audioPlayer.currentTime = 0;
		}
		// Transition
		$(".slider").animate({left : "0"}, "fast" );
		$(".app_room").animate({opacity : 0}, "fast" );
		$(".app_roomlist").animate({opacity : 1}, "slow" );
		$(".dim").animate({opacity : 0}, "slow" );
		$(".letsDJ").animate({opacity : 0.8}, "fast" );
		RoomFull.clear();
	},

	room : function(djName) {
		// Draw the room we want to load
		RoomFull.render(djName);
		// And show it
		$(".slider").animate({left : "-500px"}, "fast" );
		$(".app_roomlist").animate({opacity : 0}, "fast" );
		$(".app_room").animate({opacity : 1}, "slow" );
		$(".dim").animate({opacity : 0.7}, 500 );
		$(".letsDJ").animate({opacity : 0}, "fast" );
	}
});
