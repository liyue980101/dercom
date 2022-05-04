<?php
declare (strict_types = 1);

namespace app\admin\controller;

use app\admin\model\AdminUser;
use app\admin\model\Sysversions;
use app\common\controller\AdminBaseController;
use think\facade\Route;
use think\Request;
use think\Exception;
use app\common\service\FormBuilder as Form;

class Sysversion extends AdminBaseController
{

    protected function initialize()
    {
        parent::initialize(); // TODO: Change the autogenerated stub

        $this->model=new Sysversions();

        $this->assign("user",AdminUser::field("id,username")->select()->toArray());
    }


    /**
     * @return string|\think\response\Json
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:添加
     */
    public function add()
    {
        $version=$this->model->limit(1)->order("id desc")->value("version");
        $time=date("Y-m-d",time());
        $f = [];
        $f[] = Form::input('version', '版本号：')->required("请输入版本号，例如v1.0.1")->info("上个版本号：".$version)->placeholder("上个版本号：".$version);
        $f[] = Form::date('date_time', '版本更新时间：',$time)->placeholder("更新时间")->info("默认为当天时间");
        $f[] = Form::textarea('content', '版本内容：')->rows(10)->required("版本的修改内容必填");
        $f[] = Form::hidden("__token__", token());
        $form = Form::make_post_form('添加版本', $f, Route::buildUrl('upAndAdd'));
        $this->assign(compact('form'));
        return $this->fetch('public/form-builder');

    }


    /**
     * @return string|\think\response\Json
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:修改
     */
    public function edit()
    {
        $id = $this->request->param("id/d",0);//父id
        $info = $this->model->find($id);
        if (!$info) return $this->failed("信息不存在");
        $f = [];
        $info['content']=str_replace("<br />","",$info['content']);
        $f[] = Form::input('version', '版本号：',$info['version'])->required("请输入版本号，例如v1.0.1");
        $f[] = Form::date('date_time', '版本更新时间：',$info['date_time'])->placeholder("更新时间");
        $f[] = Form::textarea('content', '版本内容：',$info['content'])->rows(10)->required("版本的修改内容必填");
        $f[] = Form::hidden("__token__", token());
        $f[] = Form::hidden("id", $info['id']);
        $form = Form::make_post_form('添加版本', $f, Route::buildUrl('upAndAdd'));
        $this->assign(compact('form'));
        return $this->fetch('public/form-builder');
    }



}
