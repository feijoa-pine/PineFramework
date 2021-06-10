<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;
use \pine\bamboo as bamboo;
use \pine\Dto as Dto;

abstract class CommandCommonView extends SiteCommonView implements \pine\manual\ViewManual, \pine\manual\UtilityManual
{
    /**
     * コマンド内の全Viewで共通に実行される関数
     * 
     * @param   Dto     $dto
     * @param   bool    $action_result
     * @return  bool
     */
    protected function cmd_common(Dto $dto, bool $action_result) : bool
    {
        $this->set([
              "keywords"        => null
            , "description"     => null
        ]);
        $this->merge([
              "head"            => []
            , "script"          => []
            , "css"             => []
        ]);
        
        return true;
    }
    
    /**
     * アクション毎の View::draw() で false が返された場合に呼ばれる関数
     * 
     * @param   Dto     $dto
     * @param   bool    $action_result
     * @return  bool
     */
    protected function cmd_fail(Dto $dto, bool $action_result) : bool
    {
        return false;
    }
}

////////////////////////////////////////////////////////////////////////////////
// Twig Filters
//   note: filterの記述場所を明確にするため、プレフィックスとして cmd_ を付加してください。
class CommandCommonTwigFilters extends SiteCommonTwigFilters implements \pine\manual\TwigFiltersManual
{
}

////////////////////////////////////////////////////////////////////////////////
// Twig Functions
//   note: functionの記述場所を明確にするため、プレフィックスとして cmd_ を付加してください。
class CommandCommonTwigFunctions extends SiteCommonTwigFunctions implements \pine\manual\TwigFunctionsManual
{
}
