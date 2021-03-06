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
// | Date: 2020/7/17 0026
// +----------------------------------------------------------------------
// | Description:
// +----------------------------------------------------------------------



namespace app\common\subscribes;

use app\admin\model\AdminUser;


class AdminSubscribe extends Base
{

    /**
     * @param $event
     * @author: DER <der1998@gmail.com>
     * @describe:用户登录后
     */
    public function onAdminLoginAfter($event){
         list($data)=$event;
         AdminUser::update($data);
    }




}