var WorkspaceRouter = Backbone.Router.extend({
	routes : {
		""          : "index",
		":djName" : "room"
	},

	index : function() {
	},

	room : function(djName) {
		console.log(djName);
	}
});
