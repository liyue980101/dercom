<?php
declare (strict_types = 1);

namespace app\admin\controller\article;

use app\admin\model\article\ArticleUsers;
use think\Request;
use app\common\controller\AdminBaseController;
use app\admin\service\ExcelService;
use think\Exception;
use think\facade\Db;
use app\common\service\FormBuilder as Form;
use think\facade\Route;

class ArticleUser extends AdminBaseController
{
    protected function initialize()
    {
         parent::initialize(); // TODO: Change the autogenerated stub

         $this->model=new ArticleUsers();

    }


}
