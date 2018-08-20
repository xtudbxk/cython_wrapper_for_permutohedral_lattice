cdef extern from "src/Image.h":
    cdef cppclass Image:
        Image(int,int,int,int,const float*) except +
        Image() except +
        float* data
        int frames,height,width,channels

