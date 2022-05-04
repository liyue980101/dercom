<?php
declare (strict_types=1);

namespace app\admin\model;

use app\common\impl\Comm;
use app\common\model\AdminBaseModel;
use think\Exception;


/**
 * @mixin \think\Model
 */
class PageSetting extends AdminBaseModel implements Comm
{

    protected $name = "page_setting";

    public function getAdminPageData($param = [], $order = 'id asc')
    {
        // TODO: Implement getAdminPageData() method.

        $where = [];
        if (isset($param['page_num']) && $param['page_num'] != '') {
            $where[] = ['page_num', '=', $param['page_num']];
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
        // TODO: Implement doAll() method.
        try {
            if (empty($data['page_num'])) {
                return parent::JsonReturn("页面序号不能为空", 0);
            }
            if (empty($data['jump_url'])) {
                return parent::JsonReturn("跳转地址不能为空", 0);
            }

            $row = $this->where("page_num", $data['page_num'])->find();
            if(!empty($row['id']) && ($row['id']!=$data['id'])){
                return parent::JsonReturn("页面序号已存在", 0);
            }

            return parent::doAllData($data);

        } catch (Exception $exception) {
            return parent::JsonReturn($exception->getMessage(), 0);
        }
    }

}
