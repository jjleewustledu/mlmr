classdef (Abstract) ISessionMRData 
	%% ISESSIONMRDATA  

	%  $Revision$
 	%  was created 27-May-2018 16:56:40 by jjlee,
 	%  last modified $LastChangedDate$ and placed into repository /Users/jjlee/MATLAB-Drive/mlpet/src/+mlpet.
 	%% It was developed on Matlab 9.4.0.813654 (R2018a) for MACI64.  Copyright 2018 John Joowon Lee.
 	
	properties
 		atlVoxelSize
 	end
    
	methods (Abstract)        
        aparcA2009sAseg(this)
        aparcAseg(this)
        asl(this)
        atlas(this)
        bold(this)
        brainmask(this)
        freesurferLocation(this)
        fslLocation(this)
        mriLocation(this)
        mrObject(this)
        T1001(this)
        tof(this)
        wmparc(this)
        zeroZeroOne(this)
  	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
 end

