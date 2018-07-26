#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Add calendar to pictures.

Created at 2017-03-31
Author Yongwen Zhuang

TODO: 太阴历、黄历、Google日历
"""

import os
import sys
from PIL import Image, ImageDraw, ImageFont
import datetime
import calendar

now = datetime.datetime.now()
text = calendar.TextCalendar(firstweekday=6).formatmonth(now.year, now.month, 3)
text_draw = ''
for line in text.split('\n'):
    text_draw += line.ljust(30) + '\n'

filename = sys.argv[1]
command = 'convert {} -font Consolas \
    -fill gray70 -gravity SouthEast -pointsize 25 -strokewidth 2 \
    -annotate 0 "{}" o.png'.format(filename, text_draw)

print(command)

os.system(command)

font = ImageFont.truetype('simsun.ttc', 100)
img = Image.open('o.jpg')
draw = ImageDraw.Draw(img)
draw.text((0, 50), u'你好,世界!', (0, 0, 0), font=font)
img.save('img.jpg', 'JPEG')
img.show()
