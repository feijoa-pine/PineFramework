<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;
use \pine\bamboo as bamboo;
use \pine\Dto as Dto;
use \pine\util\DATASTORE as DATASTORE;
use \pine\util\NET as NET;
use \pine\util\TICKET as TICKET;

abstract class SiteCommonController extends \pine\BaseController implements \pine\manual\ControllerManual, \pine\manual\UtilityManual
{
    //****************************************************************************************
    //	プロトコルなどによるリダイレクト処理
    //****************************************************************************************
    protected function redirect(Dto $dto) : bool
    {
         // write your codes here.
        
        return true;
    }
    
    //****************************************************************************************
    //	認証処理
    //****************************************************************************************
    protected function authentication(Dto $dto) : bool
    {
        // write your codes here.
        
        return true;
    }
    
    
    //****************************************************************************************
    //	executeに先立って実行される先行処理
    //****************************************************************************************
    protected function prior(Dto $dto) : bool
    {
        // write your codes here.
        
        return true;
    }
    
}
