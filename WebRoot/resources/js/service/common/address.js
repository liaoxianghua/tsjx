define(function (require) {
    // 关于地址的信息都在这里
    // 获取省份列表
    // 根据省份获取城市列表
    // 根据城市获取区，县列表

    angular.module('App')
        .service('address', ['$http',
            function ($http) {

                this.getCatagoryList = function (cid) {
                    var catagory = {};
                    $http.get(angular.path + '/catagory/listCatagory?id=' + cid)
                        .success(function (resp) {
                            if (resp.object instanceof Array) {
                                angular.forEach(resp.object, function (p) {
                                    catagory[p.id] = p.catagoryName;
                                });
                            }
                        })
                        .error(function () {
                            alert('获取产品列表失败');
                        });
                    return catagory;
                };

                this.getBrandList = function (cid) {
                    var brand = {};
                    if(undefined==cid){
                        return brand;
                    }
                    $http.get(angular.path + '/brand/listBrand?catagoryId=' + cid)
                        .success(function (resp) {
                            if (resp.object instanceof Array) {
                                angular.forEach(resp.object, function (p) {
                                    brand[p.id] = p.brandName;
                                });
                            }
                        })
                        .error(function () {
                            alert('获取品牌列表失败');
                        });
                    return brand;
                };

                this.getModelList = function (bid) {
                    var model = {};
                    if(undefined==bid){
                        return model;
                    }
                    $http.get(angular.path + '/models/listModels?brandId=' + bid)
                        .success(function (resp) {
                            if (resp.object instanceof Array) {
                                angular.forEach(resp.object, function (p) {
                                    model[p.id] = p.modelsName;
                                });
                            }
                        })
                        .error(function () {
                            alert('获取型号列表失败');
                        });
                    return model;
                };

                var provinces, citys = {}, districts = {};

                this.getProvinceList = function () {
                    if (!provinces) {
                        provinces = {};
                        $http.get(angular.path + '/region/listRegion?id=0')
                            .success(function (resp) {
                                if (resp.object instanceof Array) {
                                    angular.forEach(resp.object, function (p) {
                                        provinces[p.id] = p.regionName;
                                    });
                                }
                            })
                            .error(function () {
                                alert('获取省份列表出错');
                            });
                    }

                    return provinces;

                };

                this.getCitysByPid = function (pid) {
                    if (!pid) {
                        return false;
                    }
                    if (!citys[pid]) {
                        citys[pid] = {};
                        $http.get(angular.path + '/region/listRegion?id=' + pid)
                            .success(function (resp) {
                                if (resp.object instanceof Array) {
                                    angular.forEach(resp.object, function (c) {
                                        citys[pid][c.id] = c.regionName;
                                    });
                                }
                            })
                            .error(function () {
                                alert('获取城市列表出错');
                            });
                    }

                    return citys[pid];
                };

                this.getDistrictsByCid = function (cid) {
                    if (!cid || cid == "null") {
                        return false;
                    }
                    if (!districts[cid]) {
                        districts[cid] = {};
                        $http.get(angular.path + '/common/get/address/getdistricts?cityId=' + cid)
                            .success(function (resp) {
                                if (resp instanceof Array) {
                                    angular.forEach(resp, function (d) {
                                        districts[cid][d.id] = d.name;
                                    });
                                }
                            })
                            .error(function () {
                                alert('获取区域列表出错');
                            });
                    }

                    return districts[cid];

                };

            }
        ]);

});