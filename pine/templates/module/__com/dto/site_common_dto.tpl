<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;

abstract class SiteCommonDto extends \pine\BaseDto implements \pine\manual\DtoManual, \pine\manual\UtilityManual
{
    private $accessible = [];   // アクセスを許可するプロパティ名
    
    /**
     * マジックメソッドによるセッター（基底クラスから呼ばれる）
     * 
     * @param   string  $name
     * @param   mixed   $value      マジックメソッドによって設定する値
     * @return  bool                セットしたか？
     * @throw   Exception
     */
    protected function set_common(string $name, $value) : bool
    {
        switch(true)
        {
            case in_array($name, $this->accessible, true):
                $this->$name = $value;
                return true;
            
            default:
                return false;
        }
    }
    
    /**
     * マジックメソッドによるゲッター（基底クラスから呼ばれる）
     * 
     * @param   string  $name
     * @return  mixed   &$value     マジックメソッドによって取得変数への参照
     * @return  bool                ゲットしたか？
     * @throw   Exception
     */
    protected function get_common(string $name, &$value) : bool
    {
        switch(true)
        {
            case in_array($name, $this->accessible, true):
                $this->$name = $value;
                return true;
                
            default:
                return false;
        }
    }
    
}
