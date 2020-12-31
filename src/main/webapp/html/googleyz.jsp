<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<form id="ggyzqForm"  class="layui-form layui-form-pane" style="padding:15px;box-sizing: border-box;">
    <c:if test="${param.flag==2}">
        <div class="layui-form-item">
            <label class="layui-form-label" style="padding: 8px 8px;font-size:12px;">旧动态验证码：</label>
            <div class="layui-input-block">
                <input type="number" lay-verify="required" id="ggoldyzm" lay-reqtext="验证码是必填项" placeholder="请输入验证码" autocomplete="off" class="layui-input">
            </div>
        </div>
    </c:if>
    <div class="layui-form-item">
        <label class="layui-form-label">我的密钥：</label>
        <div class="layui-input-block">
            <input type="text" name="title" lay-verify="title" id="ggmy" autocomplete="off" placeholder="密钥建议系统生成" class="layui-input">
            <button class="layui-btn layui-btn-xs layui-btn-normal" onclick="getGoogleCode()" type="button" style="position: absolute;width: 105px; height: 37px;top: 0px;right: 0px;">点我生成密钥</button>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="padding: 8px 10px;">动态验证码：</label>
        <div class="layui-input-block">
            <input type="number" lay-verify="required" id="ggyzm" lay-reqtext="验证码是必填项" placeholder="请输入验证码" autocomplete="off" class="layui-input">
        </div>
    </div>
    <span id="tmsg" style="color: red;font-weight:bold;"></span>
</form>