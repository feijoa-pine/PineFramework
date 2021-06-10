<?php
declare(strict_types=1);
namespace pine;
use \pine\bamboo as bamboo;
use \pine\util\LOG as LOG;
use \pine\app\CONSTS as CONSTS;
use \pine\consts_selector\ConstsSelector as ConstsSelector;

try
{
    // すべてのエラー処理でExceptionをスローする。
    set_error_handler(
        function ($errno, $errstr, $errfile, $errline)
        {
            throw new \ErrorException($errstr, 0, $errno, $errfile, $errline);
            return false; 
        }, E_ALL
    );
    
    require __DIR__ . "/../assets/consts/selector.php";
    require __DIR__ . "/../assets/consts/consts_" . ConstsSelector::get() . ".php";
    require CONSTS::PINEROOT . "/main/pine.php";
    
    $pine   = (new Pine())->main();
}
catch(\Throwable $th)
{
    if(class_exists("\\pine\\app\\CONSTS"))
    {
        require_once __DIR__ . "/../../../" . CONSTS::PINEDIR . "/core/bamboo/DB.php";
        require_once __DIR__ . "/../../../" . CONSTS::PINEDIR . "/core/bamboo/DBConnect.php";
        bamboo\DBConnect::getInstance()->close_all();

        require_once __DIR__ . "/../../../" . CONSTS::PINEDIR . "/core/utilities/LOG.php";
        $tracking_number = "";
        $result = Log::output(LOG::E, "<<STATUS: 500>>\n" . LOG::parseTh($th), $tracking_number);
    }
    
    require __DIR__ . "/../module/__com/views/root_error.php";
}
