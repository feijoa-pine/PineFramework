<?php
{:fileheader}
declare(strict_types=1);
namespace pine;
use \pine\UME as UME;
use \pine\util\EX as EX;
use \pine\util\I18N as I18N;

class UMESettings
{
    public static function getDefaultValidators()
    {
        return array(
            // file
            "file" => array(UME::SIZE_FILE, function($obj, $key, $req, $conditions)
            {
                if(!$conditions["require"] && empty($req["tmp_name"]))  { return $req; }
                if( $conditions["require"] && empty($req["tmp_name"]))
                {
                    $obj->setVE($key, I18N::get("UME.tmp_file_not_uploaded", [$conditions["name"]], "[:@0] がアップロードファイルされていません。"));
                    return $req;
                }
                if(!empty($req["tmp_name"]) && !file_exists($req["tmp_name"]))
                {
                    $obj->setVE($key, I18N::get("UME.tmp_file_not_exists", [$conditions["name"]], "[:@0] のアップロードファイルが見つかりません。"));
                    return $req;
                }
                
                // 許容されているMIME-Typeリスト
                $allowed_mimes = explode("|", $conditions["type"]);
                $allowed_mimes = array_map(function($val){ return strtolower($val); }, $allowed_mimes);
                
                // アップロードファイルのMIME-Typeが許可されているか？
                $exts = MIME::getExtentionByMIMEType($req["real_type"]);
                foreach($exts as $ext)
                {
                    if(in_array($ext, $allowed_mimes, true)){ return $req; }
                }
                $obj->setVE($key, I18N::get("UME.invalid_file_type", [$conditions["name"], $req["name"], $conditions["type"], $req["real_type"]], "[:@0] の [:@1] は、許可されていないファイル形式です。[許可形式： :@2 | 入力： :@3]"));
                return $req;
            }),
            
            // text
            "text, string" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                return (string)$req;
            }),
                    
            // digit 全て数字か？
            "digit" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true){
                    $req = mb_convert_kana($req, "n", "UTF-8");
                }
                if (EX::is_empty($req)){ return $req; }
                if (!ctype_digit((string)$req)){
                    $obj->setVE($key, I18N::get("UME.invalid_digit_value", [$conditions["name"]], "[:@0] には数字以外が含まれています。"));
                    return $req;
                }
                return (string)$req;
            }),
                    
            // alphabet 全てアルファベットか？
            "alphabet" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true){
                    $req = mb_convert_kana($req, "r", "UTF-8");
                }
                if (EX::is_empty($req)){ return $req; }
                if (!ctype_alpha($req)){
                    $obj->setVE($key, I18N::get("UME.invalid_alphabet_value", [$conditions["name"]], "[:@0] には英字以外が含まれています。"));
                    return $req;
                }
                return (string)$req;
            }),
                    
            // int
            "int" => array(UME::SIZE_NUMBER, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true){
                    $req = mb_convert_kana($req, "a", "UTF-8");
                    $req = str_replace($obj->thousands_separator, "", $req);
                    $req = $obj->adjustHyphen($req);
                }
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A\-?([1-9]\d*|0)\z/", $req)){
                    $obj->setVE($key, I18N::get("UME.invalid_integer_value", [$conditions["name"]], "[:@0] は整数でなければなりません。"));
                    return $req;
                }
                return (int)$req;
            }),
                    
            // odd_int
            "odd" => array(UME::SIZE_NUMBER, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true){
                    $req = mb_convert_kana($req, "a", "UTF-8");
                    $req = str_replace($obj->thousands_separator, "", $req);
                    $req = $obj->adjustHyphen($req);
                }
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A\-?([1-9]\d*|0)\z/", $req)){
                    $obj->setVE($key, I18N::get("UME.invalid_integer_value", [$conditions["name"]], "[:@0] は整数でなければなりません。"));
                    return $req;
                }
                if ((int)$req % 2 === 0)
                {
                    $obj->setVE($key, I18N::get("UME.invalid_odd_integer_value", [$conditions["name"]], "[:@0] は奇数でなければなりません。"));
                    return $req;
                }
                return (int)$req;
            }),
                    
            // even_int
            "even" => array(UME::SIZE_NUMBER, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true){
                    $req = mb_convert_kana($req, "a", "UTF-8");
                    $req = str_replace($obj->thousands_separator, "", $req);
                    $req = $obj->adjustHyphen($req);
                }
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A\-?([1-9]\d*|0)\z/", $req)){
                    $obj->setVE($key, I18N::get("UME", "ume.ja_JP.invalid_integer_value", [$conditions["name"]], "[:@0] は整数でなければなりません。"));
                    return $req;
                }
                if ((int)$req % 2 !== 0)
                {
                    $obj->setVE($key, I18N::get("UME.invalid_even_integer_value", [$conditions["name"]], "[:@0] は偶数でなければなりません。"));
                    return $req;
                }
                return (int)$req;
            }),
                    
            // 4の倍数
            "even4" => array(UME::SIZE_NUMBER, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true){
                    $req = mb_convert_kana($req, "a", "UTF-8");
                    $req = str_replace($obj->thousands_separator, "", $req);
                    $req = $obj->adjustHyphen($req);
                }
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A\-?([1-9]\d*|0)\z/", $req)){
                    $obj->setVE($key, I18N::get("UME.invalid_integer_value", [$conditions["name"]], "[:@0] は整数でなければなりません。"));
                    return $req;
                }
                if ((int)$req % 4 !== 0)
                {
                    $obj->setVE($key, I18N::get("UME.invalid_even_integer_value", [$conditions["name"]], "[:@0] は4の倍数でなければなりません。"));
                    return $req;
                }
                return (int)$req;
            }),
                    
            // positive int
            "pint" => array(UME::SIZE_NUMBER, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true){
                    $req = mb_convert_kana($req, "a", "UTF-8");
                    $req = str_replace($obj->thousands_separator, "", $req);
                    $req = $obj->adjustHyphen($req);
                }
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A([1-9]\d*|0)\z/", $req)){
                    $obj->setVE($key, I18N::get("UME.invalid_positive_integer_value", [$conditions["name"]], "[:@0] は正の整数でなければなりません。"));
                    return $req;
                }
                return (int)$req;
            }),
            
            // comma sepalated int
            "commaint" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true){
                    $req = mb_convert_kana($req, "a", "UTF-8");
                    $req = preg_replace("/[、，]/u", ",", $req);
                }
                if (EX::is_empty($req)){ return $req; }
                
                $split  = explode(",", (string)$req);
                foreach($split as $val)
                {
                    if (!preg_match("/\A\d+\z/", $val)){
                        $obj->setVE($key, I18N::get("UME.invalid_integer_value", [$conditions["name"]], "[:@0] は整数でなければなりません。"));
                        return $req;
                    }
                }
                return (string)implode(",", $split);
            }),    
               
            // decimal 整数と小数
            "decimal" => array(UME::SIZE_NUMBER, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "a", "UTF-8");
                    $req = str_replace($obj->thousands_separator, "", $req);
                    $req = $obj->adjustHyphen($req);
                }
                if (EX::is_empty($req)){ return $req; }
                if (!is_numeric($req)){
                    $obj->setVE($key, I18N::get("UME.invalid_decimal_value", [$conditions["name"]], "[:@0] は数値でなければなりません。"));
                    return $req;
                }
                if(preg_match("/\A\-?([1-9]\d*|0)[.]\d+\z/", $req)){
                    return (double)$req;
                }
                return (int)$req;
            }),
                    
            // decimal1 整数と一桁までの小数
            "decimal1" => array(UME::SIZE_NUMBER, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "a", "UTF-8");
                    $req = str_replace($obj->thousands_separator, "", $req);
                    $req = $obj->adjustHyphen($req);
                }
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A\-?([1-9]\d*|0)([.]\d{1})?\z/", $req)){
                    $obj->setVE($key, I18N::get("UME.invalid_decimal1_value", [$conditions["name"]], "[:@0] は数値（小数は1桁まで）でなければなりません。"));
                    return $req;
                }
                if(preg_match("/\A\-?([1-9]\d*|0)[.]\d{1}\z/", $req)){
                    return (double)$req;
                }
                return (int)$req;
            }),
        
            // decimal2 整数と二桁までの小数
            "decimal2" => array(UME::SIZE_NUMBER, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "a", "UTF-8");
                    $req = str_replace($obj->thousands_separator, "", $req);
                    $req = $obj->adjustHyphen($req);
                }
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A\-?([1-9]\d*|0)([.]\d{2})?\z/", $req)){
                    $obj->setVE($key, I18N::get("UME.invalid_decimal2_value", [$conditions["name"]], "[:@0] は数値（小数は2桁まで）でなければなりません。"));
                    return $req;
                }
                if(preg_match("/\A\-?([1-9]\d*|0)[.]\d{2}\z/", $req)){
                    return (double)$req;
                }
                return (int)$req;
            }),
        
            // mail RFC822準拠メールアドレス
            "mail_rfc822" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "a", "UTF-8");
                }
                if (EX::is_empty($req)){ return $req; }
                if(!filter_var($req, FILTER_VALIDATE_EMAIL)){
                    $obj->setVE($key, I18N::get("UME.invalid_rfc822_mailaddress_value", [$conditions["name"]], "[:@0] はメールアドレスがの書式が間違っています。（RFC822に準拠していません）"));
                    return $req;
                }
                return $req;
            }),
        
            // alpha numeric
            "alphanum" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "a", "UTF-8");
                }
                if (EX::is_empty($req)){ return (string)$req; }
                if (!ctype_alnum((string)$req)){
                    $obj->setVE($key, I18N::get("UME.invalid_alphanum_value", [$conditions["name"]], "[:@0] は英数字以外が含まれています。"));
                    return $req;
                }
                return (string)$req;
            }),
                    
            // snakecase alpahbets and numeric
            "snake" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = strtolower(mb_convert_kana($req, "a", "UTF-8"));
                }
                if (EX::is_empty($req)){ return (string)$req; }
                if (!preg_match("/\A[a-z][a-z0-9_]+[a-z0-9]\z/", (string)$req)){
                    $obj->setVE($key, I18N::get("UME.invalid_snake_alphanum_value", [$conditions["name"]], "[:@0] はスネークケース外の英数字が含まれています。"));
                    return $req;
                }
                return (string)$req;
            }),
                    
            // ascii
            "ascii" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "a", "UTF-8");
                }
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A[\x21-\x7E]+\z/", $req)){
                    $obj->setVE($key, I18N::get("UME.invalid_ascii_value", [$conditions["name"]], "[:@0] はASCII文字以外が含まれています。"));
                    return $req;
                }
                return (string)$req;
            }),
            
            // hiragana
            "hiragana" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "HVc", "UTF-8");
                    $req = str_replace("ヽ", "ゝ", $req);
                    $req = str_replace("ヾ", "ゞ", $req);
                }
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A(\p{Hiragana}|\x{30FC})+\z/u", $req)){
                    $obj->setVE($key, I18N::get("UME.invalid_hiragana_value", [$conditions["name"]], "[:@0] はひらがな以外が含まれています。"));
                    return $req;
                }
                return (string)$req;
            }),
                    
            // katakana
            "katakana" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "KVC", "UTF-8");
                    $req = str_replace("ゝ", "ヽ", $req);
                    $req = str_replace("ゞ", "ヾ", $req);
                }
                
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A(\p{Katakana}|\x{30FC})+\z/u", $req)){
                    $obj->setVE($key, I18N::get("UME.invalid_katakana_value", [$conditions["name"]], "[:@0] はカタカナ以外が含まれています。"));
                    return $req;
                }
                return (string)$req;
            }),
            
            // katakana
            "katakananame" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "KVCS", "UTF-8");
                    $req = str_replace("ゝ", "ヽ", $req);
                    $req = str_replace("ゞ", "ヾ", $req);
                }
                
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A(\p{Katakana}|\x{30FC})+(\p{Katakana}|\x{30FC}|　)(\p{Katakana}|\x{30FC})+\z/u", $req)){
                    $obj->setVE($key, I18N::get("UME.invalid_katakananame_value", [$conditions["name"]], "[:@0] はカタカナ以外が含まれているか、スペース区切りの名前形式ではありません。"));
                    return $req;
                }
                return (string)$req;
            }),
                    
            // hankana
            "hankana" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "kh", "UTF-8");
                }
                if (EX::is_empty($req)){ return $req; }
                if (!preg_match("/\A[ｦ-ﾟ]+\z/u", $req)){
                    $obj->setVE($key, I18N::get("UME.invalid_hankana_value", [$conditions["name"]], "[:@0] は半角カタカナ以外が含まれています。"));
                    return $req;
                }
                return (string)$req;
            }),
                    
            // date
            "date" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "n", "UTF-8");
                    $req = str_replace("／", "-", $req);
                    $req = str_replace("/", "-", $req);
                    $req = $obj->adjustHyphen($req);
                }
                if (EX::is_empty($req)){ return $req; }
                if ($req !== date("Y-m-d", strtotime($req))){
                    $obj->setVE($key, I18N::get("UME.invalid_date_value", [$conditions["name"]], "[:@0] は有効な日付ではありません。（2020-01-01の形式にしてください）"));
                    return $req;
                }
                return (string)$req;
            }),
                    
            // datetime
            "datetime" => array(UME::SIZE_STRING, function($obj, $key, $req, $conditions){
                if ($conditions['auto_correct'] === true)
                {
                    $req = mb_convert_kana($req, "ns", "UTF-8");
                    $req = str_replace("／", "-", $req);
                    $req = str_replace("/", "-", $req);
                    $req = str_replace("：", ":", $req);
                    $req = $obj->adjustHyphen($req);
                }
                if (EX::is_empty($req)){ return $req; }
                if ($req !== date("Y-m-d H:i:s", strtotime($req))){
                    $obj->setVE($key, I18N::get("UME.invalid_datetime_value", [$conditions["name"]], "[:@0] は有効な日時ではありません。（2020-01-01 00:00:00の形式にしてください）"));
                    return $req;
                }
                return (string)$req;
            }),
        );
    }
}
