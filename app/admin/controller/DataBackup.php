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

namespace app\admin\controller;


use app\admin\service\ExcelService;
use app\admin\service\MysqlBackupService;
use app\common\controller\AdminBaseController;
use think\Db;
use think\Exception;
use think\facade\Cache;
use think\Request;
use think\facade\Session;

class DataBackup extends AdminBaseController
{


    protected $db;

    protected function initialize()
    {
        parent::initialize(); // TODO: Change the autogenerated stub
        $this->db = new MysqlBackupService();
    }

    /**
     * @return string
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:
     */
    public function index()
    {
       // dd($this->db->dataList());
        $this->assign("list", $this->db->dataList());
        return $this->fetch();
    }


    /***
     * @return string
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:查看表属性
     */
    public function showtable()
    {
        $table = $this->request->param("table");
        $this->assign("list", $this->db->dataList($table));
        return $this->fetch('show_table');
    }


    /**
     * @return string
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:备份文件列表
     */
    public function importlist()
    {
        $this->assign("list", $this->db->fileList());
        return $this->fetch('importlist');
    }


    /**
     * @param int $time
     * @param null $part
     * @param null $start
     * @return \think\response\Json
     * @throws \Exception
     * @author: DER <der1998@gmail.com>
     * @describe:备份还原
     */
    public function import($time = 0, $part = null, $start = null)
    {
        $db = new MysqlBackupService();
        if (is_numeric($time) && is_null($part) && is_null($start)) {
            $list = $db->getFile('timeverif', $time);
            if (is_array($list)) {
                Cache::set('backup_list', $list);
                return parent::JsonReturn("初始化完成",1,'',array('part' => 1, 'start' => 0));
            } else {
                return parent::JsonReturn("备份文件可能已经损坏，请检查！",0);
            }
        } else if (is_numeric($part) && is_numeric($start)) {

            $list = Cache::get('backup_list');

            $start = $db->setFile($list)->import($start);

            if (false === $start) {
                return parent::JsonReturn("还原数据出错",0);

            } elseif (0 === $start) {
                if (isset($list[++$part])) {
                    $data = array('part' => $part, 'start' => 0);
                    return parent::JsonReturn("正在还原...#{$part}",1,'',$data);
                } else {
                    Cache::delete('backup_list');
                    return parent::JsonReturn("还原完成");
                }
            } else {
                $data = array('part' => $part, 'start' => $start[0]);
                if ($start[1]) {
                    $rate = floor(100 * ($start[0] / $start[1]));
                    return parent::JsonReturn("正在还原...#{$part} ({$rate}%)",1,'',$data);
                } else {
                    $data['gz'] = 1;
                    return parent::JsonReturn("正在还原...#{$part}",1,'',$data);
                }
                return parent::JsonReturn("正在还原...#{$part}");
            }
        } else {
            return parent::JsonReturn("参数错误",0);

        }
    }


    /**
     * @param int $time
     * @return mixed|void
     * @author: DER <der1998@gmail.com>
     * @describe:删除备份文件
     */
    public function del($time = 0)
    {
        if ($this->db->delFile($time)) {
            $this->success("备份文件删除成功！");
        } else {
            $this->error("备份文件删除失败，请检查权限！");
        }
    }


    /**
     * @param int $time
     * @author: DER <der1998@gmail.com>
     * @describe:下载备份文件
     */
    public function down($time = 0)
    {
        $this->db->downloadFile($time);
    }


    /**
     * @throws \think\db\exception\BindParamException
     * @throws \think\exception\PDOException
     * @author: DER <der1998@gmail.com>
     * @describe:备份表
     */
    public function export()
    {
        $db = new MysqlBackupService();
        try {
            if (IS_POST) {
                $input = input('post.');
                $fileinfo = $db->getFile();
                //检查是否有正在执行的任务
                $lock = "{$fileinfo['filepath']}backup.lock";
                if (is_file($lock)) {
                    return parent::JsonReturn("检测到有一个备份任务正在执行，请稍后再试！",0);
                } else {
                    //创建锁文件
                    @file_put_contents($lock, time());
                }
                // 检查备份目录是否可写
                is_writeable($fileinfo['filepath']) || $this->error('备份目录不存在或不可写，请检查后重试！');

                //缓存锁文件
                Cache::set('lock', $lock);
                //缓存备份文件信息
                Cache::set('backup_file', $fileinfo['file']);
                //缓存要备份的表
                Cache::set('backup_tables', $input['tables']);

                //创建备份文件
                if (false !== $db->Backup_Init()) {
                    return parent::JsonReturn("初始化成功！",1,"",['tab' => ['id' => 0, 'start' => 0]]);
                } else {
                    return parent::JsonReturn("初始化失败，备份文件创建失败！",0);
                }
            } else if (IS_GET) {
                $tables = Cache::get('backup_tables');
                $file = Cache::get('backup_file');
                $id = input('id');
                $start = input('start');
                $start = $db->setFile($file)->backup($tables[$id], $start);
                if (false === $start) {
                    return parent::JsonReturn("备份出错",0);
                } else if (0 === $start) {
                    if (isset($tables[++$id])) {
                        $tab = array('id' => $id, 'start' => 0);
                        return parent::JsonReturn("备份完成!",1,'',array('tab' => $tab));
                    } else { //备份完成，清空缓存
                        unlink(Cache::get('lock'));
                        Cache::delete('backup_tables');
                        Cache::delete('backup_file');
                        return parent::JsonReturn("备份完成!");
                    }
                }
            } else {
                return parent::JsonReturn("参数错误");
            }
        } catch (Exception $exception) {
            return parent::JsonReturn($exception->getMessage(),0);
        }

    }


    /**
     * @param null $tables
     * @return \think\response\Json
     * @author: DER <der1998@gmail.com>
     * @describe:修复表
     */
    public function repair($tables = null)
    {
       if ($this->db->repair($tables)) {
           return parent::JsonReturn("数据表修复完成");
        } else {
           return parent::JsonReturn("数据表修复出错请重试",0);
        }
    }

    /**
     * @param null $tables
     * @return \think\response\Json
     * @author: DER <der1998@gmail.com>
     * @describe:优化表
     */
    public function optimize($tables = null)
    {
        if ($this->db->optimize($tables)) {
            return parent::JsonReturn("数据表优化完成");
        } else {
            return parent::JsonReturn("数据表优化出错请重试",0);
        }
    }

}