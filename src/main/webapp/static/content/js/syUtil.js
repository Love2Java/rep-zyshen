

/**
 * @author {CaoGuangHui}
 */
$.extend($.fn.tabs.methods, {
    getTabById: function (jq, id,removeit) {
        var tabs = $.data(jq[0], 'tabs').tabs;
        for (var i = 0; i < tabs.length; i++) {
            var tab = tabs[i];
            if (tab.panel('options').id == id) {
                if (removeit) {
                    alert(1);
                }
                return tab;
            }
        }
        return null;
    },
    closeById: function (jq, id) {

        var tabs = $.data(jq[0], 'tabs').tabs;

        return jq.each(function () {
            var state = $.data(this, 'tabs');

            var opts = state.options;
            var tabs = state.tabs;
            var selectHis = state.selectHis;

            if (tabs.length == 0) { return; }
            var panel = $(this).tabs('getTabById', id); // get the panel to be activated 
            if (!panel) { return }

            var title = panel.panel('options').title;

            if (opts.onBeforeClose.call(this, title, $(this).tabs('getTabIndex', panel)) == false) return;
            for (var i = 0; i < tabs.length; i++) {
                var tab = tabs[i];
                if (tab.panel('options').id == id) {
                    tabs.splice(i, 1);
                    break;
                }
            }
            panel.panel('options').tab.remove();
            panel.panel('destroy');
            opts.onClose.call(this, title, $(this).tabs('getTabIndex', panel));

         
        });
    },
    selectById: function (jq, id) {
        return jq.each(function () {
            var state = $.data(this, 'tabs');
            var opts = state.options;
            var tabs = state.tabs;
            var selectHis = state.selectHis;
            if (tabs.length == 0) { return; }
            var panel = $(this).tabs('getTabById', id); // get the panel to be activated 
            if (!panel) { return }
            var selected = $(this).tabs('getSelected');
            if (selected) {
                if (panel[0] == selected[0]) { return }
                $(this).tabs('unselect', $(this).tabs('getTabIndex', selected));
                if (!selected.panel('options').closed) { return }
            }
            panel.panel('open');
            var title = panel.panel('options').title;        // the panel title 
            selectHis.push(title);        // push select history 
            var tab = panel.panel('options').tab;        // get the tab object 
            tab.addClass('tabs-selected');
            // scroll the tab to center position if required. 
            var wrap = $(this).find('>div.tabs-header>div.tabs-wrap');
            var left = tab.position().left;
            var right = left + tab.outerWidth();
            if (left < 0 || right > wrap.width()) {
                var deltaX = left - (wrap.width() - tab.width()) / 2;
                $(this).tabs('scrollBy', deltaX);
            } else {
                $(this).tabs('scrollBy', 0);
            }
            $(this).tabs('resize');
            opts.onSelect.call(this, title, $(this).tabs('getTabIndex', panel));
        });
    },
    existsById: function (jq, id) {
        return $(jq[0]).tabs('getTabById', id) != null;
    }
});


/**
* 张志鹏
* @requires jQuery,EasyUI
*  新增 validatebox 校验规则   
*/
(function ($) {
    $.extend($.fn.validatebox.defaults.rules, {
    	name: {// 验证姓名，可以是中文或英文
            validator: function (value) {
                return /^[\Α-\￥]+$/i.test(value) | /^\w+[\w\s]+\w+$/i.test(value);
            },
            message: '请输入正确的姓名'
        },
        CHS: {
            validator: function (value) {
                return /^[\u0391-\uFFE5]+$/.test(value);
            },
            message: "只能输入中文."
        },
        stringCheck: {
            validator: function (value) {
                return /^[\u0391-\uFFE5\w]+$/.test(value);
            },
            message: "只能包括中文字、英文字母、数字和下划线."
        },
        stringCheckSub: {
            validator: function (value) {
                return /^[a-zA-Z0-9\u4E00-\u9FA5]+$/.test(value);
            },
            message: "只能包括中文字、英文字母、数字."
        },
        englishCheckSub: {
            validator: function (value) {
                return /^[a-zA-Z0-9]+$/.test(value);
            },
            message: "只能包括英文字母、数字."
        },
        numberCheckSub: {
            validator: function (value) {
                return /^[0-9]+$/.test(value);
            },
            message: "只能输入数字."
        },
        //手机号码验证
        mobile: {
            validator: function (value) {
                var reg = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;

                return value.length == 11 && reg.test(value);
            },
            message: "请输入正确的手机号码"
        },
        //电话号码验证
        telephone: {
            validator: function (value) {
                //电话号码格式010-12345678
                var reg = /^\d{3,4}?\d{7,8}$/;

                return reg.test(value);
            },
            message: "请正确填写您的电话号码."
        },
        //联系电话(手机/电话皆可)验证 
        mobileTelephone: {
            validator: function (value) {
                var cmccMobile = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
                var tel = /^\d{3,4}?\d{7,8}$/;
                return tel.test(value) || (value.length == 11 && cmccMobile.test(value));
            },
            message: "请正确填写您的联系电话."
        },
        //验证国内邮编验证
        zipCode: {
            validator: function (value) {
                var reg = /^[1-9]\d{5}$/;
                return reg.test(value);
            },
            message: "邮编必须长短0开端的6位数字."
        },
        //身份证号码验证 
        idCardNo: {
            validator: function (value) {
                return isIdCardNo(value);
            },
            message: "请正确输入身份证号码."
        }
    });
})(jQuery);



/**
* 张志鹏
* @requires jQuery,EasyUI
* 扩展获得tree 的实心节点    
*/
$(function () {
    $.extend($.fn.tree.methods, {
        getCheckedExt: function (jq) {
            var checked = $(jq).tree("getChecked");                     //获取选中的选项 也就是打钩的   
            var checkbox2 = $(jq).find("span.tree-checkbox2").parent(); //获取实心的选项 也就是实心方块的   
            $.each(checkbox2, function () {
                var node = $.extend({}, $.data(this, "tree-node"), {
                    target: this
                });
                checked.push(node);
            });
            return checked;
        }
    });
});
/**
* 张志鹏
* @requires jQuery,EasyUI
* 扩展tree，使其支持平滑数据格式
*/
$.fn.tree.defaults.loadFilter = function (data, parent) {
    var opt = $(this).data().tree.options;
    var idFiled, textFiled, parentField;
    if (opt.parentField) {
        idFiled = opt.idFiled || 'id';
        textFiled = opt.textFiled || 'text';
        parentField = opt.parentField;
        var i, l, treeData = [], tmpMap = [];
        for (i = 0, l = data.length; i < l; i++) {
            tmpMap[data[i][idFiled]] = data[i];
        }
        for (i = 0, l = data.length; i < l; i++) {
            if (tmpMap[data[i][parentField]] && data[i][idFiled] != data[i][parentField]) {
                if (!tmpMap[data[i][parentField]]['children'])
                    tmpMap[data[i][parentField]]['children'] = [];
                data[i]['text'] = data[i][textFiled];
                tmpMap[data[i][parentField]]['children'].push(data[i]);
            } else {
                data[i]['text'] = data[i][textFiled];
                treeData.push(data[i]);
            }
        }
        return treeData;
    }
    return data;
};

/**
* 张志鹏
* @requires jQuery,EasyUI
* 扩展treegrid，使其支持平滑数据格式
*/
$.fn.treegrid.defaults.loadFilter = function (data, parentId) {
    var opt = $(this).data().treegrid.options;
    var idFiled, textFiled, parentField;
    if (opt.parentField) {
        idFiled = opt.idFiled || 'id';
        textFiled = opt.textFiled || 'text';
        parentField = opt.parentField;
        var i, l, treeData = [], tmpMap = [];
        for (i = 0, l = data.length; i < l; i++) {
            tmpMap[data[i][idFiled]] = data[i];
        }
        for (i = 0, l = data.length; i < l; i++) {
            if (tmpMap[data[i][parentField]] && data[i][idFiled] != data[i][parentField]) {
                if (!tmpMap[data[i][parentField]]['children'])
                    tmpMap[data[i][parentField]]['children'] = [];
                data[i]['text'] = data[i][textFiled];
                tmpMap[data[i][parentField]]['children'].push(data[i]);
            } else {
                data[i]['text'] = data[i][textFiled];
                treeData.push(data[i]);
            }
        }
        return treeData;
    }
    return data;
};


$.fn.combotreegrid.defaults.loadFilter = function (data, parentId) {
    var opt = $(this).data().treegrid.options;
    var idFiled, textFiled, parentField;
    if (opt.parentField) {
        idFiled = opt.idFiled || 'id';
        textFiled = opt.textFiled || 'text';
        parentField = opt.parentField;
        var i, l, treeData = [], tmpMap = [];
        for (i = 0, l = data.length; i < l; i++) {
            tmpMap[data[i][idFiled]] = data[i];
        }
        for (i = 0, l = data.length; i < l; i++) {
            if (tmpMap[data[i][parentField]] && data[i][idFiled] != data[i][parentField]) {
                if (!tmpMap[data[i][parentField]]['children'])
                    tmpMap[data[i][parentField]]['children'] = [];
                data[i]['text'] = data[i][textFiled];
                tmpMap[data[i][parentField]]['children'].push(data[i]);
            } else {
                data[i]['text'] = data[i][textFiled];
                treeData.push(data[i]);
            }
        }
        return treeData;
    }
    return data;
    
}

/**
* 张志鹏
* @requires jQuery,EasyUI
* 扩展combotree，使其支持平滑数据格式
*/
$.fn.combotree.defaults.loadFilter = $.fn.tree.defaults.loadFilter;





/**
* 张志鹏
* @requires jQuery,EasyUI
* 防止panel/window/dialog组件超出浏览器边界
* @param left
* @param top
*/
var easyuiPanelOnMove = function (left, top) {
    var l = left;
    var t = top;
    if (l < 1) {
        l = 1;
    }
    if (t < 1) {
        t = 1;
    }
    var width = parseInt($(this).parent().css('width')) + 14;
    var height = parseInt($(this).parent().css('height')) + 14;
    var right = l + width;
    var buttom = t + height;
    var browserWidth = $(window).width();
    var browserHeight = $(window).height();
    if (right > browserWidth) {
        l = browserWidth - width;
    }
    if (buttom > browserHeight) {
        t = browserHeight - height;
    }
    $(this).parent().css({/* 修正面板位置 */
        left: l,
        top: t
    });
};
$.fn.dialog.defaults.onMove = easyuiPanelOnMove;
$.fn.window.defaults.onMove = easyuiPanelOnMove;
$.fn.panel.defaults.onMove = easyuiPanelOnMove;