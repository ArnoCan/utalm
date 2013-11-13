

function toggleByID(ID,offset) {
	$("#"+ID).toggle();
	var position = $("#"+ID).position();
	offset = typeof offset !== 'undefined' ? offset : $("#"+ID).height();	
	scroll(0,offset+position.top);
	}

function toggleByIDIframeChildrenRemove(ID,offset) {
	toggleByID(ID,offset)
	//ToDo: add Youtube API.
}

function toggleByClass(cls) {
	   $("."+cls).toggle();
}

function toggleChildren(father) {
	$(father).click(function () {
		  $(this).children().toggle();
});
}
	




