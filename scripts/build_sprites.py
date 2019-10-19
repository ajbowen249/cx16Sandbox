import json
import numpy
import os
import png
import sys

from functools import reduce

valid_dimensions = [ 8, 16, 32, 64 ]
valid_modes = [ "4bpp", "8bpp" ]

def validate_sprite(sprite):
    name = sprite['name']
    if sprite['width'] not in valid_dimensions:
        sys.exit('"{}" has invalid width {}.'.format(name, sprite['width']))

    if sprite['height'] not in valid_dimensions:
        sys.exit('"{}" has invalid height {}.'.format(name, sprite['height']))

    if sprite['mode'] not in valid_modes:
        sys.exit('"{}" has invalid mode {}.'.format(name, sprite['mode']))

    palette = sprite['palette']
    if palette < 0 or palette > 15:
        sys.exit('"{}" has invalid palette {}.'.format(name, palette))

def normalize_to_rgba(pixel):
    if len(pixel) == 4:
        return pixel
    if len(pixel) == 3:
        return [pixel[0], pixel[1], pixel[2], 255]
    return [0, 0, 0, 255]

def rgba_to_4bpp(rgba):
    # IMPROVE: Convert transperent pixels
    if numpy.array_equal(rgba, [   0,   0,   0, 255 ]):
        return 0 # black
    if numpy.array_equal(rgba, [ 255, 255, 255, 255 ]):
        return 1 # white
    if numpy.array_equal(rgba, [ 136,   0,   0, 255 ]):
        return 2 # red
    if numpy.array_equal(rgba, [ 170, 255, 238, 255 ]):
        return 3 # cyan
    if numpy.array_equal(rgba, [ 204,  68, 204, 255 ]):
        return 4 # violet
    if numpy.array_equal(rgba, [   0, 204,  85, 255 ]):
        return 5 # green
    if numpy.array_equal(rgba, [   0,   0, 170, 255 ]):
        return 6 # blue
    if numpy.array_equal(rgba, [ 238, 238, 119, 255 ]):
        return 7 # yellow
    if numpy.array_equal(rgba, [ 221, 136,  85, 255 ]):
        return 8 # orange
    if numpy.array_equal(rgba, [ 102,  68,   0, 255 ]):
        return 9 # brown
    if numpy.array_equal(rgba, [ 255, 119, 119, 255 ]):
        return 10 # light red
    if numpy.array_equal(rgba, [  51,  51,  51, 255 ]):
        return 11 # dark grey
    if numpy.array_equal(rgba, [ 119, 119, 119, 255 ]):
        return 12 # grey
    if numpy.array_equal(rgba, [ 170, 255, 102, 255 ]):
        return 13 # light green
    if numpy.array_equal(rgba, [   0, 136, 255, 255 ]):
        return 14 # light blue
    if numpy.array_equal(rgba, [ 187, 187, 187, 255 ]):
        return 15 # light grey

    sys.exit('Invalid 4bpp color {}.'.format(int_to_rgba(rgba)))

def export_4bpp(rows, name, palette):
    if palette != 0:
        sys.exit('Palette {}@4bpp is not yet supported.')

    raw_nibbles = []

    for row in range(0, len(rows)):
        for col in range(0, len(rows[row])):
            rgba = normalize_to_rgba(rows[row][col])
            raw_nibbles.append(rgba_to_4bpp(rgba))

    packed_nibbles = []
    for i in range(0, int(len(raw_nibbles) / 2)):
        packed_nibbles.append((raw_nibbles[i * 2] << 4) | raw_nibbles[(i * 2) + 1])

    return packed_nibbles

def export_sprite(sprite):
    validate_sprite(sprite)
    name = sprite['name']
    (width, height, pngdata, metadata) = png.Reader('../sprites/{}.png'.format(name)).read()
    if width != sprite['width']:
        sys.exit('"{}" has mismatched width.'.format(name))

    if height != sprite['height']:
        sys.exit('"{}" has mismatched height.'.format(name))

    image_2d = numpy.vstack(map(numpy.uint16, pngdata))
    image_3d = numpy.reshape(image_2d, (height, width, metadata['planes']))

    raw_data = []
    if sprite['mode'] == '4bpp':
        raw_data = export_4bpp(image_3d, name, sprite['palette'])
    else:
        sys.exit('Mode "{}" not yet supported.'.format(sprite['mode']))
    
    return 'SPRITE_{} .byte {}'.format(name.upper(), reduce(lambda x, y: str(x) + ', ' + str(y), raw_data))

def export_all_sprites(sprites):
    for sprite in sprites:
        print(export_sprite(sprite))

with open('../sprites/sprites.json', 'r') as f:
    spr_file = json.loads(f.read())
    export_all_sprites(spr_file['sprites'])
