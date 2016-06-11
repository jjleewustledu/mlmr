classdef IMRData
	%% IMRDATA  

	%  $Revision$
 	%  was created 08-Jun-2016 17:49:14
 	%  by jjlee,
 	%  last modified $LastChangedDate$
 	%  and checked into repository /Users/jjlee/Local/src/mlcvl/mlmr/src/+mlmr.
 	%% It was developed on Matlab 9.0.0.341360 (R2016a) for MACI64.
 	
    
	methods (Abstract)
        % accept parameter 'type', {'folder' 'path'}
        f = freesurferLocation(this, ~)
        f = fslLocation(       this, ~)
        f = mriLocation(       this, ~)
        
        % accept parameter 'type', {'filename' 'fn' 'fqfn' 'fileprefix' 'fp' 'fqfp' 'folder' 'path' 'ext' 'imagingContext'}
        f = adc(      this, ~)
        f = aparcA2009sAseg(this, ~)
        f = asl(      this, ~)
        f = bold(     this, ~)
        f = brain(    this, ~)
        f = dwi(      this, ~)
        f = ep2d(     this, ~)
        f = fieldmap( this, ~)
        f = localizer(this, ~)
        f = mpr(      this, ~)
        f = orig(     this, ~)
        f = t1(       this, ~)
        f = t2(       this, ~)
        f = tof(      this, ~)        
        f = wmparc(   this, ~)
 	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
 end

