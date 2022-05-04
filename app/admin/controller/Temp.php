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
// | Date: 2020/7/20 0020
// +----------------------------------------------------------------------
// | Description:
// +----------------------------------------------------------------------

namespace app\admin\controller;

use app\admin\model\article\Articles;
use app\common\controller\AdminBaseController;
use think\facade\Db;

class Temp extends AdminBaseController
{


    /**
     * @return string
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:图标
     */
    public function icon(){
        return $this->fetch();
    }


    /**
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:ueditor
     */
    public function ueditor(){
        $id=$this->request->param("id",0);
        if ((int)$id==0){
            $content='';
        }else{
            $res=Db::name("articles")->where("id",(int)$id)->find();
            $content=$res['content'];
        }
        $this->assign("content",$content);

        return $this->fetch();
    }


    /**
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:editormd
     */
    public function editormd(){
        $id=$this->request->param("id",0);
        if ((int)$id==0){
            $content='';
        }else{
            $res=Db::name("articles")->where("id",(int)$id)->find();
            $content=$res['content'];
        }
        $this->assign("content",$content);

        return $this->fetch();
    }


}