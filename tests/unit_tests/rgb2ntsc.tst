//==============================================================================
// Allan CORNET - 2012 - DIGITEO
//
// IPCV - Scilab Image Processing and Computer Vision toolbox
// Copyright (C) 2017  Tan Chin Luh
//==============================================================================
// unit test rgb2ntsc
//==============================================================================

RGB = imread(fullpath(getIPCVpath() + "/images/baboon.png"));
S = rgb2ntsc(RGB);
RGB2 = ntsc2rgb(S);
assert_checktrue(abs(sum(im2double(RGB) - im2double(RGB2))./prod(size(RGB)))<0.0001);

//==============================================================================
