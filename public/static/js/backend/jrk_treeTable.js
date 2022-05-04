/**
 * Luckhhy
 */
var treeTable = {
    config: {},
    // 当前实例配置
    options: {}
};
(function ($) {
    $.extend({
        // 表格树封装处理
        treeTable: {
            // 初始化表格
            init: function(options) {
                var defaults = {
                    id: "bootstrap-tree-table",
                    type: 1, // 0 代表bootstrapTable 1代表bootstrapTreeTable
                    height: '',
                    queryParams: $.treeTable.queryParams,
                    toolbar: "toolbar",
                    idField: 'id',
                    //在哪一列展开树形
                    treeShowField: 'title',
                    //指定父id列
                    parentIdField: 'pid',
                    formId:'form' //查询表单formID
                };
                var options = $.extend(defaults, options);
                var $table=$('#' + options.id);
                treeTable.options = options;
                treeTable.config = options;
               // treeTable.config.id=options.id;
                $.bttTable = $table.bootstrapTable({
                    idField: options.idField,
                    treeShowField: options.treeShowField,
                    parentIdField: options.parentIdField,
                    type:1,
                    method: 'post',                                             // 请求方式（*）
                    url: options.url,                                   // 请求后台的URL（*）
                    data: options.data,                                 // 无url时用于渲染的数据
                    height: options.height,                             // 表格树的高度
                    toolbar: '#' + options.toolbar,                     // 指定工作栏
                    showRefresh: true,
                    showColumns: true,
                    showToggle: true,
                    showExport: true,
                    columns: options.columns,                           // 显示列信息（*）
                    queryParams: options.queryParams,                   // 传递参数（*）
                    formId:options.formId,
                    onResetView: function(data) {
                        $table.treegrid({
                            initialState: 'collapsed',// 所有节点都折叠
                             //initialState: 'expanded',// 所有节点都展开，默认展开
                            treeColumn: 1,
                            // expanderExpandedClass: 'glyphicon glyphicon-minus',  //图标样式
                            // expanderCollapsedClass: 'glyphicon glyphicon-plus',
                            onChange: function() {
                                $table.bootstrapTable('resetWidth');
                            }
                        });
                        //只展开树形的第一级节点
                        $table.treegrid('getRootNodes').treegrid('expand');
                        // 单击tooltip事件
                        $("#"+treeTable.config.id).on("click", '.tooltip-show', function() {
                            var target = $(this).data('target');
                            var input = $(this).prev();
                            if ($.common.equals("copy", target)) {
                                input.select();
                                document.execCommand("copy");
                                $.models.tips("已复制",this);
                            } else if ($.common.equals("open", target)) {
                                parent.layer.alert(input.val(), {
                                    title: "信息内容",
                                    shadeClose: true,
                                    btn: ['确认'],
                                    btnclass: ['btn btn-primary'],
                                });
                            }
                        });
                        // 浮动提示框特效
                        $(".table [data-toggle='tooltip']").tooltip();
                       //console.log(treeTable.options)
                    },
                    onCheck:function(row){
                        var datas = $table.bootstrapTable('getData');
                        // 勾选子类
                        $.treeTable.selectChilds(datas,row,treeTable.config.idField,treeTable.config.parentIdField,true);
                        // 勾选父类
                      //  $.treeTable.selectParentChecked(datas,row,treeTable.config.idField,treeTable.config.parentIdField)
                        // 刷新数据
                        $table.bootstrapTable('load', datas);
                    },
                    onUncheck:function(row){
                        var datas = $table.bootstrapTable('getData');
                        $.treeTable.selectChilds(datas,row,treeTable.config.idField,treeTable.config.parentIdField,false);
                        $table.bootstrapTable('load', datas);
                    },
                    responseHandler: $.treeTable.responseHandler          // 在加载服务器发送来的数据之前处理函数
                });
            },
            // 查询条件
            queryParams: function(params) {
                var curParams = {
                    // 传递参数查询参数
                    searchValue:    params.search,
                };
                var currentId = $.common.isEmpty(treeTable.options.formId) ? $('form').attr('id') : treeTable.options.formId;
                return $.extend(curParams, $.common.formToJSON(currentId));
            },
            // 搜索-默认第一个form
            searchTree: function(formId, tableId, data) {
                    var currentId = $.common.isEmpty(formId) ? $('form').attr('id') : formId;
                    var params = $.common.isEmpty(tableId) ? $("#" + treeTable.options.id).bootstrapTable('getOptions') : $("#" + tableId).bootstrapTable('getOptions');
                    params.queryParams = function(params) {
                        var search = $.common.formToJSON(currentId);
                        if($.common.isNotEmpty(data)){
                            $.each(data, function(key) {
                                search[key] = data[key];
                            });
                        }
                        search.searchValue = params.search;
                        return search;
                    };

                    if($.common.isNotEmpty(tableId)){
                        $.bttTable.bootstrapTable('refresh', params);
                    } else{
                        $.bttTable.bootstrapTable('refresh', params);
                    }
            },
            //选中父项时，同时选中子项
            selectChilds:function (datas,row,id,pid,checked) {
                for(var i in datas){
                    if(datas[i][pid] == row[id]){
                        datas[i].check=checked;
                        $.treeTable.selectChilds(datas,datas[i],id,pid,checked);
                    };
                }
            },
            selectParentChecked:function(datas,row,id,pid) {
                for (var i in datas) {
                    if (datas[i][id] == row[pid]) {
                        datas[i].check = true;
                        $.treeTable.selectParentChecked(datas, datas[i], id, pid);
                    }
                }
            },
            // 刷新
            refresh: function() {
                $.bttTable.bootstrapTable('refresh');
            },
            //弹窗
            CreateOpenForm:function (title,w,h,url,is_full) {
                title=$.common.isNotEmpty(title)?title:'管理界面';
                w=$.common.isNotEmpty(w)?w:'40%';
                h=$.common.isNotEmpty(h)?h:'60%';
                var full= layer.open({
                    title:title,
                    type: 2,
                    area: [w, h],
                    offset:'auto',
                    maxmin : true,
                    zIndex: 1212,
                    skin:'',
                    shade: 0.5,
                    content: url,
                    end: function () {
                             setTimeout(function(){
                                 $.treeTable.refresh();
                             },500);
                    }
                });
                if ($.common.isNotEmpty(is_full)){
                    layer.full(full); //最大化
                }
            },
            //删除数据
            FormatData:function (ids,URL,msg,load) {
                if($.isArray(ids)) {
                    ids = ids.join(',');
                }
                if ($.common.isEmpty(ids)) {
                    $.models.toastr_error("没选择任何数据");return ;
                }
                var msgs=$.common.isNotEmpty(msg)?msg:"确认删除？";
                layer.confirm(msgs,{ icon: 3, title: "提示", anim: 1}, function(index){
                    layer.close(index);
                    $.ajax({
                        beforeSend:function(){
                            if (load){
                                layer.load(2);
                            }
                        },
                        url: URL,
                        type: "POST",
                        async: true,
                        dataType: "json",
                        data:{
                            ids: ids
                        },
                        error: function(error) {
                            $.models.toastr_error("服务器错误或超时");
                            return false;
                        },
                        success: function(data) {
                            if (data.code==1) {
                                $.models.toastr_success(data.msg,"",function () {
                                    $.treeTable.refresh();
                                });
                            }else{
                                $.models.toastr_error(data.msg,"",function () {
                                    $.treeTable.refresh();
                                });
                            }
                        },
                        complete:function(){
                            if (load){
                                layer.closeAll('loading');
                            }
                        }
                    });
                });
            },
            // 请求获取数据后处理回调函数，校验异常状态提醒
            responseHandler: function(res) {
                if (typeof treeTable.options.responseHandler == "function") {
                    treeTable.options.responseHandler(res);
                }
                if (res.code != undefined && res.code != 0) {
                    $.modal.alertWarning(res.msg);
                    return [];
                } else {
                    return res;
                }
            }
        }

    });
})(jQuery);