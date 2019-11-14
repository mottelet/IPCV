//==============================================================================
// Allan CORNET - 2012 - DIGITEO
//
// IPCV - Scilab Image Processing and Computer Vision toolbox
// Copyright (C) 2017  Tan Chin Luh
//==============================================================================
// unit test fft2pad
//==============================================================================

x = testmatrix('magic',5);
y = fft2pad(x,8,8);
assert_checkequal(size(y), [8 8]);


//==============================================================================