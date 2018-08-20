from cimage cimport Image

cdef class pyImage:
    cdef Image* img
    cdef int new_count
    cdef Py_ssize_t shape[4]
    cdef Py_ssize_t strides[4]
    cdef pyImage set_img(self,Image img)
    cdef pyImage set_data(self,float[:,:,:,::1] mv)
    @staticmethod
    cdef Image get_img(pyImage pyimg)
