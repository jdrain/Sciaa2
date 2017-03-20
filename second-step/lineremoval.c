/*====================================================================*
 -  Copyright (C) 2001 Leptonica.  All rights reserved.
 -
 -  Redistribution and use in source and binary forms, with or without
 -  modification, are permitted provided that the following conditions
 -  are met:
 -  1. Redistributions of source code must retain the above copyright
 -     notice, this list of conditions and the following disclaimer.
 -  2. Redistributions in binary form must reproduce the above
 -     copyright notice, this list of conditions and the following
 -     disclaimer in the documentation and/or other materials
 -     provided with the distribution.
 -
 -  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 -  ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 -  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 -  A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL ANY
 -  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 -  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 -  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 -  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 -  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 -  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 -  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *====================================================================*/

/*
 * lineremoval.c
 *
 *     Use with dave-orig.png
 */

#include "allheaders.h"
#include "string.h"

int main(int    argc,
         char **argv)
{
char        *filein;
char        *foldername;
char        filename[100];
char        *filearray;
char        *temp;
char        result[100];
l_float32    angle, conf, deg2rad;
PIX         *pixs, *pix1, *pix2, *pix3, *pix4, *pix5;
PIX         *pix6, *pix7, *pix8, *pix9, *pixextra,*removing_small_lines;
static char  mainName[] = "lineremoval";

    if (argc != 2)
        return ERROR_INT(" Syntax:  lineremoval filein", mainName, 1);

    filein = argv[1];
    printf("%s\n",filein );
    deg2rad = 3.14159 / 180.;
    if ((pixs = pixRead(filein)) == NULL)
        return ERROR_INT("pix not made", mainName, 1);

    printf("depth : %d\n", pixs->d);

        /* threshold to binary, extracting much of the lines */
    pix1 = pixThresholdToBinary(pixs, 200);
    //pixWrite("./dave-proc1.png", pix1, IFF_PNG);
    pixDisplayWrite(pix1, 1);

        /* find the skew angle and deskew using an interpolated
         * rotator for anti-aliasing (to avoid jaggies) */
    pixFindSkew(pix1, &angle, &conf);
    pix2 = pixRotateAMGray(pixs, deg2rad * angle, 255);
    //pixWrite("./dave-proc2.png", pix2, IFF_PNG);
    pixDisplayWrite(pix2, 1);

        /* extract the lines to be removed, originally the value was 51, but changed it to 251. With 51 it started removing the small horizontal lines in the characters.-akhil */
    pix3 = pixCloseGray(pix2, 171, 1);
    //pixWrite("./dave-proc3.png", pix3, IFF_PNG);
    pixDisplayWrite(pix3, 1);
    
    
	
        /* solidify the lines to be removed */
    pix4 = pixErodeGray(pix3, 1, 5);
    //pixWrite("./dave-proc4.png", pix4, IFF_PNG);
    pixDisplayWrite(pix4, 1);

        /* clean the background of those lines */
    pix5 = pixThresholdToValue(NULL, pix4, 170, 255);
    //pixWrite("./dave-proc5.png", pix5, IFF_PNG);
    pixDisplayWrite(pix5, 1);

    pix6 = pixThresholdToValue(NULL, pix5, 200, 0);
    //pixWrite("./dave-proc6.png", pix6, IFF_PNG);
    pixDisplayWrite(pix6, 1);
    
   

        /* get paint-through mask for changed pixels */
    pix7 = pixThresholdToBinary(pix6, 200);
    //pixWrite("./dave-proc7.png", pix7, IFF_PNG);
    pixDisplayWrite(pix7, 1);
    
    

        /* add the inverted, cleaned lines to orig.  Because
         * the background was cleaned, the inversion is 0,
         * so when you add, it doesn't lighten those pixels.
         * It only lightens (to white) the pixels in the lines! */
    pixInvert(pix6, pix6);
    pix8 = pixAddGray(NULL, pix2, pix6);
    //pixWrite("./dave-proc8.png", pix8, IFF_PNG);
    pixDisplayWrite(pix8, 1);

    pix9 = pixOpenGray(pix8, 1, 5);
    //pixWrite("./dave-proc9.png", pix9, IFF_PNG);
    pixDisplayWrite(pix9, 1);

    pixCombineMasked(pix8, pix9, pix7);
    
    foldername = strtok(filein, "/");
    //foldername = strtok(NULL,"/");
    temp = strtok(NULL, "/");
    filearray = strtok(temp,"tiff");

    strcpy(filename, filearray);
    
    strcat(filename,"png");
    

    printf("%s\n",filename );
    strcpy(result,"./");
    
    strcat(result,foldername);
    strcat(result,"/");
    strcat(result,filename);
   
    
    pixWrite(result, pix8, IFF_PNG);
    
    printf("successfully removed lines : %s \n",result);
    
    pixDisplayWrite(pix8, 1);

    //pixDisplayMultiple("/tmp/display/file*");
    return 0;
}

