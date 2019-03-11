classdef MRImagingContext < mlfourd.ImagingContext
	%% MRIMAGINGCONTEXT provides additional typeclassing for mlfourd.ImagingContext.

	%  $Revision$
 	%  was created 08-Dec-2015 20:30:10
 	%  by jjlee,
 	%  last modified $LastChangedDate$
 	%  and checked into repository /Users/jjlee/Local/src/mlcvl/mlmr/src/+mlmr.
 	%% It was developed on Matlab 8.5.0.197613 (R2015a) for MACI64.
 	

    methods (Static)
        function this = load(obj)
            %% LOAD:  cf. ctor
            
            this = mlmr.MRImagingContext(obj);
        end
    end
    
	methods 
        function a    = atlas(this, varargin)
            a = mlmr.MRImagingContext(atlas@mlfourd.ImagingContext(this, varargin{:}));
        end
        function b    = binarized(this)
            b = mlmr.MRImagingContext(binarized@mlfourd.ImagingContext(this));
        end
        function b    = binarizeBlended(this, varargin)
            b = mlmr.MRImagingContext(binarizeBlended@mlfourd.ImagingContext(this, varargin{:}));
        end
        function b    = blurred(this, varargin)
            b = mlmr.MRImagingContext(blurred@mlfourd.ImagingContext(this, varargin{:}));
        end 
        function f    = false(this, varargin)
            f = mlmr.MRImagingContext(false@mlfourd.ImagingContext(this, varargin{:}));
        end
        function g    = get(this, varargin)
            g = mlmr.MRImagingContext(get@mlfourd.ImagingContext(this, varargin{:}));
        end
        function m    = maskBlended(this, varargin)
            m = mlmr.MRImagingContext(maskBlended@mlfourd.ImagingContext(this, varargin{:}));
        end
        function m    = masked(this, varargin)
            m = mlmr.MRImagingContext(masked@mlfourd.ImagingContext(this, varargin{:}));
        end
        function m    = maskedByZ(this, varargin)
            m = mlmr.MRImagingContext(maskedByZ@mlfourd.ImagingContext(this, varargin{:}));
        end
        function n    = nan(this, varargin)
            n = mlmr.MRImagingContext(nan@mlfourd.ImagingContext(this, varargin{:}));
        end
        function n    = not(this, varargin)
           n = mlmr.MRImagingContext(not@mlfourd.ImagingContext(this, varargin{:}));
        end
        function o    = ones(this, varargin)
           o = mlmr.MRImagingContext(ones@mlfourd.ImagingContext(this, varargin{:}));
        end
        function t    = thresh(this, t)
            t = mlmr.MRImagingContext(thresh@mlfourd.ImagingContext(this, t));
        end
        function p    = threshp(this, p)
            p = mlmr.MRImagingContext(threshp@mlfourd.ImagingContext(this, p));
        end
        function t    = timeAveraged(this)
            t = mlmr.MRImagingContext(timeAveraged@mlfourd.ImagingContext(this));
        end
        function t    = timeContracted(this)
            t = mlmr.MRImagingContext(timeContracted@mlfourd.ImagingContext(this));
        end
        function t    = timeSummed(this)
            t = mlmr.MRImagingContext(timeSummed@mlfourd.ImagingContext(this));
        end
        function f    = true(this, varargin)
            f = mlmr.MRImagingContext(true@mlfourd.ImagingContext(this, varargin{:}));
        end
        function u    = uthresh(this, u)
            u = mlmr.MRImagingContext(uthresh@mlfourd.ImagingContext(this, u));
        end
        function p    = uthreshp(this, p)
            p = mlmr.MRImagingContext(uthreshp@mlfourd.ImagingContext(this, p));
        end
        function v    = volumeContracted(this)
            v = mlmr.MRImagingContext(volumeContracted@mlfourd.ImagingContext(this));
        end
        function v    = volumeSummed(this)
            v = mlmr.MRImagingContext(volumeSummed@mlfourd.ImagingContext(this));
        end
        function z    = zeros(this, varargin)
            z = mlmr.MRImagingContext(zeros@mlfourd.ImagingContext(this, varargin{:}));
        end
        function z    = zoomed(this, varargin)
            z = mlmr.MRImagingContext(zoomed@mlfourd.ImagingContext(this, varargin{:}));
        end
		  
        %% CTOR
        
 		function this = MRImagingContext(varargin)
            %% MRIMAGINGCONTEXT 
            %  @param obj is imaging data:  filename, INIfTI, MGH, ImagingComponent, double, [], ImagingContext or 
            %  MRImagingContext for copy-ctor.  
            %  @return initializes context for a state design pattern.  
            %  @throws mlfourd:switchCaseError, mlfourd:unsupportedTypeclass.

            this = this@mlfourd.ImagingContext(varargin{:});
 		end
        function c    = clone(this)
            %% CLONE simplifies calling the copy constructor.
            %  @return deep copy on new handle
            
            c = mlmr.MRImagingContext(this);
        end
    end 
    
	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
 end

