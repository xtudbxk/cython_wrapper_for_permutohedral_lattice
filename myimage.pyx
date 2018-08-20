from cpython cimport Py_buffer
import numpy as np
from cimage cimport Image

cdef class pyImage:
    def __cinit__(self):
        self.shape = (0,0,0,0)
        self.strides = (0,0,0,0)
        self.new_count = 0
        self.img = NULL

    #def __dealloc__(self):
    #    if self.new_count >= 1: # if img is not molloc in cython, then cython will not to dealloc it
    #        del self.img

    cdef pyImage set_img(self,Image img):
        self.img = &img
        self._update_shape_and_strides()
        return self

    def mydel(self):
        del self.img

    cdef pyImage set_data(self,float[:,:,:,::1] mv):
        assert self.img == NULL,"set data to a existing img"
        self.img = new Image()
        self.new_count = 1
        self.img.data = &mv[0][0][0][0]
        self.img.frames = mv.shape[0]
        self.img.height = mv.shape[1]
        self.img.width = mv.shape[2]
        self.img.channels = mv.shape[3]
        self._update_shape_and_strides()
        return self

    # I don't know why the following function must be a staticmethod
    # buf if I remove the staticemethod, I will geet error "Cannot convert Python object to 'Image'" when I run ./install.sh where I call it in permutohedral lattice
    # if you know how this happens, please explain it to me in the issues, thanks.
    @staticmethod    
    cdef Image get_img(pyImage pyimg):
        assert pyimg.new_count == 1,"there is no img in pyImage"
        return pyimg.img[0]

    def _update_shape_and_strides(self):
        self.shape[0] = self.img.frames
        self.shape[1] = self.img.height
        self.shape[2] = self.img.width
        self.shape[3] = self.img.channels
        self.strides[3] = sizeof(float)
        self.strides[2] = self.strides[3]*self.shape[3]
        self.strides[1] = self.strides[2]*self.shape[2]
        self.strides[0] = self.strides[1]*self.shape[1]

    def __getbuffer__(self, Py_buffer *buf, int flags):
        buf.buf = <void *>self.img.data
        buf.format = "f"
        buf.internal = NULL
        buf.itemsize = sizeof(float)
        buf.len = self.shape[0]*self.strides[0]
        buf.ndim = 4
        buf.obj = self
        buf.readonly = 0
        buf.shape = self.shape
        buf.strides = self.strides
        buf.suboffsets = NULL

    def __releasebuffer__(self,Py_buffer *buf):
        pass
