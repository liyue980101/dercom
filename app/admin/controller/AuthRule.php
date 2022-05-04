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

namespace app\admin\controller;

use app\admin\validate\CheckAuth;
use app\common\controller\AdminBaseController;
use \app\admin\model\AuthRule as AuthRules;
use Jrk\Tree;
use think\Exception;
use think\facade\Db;
use app\common\service\FormBuilder as Form;
use think\facade\Route;

class AuthRule extends AdminBaseController
{

    protected function initialize()
    {
        parent::initialize(); // TODO: Change the autogenerated stub

        $this->model = new AuthRules();
    }


    public function test(){
        return $this->fetch();
    }

    /**
     * @return string|\think\response\Json
     * @throws \FormBuilder\exception\FormBuilderException
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:添加
     */
    public function addAuth()
    {
        //获取菜单列表
        $pid = $this->request->param("id/d",0);//父id
        $f = [];
        $f[] = Form::select('pid', '上级菜单',"{$pid}")->setOptions(function (){
            $tree = Tree::toFormatTree(AuthRules::menuList());
            $options = [];
            $options[] = ['label' =>"顶级菜单", 'value' => 0];
            foreach ($tree as $k => $v) {
                $options[] = ['label' => $v['title_show'], 'value' => $v['id']];
            }
            return $options;
        })->multiple(0);
        $f[] = Form::hidden("font_family", "fa");
        $f[] = Form::hidden("__token__", token());
        $f[] = Form::hidden("type", 1);
        $f[] = Form::input('title', '菜单名称')->placeholder("请输入菜单名称")->required("请输入菜单名称");
        $f[] = Form::radio('auth_open', '权限验证',1)->options([['label' => '是', 'value' => 1], ['label' => '否', 'value' => 2]])->col(12);
        $f[] = Form::radio('status', '是否禁止',1)->options([['label' => '否', 'value' => 1], ['label' => '是', 'value' => 0]])->col(12);
        $f[] = Form::input('name', '菜单地址')->placeholder("格式例如：AuthRule/index（控制器名/方法名）");
        $f[] = Form::number('sort', '菜单排序', '10')->min(0);
        $f[] = Form::frameInputOne('icon', '图标', Route::buildUrl('Temp/icon', array('fodder' => 'icon')))->icon('ionic')->height('300px');
        $f[] = Form::input('param', '其它参数')->placeholder("其它参数");
        $form = Form::make_post_form($pid==0?'添加菜单':'添加子菜单', $f, Route::buildUrl('upAndAdd'));

        $this->assign(compact('form'));
        return $this->fetch('public/form-builder');
    }


    /**
     * @return string|\think\response\Json
     * @throws \FormBuilder\exception\FormBuilderException
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:编辑
     */
    public function update(){
        //获取菜单列表
        $pid = $this->request->param("id/d",0);//父id
        $info = AuthRules::find($pid);
        if (!$info) return $this->failed("ID参数错误");
        $p=$info['pid'];
        $f = [];
        $f[] = Form::select('pid', '上级菜单',"{$p}")->setOptions(function (){
            $tree = Tree::toFormatTree(AuthRules::menuList());
            $options = [];
            $options[] = ['label' =>"顶级菜单", 'value' => 0];
            foreach ($tree as $k => $v) {
                $options[] = ['label' => $v['title_show'], 'value' => $v['id']];
            }
            return $options;
        })->multiple(0);
        $f[] = Form::hidden("font_family", "fa");
        $f[] = Form::hidden("__token__", token());
        $f[] = Form::hidden("type", $info['type']);
        $f[] = Form::hidden("id", $info['id']);
        $f[] = Form::input('title', '名称',$info['title'])->placeholder("请输入名称")->required("请输入名称");
        $f[] = Form::radio('auth_open', '权限验证',$info['auth_open'])->options([['label' => '是', 'value' => 1], ['label' => '否', 'value' => 2]])->col(12);
        $f[] = Form::radio('status', '是否禁止',$info['status'])->options([['label' => '否', 'value' => 1], ['label' => '是', 'value' => 0]])->col(12);
        $f[] = Form::input('name', '菜单地址',$info['name'])->placeholder("格式例如：AuthRule/index（控制器名/方法名）");
        $f[] = Form::number('sort', '菜单排序', $info['sort'])->min(0);
        if ($info['type']==1){
            $f[] = Form::frameInputOne('icon', '图标', Route::buildUrl('Temp/icon', array('fodder' => 'icon')),$info['icon'])->icon('ionic')->height('300px');
        }

        $f[] = Form::input('param', '其它参数',$info['param'])->placeholder("其它参数");
        $form = Form::make_post_form('修改', $f, Route::buildUrl('upAndAdd'));
        $this->assign(compact('form'));
        return $this->fetch('public/form-builder');
    }


    /**
     * @return string|\think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:菜单添加节点
     */
    public function addNode(){
        if (IS_AJAX) {
            $data = $this->request->post();
             if (empty($data['title']) || empty($data['name'])) {
                 return parent::JsonReturn("请填写节点名称地址", 0);
             }
             $num = AuthRules::where("pid", $data['pid'])->where("type", 2)->count("id");
             $all = count($data['title']) + $num;
             if ($all > 8) {
                 return parent::JsonReturn("菜单节点总共超过8，已存在{$num}个节点", 0);
             }
             try {
                 $arr = [];
                 foreach ($data['title'] as $k => $v) {
                     $arr[] = [
                         'pid' => $data['pid'],
                         'type' => 2,
                         'auth_open' => $data['auth_open'],
                         'status' => $data['status'],
                         'title' => $v,
                         'name' => $data['name'][$k],
                         'create_time' => time()
                     ];
                 }
                 $res = Db::name("auth_rule")->insertAll($arr);
                 if ($res) {
                     return parent::JsonReturn("添加成功");
                 }
                 return parent::JsonReturn("添加失败", 0);
             } catch (Exception $exception) {
                 return parent::JsonReturn($exception->getMessage(), 0);
             }
        }
        $pid = $this->request->param("id/d");//id
        $info = AuthRules::find($pid);
        $this->assign(compact("info", "pid"));
        return $this->fetch();
    }


    /**
     * @return mixed
     * @author: DER <der1998@gmail.com>
     * @describe:删除选中的菜单
     */
    public function del_all()
    {
        if (IS_AJAX) {
            $ids = $this->request->post("ids");
            return $this->model->delAll($ids);
        }
    }


}