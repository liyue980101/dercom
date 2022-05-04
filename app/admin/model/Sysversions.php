<?php
declare (strict_types=1);

namespace app\admin\model;

use app\common\impl\Comm;
use app\common\model\AdminBaseModel;
use think\Exception;


/**
 * @mixin \think\Model
 */
class Sysversions extends AdminBaseModel implements Comm
{

    protected $name = "sys_version";

    /**
     * @param array $param
     * @param string $order
     * @return \think\response\Json
     * @author: DER <der1998@gmail.com>
     * @describe:
     */
    public function getAdminPageData($param = [], $order = 'id asc')
    {
        // TODO: Implement getAdminPageData() method.
        $where = [];

        if (!empty($param['isAsc']) && !empty($param['orderByColumn'])) {
            $order = "{$param['orderByColumn']} {$param['isAsc']}";
        }
        if (!empty($param['admin_id'])) {
            $admin_id = (int)$param['admin_id'];
            $where[] = ['admin_id', '=', $admin_id];
        }

        if (isset($param['time']) && $param['time'] != '') {
            $ck = @explode(" ~ ", $param['time']);
            $b = $ck[0] . " 00:00:00";
            $e = $ck[1] . " 23:59:59";
            $where[] = ['create_time', 'between', [strtotime($b), strtotime($e)]];
        }

        try {
            $data = self::with("adminUser")->limit_select($where, $order);
            $count = self::hhy_count($where);

            return parent::ajaxResult($data, $count);
        } catch (Exception $exception) {
            return parent::ajaxResult([], 0, 100, $exception->getMessage());
        }

    }


    //管理admin表
    public function adminUser()
    {
        return $this->hasOne(AdminUser::class, "id", "admin_id");
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
            if (empty($data['date_time'])) {
                return parent::JsonReturn("版本更新时间不能为空", 0);
            }
            $data['content'] = nl2br($data['content']);
            return parent::doAllData($data);

        } catch (Exception $exception) {
            return parent::JsonReturn($exception->getMessage(), 0);
        }
    }

}
