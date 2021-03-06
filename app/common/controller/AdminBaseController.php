<?php

namespace app\common\controller;

use app\admin\model\AuthRule;
use app\common\traits\JumpReturn;
use Jrk\Tree;
use liliuwei\think\Jump;
use think\facade\View;
use think\App;
use think\exception\ValidateException;
use think\Validate;
use think\Exception;
use think\Request;
/**
 * Class AdminBaseController
 * @package app\common\controller
 * 后台继承的控制器
 */
abstract class AdminBaseController
{

    //自定义 数据返回
    use JumpReturn;

    //不是ajax 提交返回
    use Jump;

    /**
     * Request实例
     * @var \think\Request
     */
    protected $request;

    /**
     * 应用实例
     * @var \think\App
     */
    protected $app;

    /**
     * 是否批量验证
     * @var bool
     */
    protected $batchValidate = false;

    /**
     * 检测是否登录
     * @var array
     */
    protected $middleware = ['app\admin\middleware\CheckAdminLogin'];

    //请求参数
    protected $param;

    //当前域名
    protected $domain;
    // 模型
    protected $model;

    //service 层
    protected $service;

    //登录信息
    static $admin_info;

    /**
     * AdminBaseController constructor.
     * @param App $app
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function __construct(App $app)
    {
        $this->app = $app;
        $this->request = $this->app->request;

        // 控制器初始化
        $this->initialize();
    }


    /**
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @name: initialize
     * @describe:
     */
    protected function initialize()
    {
        //用户登录信息
        self::$admin_info=session(ADMIN_LOGIN_INFO);

        $this->initConfig();
        $this->initAssign();
        $this->initRequestConfig();
       //左侧菜单
        $this->menuList();
    }


    /**
     * @return string
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:index
     */
    public function index(){

        if (IS_AJAX){
            return $this->model->getAdminPageData($this->param);
        }
        return $this->fetch();
    }


    /**
     * @return mixed
     * @author: DER <der1998@gmail.com>
     * @describe:删除
     */
    public function del()
    {
        if (IS_AJAX) {
            $ids = $this->request->post("ids");

            return $this->model->delById($ids);
        }
    }



    /**
     * @param mixed ...$vars
     * @author: DER <der1998@gmail.com>
     * @name: assign
     * @describe:
     */
    protected function assign(...$vars)
    {
        View::assign(...$vars);
    }


    /**
     * @param string $template
     * @return string
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:
     */
    protected function fetch(string $template = '')
    {
        return View::fetch($template);
    }


    /**
     * @param Request $request
     * @return \think\response\Json
     * @author: DER <der1998@gmail.com>
     * @describe:编辑添加
     */
    public function upAndAdd(Request $request){
        if (IS_AJAX) {

            $data = $request->post();
            try {
                $data['admin_id'] = self::$admin_info['id'];
                return $this->model->doAll($data);
            } catch (Exception $exception) {
                return self::JsonReturn($exception->getMessage(), 0);
            }
        }
    }



    /**
     * 初始化配置
     * @return void
     * @author Jackhhy
     */
    public function initConfig()
    {
        // 请求参数
        $this->param = $this->request->param();

        //过滤一些额外参数
        if (isset($this->param['_'])){
            unset($this->param["_"]);
        }
        // 分页基础默认值
        defined('LIMIT') or define('LIMIT', isset($this->param['pageSize']) ? (int)$this->param['pageSize'] : 20);
        defined('PAGE') or define('PAGE', isset($this->param['pageNum']) ? (int)$this->param['pageNum'] : 1);
    }


    /**
     * @author: DER <der1998@gmail.com>
     * @name: initRequestConfig
     * @describe:初始化请求配置
     */
    public function initRequestConfig()
    {
        // 定义是否GET请求
        defined('IS_GET') or define('IS_GET', $this->request->isGet());
        // 定义是否POST请求
        defined('IS_POST') or define('IS_POST', $this->request->isPost());
        // 定义是否AJAX请求
        defined('IS_AJAX') or define('IS_AJAX', $this->request->isAjax());
        // 定义是否PAJAX请求
        defined('IS_PJAX') or define('IS_PJAX', $this->request->isPjax());
        // 定义是否PUT请求
        defined('IS_PUT') or define('IS_PUT', $this->request->isPut());
        // 定义是否DELETE请求
        defined('IS_DELETE') or define('IS_DELETE', $this->request->isDelete());
        // 定义是否HEAD请求
        defined('IS_HEAD') or define('IS_HEAD', $this->request->isHead());
        // 定义是否PATCH请求
        defined('IS_PATCH') or define('IS_PATCH', $this->request->isPatch());
        // 定义是否为手机访问
        defined('IS_MOBILE') or define('IS_MOBILE', $this->request->isMobile());
    }


    /**
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:菜单列表
     */
    public function menuList(){

        if (self::$admin_info['id'] !=1){
            $data=AuthRule::where("id","in",session("admin_rules"))->where("type","1")->where("status",1)->select()->toArray();
            if (!empty($data)){
                foreach ($data as $k => $v) {
                    if (!empty($v['name'])) {
                        $data[$k]['url'] = (string)url($v['name']);
                    }
                }
            }
        }else{
            //超级管理员拥有所有权限
            $data = AuthRule::menuList();
        }
        //dump(Tree::DeepTree($data));
        View::assign("menulist",  empty($data) ? []:Tree::DeepTree($data));
    }


    /**
     * @author: DER <der1998@gmail.com>
     * @name: initAssign
     * @describe:
     */
    public function initAssign()
    {
        //获取当前配置的网站地址
        $this->domain = $this->request->domain();
        $this->assign("domain", $this->domain);
        //系统名称和版本号和站点地址
        $this->assign('_version', VERSION);
        $this->assign('_name', _NAME);
        $this->assign("_site",SITE_URL);

        //用户登录信息
        $this->assign("_info",session(ADMIN_LOGIN_INFO));
    }


    /**
     * @param string $msg
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @name: exception
     * @describe:
     */
    protected function exception($msg = '无法打开页面')
    {
        $this->assign(compact('msg'));
        exit($this->fetch('public/error'));
    }


    /**
     * @return string
     * @author: DER <der1998@gmail.com>
     * @name: makeToken
     * @describe:生成一个不会重复的字符串
     */
    public function makeToken()
    {
        $str = md5(uniqid(md5(microtime(true)), true)); //
        $str = sha1($str); //加密
        return $str;
    }

    /**
     * @param $name
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @name: _empty
     * @describe:
     */
    public function _empty($name)
    {
        exit($this->fetch('admin@public/404'));
    }


    /**
     * @param string $msg
     * @param int $url
     * @return \think\response\Json
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @date: 2020/7/17 0017
     * @describe:错误提醒页面
     */
    protected function failed($msg = '哎呀…亲…您访问的页面出现错误', $url = 0)
    {
        if ($this->request->isAjax()) {
            return self::JsonReturn($msg,0,$url);
        } else {
           $this->assign(compact('msg', 'url'));
            exit($this->fetch('public/error'));
        }
    }


    /**
     * @param string $msg
     * @param int $url
     * @return \think\response\Json
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:成功提醒
     */
    protected function successed($msg = '恭喜你，提交成功！', $url = 0){
        if ($this->request->isAjax()) {
            return self::JsonReturn($msg,1,$url);
        } else {
            $this->assign(compact('msg', 'url'));
            exit($this->fetch('public/success'));
        }
    }




    /**
     * 验证数据
     * @access protected
     * @param array $data 数据
     * @param string|array $validate 验证器名或者验证规则数组
     * @param array $message 提示信息
     * @param bool $batch 是否批量验证
     * @return array|string|true
     * @throws ValidateException
     */
    protected function validate(array $data, $validate, array $message = [], bool $batch = false)
    {
        try {
            if (is_array($validate)) {
                $v = new Validate();
                $v->rule($validate);
            } else {
                if (strpos($validate, '.')) {
                    // 支持场景
                    list($validate, $scene) = explode('.', $validate);
                }
                $class = false !== strpos($validate, '\\') ? $validate : $this->app->parseClass('validate', $validate);
                $v = new $class();
                if (!empty($scene)) {
                    $v->scene($scene);
                }
            }

            $v->message($message);

            //是否批量验证
            if ($batch || $this->batchValidate) {
                $v->batch(true);
            }

            $result = $v->failException(false)->check($data);
            if (true !== $result) {
                return $v->getError();
            } else {
                return $result;
            }
        } catch (\Exception $e) {
            $this->error($e->getMessage());
        }
    }


}