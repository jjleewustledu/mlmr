classdef Test_MRRegistrationBuilder < matlab.unittest.TestCase
	%% TEST_MRREGISTRATIONBUILDER  

	%  $Revision$ 
 	%  was created $Date$ 
 	%  by $Author$,  
 	%  last modified $LastChangedDate$ 
 	%  and checked into repository $URL$,  
 	%  developed on Matlab 8.1.0.604 (R2013a) 
 	%  $Id$ 
    
    properties        
 		registry
        studyData
        sessionData
 		mrb
        
        view = true
        
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
    
	methods (Test)
        function test_motionCorrect(this)
            this.mrb.sourceImage = this.sessionData.ep2d_fqfn;
            this.mrb = this.mrb.motionCorrect;
            prod = this.mrb.product;
            this.verifyInstanceOf(prod, 'mlfourd.ImagingContext');
            if (this.view)
                prod.view(this.mrb.sourceImage);
            end
        end
        function test_registerBijective(this)
        end
        function test_registerSurjective(this)
        end
        function test_registerInjective(this)
        end
        function test_information(this)
        end
        function test_alignSequentially(this)
            return
            
            collec = { this.ep2dMeanCntxt this.t2Cntxt this.t1Cntxt };
            collec = imcast(collec,'mlfourd.ImagingComposite');
            assertTrue( isa(collec, 'mlfourd.ImagingComposite'));
            prds = this.mrb.alignSequentially(collec);
            assertTrue(isa(prds, 'mlfourd.ImagingContext'));
            prds = prds.composite;
            for p = 1:length(prds)
                this.assertEntropies(this.E_sequen{p}, prds.get(p).fqfilename);
            end
        end
        function test_alignPerfusion(this)
            return
            
            cd(this.fslPath);
            %%%fprintf('\nTest_MRRegistrationBuilder.test_alignPerfusion:  pwd->%s\n', pwd);
            prd = this.mrb.alignPerfusion(this.ep2dCntxt, this.t2Cntxt);
            assertTrue(isa(prd, 'mlfourd.ImagingContext'));
            this.assertEntropies(this.E_perfusion, prd.fqfilename);
        end
 		function test_alignDiffusion(this)
            return
            
            prds = this.mrb.alignDiffusion(this.dwiCntxt, this.adcCntxt, this.t2Cntxt);
            for p = 1:length(prds.composite)
                imcmp = prds.composite{p};
                this.assertEntropies(this.E_diffusion{p}, imcmp.fqfilename);
            end
        end 
    end
    
 	methods (TestClassSetup)
		function setupMRRegistrationBuilder(this)
 			import mlmr.*;
            this.registry = MRRegistry.instance('initialize');
            this.studyData = this.registry.testStudyData('test_derdeyn');
            this.sessionData = this.registry.testSessionData('test_derdeyn'); 
            disp(this.sessionData)
 			this.mrb_ = MRRegistrationBuilder('sessionData', this.sessionData);
 		end
	end

 	methods (TestMethodSetup)
		function setupMRRegistrationBuilderTest(this)
 			this.mrb = this.mrb_;
            this.addTeardown(@this.cleanupFiles);
 		end
    end
    
    %% PRIVATE

	properties (Access = private)
 		mrb_
    end
    
    methods (Access = private)
        
        function cleanupFiles(this)
            deleteExisting(this.mrb.sourceWeight);
            deleteExisting(this.mrb.referenceWeight);
        end
        function verifyIC(this, ic, e, m, fp)
            this.assumeInstanceOf(ic, 'mlfourd.ImagingContext');
            this.verifyEqual(ic.niftid.entropy, e, 'RelTol', 1e-6);
            this.verifyEqual(dipmad(ic.niftid.img), m, 'RelTol', 1e-4);
            this.verifyEqual(ic.fileprefix, fp); 
        end
    end

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

