# setup.py
from distutils.core import setup, Extension
from Cython.Build import cythonize
ext_modules = [
    cythonize(Extension("myimage",["myimage.pyx","src/Image.cpp"],include_dirs=["src"],language="c++"))[0],
    cythonize(Extension("permutohedral_lattice",["permutohedral_lattice.pyx","myimage.pyx","src/Image.cpp","src/modified_permutohedral.cpp"],include_dirs=["src"],language="c++"))[0],
    ]

setup(ext_modules = ext_modules)
