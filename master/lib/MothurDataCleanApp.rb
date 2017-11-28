#!/usr/bin/env ruby
# encoding: utf-8
Version = '20171109-095604'

require 'sushi_fabric'
require_relative 'global_variables'
include GlobalVariables

class MothurDataCleanApp < SushiFabric::SushiApp
def initialize
super
@name = 'MothurDataClean'
@analysis_category = 'Metagenomics'
@description =<<-EOS
OTU-based metagenomics analysis with Mothur.
<a href='https://mothur.org/wiki/MiSeq_SOP'>https://mothur.org/wiki/MiSeq_SOP</a>
  EOS
@params['process_mode'] = 'DATASET'
@required_columns = ['Name', 'Read1', 'Technology']
@required_params = ['cutOff', 'diffs_Illumina','diffs_PacBio']
@params['cores'] = '1'
@params['ram'] = '8'
@params['scratch'] = '10'
@params['cutOff'] = '80'
@params['cutOff', 'description'] = 'Cut-off for taxonomy assignment in classify.seqs'
@params['diffs_Illumina'] = '2'
@params['diffs_Illumina', 'description'] = 'Differences allowed in the pre.cluster step. Should be 1 every 100 bases.If the data are only Pacbio, it is ignored'
@params['diffs_PacBio'] = '15'
@params['diffs_PacBio', 'description'] = 'Differences allowed in the pre.cluster step. Should be 1 every 100 bases.If the data are only Illumina, it is ignored'
@params['mail'] = ""
@inherit_tags = ["Factor", "B-Fabric", "Characteristic"]
@modules = ["Dev/R"]
end
def next_dataset
report_file = File.join(@result_dir, @params['name'])
report_link = File.join(report_file, '00index.html')
{'Name'=>@dataset['Name'],
  'CountTable [File]'=>File.join(@result_dir, "Mothur.good.unique.good.filter.unique.precluster.denovo.vsearch.pick.pick.count_table"),
  'PreClusteredFastaFile [File]'=>File.join(@result_dir, "Mothur.good.unique.good.filter.unique.precluster.pick.pick.fasta"),
  'Static Report [Link]'=>report_link
}.merge(extract_columns(@inherit_tags))

end
def commands
run_RApp("EzAppMothurDataClean")
end
end

if __FILE__ == $0
run SubreadsApp
#usecase = Bowtie2App.new

#usecase.project = "p1001"
#usecase.user = 'masamasa'

# set user parameter
# for GUI sushi
#usecase.params['process_mode'].value = 'SAMPLE'
#usecase.params['refBuild'] = 'mm10'
#usecase.params['paired'] = true
#usecase.params['strandMode'] = 'both'
#usecase.params['cores'] = 8
#usecase.params['node'] = 'fgcz-c-048'

# also possible to load a parameterset csv file
# mainly for CUI sushi
#usecase.parameterset_tsv_file = 'tophat_parameterset.tsv'
#usecase.parameterset_tsv_file = 'test.tsv'

# set input dataset
# mainly for CUI sushi
#usecase.dataset_tsv_file = 'tophat_dataset.tsv'

# also possible to load a input dataset from Sushi DB
#usecase.dataset_sushi_id = 3

# run (submit to workflow_manager)
#usecase.run
#usecase.test_run

end
