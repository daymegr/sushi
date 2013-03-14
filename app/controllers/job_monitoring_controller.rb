class JobMonitoringController < ApplicationController
  def index
    @job_list = `public/wfm_job_list with_result`
    @job_list = @job_list.split(/\n/).map{|job| job.split(/,/)}
  end
  def print_log
    text = `public/wfm_get_log #{params[:job_id]} :with_err`
    render :text => text.gsub(/\n/,'<br />')
  end
  def print_script
    text = `public/wfm_get_script #{params[:job_id]}`
    render :text => text.gsub(/\n/,'<br />')
  end
end