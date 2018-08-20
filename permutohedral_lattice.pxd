cdef class pyPermutohedralLattice:
    @staticmethod
    cdef _filter(float[:,:,:,::1] a, float[:,:,:,::1] b)
    @staticmethod
    cdef _filter_with_mask(float[:,:,:,::1] a, float[:,:,:,::1] b, int[:,:,::1]mask, int mask_num)
    @staticmethod
    cdef _filter_without_normalization(float[:,:,:,::1] a, float[:,:,:,::1] b)
