<?php
declare(strict_types=1);
namespace pine\manual;

interface ActionManual
{
    /**
     * protected $response      \stdClass Object                            // ブラウザに返すレスポンスオブジェクト
     *   ->status               = true;                                     // Actionの実行結果　成功: true, 失敗: false
     *   ->tracking_number      = "";                                       // エラー発生時に書き出されたログの参照ID
     *
     * protected $ume           $ume_class Object
     *
     * protected $static_page                  = false;                     // 静的ページか？（trueの場合、controllerはactionを実行せずにviewの呼び出しを行う）
     * protected $ume_class                    = "GetIndexUME";             // このアクションがデフォルトで使用するUMEクラス
     * protected $validate_ticket              = true;                      // ワンタイムチケットの検査を行うか？
     * protected $validate_ticket_on_get       = false;                     // GETメソッド時に、ワンタイムチケットの検査を行うか？
     * protected $validate_ticket_by           = util\TICKET::BY_POST;      // どのメソッドで渡されたワンタイムチケットを検査するか？
     * protected $regenerate_ticket_after_post = true;                      // POSTメソッドの際に、ワンタイムチケットを再生成するか？
     * protected $transaction                  = false;                     // logic()の実行に先立って、トランザクションを発行するか？
     * protected $response_type                = pine\ResponseType::HTML;   // ブラウザに返すレスポンスの種別
     * 
     * protected function prepare(\pine\Dto $dto): bool
     *      Modelの実行に先立って行う前処理
     *      falseをreturnすると、BaseActionはlogic()は実行せずにcloser()を実行してコントローラーに処理を返す
     *
     * protected function verror(\pine\Dto $dto): void {}
     *      ヴァリデーションエラー発生時に呼ばれる。この関数実行後、closer()を実行してコントローラーに処理を返す
     *
     * protected function deficient(\pine\Dto $dto): void {}
     *      prepare()内でのヴァリデーションエラーまたはチケットエラー、falseが返された場合に呼ばれる。この関数実行後、closer()を実行してコントローラーに処理を返す
     * 
     * protected function logic(\pine\Dto $dto): bool
     *      このアクションの実体を記述する。処理が成功した場合はdone()が、Throwableが投げられた場合はDB処理をロールバックし、fail()がコールされる
     *      falseをreturnすると、BaseActionはDB処理をロールバックしてからfail()を実行する
     * 
     * protected function fail(\pine\Dto $dto): void   {}
     *       logic()内でThrowableが投げられた場合に呼ばれる
     * 
     * protected function done(\pine\Dto $dto): void
     *      logic()内の処理が成功してtrueが返された場合に呼ばれる
     * 
     * protected function always(\pine\Dto $dto): void {}
     *      logic()が実行された場合、その処理の成功・失敗の如何にかかわらず実行される
     * 
     * protected function closer(\pine\Dto $dto): void {}
     *      このアクションの最後に必ず実行される後処理
     */
}

