from cimage cimport Image

cdef extern from "src/permutohedral.h":
    cdef cppclass PermutohedralLattice:
        @staticmethod
        Image filter(Image im, Image ref)
