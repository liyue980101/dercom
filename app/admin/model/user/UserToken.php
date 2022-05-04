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

class UserToken extends AdminBaseModel
{
    protected $name = 'user_token';

    protected $type = [
        'create_time' => 'int',
        'login_ip' => 'string'
    ];

    /**
     * @param User $user
     * @param $type
     * @return UserToken
     * @author: DER <der1998@gmail.com>
     * @describe:创建token并且保存
     */
    public static function createToken(User $user, $type): self
    {
        $tokenInfo = $user->getToken($type);
        return self::create([
            'uid' => $user->uid,
            'token' => $tokenInfo['token'],
            'expires_time' => date('Y-m-d H:i:s', $tokenInfo['params']['exp'])
        ]);
    }


    /**
     * @return int
     * @throws \think\db\exception\DbException
     * @author: DER <der1998@gmail.com>
     * @describe:删除一天前的过期token
     */
    public static function delToken()
    {
        $del=self::where('expires_time', '<', date('Y-m-d H:i:s',strtotime('-1 day')))->delete();
        return $del;
    }

}