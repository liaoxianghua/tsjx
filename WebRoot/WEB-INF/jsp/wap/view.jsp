<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext['request'].contextPath}"/>
<%
cn.com.tsjx.infomation.entity.Infomation info_ = (cn.com.tsjx.infomation.entity.Infomation)request.getAttribute("bean");
String location = info_.getEquipmentLocation();
if(location != null && !"".equals(location)) {
	location = location.replace("|", "");
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>${bean.equipmentConditionStr}${bean.brandName}${bean.modelName}${bean.catagoryName}${bean.sellTypeStr}-汤森机械网</title>
    <meta name="keywords" content="${bean.equipmentConditionStr}${bean.brandName}${bean.modelName}${bean.catagoryName}，${bean.equipmentConditionStr}${bean.brandName}${bean.modelName}${bean.catagoryName}价格-<%=location %>${bean.equipmentConditionStr}${bean.brandName}${bean.modelName}${bean.catagoryName}市场-汤森机械网">
    <meta name="description" content="汤森机械网${bean.catagoryBigName}交易平台, 为广大<%=location %>用户提供${bean.equipmentConditionStr}${bean.brandName}${bean.modelName}${bean.catagoryName}信息,已工作${bean.workTime}小时, 价格${bean.price}${bean.priceUnit}, 汤森机械网为您提供最真实,最详细的${bean.equipmentConditionStr}${bean.brandName}${bean.modelName}${bean.catagoryName}信息。">
    <%@ include file="meta.jsp" %>
    <link rel="stylesheet" href="${ctx}/wap/css/module/view.css?v=1" type="text/css" charset="utf-8">
    <style>
    .img-box .hd{height:140px;}
    .img-box .hd .img-title{padding:10px 0;}
    .img-box .bd .img-list{margin-top:10px;height:90px;padding-bottom:10px;}
    .img-box .bd .img-list a{width:90px;height:90px;margin-right:10px;}
    .img-box .bd .img-list a img{width:90px;height:90px;max-width:none;max-height:none;}
    .img-box .hd .img-title .pro-name{height:50px;line-height:50px;}
    .img-box .hd .img-title .pro-price{height:40px;line-height:40px;}
    .img-box .hd .img-title .pro-num{height:30px;line-height:30px;}
    .pro-view-mod .bd h3{ font-size:20px;}
    .pro-view-mod .bd ul li{font-size:18px;overflow:hidden;text-overflow:ellipsis;height:30px;line-height:30px;}
    .pro-view-mod .bd ul li.cl-1{font-size:20px;}
    .pro-view-mod .bd .pro-view-box .pro-img{width:200px;height:100px;line-height:100px;}
    .pro-view-mod .bd .pro-view-box .pro-img img{max-width:200px;max-height:100px;}
    .img-big-box img{left: 50%;top: 50%;transform: translate(-50%,-50%);-moz-transform:translate(-50%,-50%) ;-webkit-transform:translate(-50%,-50%) ; -o-transform:translate(-50%,-50%) ;-ms-transform: translate(-50%,-50%); max-height: 95%;max-width: 95%;}
    .img-big-box .iconfont{z-index:9999;}
    .pro-view-mod .bd .user-info .pro-img{overflow: hidden;border-radius: 60px;height: 70px;width: 70px;float: left;margin-bottom:10px;}
    .pro-view-mod .bd .user-info .pro-img img{width: 70px; height: 70px;max-width: none;max-height: none;vertical-align: top;}
    .pro-view-mod .bd .user-info  .user-info-cont{float: left;margin-left: 15px;width: 70%;}
    .pro-view-mod .bd .user-info  .user-info-cont p{line-height: 36px;font-size: 16px;}
    </style>
</head>
<body>
<!--head begin-->
<%@ include file="header.jsp" %>
<!--head end-->
<div class="page-view">
    <div class="page-view-body">
        <section class="pro-view-mod img-box">
            <div class="hd">
                <a href="${ctx}/infomation/input?id=${bean.id}&page=prev" class="prev-btn"><i class="icon iconfont">
                    &#xe603;</i></a>
                <div class="img-title">
                    <h2 class="pro-name">${bean.brandName}${bean.modelName}</h2>
                    <input type="hidden" id="id" value="${bean.id}">
                    <p class="pro-price"><fmt:formatNumber value="${bean.price}"
                    									   groupingUsed="false"
                                                           maxFractionDigits="0"/>${bean.priceUnit}</p>
                    <p class="pro-num">汤森信息编号: TS${bean.id}</p>

                </div>
                <a href="${ctx}/infomation/input?id=${bean.id}&page=next" class="next-btn"><i class="icon iconfont">
                    &#xe60b;</i></a>
            </div>
            <div class="bd" id="jImgBox">
                <div class="big-img">
                    <img src="${initParam.imgHost}${firstImg}/oryginalny"  data-index="0"/>
                </div>
                <div class="img-list">
                	<c:forEach items="${listAttch }" var="attach" varStatus="at">
	                	<a href="javascript:;" data-url="${initParam.imgHost}${attach.attchUrl}/oryginalny">
	                        <img src="${initParam.imgHost}${attach.attchUrl}/small" data-index='<c:out value="${at.index}"/>' />
	                    </a>
                	</c:forEach>
                   <!--  <a href="javascript:;" data-url="images/img_1.jpg">
                        <img src="images/img_1.jpg" />
                    </a>
                    <a href="javascript:;" data-url="images/img_2.jpg">
                        <img src="images/img_2.jpg" />
                    </a> -->
                </div>
            </div>
        </section>
        <section class="img-big-box">
            <a href="javascript:;" class="jClose icon iconfont">&#xe606;</a>
            <img src="http://www.tangsons.cn/wap/images/pro-bg.jpg"/>
        </section>
        <section class="page-view-btn">
            <a href="javascript:;" class="ui-button ui-button-blue" style="display:none;">分享</a>
            <a href="javascript:;" class="ui-button ui-button-submit" id="collection">收藏</a>
        </section>
        <section class="pro-set-info pro-view-mod">
            <c:choose>
                <c:when test="${bean.sellType == '0'}">
                    <%@ include file="chushou.jsp" %>
                </c:when>
                <c:when test="${bean.sellType == '1'}">
                    <%@ include file="chuzhu.jsp" %>
                </c:when>
                <c:when test="${bean.sellType == '2'}">
                    <%@ include file="qiugou.jsp" %>
                </c:when>
                <c:when test="${bean.sellType == '3'}">
                    <%@ include file="qiuzhu.jsp" %>
                </c:when>
            </c:choose>
        </section>
        <section class="buy-man-info pro-view-mod">
            <div class="hd">卖家信息</div>
            <div class="bd">
                <c:if test="${empty company||(not empty company && company.status!=1)}">
                    <div class="pro-view-box user-info">
                    <c:choose>
                    <c:when test="${not empty sellUser.headIcon}">
                            <div class="pro-img">
                                <img src="${initParam.imgHost}${sellUser.headIcon}/small"/>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="pro-img" style="">
                            <img src="/wap/images/icon_2.png"/>
                            </div>

                        </c:otherwise>
                    </c:choose>
                    <diiv class="user-info-cont">
                        <h3>${sellUser.realName}</h3>
                        <P>注册时间： <fmt:formatDate value="${sellUser.createTime}" pattern="yyyy/MM/dd"/></P>
                    </diiv>
                        <ul>
                            <li class="w100">电话：<a href="tel:${sellUser.mobile}">${sellUser.mobile}</a></li>
                            <c:if test="${not empty company}">
                                <li class="w100">座机：<a href="tel:${sellUser.telephone}">${sellUser.telephone}</a></li>
                            </c:if>
                            <li class="w100">地址：${sellUser.provinceName }${sellUser.cityName }</li>
                            <li>经营范围:
                                <c:if test="${sellUser.businessScope == '1'}">工程机械</c:if>
                                <c:if test="${sellUser.businessScope == '2'}">农业机械</c:if>
                                <c:if test="${sellUser.businessScope == '3'}">矿山机械</c:if>
                                <c:if test="${sellUser.businessScope == '4'}">林业机械</c:if>
                                <c:if test="${sellUser.businessScope == '5'}">运输机械</c:if>
                            </li>
                            <li>经营性质：
                                <c:if test="${sellUser.businessNature == '1'}">生产商</c:if>
                                <c:if test="${sellUser.businessNature == '2'}">代理商</c:if>
                                <c:if test="${sellUser.businessNature == '3'}">买家</c:if>
                                <c:if test="${sellUser.businessNature == '4'}">卖家</c:if>
                                <c:if test="${sellUser.businessNature == '5'}">买卖贸易</c:if>
                                <c:if test="${sellUser.businessNature == '6'}">中介</c:if>
                                <c:if test="${sellUser.businessNature == '7'}">维修</c:if>
                                <c:if test="${sellUser.businessNature == '8'}">配件商</c:if>
                                <c:if test="${sellUser.businessNature == '9'}">抵押</c:if>
                            </li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${not empty company && company.status==1 }">
                    <div class="pro-view-box">
                        <div class="pro-img">
                            <c:if test="${not empty company.createBy}">
                                <img src="${initParam.imgHost}${company.createBy}/small" class="f-l"  />
                            </c:if>
                        </div>
                        <ul>
                            <li class="w100">所属公司：${company.companyName}</li>
                             <c:if test="${sessionScope.user.id != null}"><li class="w100">联系电话：<a href="tel:${sellUser.mobile}">${sellUser.mobile}</a></li></c:if>
                            <li class="w100">公司地址：${company.address}</li>
                        </ul>
                    </div>
                    <div class="pro-view-box">
                        <h3>公司简介</h3>
                        <div id = "boxCompany">
                        	<p>${company.introduction}
                        </div>
                    </div>
                </c:if>
            </div>
        </section>
         <section class="page-view-btn">
            <a href="javascript:;" class="ui-button ui-button-blue">库存情况(${cnt_sj})</a>          
            <a <c:if test="${sessionScope.user.id != null}"> href="tel:${sellUser.mobile}" </c:if>
            <c:if test="${sessionScope.user.id == null}"> id="linkuser" </c:if>
            class="ui-button ui-button-submit">联系卖家</a>
        </section>

    </div>
</div>

<%@ include file="footer.jsp" %>
<script type="text/javascript" src="${ctx}/wap/js/require.js"></script>
<script type="text/javascript" src="${ctx}/wap/js/app.js"></script>
<script type="text/javascript">
    var ctx = "${ctx}";
    require(['module/view']);
</script>
</body>
</html>
