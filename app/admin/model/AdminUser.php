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
// | Date: 2020/6/26 0026
// +----------------------------------------------------------------------
// | Description:  
// +----------------------------------------------------------------------

namespace app\admin\model;


use app\common\impl\Comm;
use app\common\model\AdminBaseModel;
use think\Exception;
use think\facade\Db;

class AdminUser extends AdminBaseModel implements Comm
{

    protected $name="admin";
    //隐藏字段
    protected $hidden=["password"];

    /**
     * @param array $param
     * @param string $order
     * @return mixed|\think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:
     */
    public function getAdminPageData($param = [], $order = 'id asc')
    {
        // TODO: Implement getAdminPageData() method.

        $where=[];
        if (isset($param['username']) && $param['username'] != '') {
            $where[] = ['username', 'like', "%" . $param['username'] . "%"];
        }

        if (!empty($param['isAsc']) && !empty($param['orderByColumn'])){
            $order="{$param['orderByColumn']} {$param['isAsc']}";
        }
        if (!empty($param['status'])){
            $status=(int)$param['status']-1;
            $where[] = ['status', '=', $status];
        }

        if (!empty($param['group_id']) && (int)$param['group_id']!=0){
             if ((int)$param['group_id']==1){//超管
                 $where[] = ['id', '=', 1];
             }elseif((int)$param['group_id']==0){ //全部
                 $where[] = ['id', '<>', 0];
             }else{
                 $ck= Db::name("auth_group_access")->field("uid")->where("group_id",(int)$param['group_id'])->select();
                 if ($ck){
                     $ids=[];
                     foreach ($ck as $k=>$v){
                         $ids[]=$v['uid'];
                     }
                     $where[] = ['id', 'in', $ids];
                 }
             }
        }

        if (isset($param['time']) && $param['time'] != '') {
            $ck=@explode(" ~ ",$param['time']);
            $b=$ck[0]." 00:00:00";
            $e=$ck[1]." 23:59:59";
            $where[] = ['create_time', 'between', [strtotime($b),strtotime($e)]];
        }

        try {
            $data = self::limit_select($where,$order);
            $count = self::hhy_count($where);

            return parent::ajaxResult($data, $count);
        } catch (Exception $exception) {
            return parent::ajaxResult([], 0, 100, $exception->getMessage());
        }
    }


    public static function getSexName($sex){
        $arr=[0=>'男',1=>'女',2=>'未知'];
        return $arr[$sex];
    }


    public static function getStatusName($status){
        $arr=[0=>'禁止',1=>'正常'];
        return $arr[$status];
    }



    public function delById($id)
    {
        if (is_array($id) && in_array(1,$id)){
            return self::JsonReturn("超级管理员不能删除",0);
        }else{
            if((int)$id==1){
                return self::JsonReturn("超级管理员不能删除",0);
            }
        }
        // TODO: Implement delById() method.
        return parent::del($id);
    }


    public function doAll($data)
    {
        // TODO: Implement doAll() method.
        return parent::doAllData($data);
    }


}