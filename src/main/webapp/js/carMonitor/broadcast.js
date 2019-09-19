/*$.ajax($('#context').val()+'/warnlog/allList').done(function(result){
	result.rows.forEach(function(item,index){
		 $("#warnLog ul").append("<li style='list-style-type: none;border:none'>" + item.warnContent + "</li>");
	 })
}); */

function AutoScroll(obj) {
    $(obj).find("ul:first").animate({
        marginTop: "-22px"
    },
    1000,
    function() {
        $(this).css({
            marginTop: "0px"
        }).find("li:first").appendTo(this);
    });
}
$(document).ready(function() {
    setInterval('AutoScroll("#warnLog")', 3000)
});