import numpy as np

cdef class pyPermutohedralLattice:
    @staticmethod
    def filter(float[:,:,:,::1] a ,float[:,:,:,::1] b):
    #def filter(float[:,:,:,::1] a not None,float[:,:,:,::1] b not None):
        a_pyImage = image.pyImage().set_data(a)
        b_pyImage = image.pyImage().set_data(b)
        r = PermutohedralLattice.filter(image.pyImage.get_img(a_pyImage),image.pyImage.get_img(b_pyImage))
        r_pyImage = image.pyImage().set_img(r)
        ret = np.asarray(r_pyImage)
        a_pyImage.mydel()
        b_pyImage.mydel()
        return ret
