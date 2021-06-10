<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;
use \pine\app\CONSTS as CONSTS;
use \pine\bamboo as bamboo;
use \pine\Dto as Dto;
use \pine\util\EX as EX;
use \pine\util\LOG as LOG;
use \pine\util\FILE as FILE;
use \pine\util\I18N as I18N;
use \pine\PineSettings as PineSettings;

abstract class SiteCommonView extends \pine\BaseView implements \pine\manual\ViewManual, \pine\manual\UtilityManual
{
    /**
     * サイト内の全Viewで共通に実行される関数
     * 
     * @param   Dto     $dto
     * @param   bool    $action_result
     * @return  bool
     */
    protected function site_common(Dto $dto, bool $action_result): bool
    {
        $this->set([
              "TITLE"           => CONSTS::SITE_TITLE
            , "APPLE_TITLE"     => CONSTS::SITE_TITLE
            , "SITE_TITLE"      => CONSTS::SITE_TITLE
            , "HOME_URL"        => CONSTS::HOME_URL
            , "AUTHMAIL"        => CONSTS::AUTHMAIL
            , "TICKET_KEY"      => PineSettings::TICKET_KEY
            , "sub_title"       => ""
            , "responce"        => $dto->response
            , "description"     => ""
        ]);
        $this->merge([
              "head"            => ["site_parts/head_script.twig"]
            , "script"          => [
                                    // jQuery
                                      "https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"
                                      
                                    // jQuery UI
                                    , "https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"
                                   
                                    // 軽量LightBoxライブラリ   https://github.com/imgix/luminous
                                    , "https://cdnjs.cloudflare.com/ajax/libs/luminous-lightbox/2.3.2/luminous.min.js"
                                    
                                    // JavaScriptテンプレートエンジン   https://qiita.com/suisui654/items/be3a7ef5aee273d0c96c
                                    , "https://cdnjs.cloudflare.com/ajax/libs/jsrender/1.0.11/jsrender.min.js"
                                    
                                    // グラフライブラリ https://www.chartjs.org/
                                    , "https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"
                                    
                                    // テーブルヘッダーフロートライブラリ　http://mkoryak.github.io/floatThead/
                                    , "https://cdnjs.cloudflare.com/ajax/libs/floatthead/2.2.1/jquery.floatThead.min.js"
                                    
                                    // textarea自動調整ライブラリ   http://www.jacklmoore.com/autosize
                                    , "https://cdn.jsdelivr.net/npm/autosize@4.0.4/dist/autosize.min.js"
                                    
                                    // チェックボックス・ラジオボタン装飾ライブラリ　http://icheck.fronteed.com/
                                    , "https://cdnjs.cloudflare.com/ajax/libs/iCheck/1.0.3/icheck.min.js"
                                    
                                    // UIフォーカス移動プラグイン   https://striking-forces.jp/
                                    , "/__com/libraries/jquery-plugins/jquery.fcs.js"
                                    
                                    // Pine Framework 標準サブウィンドウ支援ライブラリ
                                    , "/__com/libraries/pine-framework/Subwin.js"
                                    
                                    , "/__com/global/js/bundle.min.js"
                                    ]
            , "css"             => [
                                    // 軽量LightBoxライブラリ   https://github.com/imgix/luminous
                                      "https://cdnjs.cloudflare.com/ajax/libs/luminous-lightbox/2.3.3/luminous-basic.min.css|all"
                                    
                                    // チェックボックス・ラジオボタン装飾ライブラリ　http://icheck.fronteed.com/
                                    , "https://cdnjs.cloudflare.com/ajax/libs/iCheck/1.0.3/skins/all.min.css|all"
                                    
                                    , "/__com/global/css/bundle.min.css|all"
                                    ]
        ]);
        
        return true;
    }
    
    /**
     * アクション毎の View::draw() 及び ComandCommonView で false が返された場合に呼ばれる関数
     * 
     * @param   Dto     $dto
     * @param   bool    $action_result
     * @return  bool
     */
    protected function site_fail(Dto $dto, bool $action_result) : bool
    {
        $dto->http_status   = 501;
        $dto->view_message  = I18N::get("BaseView.false_returned_when_draw_executed", [], "View::draw() メソッド実行結果で false が返されました。\n異常系の描画処理を実装してください。");
        
        $this->prepare_status_code_view($dto, true);
        
        return true;
    }
    
    /**
     * ステータスコードによるエラー画面描画準備
     * 
     * @param   Dto     $dto
     * @param   bool    $action_result
     * @return  bool
     */
    protected function prepare_status_code_view(Dto $dto, bool $action_result) : bool
    {
        $this->val["index"] = "failure_report.twig";
        $this->val["tpl"]   = false;
        $verror             = "";
        
        switch($dto->http_status)
        {
            case 400:
                $this->val["http_status"]   = $dto->http_status;
                $this->val["title"]         = "400 Bad Request";
                $this->val["message"]       = I18N::get("BaseView.http_400", [], "リクエスト内容が不正です。");
                if(count($dto->response->verror) > 0)
                {
                    $this->val["verror"]    = $dto->response->verror;
                    $verror = "\n(summary)\n";
                    foreach($dto->response->verror as $key => $value)
                    {
                        $verror   .= "{$key} : {$value}\n";
                    }
                }
                break;
                
            case 405:
                $this->val["http_status"]   = $dto->http_status;
                $this->val["title"]         = "405 Method Not Allowed";
                $this->val["message"]       = I18N::get("BaseView.http_405", [], "このメソッドでのご要望のコマンド実行は許可されていません。");
                break;
            
            case 500:
                $this->val["http_status"]   = $dto->http_status;
                $this->val["title"]         = "500 Internal Server Error";
                $this->val["message"]       = I18N::get("BaseView.http_500", [], "サーバ内部にエラーが発生しました。");
                break;
            
            case 501:
                $this->val["http_status"]   = $dto->http_status;
                $this->val["title"]         = "501 Not Implemented";
                $this->val["message"]       = isset($dto->view_message)
                                                    ? $dto->view_message
                                                    : I18N::get("BaseView.http_501", [], "ご要望の機能は実装されていません。")
                                                    ;
                break;
        }
        
        $tracking_number                    = "";
        Log::output(LOG::W, "{$this->val["message"]}{$verror}", $tracking_number);
        $dto->response->tracking_number     = $tracking_number;
        
        http_response_code($dto->http_status);
        
        return true;
    }
}

////////////////////////////////////////////////////////////////////////////////
// Twig Filters
//   note: filterの記述場所を明確にするため、プレフィックスとして site_ を付加してください。
class SiteCommonTwigFilters extends \pine\BaseFiltersAndFunctions implements \pine\manual\TwigFiltersManual
{
}

////////////////////////////////////////////////////////////////////////////////
// Twig Functions
//   note: functionの記述場所を明確にするため、プレフィックスとして site_ を付加してください。
class SiteCommonTwigFunctions extends \pine\BaseFiltersAndFunctions implements \pine\manual\TwigFunctionsManual
{
    // hiddenのワンタイムチケット用<input/>フィールドを生成する
    public function site_hidden_ticket_raw(): string
    {
        if(!isset($_SESSION[PineSettings::TICKET_KEY])) { return ""; }
        return <<< EOL
<input type="hidden" name="{$this->h(PineSettings::TICKET_KEY)}" value="{$this->h($_SESSION[PineSettings::TICKET_KEY])}">
EOL;
    }
    
    // stylesheet属性出力
    public function site_css_hashed(string $value) : string
    {
        $parts  = explode("|", $value);
        return (count($parts) === 1)
                    ? "href=\"{$this->h($this->site_hash($parts[0]))}\""
                    : "href=\"{$this->h($this->site_hash($parts[0]))}\" media=\"{$this->h($parts[1])}\""
                    ;
    }
    
    // ファイルリンクの末尾にGETパラメタ（ブラウザキャッシュを利用させず強制的にファイルをダウンロードさせるためのトークン）を付加する
    public function site_hash(string $url): string
    {
        if(preg_match("/\A(http|\/\/)/", $url)) { return $url; }
        
        $split      = explode("?", $url);
        $file       = CONSTS::PUBLICS . $split[0];
        return (file_exists($file))
                        ? $this->h($url) . "?" . hash("fnv132", (string)filemtime($file))
                        : $this->h($url) . "?" . date("ymdHis")
                        ;
    }
    
}
