<?php


namespace app\admin\controller;


use app\admin\model\AdminUser;
use app\admin\model\PageEmail as PageEmailModel;
use app\common\controller\AdminBaseController;
use app\common\service\FormBuilder as Form;
use think\facade\Route;
use think\Request;

class PageEmail extends AdminBaseController
{

    protected function initialize()
    {
        parent::initialize(); // TODO: Change the autogenerated stub

        $this->model=new PageEmailModel();

        //$this->assign("user",AdminUser::field("id,username")->select()->toArray());
    }

}