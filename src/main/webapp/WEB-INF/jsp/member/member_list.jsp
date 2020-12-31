<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE HTML>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/common/global.jsp" %>
	<base href="<%=basePath%>">
	<jsp:include page="../common/static.jsp"></jsp:include>
	<title>会员持仓列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 商户管理 <span class="c-gray en">&gt;</span> 商户列表<a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">

	<div class="text-c">
		<form class="layui-form gformc" action="" >
		<div class="gformccontent">
			<label class="gformctitle">用户ID:</label><div class="gformcvalue"><input type="text" oninput="value=value.replace(/[^\d]/g,'')" maxlength="9" name="merchantId" id="merchantId" class="layui-input" ></div>
		</div>
        <div class="gformccontent">
            <label class="gformctitle">登录账号:</label><div class="gformcvalue"><input type="text" name="cname" id="mobile" class="layui-input" ></div>
        </div>
		<div class="gformccontent">
			<label class="gformctitle">用户名称:</label><div class="gformcvalue"><input type="text" name="cname" id="cname" class="layui-input" ></div>
		</div>
		<div class="gformccontent">
			<label class="gformctitle">注册时间:</label><div class="gformcvalue"><input type="text" readonly name="addTime" id="addTime" autocomplete="off" class="layui-input" style="width: 50%;display: inline;" placeholder="开始时间"><input type="text" name="endTime" id="endTime" autocomplete="off" class="layui-input" style="width: 50%;display: inline;" placeholder="结束时间"></div>
		</div>
		<div class="gformccontent">
			<label class="gformctitle">代理ID:</label><div class="gformcvalue"><input type="text" oninput="value=value.replace(/[^\d]/g,'')" maxlength="9" name="agentId" id="agentId" class="layui-input" ></div>
		</div>
		<div class="gformccontent">
			<label class="gformctitle">用户状态:</label><div class="gformcvalue">
			<select id="status" lay-verify="required" lay-search="">
				<option value="">全部</option>
				<option value="1">待审核</option>
				<option value="2">正常</option>
				<option value="3">禁用</option>
			</select>
		</div>
		<c:if test="${member.roleId==1||member.roleId==2}">
			<div class="gformccontent">
				<label class="gformctitle">用户角色:</label>
				<div class="gformcvalue">
					<select id="roleId" lay-verify="required" lay-search="">
						<option value=''>全部</option>
						<c:forEach items="${roles}" var="roles" >
							<c:if test="${member.roleId==1}">
								<c:if test="${roles.sysRoleId!=1}">
									<option value='${roles.sysRoleId}'>${roles.roleName}</option>
								</c:if>
							</c:if>
							<c:if test="${member.roleId==2}">
								<c:if test="${roles.sysRoleId!=1 && roles.sysRoleId!=2}">
									<option value='${roles.sysRoleId}'>${roles.roleName}</option>
								</c:if>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</div>
		</c:if>
		</div>
			<div class="layui-btn-group" style="float: left;">
				<button type="button"  class="layui-btn" name="" id="search" ><i class="Hui-iconfont">&#xe665;</i>搜索</button>
				<c:if test="${member.roleId!=10}">
				<button type="button"  class="layui-btn" name="" id="addMember" onclick="toAddMember()" >+添加</button>
				</c:if>
			</div>
		</form>
	</div>

	<c:if test="${member.roleId==1 || member.roleId==5 }">
		<blockquote class="layui-elem-quote" style="text-align: center;">
			<span style="color: red;"></span><b>网关为： ${payUrl}</b>
		</blockquote>
	</c:if>

	<div id="dataMsg"></div>
	<div id="merchantsPager"></div>
</div>
<!--_footer 作为公共模版分离出去-->
<jsp:include page="../common/static-js.jsp"></jsp:include>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${staticUrl}/plugins/layui-v2.2.45/layui.js"></script>
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript">

    var pageSize;
    var laypage;
    // var form;
    var laydate;
    // var layedit;
    var paging;
    $(function () {
        layui.use(['form','laypage', 'layer','laydate'], function(){
            laypage = layui.laypage;
                layer = layui.layer
                ,laydate = layui.laydate;
            laydate.render({
                elem: '#addTime'
                ,format: 'yyyy-MM-dd'
				,type: 'datetime'
            });
            laydate.render({
                elem: '#endTime'
                ,format: 'yyyy-MM-dd'
				,type: 'datetime'
            });
            //以下将以jquery.ajax为例，演示一个异步分页
            pageSize = 10;
            paging = function(curr){
                $.ajax({
                    type: "POST",
                    url: "/member/pageList.html",
                    data: {
                     	merchantId:$("#merchantId").val(),
                     	agentId:$("#agentId").val(),
                        status:$("#status").val(),
                        startTime:$("#addTime").val(),
                        endTime:$("#endTime").val(),
                        mobile:$("#mobile").val(),
                        cname:$("#cname").val(),
						roleId:$("#roleId").val(),
                        currentPage :curr || 1,
                        pageSize : pageSize
                    },
                    success: function(data){
                        $("#dataMsg").html(data);
                        var totalCount = $("#totalCount").val();
                        //显示分页
                        laypage.render({
                            elem: 'merchantsPager', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
                            count: totalCount, //通过后台拿到的总页数
                            curr: curr || 1, //当前页
                            //groups: 5 ,//连续显示分页数
                            first: 1,
                            last: totalCount,
                            jump: function(obj, first){ //触发分页后的回调
                                if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
                                    paging(obj.curr);
                                }
                            }
                        });
                    }
                });
            };
            //运行
            paging();
            $("#search").click(function () {
                paging();
            });
        });
    })    
    
	function toAddMember(){
    	layer.open({
    		type: 2,
    		area: ['520px', '510px'],
    		fix: false, //不固定
    		maxmin: true,
    		shade:0.4,
    		title: "添加用户",
    		content: "member/toAddMember.html",
            success:function(){
                $(":focus").blur();
            }
    	});
	}

</script>


</body>
</html>