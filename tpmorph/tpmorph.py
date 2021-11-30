
# export SITK_SHOW_COMMAND=fslview

# help(toto) -> aide de toute les fonction de toto

import SimpleITK as sitk
import math

import tpmod as tp

import sys

import argparse





def mapImage(movNum,fixNum,nodeSpacing):

    print "mapImage"
    # load images and point files
    mov = sitk.ReadImage("img_%02d.nii" %movNum)
    fix = sitk.ReadImage("img_%02d.nii" %fixNum)
    movP = tp.readImageAndPoints(movNum)
    fixP = tp.readImageAndPoints(fixNum)
	
    # create the bspline parameter map
    # and set node spacing, int
    parameterMap = sitk.GetDefaultParameterMap('bspline')
    parameterMap['MaximumNumberOfIterations'] = ['256']	
	
    # create elastix object for point registration
    selx=tp.createElastix(mov,fix,parameterMap)
	

    # run the registration
    selx.Execute()


    # get the transformation map
    # and map the moving image in the fixed reference 
    tpm = selx.GetTransformParameterMap()
    res = sitk.Transformix(mov,tpm)
    res.CopyInformation(fix)

    # only for compile
    # remove these two lines
    #tpm = []
    #res = sitk.Image(1,1,sitk.sitkUInt16)

    return tpm, res



def morph(odir,movNum,fixNum,nodeSpacing,N):

    print "morph"
    # read the moving image 
    # registration using mapImage 
    mov = sitk.ReadImage("img_%02d.nii" %movNum)
    fix = sitk.ReadImage("img_%02d.nii" %fixNum)
    tpm,img=mapImage(movNum,fixNum,nodeSpacing)

    # get the bspline coefficient
    bsplCoeff = tp.getBsplineCoeff(tpm) 
    
    # for each "time" sample
    # compute the modified bspline coeff, the modified tpm
    # the intermediate image
    img = []
    for k in range(0,N):
	#t=2
        bsplCoeffTemp= bsplCoeff -(1.0*k/N) * bsplCoeff
	#print("K%f",1.0*t/N)
        #sys.exit(0)
	tpmTemp=tp.setBsplineCoeff(tpm,bsplCoeffTemp)
        I= sitk.TransformixImageFilter()
	I.SetMovingImage(mov)
        I.SetTransformParameterMap(tpmTemp)
        I.Execute()
        img.append(I.GetResultImage())
        sitk.WriteImage(img[k],"%s/img_%02d_%02d_%03d.nii" % (odir,movNum,fixNum,k))

    return img
def morphSym(odir,k,l,nodeSpacing,N):

    print "morphSym"
    # perform the non symmetric morphing in each direction
    img1=morph(odir,k,l,nodeSpacing,N)
    img2=morph(odir,l,k,nodeSpacing,N) 
    # merge the two image series
    img = []
    for k in range(0,N):
	I=img1[k]*1.0*k/N + img2[k]*(1.0 - 1.0*k/N)
        img.append(I)
        sitk.WriteImage(img[k],"%s/img_%02d_%02d_%03d.nii" % (odir,k,l,k))

    return img


def morphEveryone(odir,nodeSpacing,N):

    print "morphEveryone"
#    # apply the morphing between image and the next 
    img = []
   #nodeSpacing=1
    for i in range(0,9):
       imgTemp = morphSym(odir,i,i+1,nodeSpacing,N)
       img=img+imgTemp
       
    return img






if __name__ == '__main__':
    ##################################################################################
    ##################################################################################
    # parse command line 
    parser = argparse.ArgumentParser()

    parser.add_argument("-N",   dest='N',            default='20', help="number of samples")
    parser.add_argument("-ns",  dest='nodeSpacing',  default='6',  help="node spacing")

    parser.add_argument("exNum", help="which exercice")
    parser.add_argument("exArgs", help="argument for the given exercice",nargs='*')

    args = parser.parse_args()

    N           = int(args.N)
    nodeSpacing = int(args.nodeSpacing)

    exNum  = args.exNum
    exArgs = args.exArgs


    ##################################################################################
    ##################################################################################
    # registration and map for a given node spacing
    if exNum=="ex1":
        if len(exArgs)!=2:
            print "exercice 1: tpnote movNum fixNum"
            sys.exit(1)
        movNum, fixNum = [int(a) for a in exArgs]
        tpm,img = mapImage(movNum,fixNum,nodeSpacing)
        sitk.WriteImage(img, "ex1.nii")
        print ("fslview -m single img_%02d ex1" % fixNum )
        sys.exit(0)

    ##################################################################################
    ##################################################################################
    # morphing, non symmetric
    if exNum=="ex2":
        if len(exArgs)!=2:
            print "exercice 2: tpnote movNum fixNum"
            sys.exit(1)
        movNum, fixNum = [int(a) for a in exArgs]
        imglist = morph("morph",movNum,fixNum,nodeSpacing,N)
        img3D   = sitk.JoinSeries(imglist)
        sitk.WriteImage(img3D, "ex2.nii")
        print ("fslview -m single img_%02d morph/img_%02d_%02d_???.nii img_%02d" % (fixNum,movNum,fixNum,movNum ) )
        print ("fslview -m single ex2.nii" )
        sys.exit(0)

    ##################################################################################
    ##################################################################################
    # morphing symmetric
    if exNum=="ex3":
        if len(exArgs)!=2:
            print "exercice 3: tpnote movNum fixNum"
            sys.exit(1)
        movNum, fixNum = [int(a) for a in exArgs]
        imglist = morphSym("morphSym",movNum,fixNum,nodeSpacing,N)
        img3D   = sitk.JoinSeries(imglist)
        sitk.WriteImage(img3D, "ex3.nii")
        print ("fslview -m single img_%02d morphSym/img_%02d_%02d_???.nii img_%02d" % (fixNum,movNum,fixNum,movNum ) )
        print ("fslview -m single ex3.nii" )
        sys.exit(0)

    ##################################################################################
    ##################################################################################
    # morphing everyone
    if exNum=="ex4":
        if len(exArgs)!=0:
            print "exercice 4: tpnote ex4 "
            sys.exit(1)
        imglist = morphEveryone("morphEveryone",nodeSpacing,N)
        img3D   = sitk.JoinSeries(imglist)
        sitk.WriteImage(img3D, "ex4.nii")
#        print ("fslview -m single img_%02d morphSym/img_%02d_%02d_???.nii img_%02d" % (fixNum,movNum,fixNum,movNum ) )
        print ("fslview -m single ex4.nii" )
        sys.exit(0)

    ##################################################################################
    ##################################################################################
    print "unknown exercice " + args.exNum 
    

        

