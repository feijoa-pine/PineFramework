<?php
{:fileheader}
namespace pine\app;
use \pine\app\CONSTS as CONSTS;
use \pine\bamboo as bamboo;
use \pine\Dto as Dto;
use \pine\util\FILE as FILE;
use \pine\util\PATH as PATH;
use \pine\util\DATASTORE as DATASTORE;

abstract class SiteCommonModel extends \pine\BaseModel implements \pine\manual\ModelManual, \pine\manual\UtilityManual
{
    protected function _exec_common(Dto $dto) : bool
    {
        // write your codes here.

        return true;
    }
    
    protected function command_dir() : string
    {
        return PATH::realjoin(CONSTS::MODULES, DATASTORE::instance()->full_command);
    }
    
    
    protected function assets_dir() : string
    {
        return PATH::realjoin(CONSTS::MODULES, DATASTORE::instance()->full_command, "assets");
    }
    
}
