classdef Test_MRAlignmentDirector < mlfsl_xunit.Test_MyAlignmentDirector 
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
    end
    
	methods 
        function test_alignSequentially(this)
            collec = { this.ep2dMeanCntxt this.t2Cntxt this.t1Cntxt };
            collec = imcast(collec,'mlfourd.ImagingComposite');
            assertTrue( isa(collec, 'mlfourd.ImagingComposite'));
            prds = this.mad.alignSequentially(collec);
            assertTrue(isa(prds, 'mlfourd.ImagingContext'));
            prds = prds.imcomponent;
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
            prds = prds.imcomponent;
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
            for p = 1:length(prds.imcomponent)
                imcmp = prds.imcomponent{p};
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
 			this = this@mlfsl_xunit.Test_MyAlignmentDirector(varargin{:}); 
            this.mad = mlmr.MRAlignmentDirector( ...
                       mlfsl.AlignmentDirector( ...
                       mlmr.MRAlignmentBuilder('reference', this.t1Cntxt)));
            mlbash(sprintf('rm -rf %s/*.mat+*', this.sessionPath));
        end         
    end 
    
    methods (Access = 'protected')
        function createEp2dMean(this)
            prd = this.mad.motionCorrect(this.ep2dCntxt);
            assertTrue(isa(prd, 'mlfourd.ImagingContext'));
        end
    end

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

