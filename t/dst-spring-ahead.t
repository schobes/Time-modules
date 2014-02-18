#!/usr/bin/perl -I. -w

## This test ensures that spring forward events are handled consistently.

use strict;
use Test::More tests => 8;

use POSIX qw(tzset);
use Time::ParseDate qw(parsedate);

$ENV{TZ} = 'US/Eastern';
tzset();
ok(parsedate('2011-03-13 02:30:00') == 1300001400, 'US/Eastern spring ahead event, invalid time');

$ENV{TZ} = 'Europe/Athens';
tzset();
ok(parsedate('2011-03-27 03:30:00') == 1301189400, 'Europe/Athens spring ahead event, invalid time');
ok(parsedate('2011-03-27 04:30:00') == 1301189400, 'Europe/Athens spring ahead event, valid time');

$ENV{TZ} = 'Chile/Continental';
tzset();
ok(parsedate('2011-08-20 23:59:59') == 1313899199, 'Chile/Continental spring ahead event, valid time - end');
ok(parsedate('2011-08-21 00:00:00') == 1313899200, 'Chile/Continental spring ahead event, invalid time - start');
ok(parsedate('2011-08-21 00:59:59') == 1313902799, 'Chile/Continental spring ahead event, invalid time - end');
ok(parsedate('2011-08-21 01:00:00') == 1313899200, 'Chile/Continental spring ahead event, valid time - start 1');
ok(parsedate('2011-08-21 01:59:59') == 1313902799, 'Chile/Continental spring ahead event, valid time - start 2');

