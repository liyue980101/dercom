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
// | Date: 2020/7/31 0031
// +----------------------------------------------------------------------
// | Description:
// +----------------------------------------------------------------------

namespace app\common\subscribes\activity;


use app\common\subscribes\Base;
use think\facade\Queue;

class ActivesSubscribe extends Base
{

    /**
     * @param $event
     * @author: DER <der1998@gmail.com>
     * @describe:测试
     */
    public function onActiveInitAfter($event){
        list($data)=$event;
        //延时执行（目前无效）
        Queue::later(600,'admin/Active',['data'=>$data],'test');
    }


}