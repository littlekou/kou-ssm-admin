<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/jsp/common/global.jsp" %>
    <meta charset="UTF-8">
  	<meta name="renderer" content="webkit">
  	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  	<link rel="stylesheet" href="${staticUrl}/plugins/layui-v2.2.45/css/layui.css"  media="all">
    <base href="<%=basePath%>">
    <title>职业身份</title>
    <jsp:include page="../common/static.jsp"></jsp:include>
    <style>
        .memver_c{margin-top: 15px;margin-bottom: 15px;}
        .member_menu li{width: 100%;height:35px;line-height:35px;border-bottom: 1px solid #eee;}
        .member_menu li a{margin-left:20px;}
        .site-demo-upload, .site-demo-upload img{border-radius:0;}
        .layui-input {width: 300px;}
        .layui-form-select {width: 270px;}
        .layui-form-item {margin-bottom: 10px;margin-top: 10px;}
    </style>
</head>
<body>
<div id="container">
    <form class="layui-form" action="/member/modifyBankAccount.json"  style="border:solid 1px #FFF;">
        <input type="hidden" id="memberId" name="memberId"  value="${bankAccount.memberId }" >
        <input type="hidden" id="id" name="id"  value="${memberId }" >
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>银行卡号:</label>
            <div class="layui-input-inline">
                <input type="text"  required  lay-verify="required"  value="${bankAccount.accountNo }"  id="accountNo"  name="accountNo" placeholder="请输入银行卡号!"  autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>开户名称:</label>
            <div class="layui-input-inline">
                <input type="text"  required  lay-verify="required"  value="${bankAccount.accountName }"  id="accountName"  name="accountName" placeholder="请输入开户名称!"  autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>银行名称:</label>
            <div class="layui-input-inline">
                <input type="text"  required  lay-verify="required"  value="${bankAccount.bankName }"  id="bankName"  name="bankName" placeholder="请输入银行名称!"  autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>支行地址:</label>
            <div class="layui-input-inline">
                <input type="text"  required  lay-verify="required"  value="${bankAccount.bankBranch }"  id="bankBranch"  name="bankBranch" placeholder="请输入支行地址!"  autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>预留手机号:</label>
            <div class="layui-input-inline">
                <input type="text"  required  lay-verify="required"  value="${bankAccount.mobile }"  id="mobile"  name="mobile" placeholder="请输入预留手机号!"  autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>账号状态:</label>
            <div class="layui-input-inline">
                <select id="dataStatus" name="dataStatus" lay-verify="required" lay-search=""  >
					<option value='' <c:if test="${'' eq bankAccount.dataStatus}">selected</c:if> >请选择</option>
					<option value='1' <c:if test="${'1' eq bankAccount.dataStatus}">selected</c:if> >启用</option>
					<option value='2' <c:if test="${'2' eq bankAccount.dataStatus}">selected</c:if> >禁用</option>
				</select>
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn"type="button" id="modifyBankAccount"  lay-submit  lay-filter="modifyBankAccount" style="margin-left: 240px;">保存</button>
            </div>
        </div>
    </form> 
</div>
<script type="text/javascript" src="${staticUrl}/plugins/layui-v2.2.45/layui.js"></script>
<script>

layui.use(['layedit','form'], function(){
        var form = layui.form; 
        form.render();
        form.on('submit(modifyBankAccount)', function(data){
        	 $.ajax({
                 url: data.form.action,
                 type: data.form.method,
                 data: $(data.form).serialize(),
                 success: function (info) {
		            layer.msg("保存成功!", {
		            	time: 1000 //2秒关闭（如果不配置，默认是3秒）
		            	}, function(){
		                	//当你在iframe页面关闭自身时
		                	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		                	parent.paging();
		                	parent.layer.close(index); //再执行关闭  
		            }); 
                 }
            });
        	
        });
   });
$(function(){
})
</script>
</body>
</html>
