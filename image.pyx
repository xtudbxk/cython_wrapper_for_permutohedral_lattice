from cpython cimport Py_buffer
import numpy as np

cdef class pyImage:
    def __cinit__(self):
        self.shape = (0,0,0,0)
        self.strides = (0,0,0,0)

    cdef pyImage wrap(self, Image img):
        self.img = img
        self.shape[0] = img.frames
        self.shape[1] = img.height
        self.shape[2] = img.width
        self.shape[3] = img.channels
        self.strides[3] = sizeof(float)
        self.strides[2] = self.strides[3]*self.shape[3]
        self.strides[1] = self.strides[2]*self.shape[2]
        self.strides[0] = self.strides[1]*self.shape[1]
        return self

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

cdef Image MemoryViewToImage(float[:,:,:,::1] mv):
    img = new Image()
    img.data = &mv[0][0][0][0]
    img.frames = mv.shape[0]
    img.height = mv.shape[1]
    img.width = mv.shape[2]
    img.channels = mv.shape[3]

    return img[0]



