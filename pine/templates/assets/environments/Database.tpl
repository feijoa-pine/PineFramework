<?php
{:fileheader}
declare(strict_types=1);
namespace pine\bamboo;
use \pine as pine;
use \pine\bamboo\DB as DB;

class Database
{
    /**
     * 対象データベースの接続情報であるDB情報オブジェクトを返す
     * 
     * @param   string  $target     // 
     * @return  pine\bamboo\DB
     */
    public static function getDB(string $target="default") : DB
    {
        $environment = \pine\consts_selector\ConstsSelector::get();
        
        switch(true)
        {
            // デフォルトデータベース
            case $target === "default":
            default:
                return self::default($environment);
        }
    }
    
    /**
     * デフォルトデータベース
     * 
     * @param   string      $environment   
     * @return  pine\bamboo\DB
     */
    private static function default(string $environment) : DB
    {
        $db         = new DB;
        $db->id     = "default";
        
        switch(true)
        {
            // 本番環境
            case $environment === "product":
                
                $db->system         = "MySQL";
                $db->version        = "8.0.18";
                $db->dbhost         = "127.0.0.1";
                $db->port           = 3306;
                $db->dbname         = "database_name";
                $db->schema         = "";
                $db->l_schema       = "";
                $db->dbuser         = "user_name";
                $db->dbpass         = "********";
                $db->engine         = "InnoDB";
                $db->charset        = "utf8mb4";
                $db->collate        = "utf8mb4_ja_0900_as_cs_ks";
                $db->persistent     = true;
                $db->timestamp_precision = 0;
                return $db;
            
            // 開発環境
            case $environment === "develop":
            default:
                
                $db->system         = "MySQL";
                $db->version        = "8.0.23";
                $db->dbhost         = "127.0.0.1";
                $db->port           = 3306;
                $db->dbname         = "database_name";
                $db->schema         = "";
                $db->l_schema       = "";
                $db->dbuser         = "user_name";
                $db->dbpass         = "********";
                $db->engine         = "InnoDB";
                $db->charset        = "utf8mb4";
                $db->collate        = "utf8mb4_ja_0900_as_cs_ks";
                $db->persistent     = true;
                $db->timestamp_precision = 0;
                return $db;
        }
    }
    
}
