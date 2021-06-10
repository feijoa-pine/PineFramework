<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;
use \pine\Dto as Dto;
use \pine\util\TICKET as TICKET;
use \pine\ResponseType as ResponseType;
use \pine\SESSION as SESSION;
use \pine\util\DATASTORE as DATASTORE;

abstract class SiteCommonAction extends \pine\BaseAction implements \pine\manual\ActionManual, \pine\manual\UtilityManual
{
    const   SITE_MAP    = true;

    protected $static_page                  = false;
    protected $ume_class                    = null;
    protected $validate_ticket              = true;
    protected $validate_ticket_on_get       = false;
    protected $validate_ticket_by           = TICKET::BY_COOKIE;
    protected $regenerate_ticket_after_post = true;
    protected $transaction                  = true;
    protected $response_type                = ResponseType::HTML;
    
    /**
     * アクションの実行に先立って行うサイト共通の前処理
     * 
     * @param   Dto   $dto
     * @return  bool                falseをreturnすると、BaseActionはlogic()は実行せずにcloser()を実行してコントローラーに処理を返す
     */
    protected function prepareSiteCommon(Dto $dto) : bool
    {
        // write your codes here.
        
        return true;
    }
    
    /**
     * ログアウト処理
     * 
     * @param   string  $redirect_uri
     * @return  void
     */
    protected function logout() : void
    {
        SESSION::purge();
        DATASTORE::getInstance()->setUserId("");
        
        $this->redirect("/login");
        
        exit;
    }
    
    /**
     * リジェクト処理
     * 
     * @return  void
     */
    protected function reject() : void
    {
        header("Location: /reject");
        exit;
    }
    
}
