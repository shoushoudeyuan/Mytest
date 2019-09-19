var giftConfig = window.NameSpace || {};
giftConfig.list = new function() {
	var self = this;
	
	self.listInital = function(){
		setAutoHeight(270,"dg"); 
		$('#dg').datagrid({
			url:getRootPath_web()+'/giftconfig/list',
			toolbar : $('#toolbar'),
			rownumbers : true,
			columns : [ [
					{
						field : 'id',
						width:'5%',
						hidden:true,
					},{
						field : 'action',
						title : '操作',
						width : '20%',
						formatter : function(value, rec) { 
							var btn = '<a style=""  class="radiuBtn" href="#" onclick="javascript:giftConfig.openEdit('+ rec.enumCode +')">编辑</a>';
							btn += '<a style=""  class="radiuBtn" href="'+ getRootPath_web() +'/jsp/couponmanage/couponpackagelist.jsp?packageId='+ rec.enumCode +'">配券</a>'
							return btn;
						}
					}, {
						field : 'ruleName',
						title : '规则名称',
						width : '20%',
					}, {
						field : 'isValidate',
						title : '状态',
						width : '8%',
						formatter : function(value, rec) { 
							if (rec.isValidate == 1) {
								return "<span style='color:#3598dc'>启用<span>";
							} else {
								return "<span style='color:#ff0000'>禁用</span>";
							}
						}
					}, {
						field : 'channelType',
						title : '类型',
						width : '8%',
						formatter : function(value, rec) { 
							return "系统赠送";
						}
					} , {
						field : 'configDescription',
						title : '介绍',
						width : '60%',
					} ] ],
			pagination : true,
			pageSize : 10,
			pageList : [ 5, 10, 15, 20, 50 ],
			layout:['prev','links','next','list'],
			emptyMsg : '无数据',
			onBeforeLoad : function(param) {
				$($('#fm_s').serializeArray()).each(
					function() {
						param[this.name] = this.value;
					});
				},
				onBeforeSelect : function() {
					return false;
				}
			});
		 
		var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
		pager.pagination({
			pageSize:30,
			pageList: [10,50,100],
			displayMsg:'',
			links : 5,
			layout:['prev','links','next','list']
		});     
	};
	
	self.search = function(){
		$('#dg').datagrid('load');
	};
};

giftConfig.openEdit = function(enumCode){
	switch(enumCode){
		case 1:
			$('#dlgRegister').window({href:getRootPath_web()+'/jsp/couponmanage/registergiftconfig.jsp?ec=1'})
			.window('setTitle','注册用户赠')
			.window('open');
			break;
		case 2:
			$('#dlgInvite').window({href:getRootPath_web()+'/jsp/couponmanage/invitefriendsconfig.jsp?ec=2'})
			.window('setTitle','邀请好友赠')
			.window('open');
			break;
		case 3:
			$('#dlgOrder').window({href:getRootPath_web()+'/jsp/couponmanage/ordergiftconfig.jsp?ec=3'})
			.window('setTitle','订单满额赠')
			.window('open');
			break;
		case 4:
			$('#dlgFirstOrder').window({href:getRootPath_web()+'/jsp/couponmanage/firstorderconfig.jsp?ec=4'})
			.window('setTitle','首次用车结单赠')
			.window('open');
			break;
		case 5:
			$('#dlgRegisterMember').window({href:getRootPath_web()+'/jsp/couponmanage/registerentmemberconfig.jsp?ec=5'})
			.window('setTitle','首次成为企业会员赠')
			.window('open');
			break;
		case 6:
			$('#dlgEntMember').window({href:getRootPath_web()+'/jsp/couponmanage/entmemberconfig.jsp?ec=6'})
			.window('setTitle','企业会员按时间赠')
			.window('open');
	}
}

$(function(){
	giftConfig.list.listInital();
});