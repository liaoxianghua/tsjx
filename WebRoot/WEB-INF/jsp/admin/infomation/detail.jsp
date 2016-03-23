<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext['request'].contextPath}"/>
<style type="text/css">
    h3 {
        border-bottom: 1px solid #ddd;
        padding: 8px 0;
    }

    .tab-head {
        width: 15%;
    }

    .tab-content-head {
        width: 35%;
    }
</style>

<div class="line">
    <h3 class="clearfix">发布信息详细
<span class="pull-left">(
<c:if test="${bean.status=='0'}"><span>草稿</span>
</c:if>
    <c:if test="${bean.status=='1'}"><span>待审核</span></c:if>
    <c:if test="${bean.status=='2'}"><span>发布</span></c:if>
    <c:if test="${bean.status=='3'}"><span>下架</span></c:if>
    <c:if test="${bean.status=='4'}"><span>已售</span></c:if>
)
</span>
        <span class="pull-right">
    <c:if test="${bean.sellType=='0'}"><span>出售</span></c:if>
    <c:if test="${bean.sellType=='1'}"><span>租赁</span></c:if>
    <c:if test="${bean.sellType=='2'}"><span>求购</span></c:if>
    <c:if test="${bean.sellType=='3'}"><span>求租</span></c:if>

</span>
        <c:if test="${bean.status=='1'}"><br/>
            <div class="btn-group btn-large">
                <button class="btn btn-primary  " ng-click="openModel(1)">通过</button>
                <button class="btn btn-primary " ng-click="openModel(2)">不通过</button>
            </div>
        </c:if>
    </h3>
</div>
<table class="table table-bordered">
    <tbody>
    <tr>
        <td class="tab-head">产品大类</td>
        <td class="tab-content-head" ng-model="company">${bean.catagoryBigName}</td>
        <td class="tab-head">产品组</td>
        <td>${bean.catagoryMidName}</td>
        <td class="tab-head">产品类</td>
        <td>${bean.catagoryName}</td>
    </tr>
    <tr>
        <td class="tab-head">品牌</td>
        <td class="tab-content-head" >${bean.brandName}</td>
        <td class="tab-head">型号</td>
        <td class="tab-content-head">${bean.modelName}</td>
        <td class="tab-head">用户自定义新增</td>
        <td>${bean.isNew}</td>
    </tr>
    </tbody>
</table>

<div class="line">
    <h3 class="clearfix">设备信息
    </h3>
</div>
<table class="table table-bordered">
    <tbody>
    <tr>
        <td class="tab-head">设备情况</td>
        <td class="tab-content-head" ng-model="company">${bean.equipmentCondition}</td>
        <td class="tab-head">手续资料</td>
        <td>${bean.procedures}</td>
        <td class="tab-head">设备来源</td>
        <td>${bean.src}</td>
    </tr>
    <tr>
        <td class="tab-head">设备年费</td>
        <td class="tab-content-head" >${bean.equipYear}</td>
        <td class="tab-head">工时</td>
        <td class="tab-content-head">${bean.workTime}</td>
        <td class="tab-head">价格</td>
        <td>${bean.price}</td>
    </tr>
    <tr>
        <td class="tab-head">设备序列号</td>
        <td class="tab-content-head" >${bean.serialNum}</td>
        <td class="tab-head">内部库存编码</td>
        <td class="tab-content-head">${bean.inStockCode}</td>
        <td class="tab-head">设备位置</td>
        <td class="tab-content-head">${bean.equipmentLocation}</td>
    </tr>
    <td class="tab-head">发布日期</td>
    <td class="tab-content-head" >${bean.pubTime}</td>
    <td class="tab-head">到期日期</td>
    <td class="tab-content-head">${bean.validTime}</td>
    <td class="tab-head">库存数量</td>
    <td class="tab-content-head">${bean.stockCount}</td>
    </tr>
    <tr>
        <td class="tab-head">设备序列号</td>
        <td class="tab-content-head" colspan="3">${bean.sellCount}</td>
        <td class="tab-head">是否推荐</td>
        <td class="tab-content-head">${bean.isTop}</td>
    </tr>
    </tbody>
</table>

<div class="line">
    <h3 class="clearfix">卖家附言</h3>
    <br/>
    <span class="pull-left">
        ${bean.remark}
    </span>
</div>

<c:if test="${bean.status!=null&&bean.status!=0}">
    <div>
        <h3 class="clearfix">审核记录</h3>
        <div class="col-md-12">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th class="tab-head">修改时间</th>
                    <th class="tab-head">修改人员</th>
                    <th class="tab-head">审核备注</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td ng-bind="log.dateValue | date : 'yyyy-MM-dd HH:mm:ss'"></td>
                    <td ng-bind="log.operator"></td>
                    <td ng-bind="switchReason(log.rejectCode)"></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</c:if>

<div>
    <h3 class="clearfix">信息图片</h3><br/>
    <c:forEach var="img" items="${beanImg}">
        <img src="${img.attchUrl}" style="max-width: 100%;"
             alt="">
    </c:forEach>
</div>

<%--<div>--%>
<%--<a class="btn btn-primary pull-left" ng-click="openModel(1)">通过</a>--%>
<%--<a class="btn btn-primary pull-left" ng-click="openModel(2)">不通过</a>--%>
<%--</div>--%>
<script>
    angular.companyId = "${bean.id}";
    angular.companyName = "${bean.id}";
    seajs.use(['js/controller/common/app', 'js/controller/infomation/detail'], function () {
        angular.bootstrap(document, ['App']);
    });
</script>

<script type="text/ng-template" id="selectModalTemplate.html">
    <div style="padding-left: 10px; padding-top: 3px">
        <h3>选择理由</h3>
    </div>
    <div>
        <form style="margin-bottom: 10px; padding-left: 10px;" ng-controller="selectCtrl">
            <div ng-repeat="unLockReason in unLockReasons">
                <label class="radio-inline">
                    <input type="radio" name="radio" ng-click="setReason(unLockReason)" ng-modal="unLockReason.value">{{unLockReason.reason}}
                </label>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" ng-click="unLock()">确定</button>
                <button type="button" class="btn btn-primary" ng-click="closeModal()">关闭</button>
            </div>
        </form>
    </div>

</script>