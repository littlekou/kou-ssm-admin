<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/jsp/common/global.jsp" %>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <base href="<%=basePath%>">
    <title>添加用户</title>
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
    <form class="layui-form" action="/member/modifyMember.json"  style="border:solid 1px #FFF;">
        <input type="hidden" id="id" name="id"  value="${member.id }" >
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>用户名称:</label>
            <div class="layui-input-inline">
                <input type="text"  required  lay-verify="required"  value="${member.cname }"  id="cname"  name="cname" placeholder="请输入用户名称!" maxlength="15" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><span class="c-red">*</span>登录账号:</label>
            <div class="layui-input-inline">
                <%-- <input type="text"  required  lay-verify="required" onKeyUp="value=value.replace(/[^\w\.\/]/ig,'')" value="${member.mobile }"  id="mobile" maxlength="15" name="mobile" placeholder="登录账号只能是数字或字母!"  autocomplete="off" class="layui-input">--%>
                <c:choose>
                    <c:when test="${member.mobile  ==null}">
                        <input type="text"  required  lay-verify="required" onKeyUp="value=value.replace(/[^\w\.\/]/ig,'')" value=""  id="mobile" maxlength="15" name="mobile" placeholder="请输入登录账号!"  autocomplete="off" class="layui-input">
                    </c:when>
                    <c:otherwise>
                        <input type="text"  readonly  lay-verify="required"  value="${member.mobile }"    class="layui-input">
                        <input type="hidden"  value="${member.mobile }"  id="mobile"  name="mobile">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"> <span class="c-red">*</span>用户角色:</label>
            <div class="layui-input-inline">
                <select id="roleId" name="roleId" lay-filter="roleId">
                    <c:if test="${curOpt == 'modify'}">
                        <option value="${member.roleId}" selected>
<c:forEach items="${role}" var="role"><c:if test="${role.sysRoleId == member.roleId}">${role.roleName}</c:if></c:forEach>
                        </option>
                    </c:if>
                    <c:if test="${curOpt == 'add'}">
                        <option value="">全部</option>
                        <c:choose>
                            <c:when test="${1 == currentUser.roleId}">
                                <c:forEach items="${role}" var="role">
                                    <c:if test="${role.sysRoleId!=7 && role.sysRoleId!=1}">
                                        <option value="${role.sysRoleId}" <c:if test="${role.sysRoleId eq member.roleId}">selected</c:if>>${role.roleName}</option>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:when test="${2 == currentUser.roleId || 6 == currentUser.roleId}">
                                <option value="4" <c:if test="${4 eq member.roleId}">selected</c:if>>商户</option>
                                <option value="7" <c:if test="${7 eq member.roleId}">selected</c:if>>操作员</option>
                            </c:when>
                            <c:when test="${5 == currentUser.roleId}">
                                <option value="5">码商</option>
                            </c:when>
                            <c:otherwise>

                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </select>
            </div>
            <div class="layui-form-mid layui-word-aux"></div>
        </div>

        <c:choose>
            <c:when test="${currentUser.roleId==1}">
                <div class="layui-form-item">
                    <label class="layui-form-label">创建人ID:</label>
                    <div class="layui-input-inline">
                        <input type="text"  required  lay-verify="createByVerify" value="${member.createBy }"  id="createBy"  name="createBy" placeholder="请输入创建人编号!(默认为创建人代理ID)"  autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid layui-word-aux"></div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">代理ID:</label>
                    <div class="layui-input-inline">
                        <input type="text"  required  lay-verify="createByVerify" value="${member.agentId }"  id="agentId"  name="agentId" placeholder="请输入创建人编号!(默认为创建人代理ID)"  autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid layui-word-aux"></div>
                </div>
            </c:when>
            <c:otherwise>
                <input type="hidden"   value="${member.createBy }"  id="createBy"  name="createBy"   autocomplete="off" class="layui-input">
                <input type="hidden"  value="${member.agentId }"  id="agentId"  name="agentId"   autocomplete="off" class="layui-input">
            </c:otherwise>
        </c:choose>

                <c:forEach items="${payType}" var="payType">
                    <div class="layui-form-item fl">
                        <label class="layui-form-label">${payType.pay_name}费率:</label>
                        <div class="layui-input-inline">
                            <input type="text"  required  id="${payType.pay_type}"  name="${payType.pay_type}" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-form-mid layui-word-aux"></div>
                    </div>
                </c:forEach>
                <div class="layui-form-item fl">
                    <label class="layui-form-label">代付费率‰:</label>
                    <div class="layui-input-inline">
                        <input type="text"  required  id="df"  name="df" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid layui-word-aux"></div>
                </div>
                <div class="layui-form-item fl">
                    <label class="layui-form-label">额外收费:</label>
                    <div class="layui-input-inline">
                        <input type="text"  required  id="extra"  name="extra" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid layui-word-aux"></div>
                </div>

                <div class="layui-form-item fl">
                    <label class="layui-form-label">充值费率‰:</label>
                    <div class="layui-input-inline">
                        <input type="text"  required  id="cz"  name="cz" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid layui-word-aux"></div>
                </div>
                <div class="layui-form-item fl">
                    <label class="layui-form-label">固定充值费用:</label>
                    <div class="layui-input-inline">
                        <input type="text"  required  id="gdcz"  name="gdcz" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid layui-word-aux"></div>
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
        form.verify({
            createByVerify: function(value, item){ //value：表单的值、item：表单的DOM对象
                if(value==""){
                    value = "${currentUser.id}";
                }
                if(!new RegExp("^[0-9]*$").test(value)){
                    return '代理人编号必须为数字！';
                }
            }
        });
        form.on('select(roleId)', function(data){
            var id = $("#roleId").val();
            if(id==7){
                $(".fl").hide();
            }else{
                $(".fl").show();
            }
        });
        form.on('submit(modifyMember)', function(data){
            $.ajax({
                url: data.form.action,
                type: data.form.method,
                data: $(data.form).serialize(),
                success: function (data) {
                    if(data.code==100){
                        layer.msg(data.msg);
                    }else {
                        parent.paging(parent.currentPage);
                        layer.alert(data.msg, {icon: 1},function(index){
                            var pindex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(pindex);
                            layer.close(index);
                        });
                    }
                },
                error:function (data) {
                    layer.msg("对不起，您检测到数据被修改");
                }
            });

        });
    });
    $(function(){
        //利率回显
        if('${member.rate}'!=""){
            var rate = JSON.parse('${member.rate}');
            for(var key in rate){
                $("#"+key).val(rate[key]);
            }
        }
        $("#memberRate").val(${member.memberRate});
        if(${member.roleId==7}){
            $(".fl").hide();
        }
    })

</script>
</body>
</html>
