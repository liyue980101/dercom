<?php
declare (strict_types=1);

namespace app\admin\model\article;

use app\admin\validate\CheckArticleCate;
use app\common\impl\Comm;
use app\common\model\AdminBaseModel;
use Jrk\Tree;
use think\facade\Route;
use think\Exception;


/**
 * @mixin \think\Model
 */
class ArticleCates extends AdminBaseModel implements Comm
{
    //
    //文章分类
    protected $name = "articles_cate";

    protected $hidden = ['models.id'];

    //
    public function getAdminPageData($param = [], $order = 'id asc')
    {
        // TODO: Implement getAdminPageData() method.
        $where = [];
        if (isset($param['name']) && $param['name'] != '') {
            $where[] = ['name', 'like', "%" . $param['name'] . "%"];
        }

        if (!empty($param['isAsc']) && !empty($param['orderByColumn'])) {
            $order = "{$param['orderByColumn']} {$param['isAsc']}";
        }

        if (!empty($param['is_show'])) {
            $status = (int)$param['is_show'] - 1;
            $where[] = ['is_show', '=', $status];
        }

        if (isset($param['time']) && $param['time'] != '') {
            $ck = @explode(" ~ ", $param['time']);
            $b = $ck[0] . " 00:00:00";
            $e = $ck[1] . " 23:59:59";
            $where[] = ['create_time', 'between', [strtotime($b), strtotime($e)]];
        }

        try {
            $data = self::with("models")->limit_select($where, $order);

            $count = self::hhy_count($where);

            if (!empty($data)) {
                $data = Tree::toFormatTree($data, "name");
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


    /**
     * @return \think\model\relation\HasOne
     * @author: DER <der1998@gmail.com>
     * @describe:
     */
    public function models()
    {
        return $this->hasOne(ArticleModels::class, "id", "model_id");
    }


    /**
     * @param $data
     * @return \think\response\Json
     * @author: DER <der1998@gmail.com>
     * @describe:添加编辑
     */
    public function doAll($data)
    {
        // TODO: Implement doAll() method.
        try {
            $check = new CheckArticleCate();
            if (!$check->check($data)) {
                return parent::JsonReturn($check->getError(), 0);
            }
            if ((int)$data['model_id'] == 4) {
                if (empty($data['urls'])) {
                    return parent::JsonReturn("外部链接必填", 0);
                }
            }
            $data['url']=$data['urls'];
            unset($data['urls']);

            if (isset($param['id'])) {
                $res = self::update($data);
                $id = $data['id'];
            } else {
                $res = self::save($data);
                $id = $this->id;
            }
            if ((int)$data['model_id'] != 4) {  //链接模型
                $fun = 'lists';
                if ((int)$data['model_id'] == 1 || (int)$data['pid'] == 0) {
                    $fun = 'index';
                }
                $this->edit(['id' => $id, 'url' => $this->getUrlToModelId($id, $data['model_id'], $fun), 'param' => json_encode(['cate' => $id])]);
            }
            if ($res) {
                return self::JsonReturn("更新添加成功");
            } else {
                return self::JsonReturn("更新添加失败", 0);
            }
        } catch (\Exception $e) {
            return self::JsonReturn($e->getMessage(), 0);
        }
    }

    /**
     * @param $id
     * @param $model_id
     * @param string $fun
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @author: DER <der1998@gmail.com>
     * @describe:生成前台可访问url
     */
    public function getUrlToModelId($id, $model_id, $fun = 'index')
    {
        $model_data = ArticleModels::adminGetTableNameToModelId($model_id);
        $u = 'index/' . $model_data['tablename'] . '/' . $fun;
        $url = Route::buildUrl($u, ['cate' => $id])->__toString();
        return $url;
    }


    public function edit($param)
    {
        return self::update($param);
    }





}
