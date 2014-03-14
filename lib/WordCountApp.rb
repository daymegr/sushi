#!/usr/bin/env ruby
# encoding: utf-8

require 'sushi_fabric'
require_relative 'global_variables'

class WordCountApp < SushiFabric::SushiApp
  include GlobalVariables
  def initialize
    super
    @name = 'Word_Count'
    @description = "#{GlobalVariables::SUSHI}"
    @analysis_category = 'Stats'
    @params['grouping'] = '' ### TODO: this should be filled by a column selector that allows to select a column with the tag 'Factor'
    @params['sampleGroup'] = '' ## TODO: this should be a value from the selected column
    @params['refGroup'] = '' ## TODO: this should be a value from the selected column
    @required_columns = ['Name', 'Read1']
    @required_params = []
  end
  def next_dataset
    {
      'Name'=>@dataset['Name'],
      'Stats [File]'=>File.join(@result_dir, @dataset['Name'].to_s + '.stats')
    }.merge factor_dataset
  end
  def preprocess
    if @factors = get_columns_with_tag('Factor') and @factors.first
      @factor_cols = @factors.first.keys
    end
  end
  def commands
    commands = ''
    commands << "gunzip -c $GSTORE_DIR/#{@dataset['Read1']} |wc > #{@dataset['Name']}.stats\n"
    commands << "echo 'Factor columns: [#{@factor_cols.join(',')}]'\n"
    commands << "echo 'Factors: [#{@factors.join(',')}]'\n"
    commands << "echo '#{GlobalVariables::SUSHI}'\n"
    commands << "echo '#{SUSHI}'\n"
    commands
  end
end
if __FILE__ == $0
  usecase = WordCountApp.new

  usecase.project = "p1001"
  usecase.user = 'sushi_lover'
  #usecase.parameterset_tsv_file = 'sample_parameterset.tsv'
  #usecase.dataset_tsv_file = 'sample_dataset.tsv'
  usecase.dataset_sushi_id = 1
  usecase.params['grouping'] = 'hoge'

  # run (submit to workflow_manager)
  #usecase.run
  usecase.test_run
end
