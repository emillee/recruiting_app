class UserJobPreapprovalsController < ApplicationController

	def create
		UserJobPreapproval.create(
			job_id: params[:job_id],
			preapproved_user_id: params[:preapproved_user_id],
			preapproval_applicant_id: params[:preapproval_applicant_id]
		)
		redirect_to :back
	end

	private
	def user_job_preapproval_params
		params.require(:user_job_preapproval).permit(:job_id, :preapproved_user_id, :preapproval_applicant_id)
	end

end