#!/bin/bash

mkdir -p ../Metis_build
cd ../Metis_build
[ ! -d "GKlib" ] && git clone https://github.com/KarypisLab/GKlib.git
[ ! -d "METIS" ] && git clone https://github.com/KarypisLab/METIS.git
export root_build=$PWD
echo "current folder is" $root_build
mkdir -p $root_build/build
cd $root_build/GKlib
make config prefix=$root_build/build openmp=set 
make all
make install
cd $root_build/METIS
make config prefix=$root_build/build openmp=set i64=set r64=set 
make all 
make install


cd $root_build/build/lib
mv libmetis.a libmetisn.a
echo "create libmetis.a" > combine_lib.mri
echo "addlib libGKlib.a" >> combine_lib.mri
echo "addlib libmetisn.a" >> combine_lib.mri
echo "save" >> combine_lib.mri
echo "end" >> combine_lib.mri
ar -M < combine_lib.mri
rm *n.a
cp $root_build/METIS/libmetis/*.h $root_build/build/include/
