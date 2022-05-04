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
// | Date: 2020/8/5 0005
// +----------------------------------------------------------------------
// | Description:
// +----------------------------------------------------------------------

namespace app\api\middleware;

use app\Request;
use think\facade\Config;
use think\Response;

class AllowOriginMiddleware
{

    /**
     * header头
     * @var array
     */
    protected $header = [
        'Access-Control-Allow-Origin' => '*',
        'Access-Control-Allow-Headers' => 'Authori-zation,Authorization, Content-Type, If-Match, If-Modified-Since, If-None-Match, If-Unmodified-Since, X-Requested-With',
        'Access-Control-Allow-Methods' => 'GET,POST,PATCH,PUT,DELETE,OPTIONS,DELETE',
        'Access-Control-Max-Age' => '1728000'
    ];

    /**
     * 允许跨域的域名
     * @var string
     */
    protected $cookieDomain;

    /**
     * @param Request $request
     * @param \Closure $next
     * @return mixed
     * @author: DER <der1998@gmail.com>
     * @describe:
     */
    public function handle(Request $request, \Closure $next)
    {
        $this->cookieDomain = Config::get('cookie.domain', '');
        $header = $this->header;
        $origin = $request->header('origin');

        if ($origin && ('' != $this->cookieDomain && strpos($origin, $this->cookieDomain)))
            $header['Access-Control-Allow-Origin'] = $origin;

        if ($request->method(true) == 'OPTIONS') {
            $response = Response::create('ok')->code(200)->header($header);
        } else {
            $response = $next($request)->header($header);
        }
        $request->filter(['htmlspecialchars', 'strip_tags', 'addslashes', 'trim']);
        return $response;
    }

}