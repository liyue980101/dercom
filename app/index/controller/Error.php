<?php
namespace app\index\controller;
header('Content-Type: text/html; charset=utf-8');
use app\admin\service\WordService;
use app\BaseController;
use app\command\JrkadminCurd;
use app\common\service\QrcodeSrvice;
use think\console\Input;
use think\console\Output;
use think\Exception;
use think\facade\Console;


class Error
{
    /**
     * @param $method
     * @param $args
     * @return string
     */
    public function __call($method, $args): string
    {
        return 'error request!';
    }

}
