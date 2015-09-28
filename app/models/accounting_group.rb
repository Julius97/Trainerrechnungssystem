class AccountingGroup < ActiveRecord::Base

	has_many :groups
	has_many :accounting_periods

	validates :name, :presence => true

	def actual_acc_period
		return_value = nil
		self.accounting_periods.each do |acc_period|
			if acc_period.start_date <= Date.today && acc_period.end_date >= Date.today
				return_value = acc_period
			end
		end
		return return_value
	end

end
