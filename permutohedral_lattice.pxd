cimport image

cdef extern from "src/permutohedral.h":
    cdef cppclass PermutohedralLattice:
        @staticmethod
        image.Image filter(image.Image im, image.Image ref)

cdef class pyPermutohedralLattice:
    @staticmethod
    cdef _filter(float[:,:,:,::1] a, float[:,:,:,::1] b)
    @staticmethod
    cdef _filter_with_mask(float[:,:,:,::1] a, float[:,:,:,::1] b, int[:,:,::1]mask, int mask_num)
