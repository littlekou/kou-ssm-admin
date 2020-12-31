<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE HTML>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/common/global.jsp" %>
	<base href="<%=basePath%>">
	<jsp:include page="../common/static.jsp"></jsp:include>
	<title>收款商户</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 商户管理 <span class="c-gray en">&gt;</span> 收款商户<a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
<table class="table table-border table-bordered table-bg">
    <thead>
    <tr class="text-c">
       	<th>客户端账号</th>
       	<th>最近分配时间</th>
        <th>最近收款时间</th>
        <th>收款账号</th>
        <th>登陆状态</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
	        <tr class="text-c">
            	<td>${currentUser.cname }</td>
          		<td>1</td>
	            <td>1</td>
	            <td>${currentUser.mobile }</td>
	            <td>1</td>
	            <td>${currentUser.status }</td>
	            <td>
      		  	</td>
	        </tr>
    </tbody>
</table>
</div>
<!--_footer 作为公共模版分离出去-->
<jsp:include page="../common/static-js.jsp"></jsp:include>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${staticUrl}/plugins/layui-v2.2.45/layui.js"></script>
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript">

</script>


</body>
</html>