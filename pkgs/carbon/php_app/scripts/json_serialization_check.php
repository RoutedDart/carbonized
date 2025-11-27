<?php
require __DIR__.'/../vendor/autoload.php';
use Carbon\Carbon;

date_default_timezone_set('UTC');

echo Carbon::parse('2012-12-25 20:30:00', 'Europe/Moscow')->serialize();
