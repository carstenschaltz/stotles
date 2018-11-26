class AccountantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @accountants = policy_scope(Accountant).paginate(page: params[:page], per_page: 10)
    if params[:accountant]
      params[:accountant][:services].each do |id|
        next if id = ""
        @accountants = Service.find(id).accountants & @accountants
      end
      puts "loop done"
    end
  end

  def show
    @accountant = Accountant.find(params[:id])

    if user_signed_in?
      @open_enquiries = current_user.enquiries.where(closed: false)
      @open_enquiries_no_quote = []
      @open_enquiries.each do |e|
        @open_enquiries_no_quote << e unless e.quotes.any? { |quote| quote.accountant == @accountant }
      end
    else
      @open_enquiries = []
      @open_enquiries_no_quote = []
    end

    authorize @accountant
  end
end
