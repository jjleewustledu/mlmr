classdef MRRegistry < mlpatterns.Singleton
	%% MRREGISTRY  

	%  $Revision$
 	%  was created 16-Oct-2015 10:49:45
 	%  by jjlee,
 	%  last modified $LastChangedDate$
 	%  and checked into repository /Users/jjlee/Local/src/mlcvl/mlpet/src/+mlpet.
 	%% It was developed on Matlab 8.5.0.197613 (R2015a) for MACI64.
 	
	properties (Constant)
    end
    
    methods
        function g = testStudyData(~, reg)
            assert(ischar(reg));
            g = mlpipeline.StudyDataSingletons.instance(reg);
        end
        function g = testSessionData(this, reg)
            assert(ischar(reg));
            studyData = this.testStudyData(reg);
            iter = studyData.createIteratorForSessionData;
            g = iter.next;
        end
    end
    
    methods (Static)
        function this = instance(qualifier)
            %% INSTANCE uses string qualifiers to implement registry behavior that
            %  requires access to the persistent uniqueInstance
            persistent uniqueInstance
            
            if (exist('qualifier','var') && ischar(qualifier))
                if (strcmp(qualifier, 'initialize'))
                    uniqueInstance = [];
                end
            end
            
            if (isempty(uniqueInstance))
                this = mlpet.MRRegistry();
                uniqueInstance = this;
            else
                this = uniqueInstance;
            end
        end
    end 
    
    methods  
    end
    
	methods (Access = 'private') 		  
 		function this = MRRegistry(varargin)
 			this = this@mlpatterns.Singleton(varargin{:});
 		end
 	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy
 end

