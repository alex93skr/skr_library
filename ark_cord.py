import sys
from PIL import Image
import pytesseract

import io
import requests
import time

from PIL import ImageFilter
import PIL.ImageOps
from PIL import ImageDraw
from PIL import ImageFont


#############################################################

def main():
    # print(sys.argv[1])

    file_in = 'D:\\nvidia\\ARK  Survival Evolved\\1.png'

    with open(file_in, "rb") as f:
        image_bytes = f.read()

    image = Image.open(io.BytesIO(image_bytes))

    box = (1103, 256, 1406, 806)
    image = image.crop(box)

    # image = image.convert('1')
    image = image.convert('L')

    image = PIL.ImageOps.invert(image)

    # image = image.resize((image.size[0] * 2, image.size[1] * 2))
    # image = image.filter(ImageFilter.EDGE_ENHANCE_MORE)

    # image.show()

    res = pytesseract.image_to_string(image, lang='eng', config='--psm 6 -c tessedit_char_whitelist=0123456789,')

    print(res)
    print(type(res))

    work = []

    for i in res.split('\n'):
        print(i)
        lvl = i[:i.find(' ')]
        x = i[len(lvl) + 1:len(lvl) + 1 + i[len(lvl) + 1:].find(' ')]
        y = i[len(lvl) + len(x) + 2:]
        # print(lvl, x, y, '<')

        work.append([int(lvl), int(x[:x.find(',')]), int(y[:y.find(',')])])

    with open('v1.jpg', "rb") as f:
        image_bytes = f.read()
    image_out = Image.open(io.BytesIO(image_bytes))
    font = ImageFont.truetype("arial.ttf", 40)
    # fontbg = ImageFont.truetype("arial.ttf", 40)

    # for i in sorted(work, key=lambda x: x[1]):
    for i in work:
        print(i)

        lvl = i[0]
        x = i[1]
        y = i[2]

        ImageDraw.Draw(image_out).rectangle(
            (y * 20, x * 20, (y + 1) * 20, (x + 1) * 20), outline='red', fill='red'
        )

        txt = f'{str(lvl)} {x} {y}'

        ImageDraw.Draw(image_out).text((y * 20 - 52, x * 20 - 70), txt, (0, 0, 0), font=font)
        ImageDraw.Draw(image_out).text((y * 20 - 48, x * 20 - 70), txt, (0, 0, 0), font=font)
        ImageDraw.Draw(image_out).text((y * 20 - 50, x * 20 - 68), txt, (0, 0, 0), font=font)
        ImageDraw.Draw(image_out).text((y * 20 - 50, x * 20 - 72), txt, (0, 0, 0), font=font)

        ImageDraw.Draw(image_out).text(
            (y * 20 - 50, x * 20 - 70), txt, (255, 0, 0), font=font,
        )

    image_out.show()


#############################################################

if __name__ == "__main__":
    main()

#############################################################
