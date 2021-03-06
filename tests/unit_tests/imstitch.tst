//==============================================================================
// IPCV - Scilab Image Processing and Computer Vision toolbox
// Copyright (C) 2017  Tan Chin Luh
//==============================================================================
// unit test imsuperres
//==============================================================================

S = list();
S(1) = imread(fullpath(getIPCVpath() + "/images/stitching/sk1.jpg"));
S(2) = imread(fullpath(getIPCVpath() + "/images/stitching/sk2.jpg"));
St  = imstitchimage(S);
assert_checkequal(size(St),[592,1097,3]);

//==============================================================================
