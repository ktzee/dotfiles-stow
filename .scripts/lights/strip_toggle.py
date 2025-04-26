#!/usr/bin/env python
# coding=utf-8
import os, signal
from lifxlan import LifxLAN

lifxlan = LifxLAN(2)

strip = lifxlan.get_device_by_name("Strip")
power = strip.get_power()
if power == 65535:
    strip.set_power(0)
    print("Strip Off")
else:
    strip.set_power(65535)
    print("Strip On")
