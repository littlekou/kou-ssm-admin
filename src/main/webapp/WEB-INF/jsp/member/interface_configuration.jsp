<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML>
<!--_meta 作为公共模版分离出去-->
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/global.jsp"%>
<base href="<%=basePath%>">
<jsp:include page="../common/static.jsp"></jsp:include>
<title>接口配置</title>
<style>
input[readonly] {
	cursor: not-allowed;
	background-color: #DDDDDD;
}
</style>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		接口配置 <span class="c-gray en">&gt;</span> 用户配置 <a
			class="btn btn-success radius r"
			style="line-height: 1.6em; margin-top: 3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="page-container">
		<form class="form form-horizontal" id="form-article-add">
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-2"> <span
					class="c-red">*</span> 商户编号：
				</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input readonly type="text" 
						placeholder="商户编号!" value="${member.id}"
						class="input-text">
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-2"> <span
					class="c-red">*</span> 商户密钥：
				</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" id="token" placeholder="请输入商户密钥!"
						value="${member.token}" class="input-text">
					<div id="regenerate"
						style="background-color: #5a98de; padding: 3px 6px; color: #FFF; margin-top: 3px; width: 60px; text-align: center; cursor: pointer;">重新生成</div>
				</div>
			</div>

			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-2">  回调地址：

				</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" id="notifyUrl"
						placeholder="请输入回调地址!" value="${member.notifyUrl}"
						class="input-text">
					<p class="c-red" style="margin-top:2px;">打款成功后平台会通过回调地址异步通知回调商户服务器，如果不填写，则不会回调！<br>
						 若通过接口传输则不需要填写，若接口未传则在此处填写，接口和此处均有配置则以接口为准！
					</p>
				</div>
			</div>
			<div class="row cl">
				<label class="form-label col-xs-4 col-sm-2">  检查订单地址：</label>
				<div class="formControls col-xs-8 col-sm-9">
					<input type="text" id="checkOrderUrl"
						   placeholder="请输入检查订单地址!" value="${member.checkOrderUrl}"
						   class="input-text">
				</div>
			</div>
			<div class="row cl">
				<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
					<button onClick="article_save_submit();"
						class="btn btn-primary radius" type="submit">
						<i class="Hui-iconfont">&#xe632;</i> 保存
					</button>
					<button onClick="layer_close();" class="btn btn-default radius"
						type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
				</div>
			</div>
		</form>
	</div>

	<!--_footer 作为公共模版分离出去-->
	<jsp:include page="../common/static-js.jsp"></jsp:include>
	<!--/_footer 作为公共模版分离出去-->

	<!--请在下方写此页面业务相关的脚本-->
	<script type="text/javascript"
		src="${staticUrl}/plugins/H-ui.admin/lib/My97DatePicker/4.8/WdatePicker.js"></script>
	<script type="text/javascript"
		src="${staticUrl}/plugins/H-ui.admin/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
	<script type="text/javascript"
		src="${staticUrl}/plugins/H-ui.admin/lib/jquery.validation/1.14.0/validate-methods.js"></script>
	<script type="text/javascript"
		src="${staticUrl}/plugins/H-ui.admin/lib/jquery.validation/1.14.0/messages_zh.js"></script>
	<script type="text/javascript">
		$(function() {
			$('.skin-minimal input').iCheck({
				checkboxClass : 'icheckbox-blue',
				radioClass : 'iradio-blue',
				increaseArea : '20%'
			});
			$("#tab-system").Huitab({
				index : 0
			});

			var rate = JSON.parse('${member.rate}');

			$("#alibaba_rate").val(rate.alibaba + "‰");
			$("#weChat_rate").val(rate.weChat + "‰");
			$("#unionPay_rate").val(rate.unionPay + "‰");
			
			$("#regenerate").click(function(){
				$.ajax({
	                type: "POST",
	                url: "/member/regenerate.json",
	                async: false, //同步执行
	                success: function (data) {
	                	$("#token").val(data.token);
	                }
	            });
			});
			

		});
		
		function article_save_submit(){
			var token = confirm('确认要保存吗？');
			if(token){
				var token = $("#token").val();
				var returnUrl = $("#returnUrl").val();
				var notifyUrl = $("#notifyUrl").val();
				var checkOrderUrl = $("#checkOrderUrl").val();
				if(token==""){
					alert('商户密钥不能为空!');
					return false;
				}
				if(returnUrl!="" && returnUrl!=null && returnUrl.indexOf("http")!=0){
					alert('跳转地址格式不正确，请以"http"开头!');
					return false;
				}
				$.ajax({
	                type: "POST",
	                url: "/member/modifyInterfaceConfiguration.json",
	                data: {
	                	"token": token,
	                	"returnUrl": returnUrl,
	                	"notifyUrl": notifyUrl,
						"checkOrderUrl": checkOrderUrl
	                },
	                async: false, //同步执行
	                success: function (data) {
	                	alert("保存成功！");
	                }
	            });
			}
		};
		
		function layer_close(){
			location.reload();
		};
	</script>
	<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>
