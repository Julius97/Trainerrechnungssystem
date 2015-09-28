class AccountingPeriod < ActiveRecord::Base

	belongs_to :accounting_group

	validates :start_date, :presence => true
	validates :end_date, :presence => true
	validates :accounting_group_id, :presence => true

end