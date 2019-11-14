//==============================================================================
// Allan CORNET - 2012 - DIGITEO
//
// IPCV - Scilab Image Processing and Computer Vision toolbox
// Copyright (C) 2017  Tan Chin Luh
//==============================================================================
// unit test im2col
//==============================================================================
A = testmatrix('mag',4);
B = im2col(A,[3 3]);
C = mean(B,1);
D = matrix(C,[4,4])';
E = imfilter(PadImage(A,0,1,1,1,1),1/9*ones(3,3));
assert_checkalmostequal(D,E(2:$-1,2:$-1));
//==============================================================================