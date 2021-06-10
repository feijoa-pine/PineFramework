<?php
{:fileheader}
declare(strict_types=1);
namespace pine;

class MimeSettings
{
    public static function getMIMESettings()
    {
        return array(
            "3g2"   => "video/3gpp2",
            "ai"    => "application/postscript",
            "bmp"   => ["image/x-bmp", "image/bmp", "image/x-ms-bmp"],
            "css"   => "text/css",
            "csv"   => ["text/csv", "text/comma-separated-values"],
            "doc"   => "application/msword",
            "exe"   => "application/octet-stream",
            "gif"   => "image/gif",
            "hdml"  => "text/x-hdml",
            "htm"   => "text/html",
            "jpg"   => ["image/jpeg", "image/pjpeg"],
            "jpeg"  => ["image/jpeg", "image/pjpeg"],
            "js"    => "text/javascript",
            "lha"   => "application/x-lzh",
            "lzh"   => "application/x-lzh",
            "m4a"   => "audio/mp4",
            "mid"   => "audio/midi",
            "midi"  => "audio/midi",
            "mmf"   => "application/x-smaf",
            "mp3"   => "audio/mpeg",
            "mp4"   => "video/mp4",
            "mpg"   => "video/mpeg",
            "mpe"   => "video/mpeg",
            "mpeg"  => "video/mpeg",
            "mpg4"  => "video/mp4",
            "pdf"   => "application/pdf",
            "png"   => ["image/png", "image/x-png"],
            "ppt"   => "application/vnd.ms-powerpoint",
            "swf"   => "application/x-shockwave-flash",
            "tar"   => "application/x-tar",
            "tgz"   => "application/x-tar",
            "tsv"   => "text/tab-separated-values",
            "txt"   => "text/plain",
            "wav"   => "audio/x-wav",
            "wmv"   => "video/x-ms-wmv",
            "xdw"   => "application/vnd.fujixerox.docuworks",
            "xls"   => "application/vnd.ms-excel",
            "xlsx"  => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            "zip"   => "application/zip",
        );
    }
}
