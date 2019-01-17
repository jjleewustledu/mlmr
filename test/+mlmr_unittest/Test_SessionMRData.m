classdef Test_SessionMRData < matlab.unittest.TestCase
	%% TEST_SESSIONMRDATA 

	%  Usage:  >> results = run(mlmr_unittest.Test_SessionMRData)
 	%          >> result  = run(mlmr_unittest.Test_SessionMRData, 'test_dt')
 	%  See also:  file:///Applications/Developer/MATLAB_R2014b.app/help/matlab/matlab-unit-test-framework.html

	%  $Revision$
 	%  was created 27-May-2018 14:49:58 by jjlee,
 	%  last modified $LastChangedDate$ and placed into repository /Users/jjlee/MATLAB-Drive/mlmr/test/+mlmr_unittest.
 	%% It was developed on Matlab 9.4.0.813654 (R2018a) for MACI64.  Copyright 2018 John Joowon Lee.
 	
	properties
 		registry
 		testObj
 	end

	methods (Test)
		function test_afun(this)
 			import mlmr.*;
 			this.assumeEqual(1,1);
 			this.verifyEqual(1,1);
 			this.assertEqual(1,1);
 		end
        function test_atlVoxelSize(this)
        end
        function test_aparcA2009sAseg(this)
        end
        function test_aparcAseg(this)
        end
        function test_asl(this)
        end
        function test_atlas(this)
        end
        function test_bold(this)
        end
        function test_brainmask(this)
        end
        function test_freesurferLocation(this)
        end
        function test_mrObject(this)
        end
        function test_T1001(this)
        end
        function test_tof(this)
        end
        function test_wmparc(this)
        end
        function test_zeroZeroOne(this)
        end
	end

 	methods (TestClassSetup)
		function setupSessionMRData(this)
 			import mlmr.*;
 			this.testObj_ = SessionMRData;
 		end
	end

 	methods (TestMethodSetup)
		function setupSessionMRDataTest(this)
 			this.testObj = this.testObj_;
 			this.addTeardown(@this.cleanFiles);
 		end
	end

	properties (Access = private)
 		testObj_
 	end

	methods (Access = private)
		function cleanFiles(this)
 		end
	end

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
 end

