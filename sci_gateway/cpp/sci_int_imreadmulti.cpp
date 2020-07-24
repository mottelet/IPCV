/***********************************************************************
 * SIVP - Scilab Image and Video Processing toolbox
 * Copyright (C) 2005  Shiqi Yu
 *
 * IPCV - Scilab Image Processing and Computer Vision toolbox
 * Copyright (C) 2017  Tan Chin Luh
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 ***********************************************************************/



#include "common.h"

extern "C" 
{
int sci_int_imreadmulti(char * fname,void* pvApiCtx);
}

int sci_int_imreadmulti(char * fname,void* pvApiCtx)
{

	char *pstName = NULL;
	Mat pImage;

	CheckInputArgument(pvApiCtx, 2, 2);
	CheckOutputArgument(pvApiCtx, 0, 1);

	// First Input - Image filename
	GetString(1, pstName,pvApiCtx);

	// Second Input - imread modes
	SciErr sciErr;
	int* piAddr = NULL;
	sciErr = getVarAddressFromPosition(pvApiCtx, 2, &piAddr);
	if (sciErr.iErr)
	{
		printError(&sciErr, 0);
		return 0;
	}
	///

	int iRet = 0;

	unsigned char cData = 0;
	iRet = getScalarUnsignedInteger8(pvApiCtx, piAddr, &cData);
	if (iRet)
	{
		return iRet;
	}
	//

	vector<Mat> mats;
	imreadmulti(pstName, mats, int(cData));
	
	/* if load image failed */
	if (mats.empty())
	{
		Scierror(999, "%s: Can not open file %s.\r\n", fname, pstName);
		return -1;
	}

	SetImages(1, mats, pvApiCtx);


	return 0;
}

