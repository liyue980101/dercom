<?php
// +----------------------------------------------------------------------
// | Created by PHPstorm: [ JRK丶Admin ]
// +----------------------------------------------------------------------
// | Copyright (c) 2019~2022 [LuckyHHY] All rights reserved.
// +----------------------------------------------------------------------
// | SiteUrl: http://www.luckyhhy.cn
// +----------------------------------------------------------------------
// | Author: DER <der1998@gmail.com>
// +----------------------------------------------------------------------
// | Date: 2020/6/27 0027
// +----------------------------------------------------------------------
// | Description:  
// +----------------------------------------------------------------------

use Jrk\Api;

/**
 * @param $rules
 * @param $pid
 * @param bool $all
 * @return array
 * @author: DER <der1998@gmail.com>
 * @describe:传递一个父级分类ID返回所有子分类
 */
function getChildsRule($rules, $pid, $all = true)
{
    $arr = [];
    foreach ($rules as $v) {
        if ($v['pid'] == $pid) {
            if ($all) {
                $arr[] = $v;
            } else {
                $arr[] = (int)$v['id'];
            }

            $arr = array_merge($arr, getChildsRule($rules, $v['id']));
        }
    }
    return $arr;
}


/**
 * @param array $data
 * @param string $id
 * @param string $title
 * @return array|bool
 * @author: DER <der1998@gmail.com>
 * @describe: treeCheckedtree
 */
function treeCheckedtree($data = [], $id = "id", $title = 'title')
{
    if (empty($data) || !is_array($data)) return false;
    $data = \Jrk\Tree::DeepTree($data);
    static $list = [];
    foreach ($data as $k => $v) {
        if (isset($v['children'])) {
            $ch = [];
            foreach ($v['children'] as $c => $d) {

                if (isset($d['children'])) {
                    $chd = [];

                    foreach ($d['children'] as $cc => $dd) {
                        if (isset($dd['children'])) {
                            $chdd = [];

                            foreach ($dd['children'] as $ccc => $ddd) {
                                $chdd[] = \FormBuilder\Form::treeData($ddd[$id], $ddd[$title]);
                            }

                        } else {
                            unset($d['children'][$cc]);
                            $chd[] = \FormBuilder\Form::treeData($dd[$id], $dd[$title]);
                        }
                    }
                    $ch[] = \FormBuilder\Form::treeData($d[$id], $d[$title])->children($chd);
                } else {
                    unset($v['children'][$c]);
                    $ch[] = \FormBuilder\Form::treeData($d[$id], $d[$title]);
                }
            }
            $list[] = \FormBuilder\Form::treeData($v[$id], $v[$title])->children($ch);
        } else {
            unset($data[$k]);
            $list[] = \FormBuilder\Form::treeData($v[$id], $v[$title]);
        }
    }
    return $list;
}


/**
 * @param $qq
 * @return array
 * @author: DER <der1998@gmail.com>
 * @describe:获取QQ信息
 */
function getQQInfo($qq)
{
    /**
 * @param $qq
 * @return array
 * @author: DER <der1998@gmail.com>
 * @describe:获取QQ信息
 */
function getQQInfo($qq)
{
    $returnArr=Api::getQQ(qq);
    if($returnArr['code']==1){
         //触发事件保存QQ信息
         event("UserQQAfter", [$returnArr]);
    }
    return $returnArr;
}
}


/**
 * @param $data 下拉框数据源
 * @param int $selected_id 选择数据ID
 * @param string $show_field 显示名称
 * @param string $val_field 显示值
 * @author: DER <der1998@gmail.com>
 * @describe: 下拉选择框组件
 */
function make_option($data, $selected_id = 0, $show_field = 'name', $val_field = 'id')
{
    $html = '';
    $show_field_arr = explode(',', $show_field);
    //dump($data);
    if (is_array($data)) {
        foreach ($data as $k => $v) {
            $show_text = '';
            if (is_array($v)) {
                foreach ($show_field_arr as $s) {
                    $show_text .= $v[$s] . ' ';
                }
                $show_text = substr($show_text, 0, -1);
                $val_field && $k = $v[$val_field];
            } else {
                $show_text = $v;
            }
            $sel = '';
            if ($selected_id && $k == $selected_id) {
                $sel = 'selected';
            }
            $html .= '<option value = ' . $k . ' ' . $sel . '>' . $show_text . '</option>';
        }
    }
    echo $html;
}


/**
 * @param $data
 * @param $lable
 * @param $name
 * @return string
 * @author: DER <der1998@gmail.com>
 * @describe:li 下拉选项
 */
function li_select($data, $lable, $name)
{
    $str = <<<EOT
    <li class="select-selectpicker">
      {$lable}：<select name="{$name}" class="selectpicker" data-none-selected-text="请选择">
      <option value="">所有</option>
EOT;
    if (is_array($data)) {
        foreach ($data as $k => $v) {
            $str .= <<<EOT
<option value ="{$k}">{$v}</option>
EOT;
        }
    }
    $str .= <<<EOT
    </select>
</li>
EOT;
    return $str;
}

/**
 * @param $lable
 * @param $name
 * @return string
 * @author: DER <der1998@gmail.com>
 * @describe:li 格式的input
 */
function li_input($lable, $name)
{
    if (empty($lable) || empty($name)) {
        echo '参数不对';
    }
    $html = <<<EOT
    <li>{$lable}： <input type="text" name="{$name}" class="form-control"  placeholder="请输入{$lable}"></li>
EOT;
    return $html;
}

/**
 * @param string $lable
 * @param string $name
 * @return string
 * @author: DER <der1998@gmail.com>
 * @describe:li 时间范围
 */
function li_time($lable = '创建时间', $name = 'time')
{
    $html = <<<EOT
<li>{$lable}： <input type="text" name="{$name}" class="form-control range_time"  placeholder="时间范围"></li>
EOT;
    return $html;
}


/**
 * @param $name
 * @param $value
 * @return string
 * @author: DER <der1998@gmail.com>
 * @describe:li  hidden
 */
function li_hidden($name, $value)
{
    $html = <<<EOT
 <input type="hidden" id="{$name}" name="{$name}" value="{$value}">
EOT;
    return $html;

}

/**
 * @author: DER <der1998@gmail.com>
 * @describe:li 搜索重置
 */
function li_search()
{
    $html = <<<EOT
            <li>
              <a class="btn btn-primary btn-rounded btn-sm" onclick="$.table.search()"><i class="fa fa-search"></i>&nbsp;搜索</a>
              <button class="btn btn-warning btn-rounded btn-sm" type="reset" onclick="$.form.reset()"><i class="fa fa-refresh"></i>&nbsp;重置</button>
            </li>
EOT;
    return $html;
}

/**
 * @param $content
 * @return mixed
 * @author: DER <der1998@gmail.com>
 * @describe:字符串替换
 */
function str_place($content)
{
    return str_replace("<br />", "\n\t", $content);
}


/**
 * @param $content HTML或者文章
 * @param int $num 内容第几张图片
 * @return false|null|\tcwei\smallTools\src
 * @author: DER <der1998@gmail.com>
 * @describe:获取内容第几张图片
 */
function get_content_image_one($content, $num = 1)
{
    return \tcwei\smallTools\GetImgSrc::src($content, $num);
}


/**
 * @param $content HTML或者文章
 * @param int $startNum 默认为1，从第一张图片开始抽取
 * @return \tcwei\smallTools\图片地址的集合数组，若无则返回空数组[]
 * @author: DER <der1998@gmail.com>
 * @describe:获取内容里第几张开始的所有图片地址
 */
function get_content_images($content, $startNum = 1)
{
    return \tcwei\smallTools\GetImgSrc::srcList($content, $startNum);
}


/**
 * @param $size
 * @param string $delimiter
 * @return string
 * @author: DER <der1998@gmail.com>
 * @describe:
 */
function format_bytes($size, $delimiter = '')
{
    $units = array('B', 'KB', 'MB', 'GB', 'TB', 'PB');
    for ($i = 0; $size >= 1024 && $i < 5; $i++) $size /= 1024;
    return round($size, 2) . $delimiter . $units[$i];
}


/**
 * @param $time
 * @return false|string
 * @author: DER <der1998@gmail.com>
 * @describe:
 */
function ftime($time)
{
    return \Jrk\Times::friendlyDate($time, "full");
}