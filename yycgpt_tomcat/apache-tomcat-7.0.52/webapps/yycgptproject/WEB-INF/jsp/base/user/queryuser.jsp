<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/base/tag.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 引用jquery easy ui的js库及css -->
<LINK rel="stylesheet" type="text/css"
	href="${baseurl}js/easyui/styles/default.css">
<%@ include file="/WEB-INF/jsp/base/common_css.jsp"%>
<%@ include file="/WEB-INF/jsp/base/common_js.jsp"%>
<title>用户管理</title>

<script type="text/javascript">
	//定义普通列
	var datagrid_v = [ [ {
		field : 'userid',//对应json中的key
		title : '帐号',
		align:'center',
		width : 120
	}, {
		field : 'username',
		title : '用户姓名',
		align:'center',
		width : 120
	}, {
		field : 'sexname',
		title : '性别',
		align:'center',
		width : 40
	},{
		field : 'phone',
		title : '电话',
		align:'center',
		width : 120
	},{
		field : 'email',
		title : '邮箱',
		align:'center',
		width : 150
	},{
		field : 'groupname',
		title : '用户类型',
		align:'center',
		width : 120,
		//通过此方法重新格式化参数的内容，value:从json中取出的值，
		//row:一行的对象，index：行的序号

		/* formatter : function(value, row, index) {
			if (value == '1') {
				return "卫生局";
			} else if (value == '2') {
				return "卫生院";
			} else if (value == '3') {
				return "卫生室";
			} else if (value == '4') {
				return "供货商";
			} else if (value == '0') {
				return "系统管理员";
			}
		}
 */
	}, {
		field : 'sysmc',
		title : '所属单位',
		align:'center',
		width : 120
	}, {
		field : 'statename',
		title : '状态',
		align:'center',
		width : 50
		 /* formatter : function(value, row, index) {
			if (value == '0') {
				return "暂停";
			} else if (value == '1') {
				return "正常";
			}
		}  */
	}, {
		field : 'delBtn',
		title : '删除',
		align:'center',
		width : 60,
		formatter : function(value, row, index) {
			return "<a href=javaScript:deleteSysuser('" + row.id + "')>删除</a>";
		}
	}, {
		field : 'editBtn',
		title : '修改',
		align:'center',
		width : 60,
		formatter : function(value, row, index) {
			return "<a href=javaScript:editSysUser('" + row.id + "')>修改</a>";
		}
	} ] ];

	//datagrid的工具栏
	var toolbar_v = [

			{//工具栏
				id : 'btnadd',
				text : '添加用户',
				iconCls : 'icon-add',
				handler : function() {
					//$('#btnsave').linkbutton('enable');
					//alert('add')
					//打开页面的添加页面
					createmodalwindow("添加用户信息", 800, 400,
							'${baseurl}user/addsysuser.action');
				}
			}, ];

	//查询

	function queryuser() {
		/* datagrid的load方法要求是传入json数据
		最终将json转化成key/value数据格式传入action */
		/* $('#sysuserlist').datagrid('load',{
			'sysuserCustom.groupid':'1'
		}); */
		//将form表单中的数据分装成json数据,能够取到input的值
		var formdata = $("#sysuserqueryForm").serializeJson();
		//alert(formdata);
		$('#sysuserlist').datagrid('load', formdata);
	}

	$(function() {
		$('#sysuserlist').datagrid({
			title : '用户查询',//数据列表标题
			loadMsg : '',
			nowrap : true,//单元格中的数据不换行，如果为true表示不换行，不换行情况下数据加载性能高，如果为false就是换行，换行数据加载性能不高
			striped : true,//条纹显示效果
			url : '${baseurl}user/queryuser_result.action',//加载数据的连接，引连接请求过来是json数据
			idField : 'id',//此字段很重要，数据结果集的唯一约束
			columns : datagrid_v,
			pagination : true,//是否显示分页
			rownumbers : true,//是否显示行号
			pageList : [ 10, 15, 20, 50 ],
			//工具栏
			toolbar : toolbar_v
		});
	});

	//删除
	function deleteSysuser(userId) {
		//第一个参数是提示信息，第二个参数，取消执行的函数指针，第三个参是，确定执行的函数指针
		_confirm('您确认删除吗？', null,
				function() {

					//将要删除的id赋值给deleteid，deleteid在sysuserdeleteform中
					$("#delete_id").val(userId);
					//使用ajax的from提交执行删除
					//sysuserdeleteform：form的id，userdel_callback：删除回调函数，
					//第三个参数是url的参数
					//第四个参数是datatype，表示服务器返回的类型
					jquerySubByFId('sysuserdeleteform', userdel_callback, null,
							"json");

				});
	}
	
	//删除用户的回调函数
	
	function  userdel_callback(data){
		
		message_alert(data);
		
		//删除陈功，重新加载页面
		var type = data.resultInfo.type;
		if(type==1){
			queryuser();
		}
	}
	
	//修改
	function editSysUser(id){
		//打开页面的添加页面
		createmodalwindow("修改用户信息", 800, 300,
				'${baseurl}user/editSysUser.action?id='+id);
	}
	
</script>

</head>
<body>

	<!-- html静态页面 -->
	<form id="sysuserqueryForm">
		<!-- 查询条件 -->

		<TABLE class="table_search">
			<TBODY>
				<TR>
					<TD class="left">用户账号：</td>
					<td><INPUT type="text" name="sysuserCustom.userid" /></TD>
					<TD class="left">用户名称：</TD>
					<td><INPUT type="text" name="sysuserCustom.username" /></TD>

					<TD class="left">所属单位：</TD>
					<td><INPUT type="text" name="sysuserCustom.sysmc" /></TD>
					
					</tr>
					<tr>
					<TD class="left">用户性别：</TD>
					<td><select name="sysuserCustom.sex">
							<option value="">请选择</option>
							<c:forEach items="${sexList}" var="dictInfo">
							<option value="${dictInfo.dictcode}">${dictInfo.info}</option>
							</c:forEach>
					</select></td>
					
					<TD class="left">用户状态：</TD>
					<!-- <td><INPUT type="text" name="sysuserCustom.userstate" /></TD> -->
					<td><select name="sysuserCustom.userstate">
							<option value="">请选择</option>
							<!-- <option value="1">正常</option>
							<option value="0">暂停</option> -->
							<c:forEach items="${stateList}" var="dictInfo">
							<option value="${dictInfo.dictcode}">${dictInfo.info}</option>
							</c:forEach>
					</select></td>
					
					<TD class="left">用户类型：</TD>
					<td><select name="sysuserCustom.groupid">
							<option value="">请选择</option>
							<!-- <option value="1">卫生局</option>
							<option value="2">卫生院</option>
							<option value="3">卫生室</option>
							<option value="4">供货商</option>
							<option value="0">系统管理员</option> -->
							<c:forEach items="${groupList}" var="dictInfo">
							<option value="${dictInfo.dictcode}">${dictInfo.info}</option>
							</c:forEach>
					</select></TD>
					<td><a id="btn" href="#" onclick="queryuser()"
						class="easyui-linkbutton" iconCls='icon-search'>查询</a></td>
				</TR>
			</TBODY>
		</TABLE>

		<!-- 查询列表 -->

		<TABLE border=0 cellSpacing=0 cellPadding=0 width="99%" align=center>
			<TBODY>
				<TR>
					<TD>
						<table id="sysuserlist"></table>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</form>
	<form action="${baseurl}user/deleteSysuser.action" method="post" id="sysuserdeleteform">
	<input type="hidden" id="delete_id" name="userId"></input>
	</form>
	
</body>
</html>