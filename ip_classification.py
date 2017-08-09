#!/usr/bin/env python2

import sys
import re


def ip_classification(ip):
    ip_pattern = re.compile(r'(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})')
    m = ip_pattern.match(ip)
    if m:
        a, b, c, d = [int(i) for i in m.groups()]
        if a>=0 and a<= 126:
            if a==10:
                print ip, "A pravite"
            else:
                print ip, "A public"
        elif a==127:
            print ip, "Loopback"
        elif a>=128 and a<=191:
            if a==172 and b >=16 and b <=31:
                print ip, "B pravite"
            else:
                print ip, "B public"
        elif a>=192 and a<=223:
            if a==192 and b==168:
                print ip, "C private"
            else:
                print ip, "C public"
        elif a>=224 and a<=239:
            print ip, "D"
        elif a>=240 and a<=255:
            print ip, "E"
        else:
            print ip, "Invalid"
    else:
        print ip, "Invalid"


if __name__=='__main__':
    for ip in sys.argv[1:]:
        ip_classification(ip)
