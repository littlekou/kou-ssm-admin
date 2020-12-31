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
	<title>基本设置</title>
	<style>
		input[readonly] {
			cursor: not-allowed;
			background-color: #DDDDDD;
		}
		.anqtable{border: 1px solid #DDD;}
		.anqtable tr{height:50px;border-bottom:1px #DDD dashed;}
		.tableTB{width:80px;text-align: center;}
		.tableStatus{width:150px;text-align: center; color: #0000FF;}
		.fontIn{font-size: 16px;font-weight: bold;}
	</style>
</head>
<body>
<nav class="breadcrumb">
	<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
	商户信息 <span class="c-gray en">&gt;</span> 商户信息 <a
		class="btn btn-success radius r"
		style="line-height: 1.6em; margin-top: 3px"
		href="javascript:location.replace(location.href);" title="刷新"><i
		class="Hui-iconfont">&#xe68f;</i></a>
</nav>
<div class="page-container">
	<form class="form form-horizontal" id="form-article-add">
		<div id="tab-system" class="HuiTab">
			<div class="tabBar cl">
				<span>商户信息</span>
				<%--<span>商户</span>--%>
				<span>收款账号</span>
				<%--<span>接口费率</span>--%>
				<span class="current">安全中心</span>
			</div>
			<div class="tabCon">
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 用户名称：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input readonly type="text" id="cname" placeholder="用户名称"
							   value="${member.cname}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 登录账号：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input readonly type="text" id="account" placeholder="登录账号"
							   value="${member.mobile}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 账号状态：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<c:if test="${member.status == 2}">
							<input readonly type="text"  placeholder="账号状态"
								   value="正常" class="input-text">
						</c:if>
						<c:if test="${member.status == 1}">
							<input readonly type="text"  placeholder="账号状态"
								   value="待审核" class="input-text">
						</c:if>
						<c:if test="${member.status == 3}">
							<input readonly type="text"  placeholder="账号状态"
								   value="禁用" class="input-text">
						</c:if>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 注册时间：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input readonly type="text"  placeholder="注册时间" value='<fmt:formatDate value="${member.addTime }"   pattern="yy/MM/dd HH:mm:ss" type="date" dateStyle="long" />' class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 商户编号：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input readonly type="text" id="memberId"
							   placeholder="商户编号!" value="${member.id}"
							   class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 可提金额：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input readonly type="text" value="${member.balance}"
							   placeholder="账户余额!" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 冻结金额：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input readonly type="text" value="${member.freezeBalance}"
							   placeholder="冻结金额!" class="input-text">
					</div>
				</div>

				<c:forEach items="${payType}" var="payType">
					<div class="row cl">
						<label class="form-label col-xs-4 col-sm-2">${payType.pay_name}费率:</label>
						<div class="formControls col-xs-8 col-sm-9">
							<input type="text" readonly id="${payType.pay_type}"  name="${payType.pay_type}" class="layui-input">
						</div>
					</div>
				</c:forEach>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2">代付费率‰:</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input type="text"  readonly  id="df"  name="df" class="layui-input">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2">额外收费:</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input type="text"  readonly  id="extra"  name="extra" class="layui-input">
					</div>
				</div>

				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2">充值费率‰:</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input type="text"  readonly  id="cz"  name="cz" class="layui-input">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2">固定充值费用:</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input type="text" id="gdcz"  name="gdcz" readonly class="layui-input">
					</div>
				</div>

			</div>
			<div class="tabCon">
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 银行卡号：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input  type="text" id="accountNo"  placeholder="请输入银行卡号"
								value="${bankAccount.accountNo}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 开户名称：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input  type="text" id="accountName"  placeholder="请输入开户名称"
								value="${bankAccount.accountName}" class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 银行名称：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input  type="text"  id="bankName"
								placeholder="请输入银行名称" value="${bankAccount.bankName}"
								class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 支行地址：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input  type="text" id="bankBranch"
								placeholder="请输入支行地址" value="${bankAccount.bankBranch}"
								class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 预留手机号：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input  type="text" id="mobile"
								placeholder="请输入手机号" value="${bankAccount.mobile}"
								class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 支付宝账号：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input  type="text" id="aliAccount"
								placeholder="请输入支付宝账号" value="${aliAccount.account}"
								class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> <span
							class="c-red">*</span> 支付宝用户名：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input  type="text" id="name"
								placeholder="请输入支付宝用户名" value="${aliAccount.name}"
								class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2">添加时间：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input readonly type="text"
							   placeholder="自动回显添加时间" value='<fmt:formatDate value="${bankAccount.addTime}"   pattern="yy/MM/dd HH:mm:ss" type="date" dateStyle="long" />'
							   class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2">更新时间：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input readonly type="text"
							   placeholder="自动回显更新时间" value='<fmt:formatDate value="${bankAccount.updateTime}"   pattern="yy/MM/dd HH:mm:ss" type="date" dateStyle="long" />'
							   class="input-text">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2"> 账号状态：
					</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input readonly type="text" id="status" placeholder="自动回显账号状态"
							   value="<c:if test='${bankAccount.dataStatus == 2}'>启用</c:if><c:if test='${bankAccount.dataStatus == 1}'>禁用</c:if>"
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
			</div>
			<div class="tabCon">
				<div class="row cl"  style="padding-left:20px;padding-right:20px;">
					<table class="anqtable">
						<tr>
							<td class="tableTB">
								<c:choose>
									<c:when test="${null!=member.payPassword&&member.payPassword ne ''}">
										<img src="http://member.99114.com/static/images/right.gif">
									</c:when>
									<c:otherwise>
										<img src="http://member.99114.com/static/images/worn01.png">
									</c:otherwise>
								</c:choose>
							</td>
							<td class="fontIn">
								设置支付密码
								<c:if test="${null!=member.payPassword&&member.payPassword ne ''}">
									<span style="font-size:12px;font-weight: normal;">已设置支付密码，提现时需要输入支付密码</span>
								</c:if>
							</td>
							<td class="tableStatus">
								<c:choose>
									<c:when test="${null!=member.payPassword&&member.payPassword ne ''}">
										<a class="zfPwd" style="color: #06c;" href="javascript:;">修改</a>
									</c:when>
									<c:otherwise>
										<a class="zfPwd" style="color: #06c;" href="javascript:;">设置</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="tableTB">
								<c:choose>
									<c:when test="${null!=member.googleSecretKey&&member.googleSecretKey ne ''}">
										<img src="http://member.99114.com/static/images/right.gif">
									</c:when>
									<c:otherwise>
										<img src="http://member.99114.com/static/images/worn01.png">
									</c:otherwise>
								</c:choose>
							</td>
							<td class="fontIn">
								绑定谷歌验证器
								<c:if test="${null!=member.googleSecretKey&&member.googleSecretKey ne ''}">
									<span style="font-size:12px;font-weight: normal;">已绑定谷歌验证器，提现时需要输入谷歌验证码</span>
								</c:if>
							</td>
							<td class="tableStatus">
								<c:choose>
									<c:when test="${null!=member.googleSecretKey&&member.googleSecretKey ne ''}">
										<a style="color: #06c;" data-flag="2"  class="ggyzq" href="javascript:;">修改</a>
									</c:when>
									<c:otherwise>
										<a style="color: #06c;" data-flag="1" class="ggyzq" href="javascript:;">设置</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="tableTB">
								<c:choose>
									<c:when test="${null!=member.ipWhiteList&&member.ipWhiteList ne ''}">
										<img src="http://member.99114.com/static/images/right.gif">
									</c:when>
									<c:otherwise>
										<img src="http://member.99114.com/static/images/worn01.png">
									</c:otherwise>
								</c:choose>
							</td>
							<td class="fontIn">
								设置ip白名单
								<c:choose>
									<c:when test="${null!=member.ipWhiteList&&member.ipWhiteList ne ''}">
										<span style="font-size:12px;font-weight: normal;">已设置ip白名单</span>
									</c:when>
									<c:otherwise>
										<span style="font-size:12px;font-weight: normal;color: red">
											请填写ip白名单，只有指定ip可以提交代付单！多个ip时以英文逗号隔开，如192.168.1.1,192.168.1.2
										</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="tableStatus">
								<c:choose>
									<c:when test="${null!=member.ipWhiteList&&member.ipWhiteList ne ''}">
										<a style="color: #06c;" data-flag="2"  class="ipbmd" href="javascript:;">修改</a>
									</c:when>
									<c:otherwise>
										<a style="color: #06c;" data-flag="1" class="ipbmd" href="javascript:;">设置</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="tableTB">
								<c:choose>
									<c:when test="${null!=member.phone&&member.phone ne ''}">
										<img src="http://member.99114.com/static/images/right.gif">
									</c:when>
									<c:otherwise>
										<img src="http://member.99114.com/static/images/worn01.png">
									</c:otherwise>
								</c:choose>
							</td>
							<td class="fontIn">
								绑定手机号
								<c:if test="${null!=member.phone&&member.phone ne ''}">
									<span style="font-size:12px;font-weight: normal;">已绑定手机号</span>
								</c:if>
							</td>
							<td class="tableStatus">
								<c:choose>
									<c:when test="${null!=member.phone&&member.phone ne ''}">
										<a style="color: #06c;" data-flag="2"  class="phone" href="javascript:;">修改</a>
									</c:when>
									<c:otherwise>
										<a style="color: #06c;" data-flag="1" class="phone" href="javascript:;">设置</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</table>
				</div>
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
<script type="text/javascript" src="${staticUrl}/plugins/layui-v2.2.45/layui.js"></script>
<script type="text/javascript">
	var flag;
    $(function(){
        //利率回显
        if('${member.rate}'!=""){
            var rate = JSON.parse('${member.rate}');
            for(var key in rate){
                $("#"+key).val(rate[key]);
            }
        }
        if('${flag}'==1){
            flag=2;
		}else{
            flag=0;
		}

    })
	//安全中心
	layui.use(['layer'], function(){
        var payPassword = "${member.payPassword}";
		$(".zfPwd").click(function (data) {
            $.post('/html/updatePayPwd.jsp?payPassword='+payPassword, {}, function(str){
				layer.open({
					type: 1,
					offset:'10px',
					anim: 2,
					title: '修改支付密码',
					area: ['500px', '290px'],
					btn: ['提交', '取消'],
					content: str //注意，如果str是object，那么需要字符拼接。
					,yes:function(index, layero){
						changePW();
					}
				});
			});
		});

		$(".ggyzq").click(function (data) {
			var dataFlag = $(this).attr("data-flag");
			var divHeight = "260px";
			if(dataFlag==2){
				divHeight = "318px";
			}
			$.post('/html/googleyz.jsp?flag='+dataFlag, {}, function(str){
				layer.open({
					type: 1,
					offset:'10px',
					anim: 2,
					title:'绑定谷歌验证器',
					area: ['500px', divHeight],
					btn: ['绑定', '取消'],
					content: str //注意，如果str是object，那么需要字符拼接。
					,yes:function(index, layero){
						var ggyzm = $("#ggyzm").val();
						var oldCode = $("#ggoldyzm").val();
						var googleSecretKey = $("#ggmy").val();
						if(null==ggyzm||null==googleSecretKey||googleSecretKey.length<3||ggyzm.length<3){
							layer.msg("请输入正确的信息！");
							return;
						}
						$.post("/member/updateGoogleSecretKey.json",{id:$("#memberId").val(),code:ggyzm,oldCode:oldCode,googleSecretKey:googleSecretKey},function (data) {
							if(data.code==200){
								layer.closeAll();
								layer.msg("绑定成功");
								window.location.href="/member/toMemberInfo.html";
							}else{
								$("#tmsg").html(data.msg);
							}
						});
					}
				});
			});
		});

        $(".ipbmd").click(function (data) {
            if(${null==member.googleSecretKey} || ${member.googleSecretKey == ''}){
                layer.msg("请先绑定谷歌验证器再配ip白名单");
			}else{
				if(${null!=member.googleSecretKey} && ${member.googleSecretKey != ''}){
					var dataFlag = $(this).attr("data-flag");
					var divHeight = "260px";
					if(dataFlag==2){
						divHeight = "318px";
					}
					var ip = "${member.ipWhiteList}";
					$.post('/html/whiteList.jsp?ip='+ip, {}, function(str){
						layer.open({
							type: 1,
							offset:'10px',
							anim: 2,
							title:'设置ip白名单',
							area: ['500px', divHeight],
							btn: ['保存', '取消'],
							content: str //注意，如果str是object，那么需要字符拼接。
							,yes:function(index, layero){
								var ipbmd = $("#ipbmd").val();
								var code = $("#ggyzm").val();
								$.post("/member/updateIpWhiteList.json",{id:$("#memberId").val(),ipbmd:ipbmd ,code:code},function (data) {
									if(data.code==200){
										layer.closeAll();
										layer.msg("设置成功");
										window.location.href="/member/toMemberInfo.html";
									}else{
										$("#tmsg").html(data.msg);
									}
								});
							}
						});
					});
				}
			}
        });
		$(".phone").click(function (data) {
			var dataFlag = $(this).attr("data-flag");
			var divHeight = "318px";
			if(dataFlag==2){
				divHeight = "388px";
			}
			var ph="${member.phone}";
            var google = "${member.googleSecretKey}";
			$.post('/html/phone.jsp?phone='+ph+"&google="+google, {}, function(str){
				layer.open({
					type: 1,
					offset:'10px',
					anim: 2,
					title:'绑定手机号',
					area: ['500px', divHeight],
					btn: ['绑定', '取消'],
					content: str //注意，如果str是object，那么需要字符拼接。
					,yes:function(index, layero){
						var phone = $("#phone").val();
						var imgCode = $("#imgCode").val();
						var phoneCode = $("#phoneCode").val();
						if(null==phone||null==imgCode||null==phoneCode||imgCode.length<4||phoneCode.length<4){
							layer.msg("请输入正确的信息！");
							return;
						}
						$.post("/member/updatePhone.json",{id:$("#memberId").val(),phone:phone,imgCode:imgCode,phoneCode:phoneCode,phoneGoogle:$("#phoneGoogle").val()},function (data) {
							if(data.code==200){
								layer.closeAll();
								layer.msg("绑定成功");
								window.location.href="/member/toMemberInfo.html";
							}else{
								$("#yzm_img").prop('src','admin/getVerifyCode.html?a='+new Date().getTime());
								layer.alert(data.msg, {icon: 2});
								$("#tmsg").html(data.msg);
							}
						});
					}
				});
			});
		});
	});

	function getGoogleCode(){
		$.get("/member/getGoogleCode.json",{},function (data) {
			if(null!=data&&data.code==200){
				$("#ggmy").val(data.msg);
			}
		});
	}

	function getVerifiCode() {
		$("#yzm_img").prop('src','admin/getVerifyCode.html?a='+new Date().getTime());
	}
	function getPhoneVerify() {
		var phone = $("#phone").val();
		var imgCode = $("#imgCode").val();
		if(!phone || !imgCode){
			layer.msg("请填写完信息！", {time: 1000 });
		}else{
			$.post("admin/getMemberPhoneVerify.json",{"phone":phone,"imgCode":imgCode},function(data){
				if(200==data.code){
					var bu = $('#phoneBtn');
					time(bu);
					layer.msg("请求成功", {
						time: 1000 //2秒关闭（如果不配置，默认是3秒）
					});
				}else{
					$("#yzm_img").prop('src','admin/getVerifyCode.html?a='+new Date().getTime());
					layer.msg(data.msg, {
						time: 2000 //2秒关闭（如果不配置，默认是3秒）
					});
				}
			},"json");
		}
	}

	$(function() {
		$('.skin-minimal input').iCheck({
			checkboxClass : 'icheckbox-blue',
			radioClass : 'iradio-blue',
			increaseArea : '20%'
		});
		$("#tab-system").Huitab({
			index : flag
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
			var accountNo = $("#accountNo").val();
			var accountName = $("#accountName").val();
			var bankName = $("#bankName").val();
			var bankBranch = $("#bankBranch").val();
			var mobile = $("#mobile").val();
			var account = $("#aliAccount").val();
			var name = $("#name").val();
			var memberId = $("#memberId").val();

			if(accountNo==""){
				alert("银行卡号不能为空！");
			}else if(accountName==""){
				alert("开户名称不能为空！");
			}else if(bankName==""){
				alert("银行名称不能为空！");
			}else if(bankBranch==""){
				alert("支行地址不能为空！");
			}else if(mobile==""){
				alert("预留手机号不能为空！");
			}else if(account==""){
				alert("支付宝账号不能为空！");
			}else if(name==""){
				alert("支付宝用户名不能为空！");
			}else{
				$.ajax({
					type: "POST",
					url: "/member/modifyAccount.json",
					data: {
						"accountNo": accountNo,
						"accountName": accountName,
						"bankName": bankName,
						"bankBranch": bankBranch,
						"mobile": mobile,
						"account": account,
						"name": name,
						"memberId": memberId
					},
					async: false, //同步执行
					success: function (data) {
						if(data.flag){
							alert("保存成功！");
							window.parent.frames[1].location.reload()
						}else{
							alert("请求非法！");
						}
					}
				});
			}

		}
	};

	function layer_close(){
		location.reload();
	};

	function changePW() {
		var newPassword = $("#newPassword").val();
		var reNewPassword = $("#reNewPassword").val();
		var oldPassword = $("#oldPassword").val();
		if(oldPassword==""){
			alert("请输入旧密码！");
			return;
		}
		if(oldPassword==""){
			alert("请输入旧提现密码！");
			return;
		}
		if(newPassword != reNewPassword){
			alert("新密码两次输入不一致！");
			return;
		}else{
			$.ajax({
				type: "POST",
				url: "/member/changePW.json",
				data: {
					"newPassword": newPassword,
					"oldPassword": oldPassword,
					"type":2
				},
				success: function (data) {
					if(data.status==200){
						layer.msg(data.msg, { time: 1000 }, function(){
							window.location.href="/member/toMemberInfo.html";
						});

					}else {
						layer.alert(data.msg, {icon: 5});
						$("#oldPassword").val("");
					}
				}
			});
		}
	}
	var wait = 60;
	function time(o) {
		if (wait == 0) {
			$(o).attr("disabled", false);
			$(o).text("获取验证码");
			wait = 60;
		} else {
			$(o).attr("disabled", true);
			$(o).text(wait + "秒后重新发送");
			wait--;
			setTimeout(function () {time(o);},1000);
		}
	}
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>
