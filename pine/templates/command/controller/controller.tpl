<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;

class {:controller_name} extends SiteCommonController implements \pine\manual\ControllerManual, \pine\manual\UtilityManual
{
    protected $command_name = "{:command_name}";
}

