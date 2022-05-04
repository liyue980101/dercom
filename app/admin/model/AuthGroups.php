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
// | Date: 2020/6/29 0029
// +----------------------------------------------------------------------
// | Description:  
// +----------------------------------------------------------------------

namespace app\admin\model;


use app\admin\validate\CheckGroups;
use app\common\impl\Comm;
use app\common\model\AdminBaseModel;
use Jrk\Tree;
use think\Exception;

class AuthGroups extends AdminBaseModel implements Comm
{

    protected $name="auth_group";

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
    public function getAdminPageData($param = [], $order = 'id desc')
    {
        // TODO: Implement getAdminPageData() method.

        $where=[];
        if (isset($param['title']) && $param['title'] != '') {
            $where[] = ['title', 'like', "%" . $param['title'] . "%"];
        }

        if (!empty($param['isAsc']) && !empty($param['orderByColumn'])){
            $order="{$param['orderByColumn']} {$param['isAsc']}";
        }

        if (!empty($param['status'])){
            $status=(int)$param['status']-1;
            $where[] = ['status', '=', $status];
        }

        if (isset($param['time']) && $param['time'] != '') {
            $ck=@explode(" ~ ",$param['time']);
            $b=$ck[0]." 00:00:00";
            $e=$ck[1]." 23:59:59";
            $where[] = ['create_time', 'between', [strtotime($b),strtotime($e)]];
        }

        try {
            $data = self::limit_select($where,$order);
            //dd(self::getLastSql());
            $count = self::hhy_count($where);

            if (!empty($data)){
                $data=Tree::toFormatTree($data);
            }
            return parent::ajaxResult($data, $count);
        } catch (Exception $exception) {
            return parent::ajaxResult([], 0, 100, $exception->getMessage());
        }
    }


    public function delById($id)
    {
        // TODO: Implement delById() method.
        return parent::del($id);
    }



    public function doAll($data)
    {
        try {
            //验证提交的数据
            $validate = new CheckGroups();
            if (!$validate->check($data)) {
                return parent::JsonReturn($validate->getError(), 0);
            }
            if (!isset($data['id'])) {
                $res = self::where(['title' => "" . $data['title'] . ""])->find();
                if ($res) {
                    return parent::JsonReturn($data['title'] . "该名称已存在", 0);
                }
            }
            $data['rules'] = @implode(",", array_unique($data['rule']));
            unset($data['rule']);
            unset($data['admin_id']);
            // TODO: Implement doAll() method.
            return parent::doAllData($data);
        } catch (Exception $exception) {
            return parent::JsonReturn($exception->getMessage(), 0);
        }
    }


}