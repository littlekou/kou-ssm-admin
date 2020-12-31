<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <%@ include file="/WEB-INF/jsp/common/global.jsp" %>
    <base href="<%=basePath%>">
    <title>支付系统</title>
    <style type="text/css">
        body{padding:0px;margin:0px;}
        .middleFormDiv form:after{content: '';clear: both;}
        .zc_input1 {
            border: 1px #E2E2E2 solid;
            background: #fff;
            line-height: 38px;
            width: 288px;
            padding: 0 0 0 10px;
            color: #888;        font-size: 14px;
            margin-bottom: 20px;
        }
        .login_input1 {
            border: 0;width: 231px; height: 40px;
            line-height: 40px;        border-radius: 2px;
            padding: 0 0 0 10px;        font-size: 14px;
        }
        .loginbtn1 {
            background: #dd4545;border-radius: 2px;        width: 100%;
            height: 45px;line-height: 45px;border: 0; cursor: pointer;        color: #fff;        font-size: 14px;font-weight: bold;
        }
    </style>
</head>
<body>
<div style='font-size:28px;line-height:100px;background-image:none;width:1000px;margin-left:auto;margin-right:auto;'>商家管理平台</div>
<div class="middleDiv" style="height:580px;background:#87CEEE url(/images/login_bg.jpg) no-repeat center;background-size:cover;">
    <div class="middleFormDiv" style="width:1000px;margin-left:auto;margin-right:auto;padding-top: 110px;">
        <form class="form form-horizontal" style="float: right;margin-left:auto;margin-right: auto;background-color:#FFF;width:300px;background:#fff;border:1px #ddd solid;padding:20px;" action="admin/login.html" method="post">
            <div style='font-size:24px;margin:10px auto 25px;background:url(/images/dl_ico.png) no-repeat;padding-left:40px;color:#666;height:30px;line-height:30px;'>用户登录</div>
            <div class="zc_input1">
                账号：
                <input id="loginName" name="loginName" type="text" placeholder="账户" value="${loginName}" onblur="getMemberMsg(this.value)" maxlength="20" class="login_input1">
            </div>
            <div class="zc_input1">
                密码：
                <input id="pwd" name="pwd" type="password" placeholder="密码" autocomplete="new-password" maxlength="20" class="login_input1">
            </div>
            <div class="google" hidden>
                <div class="zc_input1 ">
                    谷歌验证码：
                    <input type="text" id="googleCode" name="googleCode" placeholder="请输入谷歌验证码"  maxlength="18" >
                </div>
            </div>
            <div class="verity" hidden>
                <div class="zc_input1" style="position: relative;">
                    图片验证码：
                    <input type="text" id="imgVerify" name="imgVerify" placeholder="请输入验证码"  maxlength="18" >
                    <a href="javascript:getVerifiCode()" style="position: absolute;right: 0px;">
                        <img id="yzm_img" style="cursor:pointer;width: 94px;border-radius: 1px;" title="点击刷新" src="admin/getVerifyCode.html"/>
                    </a>
                </div>
                <div class="zc_input1" style="position: relative;">
                    短信验证码：
                    <input type="text" id="phoneVerify" name="phoneVerify" placeholder="请输入验证码"  maxlength="4" >
                    <button type="button" class="layui-btn" style="position: absolute;right: 0px;height: 38px;cursor:pointer;width: 94px;border-radius: 1px;" id="search" onclick="getPhoneVerify(this)">获取验证码${param.loginInfo}</button>
                </div>
            </div>

            <c:if test="${loginInfo!='' and loginInfo!=null}">
                <div style="text-align:center;padding-bottom:18px;color:red;">
                     <span id="span">${loginInfo}</span>
                </div>
            </c:if>
            <div class="row cl">
                <div class="formControls col-xs-8 col-xs-offset-3">
                    <input name="" id="login" type="submit" class="loginbtn1" value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
                </div>
            </div>
        </form>
    </div>
</div>
<div class='footer'>七七网络 copyright 2020 | All right reserved .</div>
<!--_footer 作为公共模版分离出去-->
<jsp:include page="./common/static-js.jsp"></jsp:include>
<!--/_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/static/plugins/layui-v2.2.45/layui.js"></script>

<script type="text/javascript" src="/js/user_login.js"></script>
</body>
<script>
    $(function() {
        <c:choose>
            <c:when test="${verity=='ok'}">
                $(".verity").show();
            </c:when>
            <c:otherwise>
                $(".verity").hide();
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${google=='ok'}">
                $(".google").show();
            </c:when>
            <c:otherwise>
                $(".google").hide();
            </c:otherwise>
        </c:choose>
    })
    var layer;
    layui.use('layer', function(){
        layer = layui.layer;
    });
    function getVerifiCode() {
        $("#yzm_img").prop('src','admin/getVerifyCode.html?a='+new Date().getTime());
    }

    function getPhoneVerify(val) {
        var loginName = $("#loginName").val();
        var imgVerify = $("#imgVerify").val();
        if(!loginName || !imgVerify){
            layer.msg("请填写完信息！", {time: 1000 });
        }else{
            $.post("admin/getPhoneVerify.json",{"loginName":$("#loginName").val(),"imgVerify":$("#imgVerify").val()},function(data){
                if(200==data.code){
                    var bu = $('#search');
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
    function getMemberMsg(m) {
        $.get("/admin/getMemberMsg.json?loginName="+m,{},function (data) {
            if(data.verity=='ok'){
                $(".verity").show();
            }else{
                $(".verity").hide();
            }
            if(data.google=='ok'){
                $(".google").show();
            }else{
                $(".google").hide();
            }
        });
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
</html>