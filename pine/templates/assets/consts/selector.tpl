<?php
{:fileheader}
declare(strict_types=1);
namespace pine\consts_selector;

class ConstsSelector
{
    public static function get() : string
    {
        return (isset($_SERVER["SERVER_NAME"]))
                    ? self::web($_SERVER["SERVER_NAME"])
                    : self::cli($_SERVER["COMPUTERNAME"] ?? $_SERVER["LOGNAME"]."@".$_SERVER["WSL_DISTRO_NAME"])
                    ;
    }
    
    /**
     * WEBアクセスの場合
     * 
     * @param   type    $domain
     * @return  string
     */
    private static function web(string $domain) : string
    {
        $environment = "";
        switch(true)
        {
            // 本番環境
            case $domain === "domain.to.production":
                $environment    = "product";
                break;
            
            // 開発環境
            case $domain === "domain.to.develop":
            default:
                $environment    = "develop";
                
        }
        return $environment;
    }
    
    private static function cli(string $domain) : string
    {
        $environment = "";
        switch(true)
        {
            // 開発環境
            case $domain === "computer.name":
            default:
                $environment    = "develop";
                
        }
        return $environment;
    }
}