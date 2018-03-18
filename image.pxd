cdef extern from "src/Image.h":
    cdef cppclass Image:
        Image(int,int,int,int,const float*) except +
        Image() except +
        float* data
        int frames,height,width,channels

cdef class pyImage:
    cdef Image img
    cdef Py_ssize_t shape[4]
    cdef Py_ssize_t strides[4]
    cdef pyImage wrap(self,Image img)

cdef Image MemoryViewToImage(float[:,:,:,::1] mv)
