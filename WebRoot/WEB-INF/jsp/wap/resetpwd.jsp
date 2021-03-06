<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext['request'].contextPath}" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>汤森机械网-找回密码</title>
    <%@ include file = "meta.jsp" %>
    <link rel="stylesheet" href="css/module/forgotpwd.css?v=1" type="text/css" charset="utf-8">
    <style>
    .logo{padding:0 0 20px;}
    .logo img{margin: 20px auto 0;}
    .logo span{width:100%;text-align: center;}
    .ui-form-mod .ui-form-bd{position:relative;}
    .ui-form-mod .ui-form-bd.dx-box input{width: 68%;}
    .ui-form-mod .ui-form-bd .ui-button{position: absolute;top:0;right: 0;display: inline-block;width: 30%;}
    </style>
</head>
<body>
<!--head begin-->
<header class="ui-header">
    <a href="${ctx}/wap/index.htm" class="ui-left">
        <img src="${ctx}/wap/images/logo.png" class="ui-logo" />
    </a>
    <a  href="${ctx}/wap/login.htm" class="ui-right ui-login">
        <span class="icon iconfont">&#xe600;</span>登录
    </a>
</header>
<!--head end-->
<div class="page-view">
    <div class="logo">
        <img src="${ctx}/wap/images/logo2.png" />
        <span>重置密码</span>
    </div>
    <section class="ui-login">
        <form action="${ctx}/wap/savepwd.htm" class="ui-form" id="formMobile" method="post">
            <div class="ui-form-mod">
                <label class="ui-form-hd">密码</label>
                <div class="ui-form-bd">
                    <input type="password" name="pwd" id="pwd" placeholder="请输入密码" value="">
                </div>
            </div>
             <div class="ui-form-mod">
                <label class="ui-form-hd">确认密码</label>
                <div class="ui-form-bd">
                    <input type="password" name="repwd" id="repwd" placeholder="请再次输入密码" value="">
                </div>
            </div>
            <div class="field-submit">
                <input type="submit" class="ui-button ui-button-submit" value="提交">
            </div>
        </form>
    </section>
</div>

<script type="text/javascript" src="${ctx}/wap/js/require.js"></script>
<script type="text/javascript" src="${ctx}/wap/js/app.js"></script>
<script type="text/javascript">
var ctx = "${ctx}"
     
</script>
</body></html>
