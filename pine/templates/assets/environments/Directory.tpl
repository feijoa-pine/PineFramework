<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;
use \pine as pine;

class Directory
{
    /**
     * 対象データベースの接続情報であるDB情報オブジェクトを返す
     * 
     * @param   string  $target     // 
     * @return  string
     */
    public static function get(string $target = "default") : string
    {
        // TODO: メンバ関数の存在チェックを行う
    
        $environment = \pine\consts_selector\ConstsSelector::get();
        return self::$target($environment);
    }
    
    private static function default(string $environment): string
    {
        switch(true)
        {
            // 本番環境
            case $environment === "product":
                
                return "/path/to/anywhere";
            
            // 開発環境
            case $environment === "develop":
            default:
                
                return "C:\path\to\anywhere";
        }
    }
    
}
