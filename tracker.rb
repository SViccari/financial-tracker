#!/usr/bin/env ruby
#Financial Tracker Apollo Assignment

require 'csv'

@overdraft_array = []
#balance starts at $0
balance = 0.0
#income starts at $0
income = 0.0
#expenses starts at $0
expenses = 0
#overdraft charges starts at $0
@overdraft_charges = 0

#if balance drops below zero, charge fee of $20.00
#store the transaction data when balance is less than zero
def log_overdraft(balance, trans)
			#place each overdraft into a hash
			overdraft_hash = {}
			@overdraft_charges += 20
			#store each row as a hash
  		overdraft_hash[:current_balance] = balance.round(2)
  		overdraft_hash[:date] = trans[0]
  		overdraft_hash[:amount] = trans[1].to_i.round(2)
  		overdraft_hash[:description] = trans[2]
			#push the overdraft data (hashes) into an array
  		@overdraft_array << overdraft_hash
end

#process each transaction to know the current balance at any stage
CSV.foreach('transactions.csv', headers: true) do |trans|
  balance += trans[1].to_f
  	if balance < 0
  		#add $20 each time the balance is below zero
  		log_overdraft(balance, trans) 
  	end

  	#if the balance is over zero, add to "income"
  	if trans[1].to_f > 0
  		income += trans[1].to_f
  	end

  	#if the balance is below zero, add to "expenses"
  	if trans[1].to_f < 0
  		expenses += trans[1].to_f
		end
end

#print "Ending Blanance: AMT" after processing all transactions
#print "Total Income: AMT" after processing all transactions
#print "Total Expenses: AMT" after processing all transactions
puts "Ending Balance: #{balance.round(2)}"
puts "Total Income: #{income.round(2)}" 
puts "Total Expenses: #{expenses.round(2)}"
puts "Total Overdraft Charges: #{@overdraft_charges}"
puts
#Print heading Overdrafts (balance, expense, description, date) after total draft charges.
puts "Overdrafts (balance, expense, description, date)"

@overdraft_array.each do |object|
	object.each do |key, value|
		print "#{key} #{value}, "
	end
	puts 
end





