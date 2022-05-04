<?php


namespace app\index\controller;


use app\BaseController;
use think\facade\View;

class Common extends BaseController
{
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
     * @param $name
     * @param $arguments
     * @return \think\response\Json
     */
    public function __call($name, $arguments){
        return json('error request!',400);
    }
}