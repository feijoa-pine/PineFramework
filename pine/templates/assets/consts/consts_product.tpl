<?php
{:fileheader}
declare(strict_types=1);
namespace pine\app;
use \pine\util\LOG as LOG;

class CONSTS
{
    // 開発
    const   DEVELOP_MODE    = false;
    const   DISPLAY_ERRORS  = "Off";
    const   SYSTEM_LOCALE   = "ja_JP.UTF-8";
    const   SYSTEM_LANGUAGE = "ja";
    const   SYSTEM_ENCODE   = "UTF-8";
    const   TERMINAL_ENCODE = "UTF-8";
    const   DEFAULT_LOCALE  = "ja_JP";
    const   USER_LOCALE     = "ja_JP";
    const   LOG_LOCALE      = "ja_JP";
    const   TWIG_DEBUG      = true;
    const   HTML_MINIFY     = true;
    const   LOG_REPORT      = (LOG::AVERAGE|LOG::MEMORY|LOG::ERROR|LOG::WARNING|LOG::SYSTEM|LOG::INFO);
    
    // ファイルヘッダ
    const   PROJECT_NAME    = "{:project_name}";    
    const   COPYRIGHT       = "{:copyright}";
    const   AUTHOR          = "{:author}";
    const   AUTHMAIL        = "{:authmail}";
    const   RETURN_TO       = "{:return_to}";
    
    // ディレクトリ
    const   ROOT            = __DIR__ . "/../../../../";
    const   PINEDIR         = "{:pine_dir_name}";
    const   PINEROOT        = self::ROOT . self::PINEDIR . "/";
    const   PINECORE        = self::PINEROOT . "core/";
    const   SITEROOT        = self::ROOT . "sites/";
    const   XSITELIB        = [];
    const   MODULES         = self::SITEROOT . self::SITE_ID . "/module/";
    const   PUBLICS         = self::SITEROOT . self::SITE_ID . "/public/";
    const   ASSETS          = self::SITEROOT . self::SITE_ID . "/assets/";
    const   TEMPLATES       = self::ASSETS . "templates/";
    const   STORAGE         = self::ASSETS . "storage/";
    const   EXTERNAL        = self::ASSETS . "external/";
    const   LOGS            = self::SITEROOT . self::SITE_ID . "/__logs/";
    const   COMPOSER        = self::ROOT . "composer/";
    const   CACHES          = self::ROOT . "caches/";
    const   TESTROOT        = self::ROOT . "stestfiles/";
    const   SITE_ID         = "{:site_id}";     // siteディレクトリ名
    
    // WEB
    const   SITE_TITLE      = "domain.to.product";
    const   HOME_URL        = "https://domain.to.product";
    const   SITE_MAP        = {:site_map};
    
}
