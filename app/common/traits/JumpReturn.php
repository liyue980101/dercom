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

namespace app\common\traits;

use think\response\Json;
trait JumpReturn
{

    /**
     * @param array $data
     * @param int $code
     * @param string $msg
     * @param int $count
     * @return Json
     * @author: DER <der1998@gmail.com>
     * @date: 2020/6/25 0025
     * @describe: 返回 bootstrap-table 表格的数据格式
     */
    public static function ajaxResult(array $data=[],int $count=0,int $code = 0, string $msg = '')
    {
        $result = [
            'code' => $code,
            'msg'  => $msg,
            'time' => time(),
            'rows' => $data,
            'total'=> $count
        ];
        return json($result);
    }


    /**
     * @param array $data
     * @param int $code
     * @param string $msg
     * @param int $count
     * @return Json
     * @author: DER <der1998@gmail.com>
     * @date: 2020/6/25 0025
     * @describe: 返回 layui 表格的数据格式
     */
    public static function layuiResult(array $data=[],int $count=0,int $code = 0, string $msg = '')
    {
        $result = [
            'code' => $code,
            'msg'  => $msg,
            'time' => time(),
            'rows' => $data,
            'count'=> $count
        ];
        return json($result);
    }


    /**
     * @param string $msg
     * @param int $code
     * @param string $url
     * @param array $data
     * @return Json
     * @author: DER <der1998@gmail.com>
     * @date: 2020/6/25 0025
     * @describe:返回数据
     */
    public static function  JsonReturn(string $msg="",int $code=1, string $url="",array $data=[]){
        $data = ['code' => $code, 'msg' => $msg,'url'=>$url,'data'=>$data,"time"=>time()];
        return json($data);
    }



}