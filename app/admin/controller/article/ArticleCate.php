<?php
declare (strict_types=1);

namespace app\admin\controller\article;

use app\admin\model\article\ArticleCates;
use app\admin\model\article\ArticleModels;
use app\admin\validate\CheckArticleCate;
use app\common\controller\AdminBaseController;
use Jrk\Tree;
use think\Request;
use think\Exception;
use app\common\service\FormBuilder as Form;
use think\facade\Route;

class ArticleCate extends AdminBaseController
{
    protected function initialize()
    {
        parent::initialize(); // TODO: Change the autogenerated stub

        $this->model = new ArticleCates();

        $this->assign("models",ArticleModels::adminGetModelSelect());
    }


    /**
     * @return string|\think\response\Json
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:添加
     */
    public function add()
    {
        $f = [];
        $f[] = Form::select('pid', '上级栏目', '0')->setOptions(function () {
            $tree = Tree::toFormatTree($this->model->select()->toArray(), "name");
            $options = [];
            $options[] = ['label' => "顶级栏目", 'value' => 0];
            foreach ($tree as $k => $v) {
                $options[] = ['label' => $v['title_show'], 'value' => $v['id']];
            }
            return $options;
        })->multiple(false);

        $f[] = Form::select('model_id', '选择模型', '0')->setOptions(function () {
            $tree = ArticleModels::adminGetModelSelect();
            $options = [];
            $options[] = ['label' => "请选择模型", 'value' => 0];
            foreach ($tree as $k => $v) {
                $options[] = ['label' => $v['name'], 'value' => $v['id']];
            }
            return $options;
        })->multiple(false);
        $f[] = Form::input('name', '栏目名称：')->required("请输入栏目名称")->placeholder("请输入栏目名称")->info("请输入栏目名称");
        $f[] = Form::input('urls', '外部链接：')->placeholder("当选择链接模型的时候有效")->info("链接需http://或https://开头,当选择链接模型的时候有效");
        $f[] = Form::radio('is_show', '是否显示：', 1)->options([['label' => '显示', 'value' => 1], ['label' => '不显示', 'value' => 0]])->col(9);
        $f[] = Form::input('sort', '排序：', 10)->placeholder("排序")->col(9);
        $f[] = Form::textarea('description', '描述：')->placeholder("描述")->rows(5);
        $form = Form::make_post_form('添加栏目', $f, Route::buildUrl('upAndAdd'));
        $this->assign(compact('form'));
        return $this->fetch('public/form-builder');
    }


    /**
     * @param $id
     * @return string|\think\response\Json
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:编辑
     */
    public function edit($id)
    {
        $info = $this->model->where("id", $id)->find()->toArray();
        if (!$info) {
            return parent::failed("未查询到数据");
        }
        $f = [];
        $f[] = Form::select('pid', '上级栏目', "{$info['pid']}")->setOptions(function () {
            $tree = Tree::toFormatTree($this->model->select()->toArray(), "name");
            $options = [];
            $options[] = ['label' => "顶级栏目", 'value' => 0];
            foreach ($tree as $k => $v) {
                $options[] = ['label' => $v['title_show'], 'value' => $v['id']];
            }
            return $options;
        })->multiple(false);

        $f[] = Form::select('model_id', '选择模型', "{$info['model_id']}")->setOptions(function () {
            $tree = ArticleModels::adminGetModelSelect();
            $options = [];
            $options[] = ['label' => "请选择模型", 'value' => 0];
            foreach ($tree as $k => $v) {
                $options[] = ['label' => $v['name'], 'value' => $v['id']];
            }
            return $options;
        })->multiple(false);
        $f[] = Form::input('name', '栏目名称：',$info['name'])->required("请输入栏目名称")->placeholder("请输入栏目名称")->info("请输入栏目名称");
        $f[] = Form::input('urls', '栏目地址：',$info['url'])->info("栏目地址是提交后修改的不可以修改")->readonly(true);
        $f[] = Form::hidden('id', $id);
        $f[] = Form::radio('is_show', '是否显示：', $info['is_show'])->options([['label' => '显示', 'value' => 1], ['label' => '不显示', 'value' => 0]])->col(9);
        $f[] = Form::input('sort', '排序：',$info['sort'])->placeholder("排序")->col(9);
        $f[] = Form::textarea('description', '描述：',$info['description'])->placeholder("描述")->rows(5);
        $form = Form::make_post_form('添加栏目', $f, Route::buildUrl('upAndAdd'));
        $this->assign(compact('form'));
        return $this->fetch('public/form-builder');
    }


}
