classdef Test_MRAlignmentDirector < mlfourd_unittest.Test_mlfourd
	%% TEST_MRALIGNMENTDIRECTOR  

	%  Usage:  >> runtests tests_dir  
	%          >> runtests mlmr.Test_MRAlignmentDirector % in . or the matlab path 
	%          >> runtests mlmr.Test_MRAlignmentDirector:test_nameoffunc 
	%          >> runtests(mlmr.Test_MRAlignmentDirector, Test_Class2, Test_Class3, ...) 
	%  See also:  package xunit 

	%  $Revision$ 
 	%  was created $Date$ 
 	%  by $Author$,  
 	%  last modified $LastChangedDate$ 
 	%  and checked into repository $URL$,  
 	%  developed on Matlab 8.1.0.604 (R2013a) 
 	%  $Id$ 
    
    properties
        mad
        
        E_diffusion = { 2.212584730546838 1.978445464593273 };
        E_ep2dMcf   =   4.872446363605402;
        E_ep2dMean  =   4.486447584822766;
        E_indep     = { 2.823928199240487 3.117361156097319 };
        E_perfusion =   2.900899603213688;
        E_sequen    = { 2.900899603213688 3.117361156097319 4.318537132583254 };
        E_t2ont1    =   3.117361156097319;
        E_iront1    =   0;
    end
    
    properties (Dependent)
        bettedStandard_fqfn
        bettedStandardCntxt
        standard_fqfn
        standardCntxt
        fsaverage_fqfn
        fsaverageCntxt
    end

    methods %% GET/SET
        function fn = get.bettedStandard_fqfn(this) %#ok<MANU>
            fn = fullfile(getenv('FSLDIR'), 'data/standard', 'MNI152_T1_2mm_brain.nii.gz');
        end
        function ic = get.bettedStandardCntxt(this)
            ic = mlfourd.ImagingContext.load(this.bettedStandard_fqfn);
        end
        function fn = get.standard_fqfn(this) %#ok<MANU>
            fn = fullfile(getenv('FSLDIR'), 'data/standard', 'MNI152_T1_2mm.nii.gz');
        end
        function ic = get.standardCntxt(this)
            ic = mlfourd.ImagingContext.load(this.standard_fqfn);
        end
        function fn = get.fsaverage_fqfn(this) %#ok<MANU>
            fn = fullfile(getenv('MLUNIT_TEST_PATH'), 'np755/fsaverage_2013nov18/fsl/brainmask_2mm.nii.gz');
        end
        function ic = get.fsaverageCntxt(this)
            ic = mlfourd.ImagingContext.load(this.fsaverage_fqfn);
        end
    end
    
	methods 
        function test_alignSequentially(this)
            collec = { this.ep2dMeanCntxt this.t2Cntxt this.t1Cntxt };
            collec = imcast(collec,'mlfourd.ImagingComposite');
            assertTrue( isa(collec, 'mlfourd.ImagingComposite'));
            prds = this.mad.alignSequentially(collec);
            assertTrue(isa(prds, 'mlfourd.ImagingContext'));
            prds = prds.composite;
            for p = 1:length(prds)
                this.assertEntropies(this.E_sequen{p}, prds.get(p).fqfilename);
            end
        end
        function test_alignIndependently(this)
            collec = { this.ep2dMeanCntxt this.t2Cntxt };
            collec = imcast(collec,'mlfourd.ImagingComposite');
            assertTrue( isa(collec, 'mlfourd.ImagingComposite'));
            prds = this.mad.alignIndependently(collec, this.t1Cntxt);
            assertTrue(isa(prds, 'mlfourd.ImagingContext'));
            prds = prds.composite;
            for p = 1:length(prds)
                this.assertEntropies(this.E_indep{p}, prds.get(p).fqfilename);
            end
        end
 		function test_alignPair(this)
            prd = this.mad.alignPair(this.t2Cntxt, this.t1Cntxt);
            assertTrue(isa(prd, 'mlfourd.ImagingContext'));
            this.assertEntropies(this.E_t2ont1, prd.fqfilename);
        end 
        function test_alignPerfusion(this)
            cd(this.fslPath);
            %%%fprintf('\nTest_MRAlignmentDirector.test_alignPerfusion:  pwd->%s\n', pwd);
            prd = this.mad.alignPerfusion(this.ep2dCntxt, this.t2Cntxt);
            assertTrue(isa(prd, 'mlfourd.ImagingContext'));
            this.assertEntropies(this.E_perfusion, prd.fqfilename);
        end
 		function test_alignDiffusion(this)
            prds = this.mad.alignDiffusion(this.dwiCntxt, this.adcCntxt, this.t2Cntxt);
            for p = 1:length(prds.composite)
                imcmp = prds.composite{p};
                this.assertEntropies(this.E_diffusion{p}, imcmp.fqfilename);
            end
        end 
        function test_meanvol(this)
            this.assertEntropies(this.E_ep2dMean, this.ep2dMean_fqfn);
        end
        function test_motionCorrect(this)
            this.assertEntropies(this.E_ep2dMcf, this.ep2dMcf_fqfn);
        end
        
 		function this = Test_MRAlignmentDirector(varargin) 
 			this = this@mlfourd_unittest.Test_mlfourd(varargin{:});             
            cd(this.sessionPath);
            this.mad = mlmr.MRAlignmentDirector( ...
                       mlfsl.AlignmentDirector( ...
                       mlmr.MRAlignmentBuilder('reference', this.t1Cntxt)));
            mlbash(sprintf('rm -rf %s/*.mat+*', this.sessionPath));
        end         
    end 
    
    methods (Access = 'protected')
        function createEp2dMean(this)
            prd = this.mad.directMotionCorrection(this.ep2dCntxt);
            assertTrue(isa(prd, 'mlfourd.ImagingContext'));
        end
    end

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

