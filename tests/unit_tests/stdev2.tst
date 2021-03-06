//==============================================================================
// Allan CORNET - 2012 - DIGITEO
//
// IPCV - Scilab Image Processing and Computer Vision toolbox
// Copyright (C) 2017  Tan Chin Luh
//==============================================================================
// unit test mean2
//==============================================================================

a = rand(10,10).*100;
b = round(a);
y1 = stdev2(uint8(b));
y2 = stdev(b);
assert_checkequal(y1,y2);

//==============================================================================
