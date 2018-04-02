import numpy as np

cdef class pyPermutohedralLattice:
    @staticmethod
    def filter(float[:,:,:,::1] a ,float[:,:,:,::1] b):
        # a: the matric needs to be filered which shape is [batch_size,:,:,:]. b: the feature matric, which shape is [1,:,:,:]
        batch_size = a.shape[0]
        h = a.shape[1]
        w = a.shape[2]
        c = a.shape[3]
        ret = None
        for i in range(batch_size): 
            a_pyImage = image.pyImage().set_data(np.reshape(a[i,:,:,:],(1,h,w,c)))
            b_pyImage = image.pyImage().set_data(b)
            r = PermutohedralLattice.filter(image.pyImage.get_img(a_pyImage),image.pyImage.get_img(b_pyImage))
            r_pyImage = image.pyImage().set_img(r)
            ret_tmp = np.asarray(r_pyImage)
            ret_tmp = np.copy(ret_tmp,order="C")
            a_pyImage.mydel()
            b_pyImage.mydel()
            if ret is None:
                ret = ret_tmp
            else:
                ret = np.concatenate([ret,ret_tmp],axis=0)
        return ret
