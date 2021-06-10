<?php
/**
 * Project Name: Pine
 * Description : Defination of Site
 * Start Date  : 2018/09/03
 * Copyright   : Katsuhiko Miki   https://striking-forces.jp
 * 
 * @author Katsuhiko Miki
 */
declare(strict_types=1);
namespace pine\command;
use \pine\util\LOG as LOG;

class CONSTS_GLOBAL
{
    const   DISPLAY_ERRORS  = "On";
    const   SYSTEM_LOCALE   = "ja_JP.UTF-8";
    const   SYSTEM_LANGUAGE = "ja";
    const   SYSTEM_ENCODE   = "UTF-8";
    const   TERMINAL_ENCODE = "UTF-8";
    const   LOG_LOCALE      = "ja_JP";
    const   TEMPLATE_EXT    = "tpl";
    
    const   ROOT            = __DIR__ . "/../../../";
    const   PINEDIR         = "pine";
    const   PINEROOT        = self::ROOT . self::PINEDIR . "/";
    const   PINECORE        = self::PINEROOT . "core/";
    const   TEMPLATES       = self::PINEROOT . "templates/";
    const   SITEROOT        = self::ROOT . "sites/";
    const   COMPOSER        = self::ROOT . "composer/";
    
    const   PROJECT_NAME    = "Pine Framework - CODE NAME: striking code";
    const   COPYRIGHT       = "copyright";
    const   AUTHOR          = "auther name";
    const   AUTHMAIL        = "authmail@mail.address";
    const   RETURN_TO       = "return_to@mail.address";
}

