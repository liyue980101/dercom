<?php

namespace app\admin\controller;

use liliuwei\think\Jump;

class Error
{
    use Jump;
    public function __call($name, $arguments)
    {
         $result = [
          'code' => 0,
          'msg'    => "不存在的请求",
          'data'  => []
        ];
        if (request()->isAjax()) {
             return json($result, 200);
        }
       $this->error("不存在的请求",url("index"));
    }
}