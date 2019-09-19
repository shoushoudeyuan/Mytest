$
		.extend(
				$.fn.validatebox.defaults.rules,
				{
					minIngeter:{
						validator:function(value){
							return /^[1-9]\d*$/.test(value)
						},
						message:'请输入最少1张'
					},
					maxLengtha:{
						validator : function(value, param) {
							return value.length <= 8;
						},
						message : '最多可输入8个字符.'
					},
					maxLengthb:{
						validator : function(value, param) {
							return value.length <= 10;
						},
						message : '最多可输入10个字符.'
					},
					maxLengthc:{
						validator : function(value, param) {
							return value.length <= 18;
						},
						message : '最多可输入18个字符.'
					},
					limitCarNum:
						{
						validator : function(value) {
							
							return (value!= "选择限号" && value!= "请选择");
						},
						message : '该输入项为必输项'
						},
					// 必须和某个字段相等
					equalTo : {
						validator : function(value, param) {
							return $(param[0]).val() == value;
						},
						message : '字段值不相等'
					},
					idCode : {// 验证身份证
						validator : function(value) {
							return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
						},
						message : '身份证号码格式不正确'
					},
					minLength : {
						validator : function(value, param) {
							return value.length >= param[0];
						},
						message : '请输入至少（2）个字符.'
					},
					length : {
						validator : function(value, param) {
							var len = $.trim(value).length;
							return len >= param[0] && len <= param[1];
						},
						message : "输入内容长度必须介于{0}和{1}之间."
					},
					phone : {// 验证电话号码
						validator : function(value) {
							return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i
									.test(value);
						},
						message : '格式不正确,请使用下面格式:020-88888888'
					},
					mobile : {// 验证手机号码
						validator : function(value) {
							return /^1\d{10}$/i.test(value);
						},
						message : '手机号码格式不正确'
					},
					number : {// 验证整数或小数
						validator : function(value) {
							return /^\d+(\.\d+)?$/i.test(value);
						},
						message : '请输入整数或小数'
					},
					currency : {// 验证货币
						validator : function(value) {
							return /^\d+(\.\d+)?$/i.test(value);
						},
						message : '货币格式不正确'
					},
					qq : {// 验证QQ,从10000开始
						validator : function(value) {
							return /^[1-9]\d{4,9}$/i.test(value);
						},
						message : 'QQ号码格式不正确'
					},
					integer : {// 验证整数 可正负数
						validator : function(value) {
							// return /^[+]?[1-9]+\d*$/i.test(value);

							return /^([+]?[0-9])|([-]?[0-9])+\d*$/i.test(value);
						},
						message : '请输入整数'
					},
					age : {// 验证年龄
						validator : function(value) {
							return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i
									.test(value);
						},
						message : '年龄必须是0到120之间的整数'
					},

					chinese : {// 验证中文
						validator : function(value) {
							return /^[\Α-\￥]+$/i.test(value);
						},
						message : '请输入中文'
					},
					english : {// 验证英语
						validator : function(value) {
							return /^[A-Za-z]+$/i.test(value);
						},
						message : '请输入英文'
					},
					unnormal : {// 验证是否包含空格和非法字符
						validator : function(value) {
							return /.+/i.test(value);
						},
						message : '输入值不能为空和包含其他非法字符'
					},
					// 验证字母或者数字 验证密码
					numberAndword : {
						validator : function(value) {
							return /^[0-9a-zA-Z]{6,12}$/.test(value);
						},
						message : '6到12位 只能包含 字母、数字'
					},
					numberTime : {//验证任务规定时间1-9位
						validator : function(value) {
							return /^[0-9]{1,9}$/.test(value);
						},
						message : '1到9位数字'
					},
					username : {// 验证用户名
						validator : function(value) {
							return /^[a-zA-Z0-9]{6,18}$/i.test(value);
						},
						message : '用户名不合法（允许6-18位，字母和数字）'
					},
					//验证密码
					password : {
						validator : function(value) {
							return /^[0-9a-zA-Z_]{6,8}$/.test(value);
						},
						message : '6到8位 只能包含 字母、数字、下划线'
					},
					faxno : {// 验证传真
						validator : function(value) {
							// return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[
							// ]){1,12})+$/i.test(value);
							return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i
									.test(value);
						},
						message : '传真号码不正确'
					},
					zip : {// 验证邮政编码
						validator : function(value) {
							return /^[1-9]\d{5}$/i.test(value);
						},
						message : '邮政编码格式不正确'
					},
					ip : {// 验证IP地址
						validator : function(value) {
							return /d+.d+.d+.d+/i.test(value);
						},
						message : 'IP地址格式不正确'
					},
					name : {// 验证姓名，可以是中文或英文
						validator : function(value) {
							return /^[\Α-\￥]+$/i.test(value)
									|/^[A-Za-z]+$/i.test(value);
						},
						message : '中文或英文'
					},
					date : {// 验证姓名，可以是中文或英文
						validator : function(value) {
							// 格式yyyy-MM-dd或yyyy-M-d
							return /^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i
									.test(value);
						},
						message : '清输入合适的日期格式'
					},
					dateTime : {// 验证日期针对所有日期格式
						validator : function(value) {
							try{
		 						var date = new Date(value)						
		 						if(date==null || date=='Invalid Date'){
		 							return false;
		 						}
		 						return true;
		 					}
		 					catch(Exception){
		 						return false;
		 					}
						},
						message : '清输入正确的日期格式'
					},
					isBlank : {
						validator : function(value) {
							return $.trim(value) != '';
						},
						message : '请输入正确内容'
					},
					same : {
						validator : function(value, param) {
							if ($("#" + param[0]).val() != "" && value != "") {
								return $("#" + param[0]).val() == value;
							} else {
								return true;
							}
						},
						message : '两次输入的密码不一致！'
					},
					maxLength : {
						validator : function(value, param) {
							if ($("#" + param[0]).val() != "" && value != "") {
								return param[0] >= value.length;
							} else {
								return true;
							}
						},
						message : '请输入最大{0}位字符.'
					},
					moneyNumber : { // 最多两位小数的正数
						validator : function(value) {
							return /^(?!0+(?:\.0+)?$)(?:[1-9]\d*|0)(?:\.\d{1,2})?$/i
									.test(value);
						},
						message : '请输入最多两位小数的正数.'
					},
					ZNumber : { // 正整数
						validator : function(value) {
							return /^[1-9]\d*$/i.test(value);
						},
						message : '请输入正整数.'
					},
					dlNumber : { // 1-99正整数
						validator : function(value) {
							return /^\d{1,2}$/i.test(value);
						},
						message : '请输入1-99正整数.'
					},
					Numbers : { // 0-9数的数字
						validator : function(value) {
							return /^[0-9]\d*$/i.test(value);
						},
						message : '请输入0-9的数字.'
					},
					numberws : {//验证任务规定时间1-10位
						validator : function(value) {
							return /^[0-9]{1,10}$/.test(value);
						},
						message : '1到10位正整数'
					},
					percentNumber : {//验证折扣百分比
						validator : function(value) {
							return /^(0|\d{1,2}|100)$/.test(value);
						},
						message : '请输入0-100的正整数'
					},
					threenumber : {//验证任务规定时间1-10位
						validator : function(value) {
							return /^[0-9]{1,3}$/.test(value);
						},
						message : '1到3位正整数'
					},
					datecompare : { // 0-9数的数字
						validator : function(value, param) {
							var varend = $(param[0]).datebox('getValue');

							if (value != null && varend != null && value != ""
									&& varend != "") {
								var qssj = new Date(value.replace("-", "/"));
								var jssj = new Date(varend.replace("-", "/"));
								return qssj.getTime() > jssj.getTime();
							} else {
								return true;
							}
						},
						message : '结束日期不能小于开始日期.'
					},
					//真实姓名
					realName : {
						validator : function(value) {
							return /^[a-zA-Z0-9\u4e00-\u9fa5]{2,5}$/.test(value);
						},
						message : '2到5位 只能包含 数字、字母和中文'
					},
				});
