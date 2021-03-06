define(['jquery', 'url', 'plug/ajax', 'plug/box', 'plug/validate/validateMethod', 'plug/uploader/uploader-list', 'plug/imgLoading', 'plug/scrollIcon', 'plug/selectPro'], function ($, url, ajax, box, Validator, Uploader, imgLoading, scrollIcon) {
    scrollIcon();

    var oBigGoodsCatagory = $(".bigGoodsCatagory");
    var oMiddleGoodsCatagory = $(".middleGoodsCatagory");
    var oSmallGoodsCatagory = $(".smallGoodsCatagory");

    var oBrand = $(".brand");
    var oModels = $(".models");

    //产品大类
    var getBig = function () {
        $.getJSON(url.listGoodsCatagory, {id: '0'}, function (data) {
            var oBig_html;
            $.each(data.object, function (i, data) {
                oBig_html += "<option value='" + data.id + "'>" + data.catagoryName + "</option>";
            });
            oBigGoodsCatagory.html(oBig_html);
            getMiddle();
        });
    }

    oBigGoodsCatagory.change(function () {
        getMiddle();
    });

    //产品组
    var getMiddle = function () {
        var n = oBigGoodsCatagory.val();
        $.getJSON(url.listGoodsCatagory, {id: n}, function (data) {
            var oMiddle_html;
            $.each(data.object, function (i, data) {
                oMiddle_html += "<option value='" + data.id + "'>" + data.catagoryName + "</option>";
            });
            oMiddleGoodsCatagory.html(oMiddle_html);
            getSmall();
        });
    }

    oMiddleGoodsCatagory.change(function () {
        getSmall();
    });

    //产品类型
    var getSmall = function () {
        var n = oMiddleGoodsCatagory.val();
        $.getJSON(url.listGoodsCatagory, {id: n}, function (data) {
            var oSamll_html;
            $.each(data.object, function (i, data) {
                oSamll_html += "<option value='" + data.id + "'>" + data.catagoryName + "</option>";
            });
            oSmallGoodsCatagory.html(oSamll_html);
            getBrand();
        });
    }

    oSmallGoodsCatagory.change(function () {
        getBrand();
    });

    //品牌
    var getBrand = function () {
        var n = oSmallGoodsCatagory.val();
        $.getJSON(url.listBrand, {catagoryId: n}, function (data) {
            var oBrand_html;
            $.each(data.object, function (i, data) {
                oBrand_html += "<option value='" + data.id + "'>" + data.firstLetter + " " + data.brandName + "</option>";
            });
            oBrand.html(oBrand_html);
            getModels();
        });
    }

    oBrand.change(function () {
        getModels();
    });

    //型号
    var getModels = function () {
        var n = oBrand.val();
        $.getJSON(url.listModels, {brandId: n}, function (data) {
            var oModels_html;
            $.each(data.object, function (i, data) {
                oModels_html += "<option value='" + data.id + "'>" + data.modelsName + "</option>";
            });
            oModels.html(oModels_html);
        });
    }

    //初始化产品大类
    getBig();


    var oRegionProvice = $(".regionProvice");
    var oRegionCity = $(".regionCity");

    //产品大类
    var getProvice = function () {
        $.getJSON(url.listRegion, {id: '0'}, function (data) {
            var oProvice_html;
            $.each(data.object, function (i, data) {
                oProvice_html += "<option value='" + data.id + "'>" + data.regionName + "</option>";
            });
            oRegionProvice.html(oProvice_html);
            getCity();
        });
    }

    oRegionProvice.change(function () {
        getCity();
    });

    //产品组
    var getCity = function () {
        var n = oRegionProvice.val();
        $.getJSON(url.listRegion, {id: n}, function (data) {
            var oCity_html;
            $.each(data.object, function (i, data) {
                oCity_html += "<option value='" + data.id + "'>" + data.regionName + "</option>";
            });
            oRegionCity.html(oCity_html);
        });
    };


    var initPriceUnit = function () {
        var sellType = $('select[name=sellType]').val();
        initPriceUnitOpt(sellType);
    }

    var initPriceUnitOpt = function (sellType) {
        var unitOptHtml = "";
        if (sellType == '0') {	//出售
            unitOptHtml = "<option value='元'>元</option>";
        } else if (sellType == '1') {	//租赁
            unitOptHtml = "<option value='元/天'>元/天</option><option value='元/月'>元/月</option>"
                + "<option value='元/小时'>元/小时</option><option value='元/亩'>元/亩</option>"
                + "<option value='元/吨'>元/吨</option><option value='元/立方'>元/立方</option>"
                + "<option value='元/公里'>元/公里</option>"
        } else if (sellType == '2') {	//求购
            unitOptHtml = "<option value='元左右'>元左右</option>";
        } else if (sellType == '3') {	//求租
            unitOptHtml = "<option value='元/天'>元/天</option><option value='元/月'>元/月</option>"
                + "<option value='元/小时'>元/小时</option><option value='元/亩'>元/亩</option>"
                + "<option value='元/吨'>元/吨</option><option value='元/立方'>元/立方</option>"
                + "<option value='元/公里'>元/公里</option>"
        }
        $("select[name='priceUnitSel']").html(unitOptHtml);
    }

    //初始省市
    getProvice();

    //初始化价格单位
    initPriceUnit();


    var status = 0;
    //信息提交
    Validator.validate('#informationFrom', {
        rules: {
            price: {
                required: true,
                digits: true
            },
            remark: {
                maxlength: 140
            }
        },
        messages: {
            price: {
                required: '价格不能为空',
                digits: '价格必须是整数'
            },
            remark: {
                maxlength: '附言不能大于140个字'
            }

        },
        submitHandler: function (form) {
            $.post(
                url.saveInfo,
                {
                    catagoryBigId: $(form).find('select[name=catagoryBig]').val(),
                    catagoryBigName: $(form).find('select[name=catagoryBig]').find("option:selected").text(),
                    catagoryMidId: $(form).find('select[name=catagoryMid]').val(),
                    catagoryMidName: $(form).find('select[name=catagoryMid]').find("option:selected").text(),
                    catagoryId: $(form).find('select[name=catagorySmall]').val(),
                    catagoryName: $(form).find('select[name=catagorySmall]').find("option:selected").text(),
                    brandId: $(form).find('select[name=brand]').val(),
                    brandName: $(form).find('select[name=brand]').find("option:selected").text().substring(2),
                    modelId: $(form).find('select[name=models]').val(),
                    modelName: $(form).find('select[name=models]').find("option:selected").text(),
                    newBrand: $(form).find('input[name=newBrand]').val(),
                    newModel: $(form).find('input[name=newModels]').val(),
                    sellType: $(form).find('select[name=sellType]').val(),
                    equipmentCondition: $(form).find('select[name=equipmentCondition]').val(),
                    procedures: $(form).find('select[name=procedures]').val(),
                    src: $(form).find('select[name=src]').val(),
                    equipYear: $(form).find('select[name=equipYear]').val(),
                    remark: $(form).find('textarea[name=remark]').val(),
                    provinceId: $(form).find('select[name=regionProvice]').val(),
                    provinceName: $(form).find('select[name=regionProvice]').find("option:selected").text(),
                    cityId: $(form).find('select[name=regionCity]').val(),
                    cityName: $(form).find('select[name=regionCity]').find("option:selected").text(),
                    validTime: $(form).find('select[name=validTime]').find("option:selected").val(),
                    price: $(form).find('input[name=price]').val(),
                    workTime: $(form).find('input[name=workTime]').val(),
                    serialNum: $(form).find('input[name=serialNum]').val(),
                    stockCount: $(form).find('input[name=stockCount]').val(),
                    priceUnit: $(form).find('select[name=priceUnitSel]').val(),
                    imgUrl: array,
                    status: status
                },
                function (data) {
                    var str = JSON.parse(data);
                    submitIng = false;
                    if (str.result) {
                        $('#saving_product').length > 0 ? $('#saving_product').animate({'width': '100%'}, 1000) : box.ok(data.msg);
                        $('#redirecting').length > 0 ? $('#redirecting').text('Redirecting...') : box.ok(data.msg);
                        window.location.href = ctx + url.infoList + "?status=0";

                    } else {
                        box.error(str.message);
                    }

                });
        },
        showError: function (elem, msg) {
            submitIng = false;
            box.error(msg, elem);
        },
        success: null
    });

    var saveSubmit = function () {
        var fixHtml = '<div class="fixed text-align-center white-text" style="position: fixed;top:100%; height: 100%; left:0; height:auto; bottom:0; width:100%; background:rgba(224,80,64,0.95)" id="saving_product_frame">';
        fixHtml += '<h1 style="margin:100px 40px 0; line-height:36px;text-align:center;color: #f0f0f0;" class="white-text" id="redirecting">正在保存...</h1>';
        fixHtml += '<div style="height:8px; background:rgba(17,0,0,0.5); margin:40px ">';
        fixHtml += '<div style="height:8px; background:rgba(17,0,0,0.5); width:0%" id="saving_product"></div></div> ';
        fixHtml += '<div class="font-small" style="text-align:center;font-size: 14px;overflow: hidden;color: #f0f0f0;">设备保存后，我们将尽快审核.</div></div>';
        $('body').append(fixHtml);
        $('#saving_product_frame').animate({'top': '0'}, 500, function () {
            $('#saving_product').animate({'width': '80%'}, 5000);
        });
    };


    var submitIng = false;
    var array = "";
    $("#jSave").click(function () {
        if (submitIng) {
            /* box.error('上传中，不能重复提交！');*/
            saveSubmit();
            return;
        }
        status = 0;
        var modelsId = oModels.val();
        if (modelsId == null || modelsId == "") {
            box.error('型号未选择');
            return;
        }
        var _text = $("input[name^='_UPLOAD_']");
        for (var i = 0; i < _text.length; i++) {
            array += _text[i].value + ",";
        }
        var sellType = $('select[name=sellType]').val();
        if (_text.length < 2 && (sellType == 0 || sellType == 1)) {
            box.error('需要上传3张以上的照片');
            return;
        }
        submitIng = true;
        $('#informationFrom').submit();

    });

    $("#jSubmit").click(function () {
        //alert('提交之前请先保存');
        status = 1;
        if (submitIng) {
            saveSubmit();
            return;
        }
        var _text = $("input[name^='_UPLOAD_']");
        for (var i = 0; i < _text.length; i++) {
            array += _text[i].value + ",";
        }
        submitIng = true;
        $('#informationFrom').submit();
    });


    //图片管理
    var clickHandlers = {
        deleteImgBtn: function (e) {
            clickHandlers.changeInputName($('.ui-button-upload'));
        },
        changeInputName: function ($obj) {
            $.each($obj.find('input[type=hidden]'), function (i) {
                $(this).attr('name', '_UPLOAD_' + i);
            });
        }
    };

    //file uploader buton installations  失败：-1 初始值0 正在上传1 成功2
    var uploadArray = [];
    $('[node-type="uploadButton"]').each(function (i, el) {
        uploadArray[i] = 0;
        var $el = $(el),
            fieldName = $el.data('name');

        /*$el.append(fieldInput);*/

        // initialize file upload component
        var uploader = Uploader(el, {
            endpoint: url.compressUploadUrl
        });


        uploader.on('fileselect', function (e) {
            var html = '<div class="progressbar"><div></div></div>';
            $el.append(html);
            uploadArray[i] = 1;
        });

        uploader.on('uploadprogress', function (e) {
            var percent = Math.min(e.percentLoaded, 99) + '%';
            $el.find('.progressbar div').css('width', percent).text(percent);
        });

        uploader.on('uploadcomplete', function (e) {
            var res = e.data || {}, fieldInput = $('<input type="hidden" />');
            if (res.code == "1") {
                uploadArray[i] = 2;
                fieldInput.val(res.url);
                $el.append(fieldInput);
                clickHandlers.changeInputName($el);
            } else {
                var isFirst = true;
                var timer = setInterval(function () {
                    var eImg = $el.next().find('.up-img-box ').last();
                    if (isFirst && eImg.length > 0) {
                        box.tips(res.msg || '图片上传失败');
                        eImg.remove();
                        isFirst = false;
                        clearInterval(timer);
                    }
                }, 100);
            }
        });
        uploader.on('uploaderror', function (e) {
            uploadArray[i] = -1;
            box.tips('图片上传失败!');
        });

    });


    for (var k in clickHandlers) {
        var handle = clickHandlers[k];
        var key = "[node-type=" + k + "]";
        if (handle) {
            $("body").on("click", key, handle);
        }
    }

    $('body').on('click', '.jAddProType', function () {
        if ($(this).hasClass('open')) {
            $('.desc-child').addClass('isHide');
            $(this).removeClass('open');
        } else {
            $('.desc-child').removeClass('isHide');
            $(this).addClass('open');
        }
    });


    //计算有效期时间
    var GetDateStr = function (AddDayCount) {
        var dd = new Date();
        dd.setDate(dd.getDate() + parseInt(AddDayCount));//获取AddDayCount天后的日期
        var y = dd.getFullYear();
        var m = (dd.getMonth() + 1) < 10 ? "0" + (dd.getMonth() + 1) : (dd.getMonth() + 1);//获取当前月份的日期，不足10补0
        var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate(); //获取当前几号，不足10补0
        return y + "年" + m + "月" + d + "日";
    };
    var $date = $('.jDate'), $select = $('select[name=validTime]');
    if ($select.length) {
        $date.html(GetDateStr($select.val()));
    }
    ;
    $('body').on('change', 'select[name=validTime]', function () {
        var val = $(this).val();
        $date.html(GetDateStr(val));

    });

    //根据不同的销售方式，确定价格的单位
    $('body').on('change', 'select[name=sellType]', function () {
        var val = $(this).val();
        initPriceUnitOpt(val);
    });


})
;