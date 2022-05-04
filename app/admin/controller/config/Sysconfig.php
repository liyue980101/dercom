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
// | Date: 2020/7/30 0030
// +----------------------------------------------------------------------
// | Description:
// +----------------------------------------------------------------------

namespace app\admin\controller\config;


use app\admin\model\SysConfigTabs;
use app\admin\validate\CheckConfig;
use app\common\controller\AdminBaseController;
use app\admin\model\SysConfig as SysConfigs;
use app\common\service\FormBuilder as Form;
use think\Exception;
use think\facade\Route;

class Sysconfig extends AdminBaseController
{
    protected $gp;
    protected function initialize()
    {
        parent::initialize(); // TODO: Change the autogenerated stub

        $this->model=new SysConfigs();

        $this->gp=SysConfigTabs::where("status",1)->select()->toArray();
        //配置分类
        $this->assign("gropu", $this->gp);
    }


    /**
     * @return string|\think\response\Json
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:
     */
    public function addConfig(){
        if (IS_AJAX) {
            $data = $this->request->post();
            try {
                $checkUser = new CheckConfig();
                if (!$checkUser->scene("Config")->check($data)){
                    return parent::JsonReturn($checkUser->getError(), 0);
                }
                $res=$this->model->where("name",$data['name'])->where("group_id",$data['group_id'])->select()->toArray();

                if ($res){
                    return parent::JsonReturn("当前配置分类的配置名已存在", 0);
                }

                $data['group']=SysConfigTabs::where("id",$data['group_id'])->value("eng_title");
                return $this->model->doAll($data);

            } catch (Exception $exception) {
                return parent::JsonReturn($exception->getMessage(), 0);
            }
        }

        $f = [];
        $f[] = Form::select('group_id', '配置分类',"1")->setOptions(function (){
            $options = [];
            foreach ($this->gp as $k=>$v) {
                $options[] = ['label' => $v['title'], 'value' => $v['id']];
            }
            return $options;
        })->multiple(0)->required("请选择配置分类");

        $f[] = Form::input('name', '配置名')->required("配置名必填")->placeholder("请输入配置名");
        $f[] = Form::input('value', '配置值')->required("配置值必填")->placeholder("请输入配置值")->info("配置值");
        $f[] = Form::hidden("__token__", token());
        $f[] = Form::textarea("beizhu","备注");
        $form = Form::make_post_form('添加配置', $f, Route::buildUrl('addConfig'));
        $this->assign(compact('form'));
        return $this->fetch('public/form-builder');
    }


    /**
     * @return string|\think\response\Json
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:
     */
    public function update(){
        if (IS_AJAX) {
            $data = $this->request->post();
            try {
                $checkUser = new CheckConfig();
                if (!$checkUser->scene("Config")->check($data)){
                    return parent::JsonReturn($checkUser->getError(), 0);
                }
                $res=$this->model->where("name",$data['name'])->where("group_id",$data['group_id'])->where("id","<>",$data['id'])->select()->toArray();

                if ($res){
                    return parent::JsonReturn("当前配置分类的配置名已存在", 0);
                }
                $data['group']=SysConfigTabs::where("id",$data['group_id'])->value("eng_title");
                return $this->model->doAll($data);

            } catch (Exception $exception) {
                return parent::JsonReturn($exception->getMessage(), 0);
            }
        }
        $id = $this->request->param("id/d",0);//父id
        $info = $this->model->where("id",$id)->find()->toArray();
        if (!$info) return $this->failed("数据错误");
       // dd($info);
        $f = [];
        $f[] = Form::select('group_id', '配置分类',"{$info['group_id']}")->setOptions(function (){
            $options = [];
            foreach ($this->gp as $k=>$v) {
                $options[] = ['label' => $v['title'], 'value' => $v['id']];
            }
            return $options;
        })->multiple(0)->required("请选择配置分类");

        $f[] = Form::input('name', '配置名',$info['name'])->required("配置名必填")->placeholder("请输入配置名");
        $f[] = Form::input('value', '配置值',$info['value'])->required("配置值必填")->placeholder("请输入配置值")->info("配置值");
        $f[] = Form::hidden("__token__", token());
        $f[] = Form::textarea("beizhu","备注",$info['beizhu']);
        $f[] = Form::hidden("id", $info['id']);
        $form = Form::make_post_form('添加配置', $f, Route::buildUrl('update'));
        $this->assign(compact('form'));
        return $this->fetch('public/form-builder');
    }

}