<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/jsp/common/global.jsp" %>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${staticUrl}/plugins/layui-v2.2.45/css/layui.css" media="all">
    <base href="<%=basePath%>">
    <title>冻结</title>
    <jsp:include page="../common/static.jsp"></jsp:include>
    <style>
        .member_menu li {
            width: 100%;
            height: 35px;
            line-height: 35px;
            border-bottom: 1px solid #eee;
        }

        .member_menu li a {
            margin-left: 20px;
        }

        .layui-input {
            width: 300px;
        }

        .layui-form-item {
            margin-bottom: 10px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div id="container">
    <form class="layui-form" action="/member/freezeBalance.json" style="border:solid 1px #FFF;">
        <input type="hidden" id="id" name="id" value="${member.id }">
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>当前余额:</label>
            <div class="layui-input-inline">
                <input type="text" required lay-verify="required" value="${member.balance }" id="beforeBalance"
                       name="beforeBalance" disabled="disabled" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>当前冻结金额:</label>
            <div class="layui-input-inline">
                <input type="text" required lay-verify="required" value="${member.freezeBalance }" id="beforeFreeze"
                       name="beforeFreeze" disabled="disabled" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>冻结后金额:</label>
            <div class="layui-input-inline">
                <input type="text" required lay-verify="required" value="${member.balance }" id="afterBalance"
                       name="afterBalance" disabled="disabled" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>冻结金额:</label>
            <div class="layui-input-inline">
                <input type="text" required lay-verify="required" onmouseleave="addMoney()" maxlength=""
                       id="freezeMoney" name="freezeMoney" placeholder="请输入冻结金额!" autocomplete="off"
                       class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>备注:</label>
            <div class="layui-input-inline">
                <input type="text" required lay-verify="required" id="remark" name="remark" placeholder="请输入冻结备注!"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" type="button" id="modifyMember" lay-submit lay-filter="freeze"
                        style="margin-left: 240px;">保存
                </button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="${staticUrl}/plugins/layui-v2.2.45/layui.js"></script>
<script>

    var freezeStatus = true;

    layui.use(['layedit', 'form'], function () {
        var form = layui.form;
        form.on('submit(freeze)', function (data) {
            if (freezeStatus) {
                $.ajax({
                    url: data.form.action,
                    type: data.form.method,
                    data: $(data.form).serialize(),
                    success: function (info) {
                        freezeStatus = false;
                        if (info.code == 200) {
                            layer.msg(info.msg, {
                                time: 1000 //1秒关闭（如果不配置，默认是3秒）
                            }, function () {
                                //当你在iframe页面关闭自身时
                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                parent.paging();
                                parent.layer.close(index); //再执行关闭
                            });
                        } else if (info.code == 500) {
                            layer.msg(info.msg, {icon: 5}, {
                                time: 1000 //2秒关闭（如果不配置，默认是3秒）
                            }, function () {
                                //当你在iframe页面关闭自身时
                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                parent.paging();
                                parent.layer.close(index); //再执行关闭
                            });
                        }
                    }
                });
            } else {
                layer.msg("请勿重复提交", {icon: 5}, {
                    time: 1000 //2秒关闭（如果不配置，默认是3秒）
                }, function () {
                    //当你在iframe页面关闭自身时
                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                    parent.paging();
                    parent.layer.close(index); //再执行关闭
                });

            }

        });
    });

    function addMoney() {
        var freezeMoney = $("#freezeMoney").val();
        var beforeBalance = $("#beforeBalance").val();
        var beforeFreeze = $("#beforeFreeze").val();
        var reg = /^(\-?)\d+(\.\d{0,2})?$/;
        if (freezeMoney != null && freezeMoney != "") {
            if (!reg.test(freezeMoney)) {
                $("#freezeMoney").val("");
                layer.msg("充值金额必须为数字且最多有两位小数", {time: 1500}, {icon: 5}, function (index) {
                    layer.close(index);
                });
                return;
            }
            if(Number(freezeMoney)>Number(beforeBalance)){
                $("#freezeMoney").val("");
                layer.msg("可用金额不足", {time: 1500}, {icon: 5}, function (index) {
                    layer.close(index);
                });
                return;
            }
            if(Number(freezeMoney)<0&&Number(Math.abs(freezeMoney))>Number(beforeFreeze)){
                $("#freezeMoney").val("");
                layer.msg("可用冻结金额不足", {time: 1500}, {icon: 5}, function (index) {
                    layer.close(index);
                });
                return;
            }
            $("#afterBalance").val(Math.floor((Number(beforeBalance) * 100) - (Number(freezeMoney) * 100)) / 100);
        }
    }
</script>
</body>
</html>
