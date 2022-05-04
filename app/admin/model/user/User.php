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
// | Date: 2020/7/31 0031
// +----------------------------------------------------------------------
// | Description:
// +----------------------------------------------------------------------

namespace app\admin\model\user;


use app\common\model\AdminBaseModel;
use app\common\traits\JwtTrait;

class User extends AdminBaseModel
{

    use JwtTrait;

    protected $pk = 'id';

    protected $name = 'user';

    protected $insert = [];

    protected $hidden = ['pwd'];


    /**
     * @param $uid
     * @param string $field
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:查询当前用户信息
     */
    public static function getUserInfo($uid, $field = '')
    {
        if (strlen(trim($field))) $userInfo = self::where('uid', $uid)->field($field)->find();
        else  $userInfo = self::where('uid', $uid)->find();
        if (!$userInfo) return [];
        return $userInfo->toArray();
    }
}