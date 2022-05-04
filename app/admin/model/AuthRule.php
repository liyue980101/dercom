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
// | Date: 2020/6/27 0027
// +----------------------------------------------------------------------
// | Description:  
// +----------------------------------------------------------------------

namespace app\admin\model;


use app\admin\model\AuthRule as AuthRules;
use app\admin\validate\CheckAuth;
use app\common\impl\Comm;
use app\common\model\AdminBaseModel;
use Jrk\Tree;
use think\Exception;
use think\facade\Db;


class AuthRule extends AdminBaseModel implements Comm
{
    protected $name = "auth_rule";


    public function getAdminPageData($param = [], $order = 'id asc')
    {
        // TODO: Implement getAdminPageData() method.
        $where = [];

        if (isset($param['title']) && $param['title'] != '') {
            $where[] = ['title', 'like', "%" . $param['title'] . "%"];

        }
        try {
            $data = self::where($where)->order($order)->select()->toArray();
            $count = self::where($where)->count("id");
            if (!empty($data)) {
                foreach ($data as $k => $v) {
                    if ($v['type'] == 1) { //菜单
                        $f = $this->isChild($v['id']);
                        if ($f) {
                            $data[$k]['_no'] = 1;
                        } else {
                            $data[$k]['_no'] = 2;
                        }
                    }
                }
            }

            // return json($data);
            return parent::ajaxResult(Tree::addLevelTree($data), $count);
        } catch (Exception $exception) {
            return parent::ajaxResult([], 0, 100, $exception->getMessage());
        }

    }


    public function doAll($data)
    {
        try {
            //验证提交的数据
            $validate = new CheckAuth();
            if (!$validate->check($data)) {
                return parent::JsonReturn($validate->getError(), 0);
            }
            if (!isset($data['id'])) {
                $res = AuthRules::where(['title' => "" . $data['title'] . ""])->find();
                if ($res) {
                    return parent::JsonReturn($data['title'] . "该名称已存在", 0);
                }
            }
            // TODO: Implement doAll() method.
            return parent::doAllData($data);
        } catch (Exception $exception) {
            return parent::JsonReturn($exception->getMessage(), 0);
        }
    }


    /**
     * @param $id
     * @return \think\response\Json
     * @author: DER <der1998@gmail.com>
     * @describe:删除选中的菜单
     */
    public function delAll($id)
    {
        return parent::del($id);
    }


    /**
     * @param $id
     * @return mixed|\think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:删除单个菜单，有子集不能删除
     */
    public function delById($id)
    {
        // TODO: Implement delById() method.
        $res = $this->findChild($id);
        if ($res == false) {
            return parent::JsonReturn("当前菜单下有子集，不能删除", 0);
        }
        return parent::del($id);
    }


    /**
     * @param $id
     * @return bool
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:查询是否有子集
     */
    private function findChild($id)
    {
        $res = Tree::getChildrenPid(self::where("status", "=", 1)->order('sort desc')->select(), $id);
        if (empty($res)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * @param array $where
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:菜单列表
     */
    public static function menuList(array $where = [])
    {
        $where['status'] = 1;
        $where['type'] = 1;
        $rule = self::where($where)->order('sort desc')->select();
        if (!empty($rule)) {
            foreach ($rule as $k => $v) {
                if (!empty($v['name'])) {
                    $rule[$k]['url'] = (string)url($v['name']);
                }
            }
            return $rule->toArray();
        } else {
            return [];
        }
    }


    /**
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:
     */
    public static function menuALL(array $where = [])
    {
        $rule = self::where($where)->order('sort desc')->select();
        if (!empty($rule)) {
            foreach ($rule as $k => $v) {
                if (!empty($v['name'])) {
                    $rule[$k]['url'] = (string)url($v['name']);
                }
            }
            return $rule->toArray();
        } else {
            return [];
        }
    }


    /**
     * @param $id
     * @return bool
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:
     */
    protected function isChild($id)
    {
        $res = self::where("pid", $id)->where("type", 1)->find();
        if ($res) {
            return false;
        }
        return true;
    }

    /**
     * @param $node
     * @return bool
     * @author: DER <der1998@gmail.com>
     * @describe:节点权限验证
     */
    public static function auth_verify($node)
    {
        //超级管理员跳过
        if (session(ADMIN_LOGIN_INFO)['id'] == 1) {
            return true;
        }
        if (empty($node)) {
            return false;
        }
        if (!stripos($node, ".")) {
            $node = ucfirst($node);
        } else {
            $n = explode(".", $node);
            $node = $n[0] . '.' . ucfirst($n[1]);
        }
        //根据传入的节点获取当前 id
        $id = self::where(["type" => 2, 'name' => $node])->value("id");
        if (empty($id)) {
            return false;
        }
        //当前用户授权的 菜单和按钮id
        $ok_ids = session("admin_rules");
        if (in_array($id, $ok_ids)) {
            return true;
        }
        return false;
    }

}