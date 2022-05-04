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
// | Date: 2020/8/12 0012
// +----------------------------------------------------------------------
// | Description:
// +----------------------------------------------------------------------

namespace app\admin\validate;


use think\Validate;

class CheckArticle extends Validate
{
    protected $rule = [
        'cate_id' =>  'gt:0',
        'title'  =>  'require|max:150',
        'keywords' =>  'max:100',
        'description' =>  'max:200',
        'img_url' =>'require',
        'content' =>'require'
    ];


}