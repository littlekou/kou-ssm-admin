<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<form id="ggyzqForm"  class="layui-form layui-form-pane" style="padding:15px;box-sizing: border-box;">
    <div class="layui-form-item">
        <label class="layui-form-label" style="padding: 8px 8px;font-size:12px;">当前手机号：</label>
        <div class="layui-input-block">
            <input type="number" lay-verify="required" value="${param.phone}" id="phone"  placeholder="请输入手机号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="padding: 8px 8px;font-size:12px;">图片验证码：</label>
        <div class="layui-input-block">
            <input type="text" name="imgCode" lay-verify="title" id="imgCode" autocomplete="off" placeholder="请输入验证码" class="layui-input">
            <a href="javascript:getVerifiCode()">
                <img id="yzm_img" style="cursor:pointer;width: 94px;border-radius: 1px;position: absolute;top: 0px;right: 0px;" title="点击刷新" src="admin/getVerifyCode.html"/>
            </a>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="padding: 8px 8px;font-size:12px;">短信验证码：</label>
        <div class="layui-input-block">
            <input type="text" name="title" lay-verify="title" id="phoneCode" autocomplete="off" placeholder="请输入验证码" class="layui-input">
            <button type="button" class="layui-btn layui-btn-xs layui-btn-normal" id="phoneBtn" onclick="getPhoneVerify()" style="position: absolute;width: 105px; height: 37px;top: 0px;right: 0px;">获取验证码</button>
        </div>
    </div>

    <c:if test="${null!=param.google&&param.google ne ''}">
        <div class="layui-form-item">
            <label class="layui-form-label" style="padding: 8px 8px;font-size:12px;">谷歌验证码：</label>
            <div class="layui-input-block">
                <input type="number" id="phoneGoogle" lay-reqtext="" placeholder="请输入验证码" autocomplete="off" class="layui-input">
            </div>
        </div>
    </c:if>

    <span id="tmsg" style="color: red;font-weight:bold;"></span>
</form>