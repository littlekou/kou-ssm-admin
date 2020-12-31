<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/common/global.jsp" %>
	<base href="<%=basePath%>">
	<meta charset="utf-8">
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<link rel="Bookmark" href="/favicon.ico" >
	<link rel="Shortcut Icon" href="/favicon.ico" />
	<script src="/static/plugins/jquery-1.9.1.js" charset="utf-8"></script>
	<jsp:include page="common/static.jsp"></jsp:include>
	<title>${map6.sysName}</title>
</head>
<body>

<header class="navbar-wrapper">
	<div class="navbar navbar-fixed-top">
		<div class="container-fluid cl">
			<input type="hidden" id="currentRoleId" value="${currentUser.roleId}">
            <div id="cut" style="float: left">
                    <a class="logo navbar-logo f-l mr-10 hidden-xs" href="javascript:void(0);" id="sys">${sysName}</a>
                    <span class="logo navbar-slogan f-l mr-10 hidden-xs">v</span>
            </div>
			<a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>
			<nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
				<ul class="cl">
					<c:if test="${currentUser.roleId==1}">
						<li>管理员:${currentUser.cname}</li>
					</c:if>
					<c:if test="${currentUser.roleId==2}">
						<li>代理商：${currentUser.cname}</li>
					</c:if>
					<c:if test="${currentUser.roleId==3}">
						<li>会员：${currentUser.cname}</li>
					</c:if>
					<c:if test="${currentUser.roleId==4}">
						<li>商户：${currentUser.cname}</li>
					</c:if>
					<c:if test="${currentUser.roleId==5}">
						<li>码商：${currentUser.cname}</li>
					</c:if>
					<c:if test="${currentUser.roleId==6}">
						<li>代付商：${currentUser.cname}</li>
					</c:if>
					<c:if test="${currentUser.roleId==7}">
						<li>操作员：${currentUser.cname}</li>
					</c:if>
					<li class="dropDown dropDown_hover">
						<a href="javascript:void(0);" class="dropDown_A">${currentUser.loginName} <i class="Hui-iconfont">&#xe6d5;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							<li><a href="javascript:void(0)"  id="updatePassWD">修改密码</a></li>
							<li><a href="javascript:void(0)"  id="updatePayPassWD">修改提现密码</a></li>
							<li><a href="admin/logout.html">退出</a></li>
						</ul>
					</li>
					<li id="Hui-skin" class="dropDown right dropDown_hover"> <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							<li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
							<li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
							<li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
							<li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
							<li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
							<li><a href="javascript:;" data-val="orange" title="绿色">橙色</a></li>
						</ul>
					</li>
				</ul>
			</nav>
		</div>
	</div>
</header>

<jsp:include page="common/left.jsp"></jsp:include>

<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
	<div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
		<div class="Hui-tabNav-wp">
			<ul id="min_title_list" class="acrossTab cl">
				<li class="active">
					<span title="首页" data-href="welcome.html">首页</span>
					<em></em></li>
			</ul>
		</div>
		<div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a>
			<a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
	</div>
		<div id="iframe_box" class="Hui-article">
			<div class="show_iframe">
				<div style="display:none" class="loading"></div>
				<iframe scrolling="yes" frameborder="0" src="/admin/welcome.html"></iframe>
			</div>
		</div>
</section>

<!--_footer 作为公共模版分离出去-->
<jsp:include page="common/static-js.jsp"></jsp:include>
<!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/static/plugins/layui-v2.2.45/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','laypage', 'layer'], function(){
			var laypage = layui.laypage
					,layer = layui.layer;
		$("#updatePassWD").click(function(){
			layer.open({
				type: 2,
				area: ['500px', '350px'],
				fix: false, //不固定
				maxmin: true,
				shade:0.4,
				title: "修改密码",
				content: "admin/toUpdatePassWd.html?type=1"
			});
		});
		$("#updatePayPassWD").click(function(){
			layer.open({
				type: 2,
				area: ['500px', '350px'],
				fix: false, //不固定
				maxmin: true,
				shade:0.4,
				title: "修改密码",
				content: "admin/toUpdatePassWd.html?type=2"
			});
		});

	});

	var flag = 0;
	var currentTime = 0;
	// $(function () {
	// 	var currentRoleId = $("#currentRoleId").val();
	// 	if(currentRoleId==1||currentRoleId==2||currentRoleId==7) {
	// 		setInterval(getTotalMsg, 10000);
	// 	}
	// });
	// function getTotalMsg() {
    //     var obj=0;var code=0;
	// 	currentTime = new Date().getTime();
	// 	if(currentTime-flag>10000){
	// 		flag=currentTime;
	// 		$.ajax({
	// 			url:"/transfer/getTotalMsg.json",
	// 			type:"post",
	// 			dataType:"json",
	// 			success:function (data) {
	// 				flag=0;
	// 				$("#toDoMsg").html(data.obj);
	// 				if(data.obj>0){
	// 					obj=data.obj;
	// 				}
	// 				if(data.code>0){
	// 					code=data.code;
	// 				}
	// 				setTimeout(function () {
	// 					if(code>0){
	// 						playSound(1);
	// 					}
	// 				},3000);
	// 				setTimeout(function () {
	// 					if(obj>0){
	// 						playSound(0);
	// 					}
	// 				},7000);
	//
	// 			}
	// 		});
	// 	}
	// }

	function playSound(num)
	{
		var borswer = window.navigator.userAgent.toLowerCase();
		if ( borswer.indexOf( "ie" ) >= 0 )
		{
			$(".audioPlay").remove();
			var strEmbed;
			if(num==0){
			//IE内核浏览器
			    strEmbed = '<embed name="embedPlay" src="${staticUrl}/plugins/8906.wav"></embed>';
			}else{
				strEmbed = '<embed name="embedPlay" src="${staticUrl}/plugins/554695.mp3"></embed>';
			}
			if ( $( "body" ).find( "embed" ).length <= 0 )
				$( "body" ).append( strEmbed );
			var embed = document.embedPlay;

			//浏览器不支持 audion，则使用 embed 播放
			embed.volume = 100;
			//embed.play();这个不需要
		} else
		{
			$("#audioPlay").remove();
			var strAudio;
			if(num==0){
			//非IE内核浏览器
			    strAudio = "<audio id='audioPlay' src='${staticUrl}/plugins/8906.wav' hidden='true'>";
			}else{
				strAudio = "<audio id='audioPlay' src='${staticUrl}/plugins/554695.mp3' hidden='true'>";
			}
			if ( $( "body" ).find( "audio" ).length <= 0 )
				$( "body" ).append( strAudio );
			var audio = document.getElementById( "audioPlay" );
			//浏览器支持 audion
			audio.play();
		}
	}

    function changeStatus(id,status){
        if(status==5){
            layer.confirm('确认要停止轮询吗？', {
                btn : [ '确定', '取消' ]//按钮
            }, function(index) {
                layer.close(index);
                $.ajax({
                    type: "POST",
                    url: "/admin/changeStatus.json",
                    async: false, //同步执行
                    data: {"id": id,"status":status},
                    success: function (data) {
                        layer.alert("已禁用", {icon: 1},function(index){
                            $("#five").hide();
                            $("#two").show();
                            layer.close(index);
                        });
                    }
                });
            });
        }else{
            layer.confirm('确认要开始轮询吗？', {
                btn : [ '确定', '取消' ]//按钮
            }, function(index) {
                layer.close(index);
                $.ajax({
                    type: "POST",
                    url: "/admin/changeStatus.json",
                    async: false, //同步执行
                    data: {"id": id,"status":status},
                    success: function (data) {
                        layer.alert("已启用", {icon: 1},function(index){
                            $("#five").show();
                            $("#two").hide();
                            layer.close(index);
                        });
                    }
                });
            });
        }
    }

</script>

</body>
</html>