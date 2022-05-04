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
// | Date: 2020/8/10 0010
// +----------------------------------------------------------------------
// | Description:  
// +----------------------------------------------------------------------

namespace app\admin\validate;


use think\Validate;

class CheckArticleModel extends Validate
{

    protected $rule = [
        'name'  =>  'chs|max:12',
        'tablename' =>  'require',
        'index_template'    =>'alpha|max:14',
        'list_template' =>  'alpha|max:14',
        'show_template' =>  'alpha|max:14'
    ];

}