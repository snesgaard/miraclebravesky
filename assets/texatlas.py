#! /usr/bin/python
import cv2
import numpy as np
import sys
import math
import argparse
import os
import json

parser = argparse.ArgumentParser(
    description = "Generates texture atlas from provided images"
)
parser.add_argument(
    'path', metavar='path', type=str, nargs='+',
    help='an integer for the accumulator'
)
parser.add_argument(
    "-s", "--sheet", dest = "sheet", type = str, default = "./sheet.png",
    help = "Path to output atlas image"
)
parser.add_argument(
    "-i", "--index", dest = "index", type = str, default = "./index.lua",
    help = "Path to indexing Lua file"
)
parser.add_argument(
    "-v", "--verbose", dest = "verbose", action='store_true', default = False,
    help = "Makes script talkative"
)

args = parser.parse_args()

ims = []

def vprint(*arg):
    if args.verbose:
        print arg

def load_json(path):
    f = open(path, 'r')
    data = json.loads(f.read())
    f.close()
    return data

def json2im(data, json_path):
    path = os.path.join(os.path.dirname(json_path), data['meta']["image"])
    return cv2.imread(path, -1)

def load_im(path):
    extension = os.path.splitext(path)[1]
    if extension == '.json':
        j = load_json(path)
        return json2im(j, path)
    elif extension == '.png':
        return cv2.imread(path, -1)
    else:
        return None

theorymin = 0
#jsons = map(load_json, args.path)
ims = map(load_im, args.path)
    #im = cv2.imread(path, -1)
    #ims.append(im)
    #theorymin = theorymin + im.shape[0] * im.shape[1]

imcount = len(ims)

sortlist = sorted(zip(ims, args.path), key = lambda (im, p) : im.shape[0])

ims, path = zip(*sortlist)

# Read as (to, from, size)
D = np.zeros((imcount + 1, imcount + 1, 2))
C = np.zeros((imcount + 1, imcount + 1))
T = np.zeros((imcount + 1, imcount + 1))
# initialization
C[:, :] = np.inf
C[0, 0] = 0
T[:, :] = np.nan
T[0, 0] = 0
def cost(w, h):
    if w > 2048 or h > 2048:
        return np.inf
    return np.abs(w - h) + w * h

def readdim(D, r, c):
    if r - 1 < 0:
        return 0, 0
    else:
        return D[r, c, 0], D[r, c, 1]

for r in xrange(0, imcount + 1):
    w = 0
    h = 0
    # Find lowest cost prev step
    pr = np.argmin(C[:, r])
    ph = D[pr, r, 0]
    pw = D[pr, r, 1]
    for c in xrange(r + 1, imcount + 1):
        # Calculate current cost
        im = ims[c - 1]
        w = w + im.shape[1]
        h = max(h, im.shape[0])
        # Find cost
        cw = max(w, pw)
        ch = ph + h
        C[r, c] = cost(cw, ch)
        D[r, c, 0] = ch
        D[r, c, 1] = cw
        T[r, c] = pr

tc = C.shape[1] - 1
tr = np.argmin(C[:, -1])
vprint("cost")
vprint(C[:, -1])
vprint("trace")
vprint(T)
vprint("final dim")
vprint(D[tr, tc])
vprint("final cost")
vprint(C[tr, tc])
vprint("theoretical min cost")
vprint(theorymin)
fim = np.zeros((int(D[tr, tc, 0]), int(D[tr, tc, 1]), 4), dtype = "uint8")

splits = [imcount]
while tc > 1:
    vprint(tr)
    splits.append(int(tr))
    ntr = int(T[tr, tc])
    tc = tr
    tr = ntr

splits.append(0)
splits.reverse()
vprint(splits)

h = 0
index_json = dict()
for i in xrange(len(splits) - 1):
    w = 0
    th = 0
    for j in xrange(splits[i], splits[i + 1]):
        im = ims[j]
        # Create index
        p = path[j]
        name = os.path.splitext(os.path.basename(p))[0]
        #line = "  %s = {x = %d, y = %d, w = %d, h = %d, data = '%s'}," \
        #        % (name, w, h, im.shape[1], im.shape[0], p)
        #indexfile.append(line)
        index_json[name] = dict(x=w, y=h, w=im.shape[1], h=im.shape[0], data=p)
        # Write image
        fim[h:(h + im.shape[0]), w:(w + im.shape[1]), :] = im
        w = w + im.shape[1]
        th = max(im.shape[0], th)

    h = h + th

#indexfile.append("}")
#indexfile.append("return index")
#indexfile = map(lambda s : s + "\n", indexfile)
#f = open(args.index, "w")
#f.write(''.join(indexfile))
#f.close()
with open(args.index, 'w') as f:
    json.dump(index_json, f)

cv2.imwrite(args.sheet, fim)
