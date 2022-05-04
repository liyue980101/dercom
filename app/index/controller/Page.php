<?php
namespace app\index\controller;
header('Content-Type: text/html; charset=utf-8');

use app\admin\model\PageEmail;
use app\admin\model\PageSetting;
use app\BaseController;
use think\App;


class Page extends Common
{
    protected $PageSettingModel = null;
    protected $PageEmailModel = null;

    public function __construct(App $app)
    {
        parent::__construct($app);
        $this->PageSettingModel = new PageSetting();
        $this->PageEmailModel = new PageEmail();
    }

    public function index()
    {

        $page = $this->request->param('page',1);
        $pageModel = new PageSetting();
        $row = $pageModel->where("page_num", $page)->find();
        if(empty($row->id)){
            $page = 1;
            $row = $pageModel->where("page_num", $page)->find();
        }
        if(!empty($row->id)){
            $row = $row->toArray();
        }
        $jumpUrl = $row['jump_url'];
        $this->assign('jumpUrl',$jumpUrl);
        $this->assign('pageNum',$row['page_num']);

        return $this->fetch('page');
    }

    public function postMail(){
        $email = $this->request->param('email');
        //var_dump($this->request->param());exit;
        $p = $this->request->param('p');
        $jump_url = $this->request->param('jump_url');
        //验证邮箱格式

        //记录数据
        $eg = "/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/";
        $eg = "/^([0-9A-Za-z\\-_\\.]+)@([0-9a-z]+\\.[a-z]{2,3}(\\.[a-z]{2})?)$/i";
        if($email && preg_match($eg, $email)){
            $this->PageEmailModel->doAllData(['email'=>$email,'p'=>$p]);
        }

        echo 1;

        //跳转
        //Header("Location:$jump_url");

    }



}
