var templates = {
	itemRoom : function() {
		return '<div class="roomlist_item" key="{{ name }}"> \
			      <div class="djname">{{ val.name }}</div> \
					  <div class="genre">{{ val.genre }}</div> \
						<div class="listeners">{{ val.listeners }} listening</div> \
						<div class="carrot"></div> \
						</div>';
	},
	itemRoom_inner : function() {
		return '<div class="djname">{{ name }}</div> \
					  <div class="genre">{{ genre }}</div> \
						<div class="listeners">{{ listeners }} listening</div> \
						<div class="carrot"></div>';
	}
};
