function showFloatEditDiv(url) {
	var editIdx = getMaxZindex() + 2;
	if ($("#divFloatEditDiv").length == 0) {
		var html = " <div id=\"divFloatEditDiv\"  class=\" layui-anim layui-anim-scale\" style='z-index:101;background:#ffffff;display:none;position: absolute'>"
				+ "    <iframe scrolling= \"auto\"    frameborder= \"0\" id= \"ifrmFloatEditDiv\"  name= \"ifrmFloatEditDiv\" style = \"width: 100%; height: 100%;\" ></iframe >"
				+ "</div>";
		$("body").append(html);

		$("#divFloatEditDiv").css("width", $(window).width() + "px");
		$("#divFloatEditDiv").css("height", ($(window).height()) + "px");
		$("#divFloatEditDiv").css("top", "0px");
		$("#divFloatEditDiv").css("left", $(window).width() + "px");
	}
	$("#ifrmFloatEditDiv").attr("src", url);
	$("#divFloatEditDiv").css("display", "block");
	$("#divFloatEditDiv").css("left","0");

	// $("#divFloatEditDivCover").click(function() {
	// hideFloatEditDiv();
	// });
}

function hideFloatEditDiv() {
	$("#divFloatEditDiv").css("display","none");
}

$(window).resize(function() {
	$("#divFloatEditDiv").css("height", $(window).height() + "px");
});
