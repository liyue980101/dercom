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
// | Date: 2020/6/26 0026
// +----------------------------------------------------------------------
// | Description:
// +----------------------------------------------------------------------

namespace app\admin\controller;


use app\admin\model\SystemLogs;
use app\common\controller\AdminBaseController;

class SystemLog extends AdminBaseController
{
    protected function initialize()
    {
        parent::initialize(); // TODO: Change the autogenerated stub
        $this->model=new SystemLogs();
    }


    /**
     * @return mixed
     * @author: DER <der1998@gmail.com>
     * @describe:删除
     */
    public function del(){
        if (IS_AJAX){
            $data=$this->request->param();
            return $this->model->dels($data);
        }
    }



}