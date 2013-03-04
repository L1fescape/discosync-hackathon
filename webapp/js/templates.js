var templates = {
	fullRoom : function() {
		return '<div class="back">&larr; sync to a different disco</div> \
			      <div class="djname">{{ name }}</div> \
					  <div class="genre">{{ genre }}</div> \
						<div class="listeners">{{ listeners }} people listening</div> \
						<div class="roomsound"> \
						  <audio controls autoplay> \
							  <source src="{{ songurl }}" type="audio/mpeg"> \
							</audio> \
						</div>';
	},
	itemRoom : function() {
		return '<div class="roomlist_item" key="{{ name }}"> \
			      <div class="djname">{{ val.name }}</div> \
					  <div class="genre">{{ val.genre }}</div> \
						<div class="listeners">{{ val.listeners }} people listening</div> \
						<div class="carrot"></div> \
						</div>';
	},
	itemRoom_inner : function() {
		return '<div class="djname">{{ name }}</div> \
					  <div class="genre">{{ genre }}</div> \
						<div class="listeners">{{ listeners }} people listening</div> \
						<div class="carrot"></div>';
	}
};
