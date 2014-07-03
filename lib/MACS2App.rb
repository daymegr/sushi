#!/usr/bin/env ruby
# encoding: utf-8
Version = '201405230044'

require 'sushi_fabric'
require_relative 'global_variables'
include GlobalVariables

class MACS2App < SushiFabric::SushiApp
  def initialize
    super
    @name = 'MACS2'
    @analysis_category = 'PeakCalling'
    @required_columns = ['Name','BAM','BAI', 'build','Control']
    @required_params = ['build','paired']
    # optional params
    @params['cores'] = '1'
    @params['ram'] = '16'
    @params['scratch'] = '100'
    @params['build'] = ref_selector
    @params['paired'] = false
    @params['useControl'] = true
    @params['featureFile'] = 'genes.gtf'
    @params['cmdOptions'] = '--nomodel --shiftsize 73 --SPMR -g hs --bw 200'
    @params['specialOptions'] = ''
  end
  def set_default_parameters
    @params['build'] = @dataset[0]['build']
    if dataset_has_column?('featureFile')
      @params['featureFile'] = @dataset[0]['featureFile']
    end
    if dataset_has_column?('paired')
      @params['paired'] = @dataset[0]['paired']
    end                               
 end

  def next_dataset
    bw_link = File.join(@result_dir, "#{@dataset['Name']}.bw")
    peakfile_link = File.join(@result_dir, "#{@dataset['Name']}_peaks.xls")

    {'Name'=>@dataset['Name'], 
     'Species'=>@dataset['Species'],
     'build'=>@params['build'],
     'featureFile'=>@params['featureFile'],
     'paired'=>@params['paired'],
     'CalledPeaks [File]'=>peakfile_link,
      'BigWigFile [File]'=>bw_link
    }.merge factor_dataset
  end
  def commands
    command = "/usr/local/ngseq/bin/R --vanilla --slave << EOT\n"
    command << "source('/usr/local/ngseq/opt/sushi_scripts/init.R')\n"
    command << "config = list()\n"
    config = @params
    config.keys.each do |key|
      command << "config[['#{key}']] = '#{config[key]}'\n" 
    end
    command << "config[['dataRoot']] = '#{@gstore_dir}'\n"
    command << "input = list()\n"
    input = @dataset
    input.keys.each do |key|
      command << "input[['#{key}']] = '#{input[key]}'\n" 
    end
    command << "config[['chromSizes']] = paste('/srv/GT/reference/', gsub('Annotation/Version-.*', 'Sequence/Chromosomes/chromsizes.txt', input[['build']]),sep='')\n"
    command << "output = list()\n"
    output = next_dataset
    output.keys.each do |key|
      command << "output[['#{key}']] = '#{output[key]}'\n" 
    end
    command << "runMacs2(input=input, output=output, config=config)\n"
    command << "EOT"
    command
  end
end

if __FILE__ == $0

end
