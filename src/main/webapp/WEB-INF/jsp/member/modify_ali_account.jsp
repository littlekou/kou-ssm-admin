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
    <form class="layui-form" action="/member/modifyAliAccount.json"  style="border:solid 1px #FFF;">
        <input type="hidden" id="memberId" name="memberId"  value="${aliAccount.memberId }" >
        <input type="hidden" id="id" name="id"  value="${memberId }" >
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>支付宝账号:</label>
            <div class="layui-input-inline">
                <input type="text"  required  lay-verify="required"  value="${aliAccount.account }"  id="account"  name="account" placeholder="请输入支付宝账号!"  autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>支付宝用户名:</label>
            <div class="layui-input-inline">
                <input type="text"  required  lay-verify="required"  value="${aliAccount.name }"  id="name"  name="name" placeholder="请输入支付宝用户名!"  autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn"type="button" id="modifyAliAccount"  lay-submit  lay-filter="modifyAliAccount" style="margin-left: 240px;">保存</button>
            </div>
        </div>
    </form> 
</div>
<script type="text/javascript" src="${staticUrl}/plugins/layui-v2.2.45/layui.js"></script>
<script>

layui.use(['layedit','form'], function(){
        var form = layui.form; 
        form.render();
        form.on('submit(modifyAliAccount)', function(data){
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
