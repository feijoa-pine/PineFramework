<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;
use \pine\Dto as Dto;
use \pine\UME as UME;
use \pine\util\EX as EX;
use \pine\util\I18N as I18N;

class {:ume_name}UME extends SiteCommonUME implements \pine\manual\UMEManual, \pine\manual\UtilityManual
{
    public function __construct(\pine\Dto $dto)
    {
        parent::__construct($dto);
       
        $validators = $this->getLocalValidators();
        foreach($validators as $keys => $validator)
        {
            $this->registerValidator($keys, $validator);
        }
    }
    
    protected function getValidationDefinitions() : array
    {
        return [
{:validation_def}
        ];
    }
    
    protected function doCustomValidate(\pine\Dto $dto)
    {
        /* sample
        if($dto->R["test1"] !== \$dto->R["test2"]){
            $this->VE["unmatch_test"] = "テストパラメターが一致しません。";
        }
        */
    }
        
    protected function getLocalValidators() : array
    {
        return [
            /* sample
            // digit 全て数字か？
            "digit" => [UME::SIZE_STRING, function($obj, $key, $req, $conditions)
                        {
                            if ($conditions["auto_correct"] === true)
                            {
                                $req = mb_convert_kana($req, "n", "UTF-8");
                            }
                            if (EX::empty($req)){ return $req; }
                            if (!ctype_digit((string)$req))
                            {
                                $obj->setVE($key, I18N::get("UME.invalid_digit_value", [$conditions["name"]], "[:@0] には数字以外が含まれています。"));
                                return $req;
                            }
                            return (string)$req;
                        }],
            */
        ];
    }
}
