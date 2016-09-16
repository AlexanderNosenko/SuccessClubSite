class Admin::PaymentsController < Admin::AdminController

  def index
    @payments = Payment.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end
end
