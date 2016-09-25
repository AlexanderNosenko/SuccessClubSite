class Admin::WithdrawalsController < Admin::AdminController

	before_action :prepare_withdrawal, except: [:index]
	require 'json'

	def index
		@withdrawals = Withdrawal.where(status: nil).order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
	end
	def show
		
	end
	def update

		success = @withdrawal.update_attribute(:status, params['withdrawal']['status'])

		redirect_to admin_withdrawals_path

		respond_to do |format|

			format.html { {'success' => success}.to_json }
			format.json { {'success' => success}.to_json }

		end
	end
	private
	def prepare_withdrawal
		@withdrawal = Withdrawal.find(params[:id])

	end
end
