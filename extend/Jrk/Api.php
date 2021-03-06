<?php
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
// | Description:  各类API调用接口
// +----------------------------------------------------------------------

    namespace Jrk;

    class Api
    {

        /**
         * @param $postcom //快递公司编码
         * @param $getNu  //快递单号
         * @return mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/19
         * @name: queryExpress
         * @describe:查询快递
         */
        public static function queryExpress($postcom , $getNu) {
            $url = "https://m.kuaidi100.com/query?type=".$postcom."&postid=".$getNu."&id=1&valicode=&temp=0.49738534969422676";
            $resp = Http::get($url);
            return json_decode($resp,true);
        }




         /**
         * @param $qq
         * @return array
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: getQQ
         * @describe: 获取QQ信息
         */
       public static function getQQ($qq){
        $returnArr = ['code' => 0, 'msg' => '获取失败'];
        if (!$qq || !preg_match('|^[1-9]\d{4,10}$|i', $qq)) {
            $returnArr['msg'] = 'QQ格式错误';
            return $returnArr;
        }
        $nickname = file_get_contents('https://r.qzone.qq.com/fcg-bin/cgi_get_portrait.fcg?g_tk=1518561325&uins=' . $qq);
        $image = 'http://q.qlogo.cn/headimg_dl?dst_uin=' . $qq . '&spec=100';
        if (strstr($nickname, 'portraitCallBack')) {
            $name = trim(mb_convert_encoding($nickname, "UTF-8", "GBK"), 'portraitCallBack()');
            $name = json_decode($name, true);
            if (isset($name[$qq][6]) && !empty($name[$qq][6])) {
                $name = $name[$qq][6];
            } else {
                $name = '游客';
            }
            $returnArr = array('code' => 1, 'msg' => '成功', 'image' => $image, 'name' => $name, 'qq' => $qq);
        } else if (strstr($nickname, '_Callback')) {
            $returnArr['msg'] = '获取昵称失败';
        }
        return $returnArr;
       }


        /**
         * @param string $ip
         * @return array|bool|mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: ipLocation
         * @describe:根据IP获取详细地址
         */
       public static function ipLocation($ip=""){
           if (empty($ip)) $ip=self::getip();
           $url="https://v1.alapi.cn/api/ip?ip={$ip}";
           return self::returnArr($url);
       }




        /**
         * @param $url
         * @return array|bool|mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: sharePan
         * @describe:根据分享的百度网盘链接获取分享密码
         */
       public static function sharePan($url){
           $k=self::is_url($url);
           if (empty($url) || !$k){
               return ['code'=>0,'msg'=>"url错误"];
           }
           $url="https://v1.alapi.cn/api/bdpwd?url={$url}";
           return self::returnArr($url);
       }



        /**
         * @param $url
         * @return array|bool|mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: videoPrint
         * @describe:视频去除水印
         * 支持：抖音、快手、小红书、微视、火山小视频、秒拍、西瓜视频、今日头条、陌陌视频、映客视频、小咖秀、皮皮搞笑、开眼、全民小视频、全民K歌、最右、小影、微博、美拍、皮皮虾等平台的短视频去水印解析
         */
       public static function videoPrint($url){
           $k=self::is_url($url);
           if (empty($url) || !$k){
               return ['code'=>0,'msg'=>"url错误"];
           }
           $url="https://v1.alapi.cn/api/video/jh?url={$url}";
           return self::returnArr($url);
       }


        /**
         * @param $url
         * @return array|bool|mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: lanzhou
         * @describe:通过蓝奏云的分享链接直接获取下载地址
         */
       public static function lanzhouYun($url){
           $k=self::is_url($url);
           if (empty($url) || !$k){
               return ['code'=>0,'msg'=>"url错误"];
           }
           $url="https://v1.alapi.cn/api/lanzou?url={$url}";
           return self::returnArr($url);
       }




        /**
         * @param $docid
         * @return array|bool|mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: wyNewsDetail
         * @describe:网易新闻详细信息
         */
       public static function wyNewsDetail($docid){
           if (empty($docid)) {
               return ['code'=>0,'msg'=>"docid 错误"];
           }
           $url="https://v1.alapi.cn/api/new/detail?docid={$docid}";
           return self::returnArr($url);
       }



        /**
         * @param int $page
         * @return array|bool|mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: hanFu
         * @describe:汉服新闻
         */
       public static function hanFu($page=1){
           $url="https://v1.alapi.cn/api/new/hanfu?page={$page}&num=20";
           return self::returnArr($url);
       }


        /**
         * @param int $num
         * @return array|bool|mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: weiBoSearchHot
         * @describe:微博热搜榜单
         */
       public static function weiBoSearchHot($num=30){
           $url="https://v1.alapi.cn/api/new/wbtop?num={$num}";
           return self::returnArr($url);
       }


        /**
         * @param $domain
         * @return array|bool|mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: domainBeiAn
         * @describe:域名备案查询
         */
       public static function domainBeiAn($domain){
           if (empty($domain)){
               return ['code'=>0,'msg'=>"域名错误"];
           }
           $url="https://v1.alapi.cn/api/icp?domain={$domain}";
           $k=self::returnArr($url);
           $u="https://v1.alapi.cn/api/whois?domain={$domain}";
           $f=self::returnArr($u);
           if ($k['code']==200 && $f['code']==200){
               $arr=[
                   'code'=>200,'msg'=>'success','data'=>array_merge($k['data'],$f['data'])
               ];
               return $arr;
           }else{
               return $k;
           }
       }



        /**
         * @param $dan
         * @return array|bool|mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: kuaiDi
         * @describe:快递查询
         */
       public static function kuaiDi($dan){
           if (empty($dan)){
               return ['code'=>0,'msg'=>"单号错误"];
           }
           $url="https://v1.alapi.cn/api/kd?number={$dan}";
           return self::returnArr($url);
       }



        /**
         * @param string $typeid
         * @return array|bool|mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: mingYan
         * @describe:名言名句
         * 名言类型：1——爱情 2——道德 3——青春 4——愿望 5——集体 6——理想 7——志向 8——人才 9——谦虚 10——人格 11——天才 12——青年 13——社会 14——国家 15——财富 16——智慧 17——修养 18——工作 19——妇女 20——儿童
         * 21——思想 22——理智 23——学习 24——科学 25——信仰 26——诚信 27——读书 28——成败 29——奉献 30——劳动 31——节约 32——教育 33——企业 34——事业 35——时间 36——勤奋 37——民族 38——真理 39——友谊 40——自由
         * 41——心理 42——心灵 43——人生 44——幸福 45——团结
         */
       public static function mingYan($typeid=""){
           $url="https://v1.alapi.cn/api/mingyan?typeid={$typeid}";
           return self::returnArr($url);
       }




        /**
         * @param $url
         * @return array|bool|mixed
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: returnArr
         * @describe:返回数据
         */
       public static function returnArr($url){
           $r=Http::ApiCurl($url);
           $res=json($r);
            if (is_object($res)){
                $res=self::object_to_array($res);
            }
            if (!is_array($res)){
                return false;
            }
           if ($res['code']==200){
               if (isset($res['author'])){
                   unset($res['author']);
               }
               return $res;
           }else{
               return ['code'=>0,"msg"=>isset($res['msg'])?$res['msg']:'未请求到数据'];
           }
       }



        /**
         * @param $url
         * @return bool
         * @author: hhygyl <jackhhy520@qq.com>
         * @name: is_url
         * @describe:验证url
         */
        public static function is_url($url){
            if(empty($url)) return false;
            if(preg_match("/\b(?:(?:https?|ftp):\/\/|www\.)[-a-z0-9+&@#\/%?=~_|!:,.;]*[-a-z0-9+&@#\/%=~_|]/i",$url)){
                return true;
            }else{
                return false;
            }
        }



        /**
         * @param $obj
         * @return array|void
         * @author: DER <der1998@gmail.com>
         * @date: 2020/3/26
         * @name: object_to_array
         * @describe:对象 转 数组
         */
       public  static  function object_to_array($obj) {
            $obj = (array)$obj;
            foreach ($obj as $k => $v) {
                if (gettype($v) == 'resource') {
                    return;
                }
                if (gettype($v) == 'object' || gettype($v) == 'array') {
                    $obj[$k] = (array)self::object_to_array($v);
                }
            }
            return $obj;
        }


        /**
         * @return mixed|string
         * @author: hhygyl <hhygyl520@qq.com>
         * @name: getip
         * @describe:获取IP地址
         */
        public static function getip()
        {
            if(getenv('HTTP_CLIENT_IP') && strcasecmp(getenv('HTTP_CLIENT_IP'), 'unknown')) {
                $ip = getenv('HTTP_CLIENT_IP');
            }
            else if(getenv('HTTP_X_FORWARDED_FOR') && strcasecmp(getenv('HTTP_X_FORWARDED_FOR'), 'unknown')) {
                $ip = getenv('HTTP_X_FORWARDED_FOR');
            }
            else if(getenv('REMOTE_ADDR') && strcasecmp(getenv('REMOTE_ADDR'), 'unknown')) {
                $ip = getenv('REMOTE_ADDR');
            }
            else if(isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR'] && strcasecmp($_SERVER['REMOTE_ADDR'], 'unknown')) {
                $ip = $_SERVER['REMOTE_ADDR'];
            }
            return preg_match('/[\d\.]{7,15}/', $ip, $matches) ? $matches [0] : '127.0.0.1';
        }

    }