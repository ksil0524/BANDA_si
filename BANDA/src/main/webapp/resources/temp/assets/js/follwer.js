
$(function(){
	$("#FollowersTab").click(function(){
		$("#FollowingTab").removeClass("active");
		$("#FollowersTab").addClass("active");
	})

	$("#FollowingTab").click(function(){
		$("#FollowersTab").removeClass("active");
		$("#FollowingTab").addClass("active");
	})
})