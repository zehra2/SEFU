<?php

defined('BASEPATH') or exit('No direct script access allowed');


function my_autoloader($class)
{

    if (substr($class, 0, 9) == "MY_Addon_") {
   
       if (file_exists($file = APPPATH . 'core/' . $class . '.php')) {
            include $file;
        }
    }
}
spl_autoload_register('my_autoloader');

$route['default_controller']                 = 'welcome/index';
$route['user/resetpassword/([a-z]+)/(:any)'] = 'site/resetpassword/$1/$2';
$route['admin/resetpassword/(:any)']         = 'site/admin_resetpassword/$1';
$route['admin/unauthorized']                 = 'admin/admin/unauthorized';
$route['404_override'] = 'welcome/show_404';
$route['translate_uri_dashes'] = false;
$route['form/appointment']     = 'welcome/appointment';
$route['page/annual_calendar']     = 'welcome/annual_calendar';

//======= front url rewriting==========
$route['page/(:any)'] = 'welcome/page/$1';
$route['read/(:any)'] = 'welcome/read/$1';
$route['frontend']    = 'welcome';

//======= Kenya HIE / DHA REST API v1 Routes ==========
$route['api/v1/facility/info']              = 'api/facility/info';
$route['api/v1/terminology/icd10']          = 'api/terminology/icd10';
$route['api/v1/patients/search']            = 'api/patients/search';
$route['api/v1/patients/create']            = 'api/patients/create';
$route['api/v1/patients/detail/(:any)']     = 'api/patients/detail/$1';
$route['api/v1/patients/(:any)']            = 'api/patients/detail/$1';
$route['api/v1/patients']                   = 'api/patients/index';
$route['api/v1/encounters/search']          = 'api/encounters/search';
$route['api/v1/encounters/create']          = 'api/encounters/create';
$route['api/v1/encounters/detail/(:any)']   = 'api/encounters/search?id=$1';
$route['api/v1/encounters/(:any)']          = 'api/encounters/search?id=$1';
$route['api/v1/encounters']                 = 'api/encounters/index';
$route['api/v1/billing/patient/(:any)']     = 'api/billing/patient/$1';
$route['api/v1/billing/detail/(:any)']      = 'api/billing/patient/$1';
$route['api/v1/billing']                    = 'api/billing/index';
