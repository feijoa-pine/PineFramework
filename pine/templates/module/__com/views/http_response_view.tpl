<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;
use \pine\bamboo as bamboo;
use \pine\Dto as Dto;

class HttpResponseView extends SiteCommonView implements \pine\manual\ViewManual, \pine\manual\UtilityManual
{
    protected function common(Dto $dto, bool $action_result): bool
    {
        $dto->tpl       = "http_response.html";
        $dto->head      = null;
        $dto->script    = null;
        $dto->css       = null;
        
        switch($dto->http_status)
        {
            case 405:
                $dto->title = $dto->http_status;
                $this->val["subtitle"]  = "405 Method Not Allowed";
                $this->val["message"]   = "@test"; //I18N::get($dto->M, "system.{$dto->locale}.http_405", null, "このメソッドでのご要望のコマンド実行は許可されていません。");
                break;
            case 500:
                $dto->title = $dto->http_status;
                $this->val["subtitle"]  = "500 Internal Server Error";
                $this->val["message"]   = "@test"; //I18N::get($dto->M, "system.{$dto->locale}.http_500", null, "サーバ内部にエラーが発生しました。");
                break;
            case 501:
                $dto->title = $dto->http_status;
                $this->val["subtitle"]  = "501 Not Implemented";
                $this->val["message"]   = "@test"; //I18N::get($dto->M, "system.{$dto->locale}.http_501", null, "ご要望の機能は実装されていません。");
                break;
        }
        Log::output(LOG::W, $this->val["message"]);
        http_response_code($dto->http_status);
        
        return true;
    }
    
    //****************************************************************************************
    //	abstract functions
    //****************************************************************************************
    protected function draw(Dto $dto, bool $action_result): bool { return true; }
    protected function cmd_common(Dto $dto, bool $action_result): bool { return true; }
    protected function cmd_fail(Dto $dto, bool $action_result): bool { return false; }

}

////////////////////////////////////////////////////////////////////////////////
// Twig Filters
//   note: filterの記述場所を明確にするため、プレフィックスとして act_ を付加してください。
class HTTPResponseTwigFilters extends SiteCommonTwigFilters implements \pine\manual\TwigFiltersManual
{
}

////////////////////////////////////////////////////////////////////////////////
// Twig Functions
//   note: functionの記述場所を明確にするため、プレフィックスとして act_ を付加してください。
class HTTPResponseTwigFunctions extends SiteCommonTwigFunctions implements \pine\manual\TwigFunctionsManual
{
}
