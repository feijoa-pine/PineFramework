<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;
use \pine\bamboo as bamboo;
use \pine\Dto as Dto;

class {:view_name}View extends CommandCommonView implements \pine\manual\ViewManual, \pine\manual\UtilityManual
{
    /**
     * 画面表示
     *   SiteCommonView::site_common()->CommandCommonView::cmd_common()->View::draw()
     * 
     * @param   Dto     $dto
     * @param   bool    $action_result
     * @return  bool
     */
    protected function draw(Dto $dto, bool $action_result): bool
    {
        return ($dto->response->status === true)
                            ? $this->normal($dto)
                            : false
                            ;
    }
    
    /**
     * 入力内容にエラーが無い場合の正常系画面表示
     * 
     * @param   Dto       $dto
     * @return  bool
     */
    private function normal(Dto $dto): bool
    {
        $this->concat([
              "TITLE"           => "ページタイトル"
        ]);
        $this->set([
              "index"           => "index.twig"
            , "tpl"             => "{:action_name}.twig"
            , "keywords"        => null
            , "description"     => null
        ]);
        $this->merge([
              "head"            => null
            , "script"          => ["/{:command_name}/{:action_name}/js/bundle.min.js"]
            , "css"             => ["/{:command_name}/{:action_name}/css/bundle.min.css|all"]
        ]);
        
        return true;
    }

}

////////////////////////////////////////////////////////////////////////////////
// Twig Filters
//   note: filterの記述場所を明確にするため、プレフィックスとして act_ を付加してください。
class TwigFilters extends CommandCommonTwigFilters implements \pine\manual\TwigFiltersManual
{
}

////////////////////////////////////////////////////////////////////////////////
// Twig Functions
//   note: functionの記述場所を明確にするため、プレフィックスとして act_ を付加してください。
class TwigFunctions extends CommandCommonTwigFunctions implements \pine\manual\TwigFunctionsManual
{
}
