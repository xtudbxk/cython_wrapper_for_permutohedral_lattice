cdef extern from "src/modified_permutohedral.hpp":
    cdef cppclass ModifiedPermutohedral:
        void init ( const float* features, int num_dimensions, int num_points)
        void compute(int ,float* , const float*)
