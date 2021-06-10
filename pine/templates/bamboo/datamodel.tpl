<?php
{:fileheader}
declare(strict_types=1);
namespace pine\bamboo;

class {:datamodel_name} extends BaseDataModel implements \pine\manual\DataModelManual
{
    //*****************************************/
    // const
    //	BOOLEAN = 'boolean',
    //	INTEGER = 'integer',
    //	DOUBLE  = 'double',
    //	FLOAT   = 'double',
    //	STRING  = 'string',
    //	LOB     = 'string',
    //	DATETIME = 'dateTime';
    //  DATE     = 'date';
    //*****************************************/
    
    protected $table_type   = DataModel::{:table_type};
    protected $logging      = {:logging};

    protected $schema  = [
{:schema}
    ];
    
    protected $primary = [{:primary}];
    
    public function isValid(): bool
    {
        return true;
    }

}
