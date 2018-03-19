cdef extern from "src/Image.h":
    cdef cppclass Image:
        Image(int,int,int,int,const float*) except +
        Image() except +
        float* data
        int frames,height,width,channels

cdef class pyImage:
    cdef Image* img
    cdef int new_count
    cdef Py_ssize_t shape[4]
    cdef Py_ssize_t strides[4]
    cdef pyImage set_img(self,Image img)
    cdef pyImage set_data(self,float[:,:,:,::1] mv)
    @staticmethod
    cdef Image get_img(pyImage pyimg)
