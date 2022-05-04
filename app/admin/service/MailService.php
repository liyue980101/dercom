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
// | Date: 2020/7/31 0031
// +----------------------------------------------------------------------
// | Description:
// +----------------------------------------------------------------------

namespace app\admin\service;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

class MailService
{
    /**
     * @param $to
     * @param string $subject
     * @param string $content
     * @param string $addAttachment
     * @return array
     * @throws Exception
     * @author: DER <der1998@gmail.com>
     * @describe:发送邮件
     */
    public static function sendEmail($to,$subject='',$content='',$addAttachment=''){
        //判断openssl是否开启
        $openssl_funcs = get_extension_funcs('openssl');
        if(!$openssl_funcs){
            return ['code'=>0 , 'msg'=>'请先开启openssl扩展'];
        }
        $config=sysconfig("mail");
        $mail = new PHPMailer;
        $mail->CharSet  = 'UTF-8'; //设定邮件编码，默认ISO-8859-1，如果发中文此项必须设置，否则乱码
        $mail->isSMTP();
        $mail->SMTPDebug = 0;
        //Whether to use SMTP authentication
        $mail->SMTPAuth = true;
        //调试输出格式
        $mail->Debugoutput = 'html';
        //smtp服务器
        $mail->Host = $config['mail_smtp_host'];
        //端口 - likely to be 25, 465 or 587
        $mail->Port = $config['mail_smtp_port'];
        $mail->SMTPSecure =$config['mail_secure'];// 使用安全协议 tls,ssl
        //用户名
        $mail->Username = $config['mail_smtp_user'];
        //密码
        $mail->Password = $config['mail_smtp_pass'];
        //Set who the message is to be sent from
        $mail->setFrom($config['mail_smtp_user'],$config['mail_smtp_name']);
        //回复地址
        //$mail->addReplyTo('replyto@example.com', 'First Last');
        //接收邮件方
        if(is_array($to)){
            foreach ($to as $v){
                $mail->addAddress($v);
            }
        }else{
            $mail->addAddress($to);
        }
        $mail->isHTML(true);// send as HTML
        //标题
        $mail->Subject = $subject;
        //邮箱正文
        $mail->Body = $content;
        //添加附件
        if (!empty($addAttachment)){
            $mail->addAttachment($addAttachment);
        }
        try {
            $mail->send();
            return ['code'=>1 , 'msg'=>'发送成功'];
        }catch (Exception $e){
            return ['code'=>0 , 'msg'=>$e->getMessage()];
        }
    }

}