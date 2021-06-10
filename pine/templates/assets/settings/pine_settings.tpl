<?php
{:fileheader}
declare(strict_types=1);
namespace pine;

class PineSettings
{
    const JSON              = "JSON";
    const SYSTEM_ENCODING   = "UTF-8";
    const SYSTEM_LANGUAGE   = "ja";
    const SYSTEM_LOCALE     = "ja_JP.UTF-8";
    const CRYPT_SOLT        = '{:default_solt}';
    const SESSION_NAME      = "pine_session";
    const TICKET_KEY        = "one_time_ticket";        // ワンタイムチケットキー
}
