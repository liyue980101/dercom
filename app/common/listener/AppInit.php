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
// | Date: 2020/6/25 0025
// +----------------------------------------------------------------------
// | Description:  
// +----------------------------------------------------------------------

namespace app\common\listener;


class AppInit
{
    public function handle(){
        $this->initSystemConst();
    }

    /**
     * @author: DER <der1998@gmail.com>
     * @date: 2020/6/25 0025
     * @describe:初始化系统常量
     */
    private function initSystemConst(){
        !defined('SITE_URL') && define('SITE_URL', '');//网址
        !defined('VERSION') && define('VERSION', env("admin.admin_version","1.0")); //版本号
        !defined('_NAME') && define('_NAME', env("admin.admin_name",'admin-Tp6')); //系统名称
        !defined('DB_PREFIX') && define('DB_PREFIX' ,env('database.prefix', 'jrk_')); //数据库前缀
        !defined('DS') && define('DS', DIRECTORY_SEPARATOR);
        !defined('DS_CONS') && define('DS_CONS', '\\');
        !defined('ADMIN_LOGIN_INFO') && define('ADMIN_LOGIN_INFO', env("admin.admin_login_info")); //定义 配置的 后台登录信息
    }

}