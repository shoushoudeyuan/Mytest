<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>

<title>交通事故登记</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>

	<div class="list_title">
		 <span class="layui-parent-title-customer">HOME</span>
		 <span class="layui-badge-dot layui-bg-title"></span>
		 <span class="layui-children-title-customer">交通事故登记</span>
	</div>

	<div class="text_input">
		<span class="div_search_customerBar"></span>
		<form id='queryForm'>
			<div class="form_item">
				<div class="form_item_inline">
					<label class="form_item_label3">订单号</label>
					<div class="form_item_input">
						<!-- 事件类型(0违章1故障2救援3催款) -->
						<input type="hidden" id="eventcategory" name="eventcategory" value="1" />
						<input id="orderNo" name="orderNo" value="" class="easyui-textbox" style="width: 100px">
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label2">姓名</label>
					<div class="form_item_input">
						<input id="customerName" name="customerName" value="" class="easyui-textbox" style="width: 100px">
					</div>
				</div>
				<div class="form_item_inline">
					<label class="form_item_label4">联系电话</label>
					<div class="form_item_input">
						<input id="mobile" name="mobile" value="" class="easyui-textbox" style="width: 100px">
					</div>
				</div>
				<div class="form_item_inline">
					<input type="button" class="text_input_button_search" onclick="search()" style="width: 100px" value="查询">
				</div>
			</div>
		</form>
	</div>
	<div class="table_data">
		<h4 class="table_data_title">
			交通事故登记
			<div class="text_input_bottom">
				<div class="text_input_button_add" id="text_input_button_left"
					onclick="addRecord()">新增</div>
				<div class="text_input_button_del" id="text_input_button_left"
					onclick="deleteRecord()">删除</div>
			</div>
		</h4>
		<table id="dg"></table>
	</div>
	<script type="text/javascript">
	$(function() {
        setAutoHeight(270, "dg");
        $('#dg').datagrid({
            url: '<%=request.getContextPath()%>/customerService/getServiceEvents',
            fitColumns: true,
            pagination: true,
            toolbar: $('#toolbar'),
            rownumbers: true,
            pageSize: 10,
            pageList: [10, 20, 30, 40],
            emptyMsg: '无数据', //为空时的数据展示
            columns: [
                [
                    { field: 'ck', checkbox: true, id: 'ck' },
                    { field: 'id', hidden: true, title: 'id' },
                    { field: 'action', title: '操作', align: 'center' ,formatter:formatAction},
                    { field: 'customername', title: '姓名' },
                    { field: 'gendername', title: '性别' },
                    { field: 'mobile', title: '电话' },
                    { field: 'orderno', title: '订单号' },
                    { field: 'vehiclemodelname', title: '车型' },
                    { field: 'platenumber', title: '车牌号' },
                    { field: 'rentparkname', title: '租车车场' },
                    { field: 'renttime', title: '取车时间' },
                    { field: 'eventtime', title: '出险时间' },
                    { field: 'eventaddress', title: '出险地点' },
                    { field: 'singleorboth', title: '单双方事故' },
                    { field: 'eventcase', title: '出险情况' },
                    { field: 'insurancecompany', title: '保险公司' },
                    { field: 'reportcaseno', title: '报案号' },
                    { field: 'contactcontent', title: '联系内容' },
                    { field: 'dealwithdate', title: '处理时间' },
                    { field: 'dealwithresult', title: '处理结果' },
                    { field: 'operator', title: '处理人' },
                    { field: 'assistant', title: '客服人员', align: 'center' },
                    { field: 'remark', title: '备注', align: 'center' }
                ]
            ],
            onBeforeLoad: function(param) {
                $($('#queryForm').serializeArray()).each(function() {
                    param[this.name] = this.value;
                });
            },
            onBeforeSelect: function() {
                return false;
            }
        });
        var pager = $('#dg').datagrid('getPager'); // get the pager of datagrid
        pager.pagination({
            pageSize: 10,
            pageList: [10,50,100],
            links: 5,
            displayMsg: '',
            emptyMsg: '无数据',
            layout: ['prev', 'links', 'next', 'list']
        });
    });
   
    function formatAction(val,row){
        return '<a style="" class="radiuBtn" href="javascript:editRecord('+row.id+')">编辑</a>';       
	}
    
	function editRecord(id){
		location.href="<%=request.getContextPath()%>/jsp/customerService/editFaultRecord.jsp?serviceEventId="+id;
	}
	
	function addRecord(){
		location.href="<%=request.getContextPath()%>/jsp/customerService/editFaultRecord.jsp";
		}

		function deleteRecord() {
			var path = '<%=request.getContextPath()%>/customerService/deleteServiceEvent'; 
			var rows = $('#dg').datagrid('getChecked');
			if (rows.length > 0) {
				$.messager.confirm('信息提示', '确定要删除记录么?', function(r) {
					if (r) {
						var ids = '';
						for (var i = 0; i < rows.length; i++) {
							ids += rows[i].id + ',';
						}
						ids = ids.substring(0, ids.length - 1);

						$.post(path, {
							eventIds : ids
						}, function(result) {
							if (result > 0) {
								$.messager.alert('信息提示', '操作成功');
								$('#dg').datagrid('reload'); // reload the user data
							} else {
								$.messager.alert('信息提示', '操作失败');
							}
						}, 'json');
					}
				});
			} else {
				$.messager.alert('操作提示', '至少选择一条记录!');
			}
		}

		function search() {
			$('#dg').datagrid('load');
		}
	</script>
</body>
</html>
