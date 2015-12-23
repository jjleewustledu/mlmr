classdef MRNIfTId < mlfourd.NIfTId
	%% MRNIFTID enables polymorphism of NIfTId over MR data.

	%  $Revision$
 	%  was created 08-Dec-2015 15:10:44
 	%  by jjlee,
 	%  last modified $LastChangedDate$
 	%  and checked into repository /Users/jjlee/Local/src/mlcvl/mlmr/src/+mlmr.
 	%% It was developed on Matlab 8.5.0.197613 (R2015a) for MACI64.
 	

	properties
 		
 	end

    methods (Static) 
        function nii = load(fn, varargin)
            %% LOAD reads NIfTI objects from the file-system with file-names ending in NIfTId.SUPPORTED_EXTENSIONS.
            %  Freesurfer's mri_convert provides imaging format support.  If no file-extension is included, LOAD will attempt guesses.
            %  Usage:  nifti = MRNIfTId.load(filename[, description])
                 
            nii = mlmr.MRNIfTId(mlfourd.NIfTId.load(fn, varargin{:}));
        end
    end
    
	methods 
        function nii = clone(this)
            nii = mlmr.MRNIfTId(clone@mlfourd.NIfTId(this));
        end
        function nii = makeSimilar(this, varargin)
            nii = mlmr.MRNIfTId(makeSimilar@mlfourd.NIfTId(this, varargin{:}));
        end
		  
 		function this = MRNIfTId(varargin)
 			%% MRNIFTID
 			%  Usage:  this = MRNIfTId()

 			this = this@mlfourd.NIfTId(varargin{:});
 		end
 	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
 end

