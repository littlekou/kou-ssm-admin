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
    <title>绑定支付宝</title>
    <jsp:include page="../common/static.jsp"></jsp:include>
    <style>
        .member_menu li{width: 100%;height:35px;line-height:35px;border-bottom: 1px solid #eee;}
        .member_menu li a{margin-left:20px;}
        .layui-form-item {margin-bottom: 10px;margin-top: 10px;margin-left: 20px}
        .layui-form-label{width: 50px;text-align: left}
    </style>
</head>
<body>
<div id="container">
    <form class="layui-form" action="/member/setMixedChannel.json"  style="border:solid 1px #FFF;">
        <input type="hidden" id="id" name="id"  value="${member.id }" >
        <label class="layui-form-label" style="font-weight: bold;">支付宝:</label>
        <div class="layui-form-item">
            <c:forEach items="${payType}" var="payType">
                <label><input name="payT" type="radio" value="${payType.channelId}" title="${payType.payName}"/></label>
            </c:forEach>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn"type="button" id="modifyMember"  lay-submit  lay-filter="modifyMember" style="margin-left: 240px;">保存</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="${staticUrl}/plugins/layui-v2.2.45/layui.js"></script>
<script>

    layui.use(['layedit','form'], function(){
        var form = layui.form;
        form.render();
        form.on('submit(modifyMember)', function(data){
            $.ajax({
                url: data.form.action,
                type: data.form.method,
                data: $(data.form).serialize(),
                success: function (data) {
                    if(data.code==100){
                        layer.msg(data.msg);
                    }else {
                        layer.msg(data.msg, {time: 1000}, function () {
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.paging(parent.currentPage);
                            parent.layer.close(index); //再执行关闭
                        });
                    }
                }
            });

        });
    });

    $(function(){
        var p;
        //利率回显
        if('${member.mixedChannel}'!=""){
            var mixed = JSON.parse('${member.mixedChannel}');
                p=mixed["alipay"];
        }

        var payT = document.getElementsByName("payT");
        for(var i = 0;i < payT.length;i++){
            if(payT[i].value == p){
                payT[i].checked =  'checked';
            }
        }
    })

</script>
</body>
</html>
