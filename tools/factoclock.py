#!/usr/bin/env python
# -*- coding: utf-8 -*-

import random
import requests

def get():
    req = requests.get('http://factoclock.com/getFact.php')
    req_json = req.json()
    return random.choice(req_json)['fact']['fact']

print(get())
