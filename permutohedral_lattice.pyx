cdef class pyPermutohedralLattice:
    @staticmethod
    def filter(float[:,:,:,::1] a ,float[:,:,:,::1] b):
    #def filter(float[:,:,:,::1] a not None,float[:,:,:,::1] b not None):
        return image.pyImage().wrap(PermutohedralLattice.filter(image.MemoryViewToImage(a),image.MemoryViewToImage(b)))
