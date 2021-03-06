<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<c:set var="ctx" value="${pageContext['request'].contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <title>汤森机械网-首页</title>
    <%@ include file = "meta.jsp" %>
    <link rel="stylesheet" href="css/module/index.css?v=1" type="text/css" charset="utf-8">
</head>
<body>
<!--head begin-->
<%@ include file="header.jsp" %>
<!--head end-->
<div class="page-view">
    <div class="page-view-body">
        <section class="search-type-mod" id="jSearch">
            <div class="search-type-hd">
                <span>42000</span>台出售
            </div>
            <div class="search-type-bd">
                <form class="ui-form">
                    <div class="ui-form-mod">
                        <label class="ui-form-hd">搜索类型</label>
                        <div class="ui-form-bd">
                            <select>
                                <option value="1">出售</option>
                                <option value="0">租赁</option>
                                <option value="0">求购</option>
                                <option value="979">求租</option>
                            </select>
                        </div>
                    </div>
                    <div class="ui-form-mod">
                        <label class="ui-form-hd">产品子类</label>
                        <div class="ui-form-bd">
                            <select>
                                <option value="2622">Aerial Platform</option>
                                <option value="903">Aggregate</option>
                                <option value="1500">Air Compressor</option>
                            </select>
                        </div>
                    </div>
                    <div class="ui-form-mod">
                        <label class="ui-form-hd">品牌</label>
                        <div class="ui-form-bd">
                            <select>
                                <option value="2622">Aerial Platform</option>
                                <option value="903">Aggregate</option>
                                <option value="1500">Air Compressor</option>
                            </select>
                        </div>
                    </div>
                    <div class="ui-form-mod">
                        <label class="ui-form-hd">型号</label>
                        <div class="ui-form-bd">
                            <select>
                                <option value="2622">Aerial Platform</option>
                                <option value="903">Aggregate</option>
                                <option value="1500">Air Compressor</option>
                            </select>
                        </div>
                    </div>

                    <div class="field-submit">
                        <a href="${ctx}/infomation/search.htm" class="ui-button ui-button-submit ui-button-blue">搜索</a>
                    </div>
                </form>
            </div>
        </section>
        <section class="recommended-mod" id="jRecommend">
            <div class="recommended-hd">
                <span class="icon iconfont">&#xe619;</span>今日推荐
            </div>
            <div class="recommended-bd">
                <ul class="clearfix">
            	<c:forEach var="item" items = "${Tops}" varStatus="status">
                    <li>
                        <a href="${ctx}/infomation/input.htm?id=${item.id}">
                            <span class="pro-img"><img src="images/blank.gif" class="jImg" data-url="images/img1.jpg" /></span>
                            <span class="name">${item.brandName}${item.modelName}</span>
                            <span class="price"><b>价格：</b>${item.price}元</span>
                        </a>
                    </li>
                </c:forEach>
                </ul>
            </div>
        </section>
        <section class="collect-mod" id="jCollect">
            <div class="collect-hd">
                <span class="icon"><img src="images/bookmark_icon.png" /> </span>我的收藏
            </div>
            <div class="collect-bd">
            <c:if test="${not empty sessionScope.user.id}">
				<ul class="clearfix" style="display: ;">
					<c:forEach var ="item" items = "${collections}" varStatus="status">
                    <li>
                        <a href="${ctx}/infomation/input.htm?id=${item.id}">
                            <span class="pro-img"><img src="images/blank.gif" class="jImg" data-url="images/img1.jpg" /></span>
                            <span class="name">${item.brandName}${item.modelName}</span>
                            <span class="price"><b>价格：</b>${item.price}元</span>
                        </a>
                    </li>
					</c:forEach>
                </ul>
		    </c:if>
		    <c:if test="${ empty sessionScope.user.id}">
	            <div class="no-login">登录后查看我的收藏</div>
		    </c:if> 
                
            </div>
        </section>
    </div>
</div>

<script type="text/html" id="recommendTpl">

</script>
<%@ include file="footer.jsp" %>
<script type="text/javascript" src="${ctx}/wap/js/require.js"></script>
<script type="text/javascript" src="${ctx}/wap/js/app.js"></script>
<script type="text/javascript">
var ctx = "${ctx}";
    require(['module/index']);
</script>
</body></html>
