classdef MRRegistrationBuilder < mlfsl.AbstractRegistrationBuilder
	%% MRRegistrationBuilder  

	%  $Revision$
 	%  was created 01-Feb-2016 18:41:25
 	%  by jjlee,
 	%  last modified $LastChangedDate$
 	%  and checked into repository /Users/jjlee/Local/src/mlcvl/mlmr/src/+mlmr.
 	%% It was developed on Matlab 9.0.0.307022 (R2016a) Prerelease for MACI64.
 	

	properties (Dependent) 		
        sourceWeight
        referenceWeight
        sourceImage
        referenceImage
        product
 	end

    methods %% GET/SET
        function this = set.sourceWeight(this, w)
            this.sourceWeight_ = mlmr.MRImagingContext(w);
        end
        function w    = get.sourceWeight(this)
            % may be empty
            w = this.sourceWeight_;
        end
        function this = set.referenceWeight(this, w)
            this.referenceWeight_ = mlmr.MRImagingContext(w);
        end
        function w    = get.referenceWeight(this)
            % may be empty
            w = this.referenceWeight_;
        end
        function this = set.referenceImage(this, ref)
            this.referenceImage_ = mlmr.MRImagingContext(ref);
        end
        function ref  = get.referenceImage(this)
            ref = this.referenceImage_;
        end
        function this = set.sourceImage(this, src)
            this.sourceImage_ = mlmr.MRImagingContext(src);
        end
        function src  = get.sourceImage(this)
            src = this.sourceImage_;
        end
        function this = set.product(this, s)
            this.product_ = mlmr.MRImagingContext(s);
        end
        function prod = get.product(this)
            prod = this.product_;
            %prod.setNoclobber(false);
        end
    end

	methods 		  
        function this = registerBijective(this)
            this = this.registerInjective;
        end
        function this = registerInjective(this)
            visitor = mlmr.MRFlirtVisitor;           
            this = visitor.registerInjective(this, this.proxyBuilder);
            this.cleanUpProxy(this.proxyBuilder);
        end
        function this = registerSurjective(this)
            visitor = mlmr.MRFlirtVisitor;           
            this = visitor.registerSurjective(this, this.proxyBuilder);
            this.cleanUpProxy(this.proxyBuilder);
        end
        
        %% CTOR
        
 		function this = MRRegistrationBuilder(varargin)
 			this = this@mlfsl.AbstractRegistrationBuilder(varargin{:});
 		end
        function obj  = clone(this)
            obj = mlmr.MRRegistrationBuilder(this);
        end
 	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
 end

