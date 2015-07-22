class AccountInformation < ActiveRecord::Base

	belongs_to :user

	validates :account_number, :presence => true
	validates :bank_code, :presence => true
	validates :bic, :presence => true
	validates :iban, :presence => true
	validates :credit_institution, :presence => true
	validates :user_id, :presence => true

end