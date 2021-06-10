<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;
use \pine\Dto as Dto;
use \pine\bamboo as bamboo;
use \pine\bamboo\Where as Where;
use \pine\bamboo\Assert as Assert;
use \pine\bamboo\OrderBy as OrderBy;

class {:model_name}Model extends SiteCommonModel implements \pine\manual\ModelManual, \pine\manual\UtilityManual
{
    protected function _exec(Dto $dto) : bool
    {
        // write your codes here.

        return true;
    }
    
}
