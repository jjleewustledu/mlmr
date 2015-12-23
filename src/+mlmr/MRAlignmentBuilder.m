classdef MRAlignmentBuilder < mlfsl.AlignmentBuilderPrototype
	%% MRALIGNMENTBUILDER   
    %  See also:  mlpatterns.BuilderImpl

	%  $Revision$ 
 	%  was created $Date$ 
 	%  by $Author$,  
 	%  last modified $LastChangedDate$ 
 	%  and checked into repository $URL$,  
 	%  developed on Matlab 8.1.0.604 (R2013a) 
 	%  $Id$ 
    
	methods 
        function this = buildBetted(this)
            vtor = mlfsl.BrainExtractionVisitor;
            this = vtor.visitMRAlignmentBuilder(this);
        end
        function this = andBrainmaskBetted(this)
            cd(this.fslPath);
            try
                mlbash('mri_convert ../mri/brainmask.mgz ./brainmask.nii.gz');
                mlbash('flirt -in brainmask -ref t1_default -omat brainmask_on_t1_default.mat -out brainmask_on_t1_default')
                mlbash('cp bt1_default_mask.nii.gz bt1_default_mask0.nii.gz');
                mlbash('fslmaths bt1_default_mask -mas brainmask_on_t1_default bt1_default_mask');
            catch ME
                handexcept(ME);
            end
        end
        function this = buildFasted(this)
            vtor = mlfsl.FastVisitor;
            this = vtor.visitMRAlignmentBuilder(this);
        end
 		function this = buildFlirted(this)
            visit = mlfsl.FlirtVisitor;
            this  = visit.align6DOF(this);
        end
 		function this = buildFlirtedSmallAngles(this)
            visit = mlfsl.FlirtVisitor;
            this  = visit.alignSmallAngles(this);
        end
        function obj  = clone(this)
            obj = mlfsl.MRAlignmentBuilder(this);
        end
        
 		function this = MRAlignmentBuilder(varargin) 
 			%% MRALIGNMENTBUILDER 
 			%  Usage:  this = MRAlignmentBuilder([...]) 
            %                                     ^ cf. mlfsl.AlignmentBuilderPrototype

 			this  = this@mlfsl.AlignmentBuilderPrototype(varargin{:}); 
 		end 
    end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
end

