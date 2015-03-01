classdef MRAlignmentDirector < mlfsl.AlignmentDirectorDecorator
	%% MRALIGNMENTDIRECTOR   

	%  $Revision$ 
 	%  was created $Date$ 
 	%  by $Author$,  
 	%  last modified $LastChangedDate$ 
 	%  and checked into repository $URL$,  
 	%  developed on Matlab 8.1.0.604 (R2013a) 
 	%  $Id$ 
    
    methods (Static)
        function mad = factory(varargin)
            %% FACTORY returns an MRAlignmentDirector/AlignmentDirector/MRAlignmentBuilder
            %  Usage:   mad = MRAlignmentDirector.factory([varargin for MRAlignmentBuilder])
            
            mad = mlmr.MRAlignmentDirector( ...
                  mlfsl.AlignmentDirector( ...
                  mlmr.MRAlignmentBuilder(varargin{:})));
        end
        function       createBettedT1(sessionPth)
            if (~exist('sessionPth', 'var'))
                sessionPth = pwd; end
            cd(fullfile(sessionPth, 'fsl', ''));
            t1_fqfn  = fullfile(sessionPth, 'fsl', 't1_default.nii.gz');
            t1_cntxt = imcast(t1_fqfn, 'mlfourd.ImagingContext');
            mad = mlmr.MRAlignmentDirector.factory( ...
                'product',        t1_cntxt, ...
                'referenceImage', t1_cntxt);
            mad.ensureBetted(t1_cntxt);            
        end
        function img = ensureBetted(img)
            if (~mlfsl.BrainExtractionVisitor.isbetted(img))
                mab = mlmr.MRAlignmentBuilder('product', imcast(img, 'mlfourd.ImagingContext'));
                mab = mab.buildBetted;
                img = mab.product;
            end
        end
    end
    
	methods 
        function prds = alignDiffusion(this, dwi, adc, t2)
            dwi = imcast(dwi, 'mlfourd.ImagingContext');
            adc = imcast(adc, 'mlfourd.ImagingContext');
            t2  = imcast(t2,  'mlfourd.ImagingContext');
            dwi = this.meanvol(dwi);
            dwi.save;
           
            import mlfourd.*;
            dwiset = ImagingContext.load( ...
                     ImagingComposite.load({dwi adc}));
            dwiset = this.alignThenApplyXfm(dwiset, this.alignT2(t2));
            prds   = ImagingContext.load( ...
                     ImagingComponent.load(dwiset));
        end
        function prd  = alignInversionRecovery(this, ir, t2)
            prd = this.alignPair( ...
                  ir, this.alignT2(t2));
        end
        function prd  = alignT2(this, t2)
            prd = this.alignSingle(t2);
        end
        function prd  = alignPerfusion(this, ep2d, t2)
            import mlfsl.*;            
            ep2d = this.meanvol(this.motionCorrect(ep2d));
            assert(lstrfind(imcast(ep2d, 'fileprefix'), ...
                  [FlirtVisitor.MCF_SUFFIX FlirtVisitor.MEANVOL_SUFFIX]));
            prd = this.alignT2star(ep2d, t2);
        end
        function prd  = alignT2star(this, t2s, t2)
            prd = this.alignPair( ...
                  t2s, this.alignT2(t2));
        end
        function prds = alignT2starOnT2(this, prds, refT2)
            %% ALIGNT2STARONT2 aligns a T2-star imaging component/composite to a reference T2;
            %  as T2-stars have hypointense skull/dura, this method aligns T2-stars to reference T2s which are
            %  also brain-extracted.
            %  t2star_composite = obj.alignT2startIdentically(t2star_component, reference_t2)
            %                                                 ^ ImagingComponent/ImagingComposite object, for which the 1st image is the
            %                                                   T2star template; the registered template's transformation matrix
            %                                                   is used to register the 2nd, ..., Nth images
            %                                                                   ^ t2-weighted anatomical registered to a 
            %                                                                     t1-weighted anatomical
            
            refT2 = imcast(refT2, 'mlfourd.NIfTI');
            refT2 = refT2 .* mlfourd.NIfTI.load( ...
                             fullfile(fileparts(refT2.fqfilename), 'bt1_default_mask.nii.gz'));
            refT2 = refT2.saveas('bt2_default_on_t1_default');
            refT2 = imcast(refT2, 'mlfourd.ImagingContext');
            prds  = this.alignThenApplyXfm(prds, refT2);
        end
        function prds = alignT2starOnT1(this, prds, refT1)
            %% ALIGNT2STARONT1 aligns a T2-star imaging component/composite to a reference T1;
            %  as T2-stars have hypointense skull/dura, this method aligns T2-stars to reference T1s which are
            %  also brain-extracted.
            %  t2star_composite = obj.alignT2startIdentically(t2star_component, reference_t2)
            %                                                 ^ ImagingComponent/ImagingComposite object, for which the 1st image is the
            %                                                   T2star template; the registered template's transformation matrix
            %                                                   is used to register the 2nd, ..., Nth images
            %                                                                   ^ t2-weighted anatomical registered to a 
            %                                                                     t1-weighted anatomical
            
            refT1 = imcast(refT1, 'mlfourd.NIfTI');
            refT1 = refT1 .* mlfourd.NIfTI.load( ...
                             fullfile(fileparts(refT1.fqfilename), 'bt1_default_mask.nii.gz'));
            refT1 = refT1.saveas('bt1_default_on_t1_default');
            refT1 = imcast(refT1, 'mlfourd.ImagingContext');
            prds  = this.alignThenApplyXfm(prds, refT1);
        end
        
 		function this = MRAlignmentDirector(varargin) 
 			%% MRALIGNMENTDIRECTOR 
 			%  Usage:  this = MRAlignmentDirector([anMRAlignmentBuilder]) 

            this = this@mlfsl.AlignmentDirectorDecorator(varargin{:});
            assert(isa(this.alignmentBuilder, 'mlmr.MRAlignmentBuilder'));
 		end 
    end     

    
	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end
