from builtins import range
import time
import numpy as np
import skimage.io as imgio
import skimage.transform as imgtf
from permutohedral_lattice import pyPermutohedralLattice
from permutohedral_lattice import pyPermutohedralLattice
import logging
# from skimage.transform import resize
import sys

__author__ = 'Ido Freeman'
__email__ = "idofreeman@gmail.com"

logging.basicConfig(format='%(asctime)s %(levelname)s %(message)s',
                    level=logging.INFO,
                    stream=sys.stdout)


def main():
    # Read in image with the shape (rows, cols, channels)
    #im = imgio.imread('./lena.small.jpg')
    im = imgio.imread('input.jpg')
    im = np.array(im) / 255.
    #im = imgtf.resize(im,(41,41))
    #imgio.imsave("input_resize.jpg",im)
    imgio.imsave("input.jpg",im)
    print("input shape:%s" % str(im.shape))

    invSpatialStdev = float(1. / 4.)
    invColorStdev = float(1. / .5)

    # Construct the position vectors out of x, y, r, g, and b.
    #positions = np.zeros((im.shape[0], im.shape[1], 5), dtype='float32')
    positions = np.zeros((im.shape[0], im.shape[1], 2), dtype='float32')
    for r in range(im.shape[0]):
        for c in range(im.shape[1]):
            positions[r, c, 0] = invSpatialStdev * c
            positions[r, c, 1] = invSpatialStdev * r
            #positions[r, c, 2] = invColorStdev * im[r, c, 0]
            #positions[r, c, 3] = invColorStdev * im[r, c, 1]
            #positions[r, c, 4] = invColorStdev * im[r, c, 2]

    im = np.expand_dims(im,axis=0)
    im = im.astype(np.float32)
    positions = np.expand_dims(positions,axis=0)
    positions = positions.astype(np.float32)
    start_time = time.time()
    out = pyPermutohedralLattice.filter(im, positions)
    print("duration time:%f" % (time.time() - start_time))
    out = np.asarray(out,dtype=np.float32)
    out -= out.min()
    out /= out.max()
    out = np.squeeze(out,axis=0)
    im -= im.min()
    im /= im.max()
    im = np.squeeze(im,axis=0)
    s = np.concatenate([im,out],axis=1)
    imgio.imshow(s)
    imgio.show()


if __name__ == '__main__':
    main()
