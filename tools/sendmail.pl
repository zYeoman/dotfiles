#! /usr/bin/env perl
#
# Short description for sendmail.pl
#
# Author Yongwen Zhuang <zeoman@163.com>
# Version 0.1
# Copyright (C) 2017 Yongwen Zhuang <zeoman@163.com>
# Modified On 2017-06-01 21:40
# Created  2017-06-01 21:40
#
use strict;
use warnings;

my($mailprog) = '/usr/sbin/sendmail';
my($from_address) ='root@vps.mickir.me';
my($to_address) ='zyeoman@163.com';
       open (MAIL, "|$mailprog -t $to_address") || die "Can't open $mailprog!\n";
       print MAIL "To: $to_address\n";
       print MAIL "From: $from_address\n";
       print MAIL "Subject: Bandwidth Usage\n";
       print MAIL "Test";
       close (MAIL);
