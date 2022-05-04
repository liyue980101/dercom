
(function($) {
    "use strict";

    $.fn.bootstrapTreeTable = function(options, param) {
        var target = $(this).data('bootstrap.tree.table');
        target = target ? target : $(this);
        // 濡傛灉鏄皟鐢ㄦ柟娉�
        if (typeof options == 'string') {
            return $.fn.bootstrapTreeTable.methods[options](target, param);
        }
        // 濡傛灉鏄垵濮嬪寲缁勪欢
        options = $.extend({}, $.fn.bootstrapTreeTable.defaults, options || {});
        target.hasSelectItem = false;// 鏄惁鏈塺adio鎴朿heckbox
        target.data_list = null; //鐢ㄤ簬缂撳瓨鏍煎紡鍖栧悗鐨勬暟鎹�-鎸夌埗鍒嗙粍
        target.data_obj = null; //鐢ㄤ簬缂撳瓨鏍煎紡鍖栧悗鐨勬暟鎹�-鎸塱d瀛樺璞�
        target.hiddenColumns = []; //鐢ㄤ簬瀛樻斁琚殣钘忓垪鐨刦ield
        target.lastAjaxParams; //鐢ㄦ埛鏈€鍚庝竴娆¤姹傜殑鍙傛暟
        target.isFixWidth=false; //鏄惁鏈夊浐瀹氬搴�
        // 鍒濆鍖�
        var init = function() {
            // 鍒濆鍖栧鍣�
            initContainer();
            // 鍒濆鍖栧伐鍏锋爮
            initToolbar();
            // 鍒濆鍖栬〃澶�
            initHeader();
            // 鍒濆鍖栬〃浣�
            initBody();
            // 鍒濆鍖栨暟鎹湇鍔�
            initServer();
            // 鍔ㄦ€佽缃〃澶村搴�
            autoTheadWidth(true);
            // 缂撳瓨target瀵硅薄
            target.data('bootstrap.tree.table', target);
        }
        // 鍒濆鍖栧鍣�
        var initContainer = function() {
            // 鍦ㄥ灞傚寘瑁呬竴涓媎iv锛屾牱寮忕敤鐨刡ootstrap-table鐨�
            var $main_div = $("<div class='bootstrap-tree-table'></div>");
            var $treetable = $("<div class='treetable-table'></div>");
            target.before($main_div);
            $main_div.append($treetable);
            $treetable.append(target);
            target.addClass("table");
            if (options.striped) {
                target.addClass('table-striped');
            }
            if (options.bordered) {
                target.addClass('table-bordered');
            }
            if (options.hover) {
                target.addClass('table-hover');
            }
            if (options.condensed) {
                target.addClass('table-condensed');
            }
            target.html("");
        }
        // 鍒濆鍖栧伐鍏锋爮
        var initToolbar = function() {
            var $toolbar = $("<div class='treetable-bars'></div>");
            if (options.toolbar) {
                $(options.toolbar).addClass('tool-left');
                $toolbar.append($(options.toolbar));
            }
            var $rightToolbar = $('<div class="btn-group tool-right">');
            $toolbar.append($rightToolbar);
            target.parent().before($toolbar);
            // ruoyi 鏄惁鏄剧ず妫€绱俊鎭�
            if (options.showSearch) {
                var $searchBtn = $('<button class="btn btn-default btn-outline" type="button" aria-label="search" title="鎼滅储"><i class="glyphicon glyphicon-search"></i></button>');
                $rightToolbar.append($searchBtn);
                registerSearchBtnClickEvent($searchBtn);
            }
            // 鏄惁鏄剧ず鍒锋柊鎸夐挳
            if (options.showRefresh) {
                var $refreshBtn = $('<button class="btn btn-default btn-outline" type="button" aria-label="refresh" title="鍒锋柊"><i class="glyphicon glyphicon-repeat"></i></button>');
                $rightToolbar.append($refreshBtn);
                registerRefreshBtnClickEvent($refreshBtn);
            }
            // 鏄惁鏄剧ず鍒楅€夐」
            if (options.showColumns) {
                var $columns_div = $('<div class="btn-group pull-right" title="鍒�"><button type="button" aria-label="columns" class="btn btn-default btn-outline dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="glyphicon glyphicon-list"></i> <span class="caret"></span></button></div>');
                var $columns_ul = $('<ul class="dropdown-menu columns" role="menu"></ul>');
                $.each(options.columns, function(i, column) {
                    if (column.field != 'selectItem') {
                        var _li = null;
                        if(typeof column.visible == "undefined"||column.visible==true){
                            _li = $('<li role="menuitem"><label><input type="checkbox" checked="checked" data-field="'+column.field+'" value="'+column.field+'" > '+column.title+'</label></li>');
                        }else{
                            _li = $('<li role="menuitem"><label><input type="checkbox" data-field="'+column.field+'" value="'+column.field+'" > '+column.title+'</label></li>');
                            target.hiddenColumns.push(column.field);
                        }
                        $columns_ul.append(_li);
                    }
                });
                $columns_div.append($columns_ul);
                $rightToolbar.append($columns_div);
                // 娉ㄥ唽鍒楅€夐」浜嬩欢
                registerColumnClickEvent();
            }else{
                $.each(options.columns, function(i, column) {
                    if (column.field != 'selectItem') {
                        if(!(typeof column.visible == "undefined"||column.visible==true)){
                            target.hiddenColumns.push(column.field);
                        }
                    }
                });
            }
        }
        // 鍒濆鍖栭殣钘忓垪
        var initHiddenColumns = function(){
            $.each(target.hiddenColumns, function(i, field) {
                target.find("."+field+"_cls").hide();
            });
        }
        // 鍒濆鍖栬〃澶�
        var initHeader = function() {
            var $thr = $('<tr></tr>');
            $.each(options.columns, function(i, column) {
                var $th = null;
                // 鍒ゆ柇鏈夋病鏈夐€夋嫨鍒�
                if (i == 0 && column.field == 'selectItem') {
                    target.hasSelectItem = true;
                    $th = $('<th style="width:36px"></th>');
                } else {
                    $th = $('<th style="' + ((column.width) ? ('width:' + column.width) : '') + '" class="' + column.field + '_cls"></th>');
                }
                if((!target.isFixWidth)&& column.width){
                    target.isFixWidth = column.width.indexOf("px")>-1?true:false;
                }
                $th.text(column.title);
                $thr.append($th);
            });
            var $thead = $('<thead class="treetable-thead"></thead>');
            $thead.append($thr);
            target.append($thead);
        }
        // 鍒濆鍖栬〃浣�
        var initBody = function() {
            var $tbody = $('<tbody class="treetable-tbody"></tbody>');
            target.append($tbody);
            // 榛樿楂樺害
            if (options.height) {
                $tbody.css("height", options.height);
            }
        }
        // 鍒濆鍖栨暟鎹湇鍔�
        var initServer = function(parms) {
            // 鍔犺浇鏁版嵁鍓嶅厛娓呯┖
            target.data_list = {};
            target.data_obj = {};
            var $tbody = target.find("tbody");
            // 娣诲姞鍔犺浇loading
            var $loading = '<tr><td colspan="' + options.columns.length + '"><div style="display: block;text-align: center;">姝ｅ湪鍔姏鍦板姞杞芥暟鎹腑锛岃绋嶅€欌€︹€�</div></td></tr>'
            $tbody.html($loading);
            if (options.url) {
                $.ajax({
                    type: options.type,
                    url: options.url,
                    data: parms ? parms : options.ajaxParams,
                    dataType: "JSON",
                    success: function(data, textStatus, jqXHR) {
                        data = calculateObjectValue(options, options.responseHandler, [data], data);
                        renderTable(data);
                        calculateObjectValue(options, options.onLoadSuccess, [data], data);
                    },
                    error: function(xhr, textStatus) {
                        var _errorMsg = '<tr><td colspan="' + options.columns.length + '"><div style="display: block;text-align: center;">' + xhr.responseText + '</div></td></tr>'
                        $tbody.html(_errorMsg);
                    },
                });
            } else {
                renderTable(options.data);
            }
        }
        // 鍔犺浇瀹屾暟鎹悗娓叉煋琛ㄦ牸
        var renderTable = function(data) {
            var $tbody = target.find("tbody");
            // 鍏堟竻绌�
            $tbody.html("");
            if (!data || data.length <= 0) {
                var _empty = '<tr><td colspan="' + options.columns.length + '"><div style="display: block;text-align: center;">娌℃湁鎵惧埌鍖归厤鐨勮褰�</div></td></tr>'
                $tbody.html(_empty);
                return;
            }
            // 缂撳瓨骞舵牸寮忓寲鏁版嵁
            formatData(data);
            // 鑾峰彇鎵€鏈夋牴鑺傜偣
            var rootNode = target.data_list["_root_"];
            // 寮€濮嬬粯鍒�
            if (rootNode) {
                $.each(rootNode, function(i, item) {
                    var _child_row_id = "row_id_" + i
                    recursionNode(item, 1, _child_row_id, "row_root");
                });
            }
            // 涓嬭竟鐨勬搷浣滀富瑕佹槸涓轰簡鏌ヨ鏃惰涓€浜涙病鏈夋牴鑺傜偣鐨勮妭鐐规樉绀�
            $.each(data, function(i, item) {
                if (!item.isShow) {
                    var tr = renderRow(item, false, 1, "", "");
                    $tbody.append(tr);
                }
            });
            target.append($tbody);
            registerExpanderEvent();
            registerRowClickEvent();
            initHiddenColumns();
            // 鍔ㄦ€佽缃〃澶村搴�
            autoTheadWidth()
        }
        // 鍔ㄦ€佽缃〃澶村搴�
        var autoTheadWidth = function(initFlag) {
            if(options.height>0){
                var $thead = target.find("thead");
                var $tbody = target.find("tbody");
                var borderWidth = parseInt(target.css("border-left-width")) + parseInt(target.css("border-right-width"))

                $thead.css("width", $tbody.children(":first").width());
                if(initFlag){
                    var resizeWaiter = false;
                    $(window).resize(function() {
                        if(!resizeWaiter){
                            resizeWaiter = true;
                            setTimeout(function(){
                                if(!target.isFixWidth){
                                    $tbody.css("width", target.parent().width()-borderWidth);
                                }
                                $thead.css("width", $tbody.children(":first").width());
                                resizeWaiter = false;
                            }, 300);
                        }
                    });
                }
            }

        }
        // 缂撳瓨骞舵牸寮忓寲鏁版嵁
        var formatData = function(data) {
            var _root = options.rootIdValue ? options.rootIdValue : null;
            // 鐖惰妭鐐瑰睘鎬у垪琛�
            var parentCodes = [];
            var rootFlag = false;
            $.each(data, function(index, item) {
                if($.inArray(item[options.parentCode], parentCodes) == -1){
                    parentCodes.push(item[options.parentCode]);
                }
            });
            $.each(data, function(index, item) {
                // 娣诲姞涓€涓粯璁ゅ睘鎬э紝鐢ㄦ潵鍒ゆ柇褰撳墠鑺傜偣鏈夋病鏈夎鏄剧ず
                item.isShow = false;
                // 椤剁骇鑺傜偣鏍￠獙鍒ゆ柇锛屽吋瀹�0,'0','',null
                var _defaultRootFlag = item[options.parentCode] == '0' ||
                    item[options.parentCode] == 0 ||
                    item[options.parentCode] == null ||
                    item[options.parentCode] == '' ||
                    $.inArray(item[options.code], parentCodes) > 0 && !rootFlag;
                if (!item[options.parentCode] || (_root ? (item[options.parentCode] == options.rootIdValue) : _defaultRootFlag)) {
                    rootFlag = true;
                    if (!target.data_list["_root_"]) {
                        target.data_list["_root_"] = [];
                    }
                    if (!target.data_obj["id_" + item[options.code]]) {
                        target.data_list["_root_"].push(item);
                    }
                } else {
                    if (!target.data_list["_n_" + item[options.parentCode]]) {
                        target.data_list["_n_" + item[options.parentCode]] = [];
                    }
                    if (!target.data_obj["id_" + item[options.code]]) {
                        target.data_list["_n_" + item[options.parentCode]].push(item);
                    }
                }
                target.data_obj["id_" + item[options.code]] = item;
            });
        }
        // 閫掑綊鑾峰彇瀛愯妭鐐瑰苟涓旇缃瓙鑺傜偣
        var recursionNode = function(parentNode, lv, row_id, p_id) {
            var $tbody = target.find("tbody");
            var _ls = target.data_list["_n_" + parentNode[options.code]];
            var $tr = renderRow(parentNode, _ls ? true : false, lv, row_id, p_id);
            $tbody.append($tr);
            if (_ls) {
                $.each(_ls, function(i, item) {
                    var _child_row_id = row_id + "_" + i
                    recursionNode(item, (lv + 1), _child_row_id, row_id)
                });
            }
        };
        // 缁樺埗琛�
        var renderRow = function(item, isP, lv, row_id, p_id) {
            // 鏍囪宸叉樉绀�
            item.isShow = true;
            item.row_id = row_id;
            item.p_id = p_id;
            item.lv = lv;
            var $tr = $('<tr id="' + row_id + '" pid="' + p_id + '"></tr>');
            var _icon = options.expanderCollapsedClass;
            if (options.expandAll) {
                $tr.css("display", "table");
                _icon = options.expanderExpandedClass;
            } else if (lv == 1) {
                $tr.css("display", "table");
                _icon = (options.expandFirst) ? options.expanderExpandedClass : options.expanderCollapsedClass;
            } else if (lv == 2) {
                if (options.expandFirst) {
                    $tr.css("display", "table");
                } else {
                    $tr.css("display", "none");
                }
                _icon = options.expanderCollapsedClass;
            } else {
                $tr.css("display", "none");
                _icon = options.expanderCollapsedClass;
            }
            $.each(options.columns, function(index, column) {
                // 鍒ゆ柇鏈夋病鏈夐€夋嫨鍒�
                if (column.field == 'selectItem') {
                    target.hasSelectItem = true;
                    var $td = $('<td style="text-align:center;width:36px"></td>');
                    if (column.radio) {
                        var _ipt = $('<input name="select_item" type="radio" value="' + item[options.code] + '"></input>');
                        $td.append(_ipt);
                    }
                    if (column.checkbox) {
                        var _ipt = $('<input name="select_item" type="checkbox" value="' + item[options.code] + '"></input>');
                        $td.append(_ipt);
                    }
                    $tr.append($td);
                } else {
                    var $td = $('<td name="' + column.field + '" class="' + column.field + '_cls"></td>');
                    if(column.width){
                        $td.css("width",column.width);
                    }
                    if(column.align){
                        $td.css("text-align",column.align);
                    }
                    if(options.expandColumn == index){
                        $td.css("text-align","left");
                    }
                    if(column.valign){
                        $td.css("vertical-align",column.valign);
                    }
                    if(options.showTitle){
                        $td.addClass("ellipsis");
                    }
                    // 澧炲姞formatter娓叉煋
                    if (column.formatter) {
                        $td.html(column.formatter.call(this, getItemField(item, column.field), item, index));
                    } else {
                        if(options.showTitle){
                            // 鍙湪瀛楁娌℃湁formatter鏃舵墠娣诲姞title灞炴€�
                            $td.attr("title",item[column.field]);
                        }
                        $td.text(getItemField(item, column.field));
                    }
                    if (options.expandColumn == index) {
                        if (!isP) {
                            $td.prepend('<span class="treetable-expander"></span>')
                        } else {
                            $td.prepend('<span class="treetable-expander ' + _icon + '"></span>')
                        }
                        for (var int = 0; int < (lv - 1); int++) {
                            $td.prepend('<span class="treetable-indent"></span>')
                        }
                    }
                    $tr.append($td);
                }
            });
            return $tr;
        }
        // 妫€绱俊鎭寜閽偣鍑讳簨浠�
        var registerSearchBtnClickEvent = function(btn) {
            $(btn).off('click').on('click', function () {
                $(".search-collapse").slideToggle();
            });
        }
        // 娉ㄥ唽鍒锋柊鎸夐挳鐐瑰嚮浜嬩欢
        var registerRefreshBtnClickEvent = function(btn) {
            $(btn).off('click').on('click', function () {
                target.refresh();
            });
        }
        // 娉ㄥ唽鍒楅€夐」浜嬩欢
        var registerColumnClickEvent = function() {
            $(".bootstrap-tree-table .treetable-bars .columns label input").off('click').on('click', function () {
                var $this = $(this);
                if($this.prop('checked')){
                    target.showColumn($(this).val());
                }else{
                    target.hideColumn($(this).val());
                }
            });
        }
        // 娉ㄥ唽琛岀偣鍑婚€変腑浜嬩欢
        var registerRowClickEvent = function() {
            target.find("tbody").find("tr").unbind();
            target.find("tbody").find("tr").click(function() {
                if (target.hasSelectItem) {
                    var _ipt = $(this).find("input[name='select_item']");
                    if (_ipt.attr("type") == "radio") {
                        _ipt.prop('checked', true);
                        target.find("tbody").find("tr").removeClass("treetable-selected");
                        $(this).addClass("treetable-selected");
                    } else if (_ipt.attr("type") == "checkbox") {
                        if (_ipt.prop('checked')) {
                            _ipt.prop('checked', true);
                            target.find("tbody").find("tr").removeClass("treetable-selected");
                            $(this).addClass("treetable-selected");
                        } else {
                            _ipt.prop('checked', false);
                            target.find("tbody").find("tr").removeClass("treetable-selected");
                        }
                    } else {
                        if (_ipt.prop('checked')) {
                            _ipt.prop('checked', false);
                            $(this).removeClass("treetable-selected");
                        } else {
                            _ipt.prop('checked', true);
                            $(this).addClass("treetable-selected");
                        }
                    }
                }
            });
        }
        // 娉ㄥ唽灏忓浘鏍囩偣鍑讳簨浠�--灞曞紑缂╄捣
        var registerExpanderEvent = function() {
            target.find("tbody").find("tr").find(".treetable-expander").unbind();
            target.find("tbody").find("tr").find(".treetable-expander").click(function() {
                var _isExpanded = $(this).hasClass(options.expanderExpandedClass);
                var _isCollapsed = $(this).hasClass(options.expanderCollapsedClass);
                if (_isExpanded || _isCollapsed) {
                    var tr = $(this).parent().parent();
                    var row_id = tr.attr("id");
                    var _ls = target.find("tbody").find("tr[id^='" + row_id + "_']"); //涓嬫墍鏈�
                    if (_isExpanded) {
                        $(this).removeClass(options.expanderExpandedClass);
                        $(this).addClass(options.expanderCollapsedClass);
                        if (_ls && _ls.length > 0) {
                            $.each(_ls, function(index, item) {
                                $(item).css("display", "none");
                            });
                        }
                    } else {
                        $(this).removeClass(options.expanderCollapsedClass);
                        $(this).addClass(options.expanderExpandedClass);
                        if (_ls && _ls.length > 0) {
                            $.each(_ls, function(index, item) {
                                // 鐖秈con
                                var _p_icon = $("#" + $(item).attr("pid")).children().eq(options.expandColumn).find(".treetable-expander");
                                if (_p_icon.hasClass(options.expanderExpandedClass)) {
                                    $(item).css("display", "table");
                                }
                            });
                        }
                    }
                }
            });
        }
        // 鍒锋柊鏁版嵁
        target.refresh = function(parms) {
            if(parms){
                target.lastAjaxParams=parms;
            }
            initServer(target.lastAjaxParams);
        }
        // 娣诲姞鏁版嵁鍒锋柊琛ㄦ牸
        target.appendData = function(data) {
            // 涓嬭竟鐨勬搷浣滀富瑕佹槸涓轰簡鏌ヨ鏃惰涓€浜涙病鏈夋牴鑺傜偣鐨勮妭鐐规樉绀�
            $.each(data, function(i, item) {
                var _data = target.data_obj["id_" + item[options.code]];
                var _p_data = target.data_obj["id_" + item[options.parentCode]];
                var _c_list = target.data_list["_n_" + item[options.parentCode]];
                var row_id = ""; //琛宨d
                var p_id = ""; //鐖惰id
                var _lv = 1; //濡傛灉娌℃湁鐖跺氨鏄�1榛樿鏄剧ず
                var tr; //瑕佹坊鍔犺鐨勫璞�
                if (_data && _data.row_id && _data.row_id != "") {
                    row_id = _data.row_id; // 濡傛灉宸茬粡瀛樺湪浜嗭紝灏辩洿鎺ュ紩鐢ㄥ師鏉ョ殑
                }
                if (_p_data) {
                    p_id = _p_data.row_id;
                    if (row_id == "") {
                        var _tmp = 0
                        if (_c_list && _c_list.length > 0) {
                            _tmp = _c_list.length;
                        }
                        row_id = _p_data.row_id + "_" + _tmp;
                    }
                    _lv = _p_data.lv + 1; //濡傛灉鏈夌埗
                    // 缁樺埗琛�
                    tr = renderRow(item, false, _lv, row_id, p_id);

                    var _p_icon = $("#" + _p_data.row_id).children().eq(options.expandColumn).find(".treetable-expander");
                    var _isExpanded = _p_icon.hasClass(options.expanderExpandedClass);
                    var _isCollapsed = _p_icon.hasClass(options.expanderCollapsedClass);
                    // 鐖惰妭鐐规湁娌℃湁灞曞紑鏀剁缉鎸夐挳
                    if (_isExpanded || _isCollapsed) {
                        // 鐖惰妭鐐瑰睍寮€鐘舵€佹樉绀烘柊鍔犺
                        if (_isExpanded) {
                            tr.css("display", "table");
                        }
                    } else {
                        // 鐖惰妭鐐规病鏈夊睍寮€鏀剁缉鎸夐挳鍒欐坊鍔�
                        _p_icon.addClass(options.expanderCollapsedClass);
                    }

                    if (_data) {
                        $("#" + _data.row_id).before(tr);
                        $("#" + _data.row_id).remove();
                    } else {
                        // 璁＄畻鐖剁殑鍚岀骇涓嬩竴琛�
                        var _tmp_ls = _p_data.row_id.split("_");
                        var _p_next = _p_data.row_id.substring(0, _p_data.row_id.length - 1) + (parseInt(_tmp_ls[_tmp_ls.length - 1]) + 1);
                        // 鐢讳笂
                        $("#" + _p_next).before(tr);
                    }
                } else {
                    tr = renderRow(item, false, _lv, row_id, p_id);
                    if (_data) {
                        $("#" + _data.row_id).before(tr);
                        $("#" + _data.row_id).remove();
                    } else {
                        // 鐢讳笂
                        var tbody = target.find("tbody");
                        tbody.append(tr);
                    }
                }
                item.isShow = true;
                // 缂撳瓨骞舵牸寮忓寲鏁版嵁
                formatData([item]);
            });
            registerExpanderEvent();
            registerRowClickEvent();
            initHiddenColumns();
        }

        // 灞曞紑/鎶樺彔鎸囧畾鐨勮
        target.toggleRow=function(id) {
            var _rowData = target.data_obj["id_" + id];
            var $row_expander = $("#"+_rowData.row_id).find(".treetable-expander");
            $row_expander.trigger("click");
        }
        // 灞曞紑鎸囧畾鐨勮
        target.expandRow=function(id) {
            var _rowData = target.data_obj["id_" + id];
            var $row_expander = $("#"+_rowData.row_id).find(".treetable-expander");
            var _isCollapsed = $row_expander.hasClass(target.options.expanderCollapsedClass);
            if (_isCollapsed) {
                $row_expander.trigger("click");
            }
        }
        // 鎶樺彔 鎸囧畾鐨勮
        target.collapseRow=function(id) {
            var _rowData = target.data_obj["id_" + id];
            var $row_expander = $("#"+_rowData.row_id).find(".treetable-expander");
            var _isExpanded = $row_expander.hasClass(target.options.expanderExpandedClass);
            if (_isExpanded) {
                $row_expander.trigger("click");
            }
        }
        // 灞曞紑鎵€鏈夌殑琛�
        target.expandAll=function() {
            target.find("tbody").find("tr").find(".treetable-expander").each(function(i,n){
                var _isCollapsed = $(n).hasClass(options.expanderCollapsedClass);
                if (_isCollapsed) {
                    $(n).trigger("click");
                }
            })
        }
        // 鎶樺彔鎵€鏈夌殑琛�
        target.collapseAll=function() {
            target.find("tbody").find("tr").find(".treetable-expander").each(function(i,n){
                var _isExpanded = $(n).hasClass(options.expanderExpandedClass);
                if (_isExpanded) {
                    $(n).trigger("click");
                }
            })
        }
        // 鏄剧ず鎸囧畾鍒�
        target.showColumn=function(field,flag) {
            var _index = $.inArray(field, target.hiddenColumns);
            if (_index > -1) {
                target.hiddenColumns.splice(_index, 1);
            }
            target.find("."+field+"_cls").show();
            //鏄惁鏇存柊鍒楅€夐」鐘舵€�
            if(flag&&options.showColumns){
                var $input = $(".bootstrap-tree-table .treetable-bars .columns label").find("input[value='"+field+"']")
                $input.prop("checked", 'checked');
            }
        }
        // 闅愯棌鎸囧畾鍒�
        target.hideColumn=function(field,flag) {
            target.hiddenColumns.push(field);
            target.find("."+field+"_cls").hide();
            //鏄惁鏇存柊鍒楅€夐」鐘舵€�
            if(flag&&options.showColumns){
                var $input = $(".bootstrap-tree-table .treetable-bars .columns label").find("input[value='"+field+"']")
                $input.prop("checked", '');
            }
        }
        // ruoyi 瑙ｆ瀽鏁版嵁锛屾敮鎸佸灞傜骇璁块棶
        var getItemField = function (item, field) {
            var value = item;

            if (typeof field !== 'string' || item.hasOwnProperty(field)) {
                return item[field];
            }
            var props = field.split('.');
            for (var p in props) {
                value = value && value[props[p]];
            }
            return value;
        };
        // ruoyi 鍙戣捣瀵圭洰鏍�(target)鍑芥暟鐨勮皟鐢�
        var calculateObjectValue = function (self, name, args, defaultValue) {
            var func = name;

            if (typeof name === 'string') {
                var names = name.split('.');

                if (names.length > 1) {
                    func = window;
                    $.each(names, function (i, f) {
                        func = func[f];
                    });
                } else {
                    func = window[name];
                }
            }
            if (typeof func === 'object') {
                return func;
            }
            if (typeof func === 'function') {
                return func.apply(self, args);
            }
            if (!func && typeof name === 'string' && sprintf.apply(this, [name].concat(args))) {
                return sprintf.apply(this, [name].concat(args));
            }
            return defaultValue;
        };
        // 鍒濆鍖�
        init();
        return target;
    };

    // 缁勪欢鏂规硶灏佽........
    $.fn.bootstrapTreeTable.methods = {
        // 涓轰簡鍏煎bootstrap-table鐨勫啓娉曪紝缁熶竴杩斿洖鏁扮粍锛岃繖閲岃繑鍥炰簡琛ㄦ牸鏄剧ず鍒楃殑鏁版嵁
        getSelections: function(target, data) {
            // 鎵€鏈夎閫変腑鐨勮褰昳nput
            var _ipt = target.find("tbody").find("tr").find("input[name='select_item']:checked");
            var chk_value = [];
            // 濡傛灉鏄痳adio
            if (_ipt.attr("type") == "radio") {
                var _data = target.data_obj["id_" + _ipt.val()];
                chk_value.push(_data);
            } else {
                _ipt.each(function(_i, _item) {
                    var _data = target.data_obj["id_" + $(_item).val()];
                    chk_value.push(_data);
                });
            }
            return chk_value;
        },
        // 鍒锋柊璁板綍
        refresh: function(target, parms) {
            if (parms) {
                target.refresh(parms);
            } else {
                target.refresh();
            }
        },
        // 娣诲姞鏁版嵁鍒拌〃鏍�
        appendData: function(target, data) {
            if (data) {
                target.appendData(data);
            }
        },
        // 灞曞紑/鎶樺彔鎸囧畾鐨勮
        toggleRow: function(target, id) {
            target.toggleRow(id);
        },
        // 灞曞紑鎸囧畾鐨勮
        expandRow: function(target, id) {
            target.expandRow(id);
        },
        // 鎶樺彔 鎸囧畾鐨勮
        collapseRow: function(target, id) {
            target.collapseRow(id);
        },
        // 灞曞紑鎵€鏈夌殑琛�
        expandAll: function(target) {
            target.expandAll();
        },
        // 鎶樺彔鎵€鏈夌殑琛�
        collapseAll: function(target) {
            target.collapseAll();
        },
        // 鏄剧ず鎸囧畾鍒�
        showColumn: function(target,field) {
            target.showColumn(field,true);
        },
        // 闅愯棌鎸囧畾鍒�
        hideColumn: function(target,field) {
            target.hideColumn(field,true);
        }
        // 缁勪欢鐨勫叾浠栨柟娉曚篃鍙互杩涜绫讳技灏佽........
    };

    $.fn.bootstrapTreeTable.defaults = {
        code: 'code',              // 閫夊彇璁板綍杩斿洖鐨勫€�,鐢ㄤ簬璁剧疆鐖跺瓙鍏崇郴
        parentCode: 'parentCode',  // 鐢ㄤ簬璁剧疆鐖跺瓙鍏崇郴
        rootIdValue: null,         // 璁剧疆鏍硅妭鐐筰d鍊�----鍙寚瀹氭牴鑺傜偣锛岄粯璁や负null,"",0,"0"
        data: null,                // 鏋勯€爐able鐨勬暟鎹泦鍚�
        type: "GET",               // 璇锋眰鏁版嵁鐨刟jax绫诲瀷
        url: null,                 // 璇锋眰鏁版嵁鐨刟jax鐨剈rl
        ajaxParams: {},            // 璇锋眰鏁版嵁鐨刟jax鐨刣ata灞炴€�
        expandColumn: 0,           // 鍦ㄥ摢涓€鍒椾笂闈㈡樉绀哄睍寮€鎸夐挳
        expandAll: false,          // 鏄惁鍏ㄩ儴灞曞紑
        expandFirst: true,         // 鏄惁榛樿绗竴绾у睍寮€--expandAll涓篺alse鏃剁敓鏁�
        striped: false,            // 鏄惁鍚勮娓愬彉鑹�
        bordered: true,            // 鏄惁鏄剧ず杈规
        hover: true,               // 鏄惁榧犳爣鎮仠
        condensed: false,          // 鏄惁绱х缉琛ㄦ牸
        columns: [],               // 鍒�
        toolbar: null,             // 椤堕儴宸ュ叿鏉�
        height: 0,                 // 琛ㄦ牸楂樺害
        showTitle: true,           // 鏄惁閲囩敤title灞炴€ф樉绀哄瓧娈靛唴瀹癸紙琚玣ormatter鏍煎紡鍖栫殑瀛楁涓嶄細鏄剧ず锛�
        showSearch: true,          // 鏄惁鏄剧ず妫€绱俊鎭�
        showColumns: true,         // 鏄惁鏄剧ず鍐呭鍒椾笅鎷夋
        showRefresh: true,         // 鏄惁鏄剧ず鍒锋柊鎸夐挳
        expanderExpandedClass: 'glyphicon glyphicon-chevron-down', // 灞曞紑鐨勬寜閽殑鍥炬爣
        expanderCollapsedClass: 'glyphicon glyphicon-chevron-right', // 缂╄捣鐨勬寜閽殑鍥炬爣
        responseHandler: function(res) {
            return false;
        },
        onLoadSuccess: function(res) {
            return false;
        }
    };
})(jQuery);