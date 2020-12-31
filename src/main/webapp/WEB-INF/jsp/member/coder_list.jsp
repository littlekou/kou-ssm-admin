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
    <title>操作员列表</title>
</head>
<body>
<div class="page-container">
    <div class="layui-form-item">
        <input type="text" id="merchantId" value="${merchantId}" hidden/>
        <!--<form class="gformc" action="" >
            <div class="gformccontent">
                <label class="gformctitle">码商名称:</label><div class="gformcvalue"><input type="text" name="cname" id="cname" maxlength="10" class="layui-input" ></div>
            </div>
            <div class="gformccontent">
                <label class="gformctitle">码商账号:</label><div class="gformcvalue"><input type="text" name="mobile"  id="mobile" maxlength="10" class="layui-input" ></div>
                <button type="button"  class="btn btn-success" onclick="search()" ><i class="Hui-iconfont">&#xe665;</i>搜索</button>
            </div>
        </form>-->
        <table class="table table-border table-bordered table-bg">
            <thead>
            <tr class="text-c">
                <td width="50px"  >选择</td>
                <td width="150px"  >操作员ID</td>
                <td width="150px"  >操作员名称</td>
                <td >操作员账号</td>
            </tr>
            </thead>
            <tbody class="text-c">
            <c:forEach items="${members}" var="members">
                <c:set var="iscontain" value="false" />
                <c:forEach items="${cus}" var="element">
                    <!-- 判断测试值是否存在于集合中，存在将iscontain置为true -->
                    <c:if test="${element == members.id}">
                        <c:set var="iscontain" value="true" />
                    </c:if>
                </c:forEach>
                　　<!-- 值在集合中 -->
                　　<c:if test="${iscontain}">
                        <tr>
                            <td >
                                <div style="margin:0 auto"><span><input type="checkbox" id="check1" name="membersCheck" value="${members.id}" checked/><label for="check"></label></span></div>
                            </td>
                            <td>${members.id}</td>
                            <td>${members.cname}</td>
                            <td>${members.mobile}</td>
                        </tr>
                    </c:if>
                　　<!-- 测试值不在集合中 -->
                　　<c:if test="${!iscontain}">
                        <tr>
                            <td >
                                <div style="margin:0 auto"><span><input type="checkbox" id="check2" name="membersCheck" value="${members.id}"/><label for="check"></label></span></div>
                            </td>
                            <td>${members.id}</td>
                            <td >${members.cname}</td>
                            <td >${members.mobile}</td>
                        </tr>
                    </c:if>

            </c:forEach>

            </tbody>
        </table>
        <div class="layui-form-mid layui-word-aux"></div>
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-sm-offset-2" style="margin-top: 20px">
                <button onclick="submitMember()"
                        class="btn btn-primary radius" type="submit">
                    <i class="Hui-iconfont">&#xe632;</i> 提交
                </button>

            </div>
        </div>
    </div>
</div>
<div id="dataMsg"></div>
    <script type="text/javascript" src="${staticUrl}/plugins/layui-v2.2.45/layui.js"></script>
</body>

<script type="text/javascript">
    var layer;
    layui.use('layer', function(){
        layer = layui.layer;
    });
    var cname,mobile;
    function search(){
        cname=$("#cname").val();
        mobile=$("#mobile").val();
        $.ajax({
            type:"post",
            url:"member/showCoder.html",
            data:{cname:cname,id:$("#merchantId").val(),mobile:mobile},
            dataType:"html",
            success:function(data){
                    $(".layui-form-item").html("")
                    $(".layui-form-item").html(data)
                $("#cname").val(cname);
                $("#mobile").val(mobile);
            },
            error:function(data){
                alert("没有码商");
            }
        })

    };


    function submitMember() {
        var id = [];
        $("input[name=\"membersCheck\"]:checked").each(function(){
            id.push($(this).val());
        });
            $.ajax({
                type: "post",
                url: "/member/bingCoderById.json",
                data: {id: id.toString(), merchantId: $("#merchantId").val()},
                success: function (data) {
                    if(data.flag){
                        layer.msg("保存成功!", {
                            time: 1000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            //当你在iframe页面关闭自身时
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.paging();
                            parent.layer.close(index); //再执行关闭
                        });
                    }else{
                        alert(data.msg)
                    }
                }
            })
    }
    
</script>
</html>
