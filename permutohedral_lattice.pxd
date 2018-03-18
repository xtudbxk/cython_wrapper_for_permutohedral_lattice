cimport image

cdef extern from "src/permutohedral.h":
    cdef cppclass PermutohedralLattice:
        @staticmethod
        image.Image filter(image.Image im, image.Image ref)

cdef class pyPermutohedralLattice:
    pass
