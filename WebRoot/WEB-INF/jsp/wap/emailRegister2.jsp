<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<c:set var="ctx" value="${pageContext['request'].contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <title>汤森机械网-注册</title>
    <%@ include file = "meta.jsp" %>
    <link rel="stylesheet" href="css/module/index.css?v=1" type="text/css" charset="utf-8">
    <style>
    .logo{padding:0 0 20px;}
    .logo img{margin: 20px auto 0;}
    .logo span{margin: 20px auto 0;}
    .ui-form-mod .ui-form-bd input{padding:0;width: 100%;}
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
</header><!--head end-->
<div class="page-view">
    <div class="logo">
        <img src="images/logo2.png" />
        <span>信息完善</span>
    </div>
    <section class="ui-login">
        <form action="" class="ui-form" id="register2" method="post">

        <input type="hidden" id = "id" name = "id" value= "${sessionScope.user.id}" />
            <div class="ui-border">
                    <fieldset>
                    <div class="ui-form-mod">
                        <label class="ui-form-hd">姓名</label>
                        <div class="ui-form-bd">
                         <input type="text" id="realName" name="realName"  maxlength="6"  mleinngth="2" placeholder="请输入姓名" value="">
                        </div>
                    </div>
                    <div class="ui-form-mod">
                        <label class="ui-form-hd">手机号码</label>
                        <div class="ui-form-bd">
                                 <input type="text" name="mobile" id="mobile" placeholder="请输入手机号码" value="">
                        </div>
                    </div>
                    <div class="ui-form-mod">
                        <label class="ui-form-hd">省份</label>
                        <div class="ui-form-bd">
                       <select class="regionProvice"  name="provinceId" id="provinceId" validate="required:true" ><option>请选择省份</option></select>
                        </div>
                    </div>
                    <div class="ui-form-mod">
                        <label class="ui-form-hd">城市</label>
                        <div class="ui-form-bd">
                            <select class="regionCity"  name="cityId" id="cityId" validate="required:true" ><option>请选择城市</option></select>
                        </div>
                    </div>
                    <div class="ui-form-mod">
                        <label class="ui-form-hd">经营范围</label>
                        <div class="ui-form-bd">
                            <select name = "businessScope">
                                <option value="1">工程机械</option>
                                <option value="2">农业机械</option>
                                <option value="3">矿山机械</option>
                                <option value="4">林业机械</option>
                                <option value="5">运输车辆</option>
                            </select>
                        </div>
                    </div>
                    <div class="ui-form-mod">
                        <label class="ui-form-hd">经营性质</label>
                        <div class="ui-form-bd">
                            <select name = "businessNature">
                                <option value="1">生产商</option>
                                <option value="2">代理商</option>
                                <option value="3">买家</option>
                                <option value="4">卖家</option>
                                <option value="5">买卖贸易</option>
                                <option value="6">中介</option>
                                <option value="7">维修</option>
                                <option value="8">配件商</option>
                                <option value="9">抵押</option>
                            </select>
                        </div>
                    </div>
                    <div class="ui-form-mod">
                        <label class="ui-form-hd"><input type="checkbox" checked="checked" name = "isAgree" /> 同意条款<em>*</em> </label>
                    </div>
                </fieldset>
            </div>
            <div class="field-submit">
                <a href="javascript:;" class="ui-button   ui-button-submit" id="jSubmit">提交</a>
            </div>
        </form>
    </section>
</div>

<script type="text/javascript" src="${ctx}/wap/js/require.js"></script>
<script type="text/javascript" src="${ctx}/wap/js/app.js"></script>
<script type="text/javascript">
var ctx = "${ctx}";
    require(['module/registerEmail2']);
</script>
</body></html>
