<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
cn.com.tsjx.infomation.entity.Infomation infomation = (cn.com.tsjx.infomation.entity.Infomation)request.getAttribute("info");
String _brandName = infomation.getBrandName();
String _modelName = infomation.getModelName();
%>
<c:set var="ctx" value="${pageContext['request'].contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>汤森机械网-草稿箱</title>
    <%@ include file = "meta.jsp" %>
    <link rel="stylesheet" href=${ctx}/wap/css/module/want.css?v=1" type="text/css" charset="utf-8">
</head>
<body>
<!--head begin-->
<%@ include file="header.jsp" %>
<!--head end-->
<div class="page-view">
    <div class="page-view-body">
        <section class="mod-info">
            <div class="hd">
                <h3 class="title">${statusMc }</h3>
                <input type="hidden" id="curStatus" value="${status }">
            </div>
            <div class="bd">
                <a class="bd-l" href="${ctx }/infomation/infoList/my?status=2" status="2">
                    <span class="num">${cnt_sj }</span>
                    <span class="num-desc">上架</span>
                </a>
                <a class="bd-m" href="${ctx }/infomation/infoList/my?status=3" status="3">
                    <span class="num">${cnt_ys }</span>
                    <span class="num-desc">已售</span>
                </a>
                <a class="bd-m" href="${ctx }/infomation/infoList/my?status=4" status="4">
                    <span class="num">${cnt_xj }</span>
                    <span class="num-desc">下架</span>
                </a>
                <a class="bd-r" href="${ctx }/infomation/infoList/my?status=0" status="4">
                    <span class="num">${cnt_cg }</span>
                    <span class="num-desc">草稿</span>
                </a>
                <a href="${ctx }/infomation/colleInfoList/my?status=9" status="9">
                    <span class="num">${cnt_sc }</span>
                    <span class="num-desc">收藏</span>
                </a>
            </div>
        </section>
        <section class="mod-want-buy">
            <form class="ui-form" id="informationFrom">
                <input type="hidden" id="id" name="id" value="${info.id}">
                <c:if test="${info.sellType == '0' || info.sellType == '1'}">
	                <div class="ui-form-title"><img src="${ctx}/wap/images/photo_icon.png"/> 上传图片</div>
                	<div class="ui-form-mod upload-img">
                    <a href="javascript:;" node-type="uploadButton">
                        <div class="img-sp" >
                            <img src="${ctx}/wap/images/camera_load_icon.png" />
                            <span>照片</span>
                        </div>
                        <div class="img-sp">
                            <img src="${ctx}/wap/images/image_load_icon.png" />
                            <span>上传图片</span>
                        </div>
                        <c:forEach items="${attches}" var="attches" varStatus="status">
                            <div class="progressbar"><div style="width: 99%;">99%</div></div>
                            <input type="hidden" value="${attches.attchUrl}" name="_UPLOAD_${status.index}">
                        </c:forEach>
                    </a>
                        <div class="up-img-list">
                            <c:forEach items="${attches}" var="attches">
                                <div class="up-img-box file-uploaded">
                                    <img src="${initParam.imgHost}${attches.attchUrl}/figure">
                                    <b class="icon-delete" node-type="deleteImgBtn"></b>
                                </div>
                            </c:forEach>
                        </div>
                </div>
                </c:if>
                <div class="ui-form-title">选择产品类别</div>
                <input type="hidden" id="_bigCataId" value="${info.catagoryBigId }">
                <input type="hidden" id="_midCataId" value="${info.catagoryMidId }">
                <input type="hidden" id="_CataId" value="${info.catagoryId }">
                <input type="hidden" id="_brandId" value="${info.brandId }">
                <input type="hidden" id="_modelId" value="${info.modelId }">
                <div class="ui-form-mod">
                    <div class="ui-form-bd more-select">
                        <select class="bigGoodsCatagory"  name="catagoryBig" id="catagoryBig" validate="required:true" ><option>请选择产品大类</option></select>
                        <select class="middleGoodsCatagory" name="catagoryMid" id="catagoryMid" validate="required:true"><option>请选择产品子类</option></select>
                        <select class="smallGoodsCatagory" name="catagorySmall" id="catagorySmall" validate="required:true"><option>请选择产品</option></select>
                    </div>
                </div>
                <div class="ui-form-title">选择品牌和 & 型号</div>
                <div class="ui-form-mod">
                    <label class="ui-form-hd">品牌和 & 型号</label>
                    <div class="ui-form-bd more-select">
                        <select class="brand" name="brand" id="brand" validate="required:true"><option>请选择品牌</option></select>
                        <select class="models"  name="models" id="models" validate="required:true"><option>请选择型号</option></select>
                    </div>
                </div>
                <div class="ui-form-mod desc">
                    <p class="ui-form-hd ">注:如找不到品牌和型号请点击<img class="jAddProType" src="${ctx}/wap/images/increa_icon.png" /><em>*</em></p>

                </div>
                <div class="ui-form-mod isHide desc-child">
                    <label class="ui-form-hd">添加品牌</label>
                    <div class="ui-form-bd">
                        <input type="text" name="newBrand" value="${info.brandName}" placeholder="请输入...">
                    </div>
                </div>
                <div class="ui-form-mod isHide desc-child">
                    <label class="ui-form-hd">添加型号</label>
                    <div class="ui-form-bd">
                        <input type="text" name="newModels" value="${info.modelName}" placeholder="请输入...">
                    </div>
                </div>
                <div class="ui-form-title">设备详情</div>
                <div class="ui-form-mod">
                    <label class="ui-form-hd">求购方式</label>
                    <div class="ui-form-bd">
                    	<input type="hidden" name="sellType" id="sellType" value="${info.sellType}"/>
                        <select name="sellTypeSel" onchange="sellType.value=this.value">
                        	<c:choose>
                        		<c:when test="${info.sellType == '0' || info.sellType == '1'}">
                        			<option value="0">出售</option>
	                        		<option value="1">租赁</option>
                        		</c:when>
                        		<c:otherwise>
	                        		<option value="2">求购</option>
	                        		<option value="3">求租</option>
                        		</c:otherwise>
                        	</c:choose>
                        </select>
                    </div>
                </div>
                <div class="ui-form-mod">
                    <label class="ui-form-hd">设备情况</label>
                    <div class="ui-form-bd">
                    	<input type="hidden" name="equipmentCondition" id="equipmentCondition" value="${info.equipmentCondition}"/>
                        <select name="equipmentConditionSel" onchange="equipmentCondition.value=this.value">
                            <option value="0">全新</option>
                            <option value="1">二手</option>
                            <option value="2">再制造</option>
                            <option value="3">库存</option>
                        </select>
                    </div>
                </div>
                <%-- <div class="ui-form-mod">
                    <label class="ui-form-hd">手续资料</label>
                    <div class="ui-form-bd">
                    	<input type="hidden" name="procedures" id="procedures" value="${info.procedures}"/>
                        <select name="proceduresSel"  onchange="procedures.value=this.value">
                            <option value="0">手续齐全</option>
                            <option value="1">无手续</option>
                            <option value="2">有无手续均可</option>
                        </select>
                    </div>
                </div>
                <div class="ui-form-mod">
                    <label class="ui-form-hd">设备来源</label>
                    <div class="ui-form-bd">
                    	<input type="hidden" name="src" id="src" value="${info.src}"/>
                        <select name="srcSel">
                            <option value="0">个人</option>
                            <option value="1">单位</option>
                            <option value="2">抵押</option>
                            <option value="3">法务</option>
                        </select>
                    </div>
                </div> --%>
                <div class="ui-form-mod">
                    <label class="ui-form-hd">年份</label>
                    <div class="ui-form-bd">
                    	<input type="hidden" name="equipYear" id="equipYear" value="${info.equipYear}"/>
                        <select name="equipYearSel">
                        	<option value="2016">2016</option>
                            <option value="2015">2015</option>
                            <option value="2014">2014</option>
                            <option value="2013">2013</option>
                            <option value="2012">2012</option>
                            <option value="2011">2011</option>
                            <option value="2010">2010</option>
                            <option value="2009">2009</option>
                            <option value="2008">2008</option>
                            <option value="2007">2007</option>
                        </select>
                    </div>
                </div>
                <div class="ui-form-mod">
                    <label class="ui-form-hd">工时</label>
                    <div class="ui-form-bd">
                        <input type="text"   name="workTime" id="workTime"  value="${info.workTime }" placeholder="请输入...">
                    </div>
                </div>
                <c:if test="${info.sellType == '0' || info.sellType == '1'}">
                <div class="ui-form-mod">
                    <label class="ui-form-hd">出厂编码</label>
                    <div class="ui-form-bd">
                        <input type="text"   name="serialNum" id="serialNum"   placeholder="请输入..." value="${info.serialNum }">
                    </div>
                </div> 
                </c:if>
                <div class="ui-form-mod">
                    <label class="ui-form-hd">价格</label>
                    <div class="ui-form-bd">
                        <input type="text"   name="price" id="price"  value="${info.price }" placeholder="请输入...">
                    </div>
                </div>
                <div class="ui-form-mod">
                    <label class="ui-form-hd">单位</label>
                    <input type="hidden" name="priceUnit" value="${info.priceUnit }">
                    <div class="ui-form-bd">
                         <select name="priceUnitSel">
                         <option value="元">元</option>
                     </select>
                    </div>
                </div>
                <c:if test="${ info.sellType == '0' || info.sellType == '1'}">
	                <div class="ui-form-mod">
	                    <label class="ui-form-hd">库存数量</label>
	                    <div class="ui-form-bd">
	                        <input type="text" name="stockCount" id="stockCount" value="${info.stockCount }"  placeholder="请输入...">
	                    </div>
	                </div>
                </c:if>
                <c:choose>
               		<c:when test="${info.sellType == '0' || info.sellType == '1'}">
               			<div class="ui-form-title">卖家附言</div>
               		</c:when>
               		<c:otherwise>
                		<div class="ui-form-title">买家附言</div>
               		</c:otherwise>
               	</c:choose>
                
                <div class="ui-form-mod">
                    <label class="ui-form-hd">附言</label>
                    <div class="ui-form-bd">
                        <textarea placeholder="请输入..."   name="remark" id="remark" maxlength="140">${info.remark }</textarea>
                    </div>
                </div>
                <div class="ui-form-title"><i class="icon iconfont">&#xe60e;</i>设备地址</div>
                <input type="hidden" name="equipmentLocation" id="equipmentLocation" value="${info.equipmentLocation}" />
                <div class="ui-form-mod">
                    <label class="ui-form-hd">省份</label>
                    <div class="ui-form-bd">
                        <select class="regionProvice"  name="regionProvice" id="regionProvice" validate="required:true" ><option>请选择省份</option></select>
                	</div>
                	<label class="ui-form-hd">城市</label>
	                <div class="ui-form-bd">
	                    <select class="regionCity"  name="regionCity" id="regionCity" validate="required:true" ><option>请选择城市</option></select>                    </div>
	                    </div>
                	<div class="ui-form-title"><i class="icon iconfont">&#xe60d;</i>上传有效期</div>
                	<div class="ui-form-mod">
	                    <div class="ui-form-bd">
	                    	<input type="hidden" name="validTime" id="validTime" value="${info.validTime }">
	                        <select id="validTimeSel" name="validTimeSel" onchange="validTime.value=this.value;">
	                            <option value="30">30天</option>
	                            <option value="60">60天</option>
	                            <option value="90">90天</option>
	                        </select>
	                       <!--  <input type="text" name="validTime" placeholder="请输入..." /> -->
	                    </div>
<!--                     <div class="ui-form-ft">此信息有效期截止至:2016年5月30日</div> -->
                </div>
                <div class="field-submit">
                    <a href="javascript:;" class="ui-button ui-button-blue" id="jSave">保存</a>
                    <a href="javascript:;" class="ui-button ui-button-submit" id="jSubmit">提交</a>
                </div>
            </form>
        </section>
    </div>
</div>
<%@ include file="footer.jsp" %>
<script type="text/javascript" src="${ctx}/wap/js/require.js"></script>
<script type="text/javascript" src="${ctx}/wap/js/app.js"></script>
<script type="text/javascript">
    var ctx = "${ctx}";
    var isNew="${info.isNew}"
    require(['module/editInfo']);
</script>
</body></html>
