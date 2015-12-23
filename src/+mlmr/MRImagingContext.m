classdef MRImagingContext < mlfourd.ImagingContext
	%% MRIMAGINGCONTEXT  

	%  $Revision$
 	%  was created 08-Dec-2015 20:30:20
 	%  by jjlee,
 	%  last modified $LastChangedDate$
 	%  and checked into repository /Users/jjlee/Local/src/mlcvl/mlmr/src/+mlmr.
 	%% It was developed on Matlab 8.5.0.197613 (R2015a) for MACI64.
 	

	properties
 		
 	end

    methods (Static)
        function this = load(obj)
            %% LOAD
            %  Usage:  this = MRImagingContext.load(object)
            %                                       ^ fileprefix, filename, NIfTI, NIfTId, MGH, ImagingComponent
            
            this = mlmr.MRImagingContext(obj);
        end
    end
    
	methods 
        function c = clone(this)
            %% CLONE returns with state typeclass of mlfourd.ImagingLocation.
            %  Usage:  a_clone = this.clone;
            
            c = mlmr.MRImagingContext([]);
            c.state_ = mlfourd.ImagingLocation.load(this.fqfilename, c);
        end
		  
 		function this = MRImagingContext(varargin)
 			%% MRIMAGINGCONTEXT.  The copy-ctor returns with state typeclass of mlfourd.ImagingLocation.
            %  Usage:  this = MRImagingContext(object)
            %                                  ^ fileprefix, filename, NIfTI, NIfTId, MGH, ImagingComponent,
            %                                    ImagingContext

 			this = this@mlfourd.ImagingContext(varargin{:});
 		end
 	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
 end

