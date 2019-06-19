#! /usr/bin/python

import json
import argparse
import cv2
import os
import sys

parser = argparse.ArgumentParser(
    description = "Merges aseprite jsons into a single json"
)
parser.add_argument(
    'index', metavar='path', type=str,
    help='path to atlas index file'
)
parser.add_argument(
    'atlas', metavar='path', type=str,
    help='path to atlas image file'
)
parser.add_argument(
    'output', metavar="path", type=str,
    help="path to the atlas output file"
)
args = parser.parse_args()

with open(args.index) as f:
    index = json.load(f)

def load_frame_json(path):
    dir = os.path.join(
        os.path.dirname(args.index), path
    )
    with open(dir) as f:
        return json.load(f)

atlas = cv2.imread(args.atlas)
frames = []
tags = []

def attach_frames(dst, frame, atlasdata):
    x, y = atlasdata['x'], atlasdata['y']
    frame["frame"]["x"] += x
    frame["frame"]["y"] += y
    frame["filename"] = "atlas %i.aseprite" % len(dst)
    dst.append(frame)

for name, atlasdata in index.iteritems():
    framedata = load_frame_json(atlasdata['data'])
    frame_start = len(frames)

    for f in framedata['frames']:
        attach_frames(frames, f, atlasdata)

    frame_end = len(frames) - 1

    framemeta = framedata['meta']

    if not len(framemeta['frameTags']):
        t = dict()
        t['name'] = name
        t['from'] = frame_start
        t['to'] = frame_end
        t['direction'] = "forward"
        tags.append(t)
    else:
        for t in framemeta['frameTags']:
            t['name'] = "%s_%s" % (name, t['name'])
            t['from'] += frame_start
            t['to'] += frame_start
            tags.append(t)

meta = dict(
    app="http://www.aseprite.org/",
    version = "1.2.11-x64",
    image = args.atlas,
    format = "RGBA8888",
    size = dict(w=atlas.shape[1], h=atlas.shape[0]),
    scale = 1,
    slices=[],
    frameTags=tags
)

json_data = dict(meta=meta, frames=frames)

with open(args.output, "w") as f:
    json.dump(json_data, f, indent=2)
