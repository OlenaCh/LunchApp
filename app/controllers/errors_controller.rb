class ErrorsController < ApplicationController
  def no_access
    redirect_to no_access_path
  end
  
  def record_not_found
    redirect_to record_not_found_path
  end
  
  def sth_went_wrong
    redirect_to sth_went_wrong_path
  end
end