<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;
use \pine\Dto as Dto;
use \pine\util\TICKET as TICKET;
use \pine\ResponseType as ResponseType;

class {:action_name} extends SiteCommonAction implements \pine\manual\ActionManual, \pine\manual\UtilityManual
{
    const   SITE_MAP    =  {:site_map};
    
    protected $static_page                  = false;
    protected $ume_class                    = "{:default_ume}";
    protected $validate_ticket              = true;
    protected $validate_ticket_on_get       = false;
    protected $validate_ticket_by           = TICKET::BY_COOKIE;
    protected $regenerate_ticket_after_post = true;
    protected $transaction                  = {:transaction};
    protected $response_type                = ResponseType::{:response_type};
    
    protected function prepare(Dto $dto) : bool
    {
        // write your codes here.

        return true;
    }
    
    protected function verror(Dto $dto) : void {}
    
    protected function deficient(Dto $dto) : void {}
    
    protected function logic(Dto $dto) : bool
    {
        // write your codes here.
        
        return true;
    }
    
    protected function fail(Dto $dto) : void {}
    
    protected function done(Dto $dto) : void {}
    
    protected function always(Dto $dto) : void {}
    
    protected function closer(Dto $dto) : void {}
    
    public function sitemap(SiteMapDto $dto) : array
    {
        $dto->loc           = $this->get_loc($dto);
        $dto->lastmod       = date(DATE_ATOM, filemtime(__FILE__));
        $dto->changefreq    = null;
        $dto->priority      = "0.9";
        
        return [$dto];
    }
    
}
