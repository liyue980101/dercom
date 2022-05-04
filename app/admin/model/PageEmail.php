<?php
declare (strict_types=1);

namespace app\admin\model;

use app\common\impl\Comm;
use app\common\model\AdminBaseModel;
use think\Exception;


/**
 * @mixin \think\Model
 */
class PageEmail extends AdminBaseModel implements Comm
{

    protected $name = "page_email_collect";

    public function getAdminPageData($param = [], $order = 'id asc')
    {
        // TODO: Implement getAdminPageData() method.

        $where = [];
        if (isset($param['email']) && $param['email'] != '') {
            $where[] = ['email', 'like', '%'.$param['email'].'%'];
        }

        if (!empty($param['isAsc']) && !empty($param['orderByColumn'])) {
            $order = "{$param['orderByColumn']} {$param['isAsc']}";
        }

        if (isset($param['time']) && $param['time'] != '') {
            $ck = @explode(" ~ ", $param['time']);
            $b = $ck[0] . " 00:00:00";
            $e = $ck[1] . " 23:59:59";
            $where[] = ['create_time', 'between', [strtotime($b), strtotime($e)]];
        }

        try {
            $data = self::limit_select($where, $order);

            $count = self::hhy_count($where);

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

    }

}
