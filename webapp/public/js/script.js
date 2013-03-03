$(document).ready(function(){
	$(".roomlist_item").click(function(){
		$(".slider").animate({left : "-500px"}, "fast" );
		$(".app_roomlist").animate({opacity : 0}, "fast" );
		$(".app_room").animate({opacity : 1}, "slow" );
		
	});
	$(".back").click(function(){
		$(".slider").animate({left : "0"}, "fast" );
		$(".app_room").animate({opacity : 0}, "fast" );
		$(".app_roomlist").animate({opacity : 1}, "slow" );
	});
	$(".letsDJ").click(function(){
		$(".frame").animate({opacity : 0}, "slow" );
		$(".app_main").animate({width : "1000px"}, "slow" );
		$(".letsDJ").animate({opacity : 1}, "slow");
		$(".closeDJ").animate({opacity : 0.5}, "slow");
		$(".interfaceDJ").animate({opacity : 1, top : "100px"}, 1000);
	});
	$(".closeDJ").click(function(){
		$(".app_main").animate({width : "600px"}, "slow" );
		$(".letsDJ").animate({opacity : 0.5}, "slow");
		$(".frame").animate({opacity : 1}, "slow" );
		$(".closeDJ").animate({opacity : 0}, "slow");
		$(".interfaceDJ").animate({opacity : 0}, "fast");
		$(".interfaceDJ").animate({top : "1000px"}, "fast");
	});
});