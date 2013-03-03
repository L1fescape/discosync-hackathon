$(document).ready(function(){
	$(".roomlist_item").click(function(){
		$(".slider").animate({left : "-500px"}, "fast" );
		$(".app_roomlist").animate({opacity : 0}, "fast" );
		$(".app_room").animate({opacity : 1}, "slow" );
		
	});
	$(".back").click(function(){
		$(".slider").animate({left : "-0"}, "fast" );
		$(".app_room").animate({opacity : 0}, "fast" );
		$(".app_roomlist").animate({opacity : 1}, "slow" );
	});
});