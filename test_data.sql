-- Users
INSERT INTO users (email, password_hash, first_name, last_name) VALUES
  ('john.doe@example.com', '$2a$10$123456789abcdefghijklmnopqrstuvwxyz', 'John', 'Doe'),
  ('jane.smith@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456789', 'Jane', 'Smith'),
  ('mike.johnson@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456789', 'Mike', 'Johnson'),
  ('sara.wilson@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456789', 'Sara', 'Wilson');

-- User Profiles
INSERT INTO user_profiles (user_id, profile_type, profile_name) VALUES
  ((SELECT id FROM users WHERE email = 'john.doe@example.com'), 'personal', 'John''s Personal Profile'),
  ((SELECT id FROM users WHERE email = 'john.doe@example.com'), 'business', 'John''s Business Profile'),
  ((SELECT id FROM users WHERE email = 'jane.smith@example.com'), 'personal', 'Jane''s Personal Profile'),
  ((SELECT id FROM users WHERE email = 'mike.johnson@example.com'), 'personal', 'Mike''s Personal Profile'),
  ((SELECT id FROM users WHERE email = 'sara.wilson@example.com'), 'personal', 'Sara''s Personal Profile');

-- Financial Accounts
INSERT INTO financial_accounts (profile_id, account_type, account_name, balance, currency) VALUES
  ((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'checking', 'John''s Checking Account', 5000.00, 'USD'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'savings', 'John''s Savings Account', 10000.00, 'USD'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'John''s Business Profile'), 'checking', 'John''s Business Checking Account', 20000.00, 'USD'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'checking', 'Jane''s Checking Account', 8000.00, 'USD'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'savings', 'Mike''s Savings Account', 15000.00, 'USD'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'checking', 'Sara''s Checking Account', 12000.00, 'USD');

-- Transactions
INSERT INTO transactions (account_id, transaction_type, amount, description, category, transaction_date) VALUES
  ((SELECT id FROM financial_accounts WHERE account_name = 'John''s Checking Account'), 'expense', 100.00, 'Grocery Shopping at Walmart', 'Food', '2023-06-01'),
  ((SELECT id FROM financial_accounts WHERE account_name = 'John''s Checking Account'), 'expense', 50.00, 'Gas Refill at Shell', 'Transportation', '2023-06-02'),
  ((SELECT id FROM financial_accounts WHERE account_name = 'John''s Checking Account'), 'income', 2000.00, 'Salary from ABC Company', 'Income', '2023-06-15'),
  ((SELECT id FROM financial_accounts WHERE account_name = 'Jane''s Checking Account'), 'expense', 80.00, 'Dinner with Friends at Italian Restaurant', 'Entertainment', '2023-06-03'),
  ((SELECT id FROM financial_accounts WHERE account_name = 'John''s Checking Account'), 'expense', 150.00, 'Medical Check-up at City Hospital', 'Healthcare', '2023-06-10'),
  ((SELECT id FROM financial_accounts WHERE account_name = 'Mike''s Savings Account'), 'expense', 200.00, 'Online Course Subscription', 'Education', '2023-06-05'),
  ((SELECT id FROM financial_accounts WHERE account_name = 'Sara''s Checking Account'), 'expense', 50.00, 'Monthly Gym Membership', 'Fitness', '2023-06-01'),
  ((SELECT id FROM financial_accounts WHERE account_name = 'John''s Checking Account'), 'transfer', 500.00, 'Transfer to Savings Account', 'Transfer', '2023-06-20'),
  ((SELECT id FROM financial_accounts WHERE account_name = 'John''s Savings Account'), 'transfer', 500.00, 'Transfer from Checking Account', 'Transfer', '2023-06-20'),
  ((SELECT id FROM financial_accounts WHERE account_name = 'Jane''s Checking Account'), 'expense', 1000.00, 'Rent Payment for June', 'Housing', '2023-06-01'),
  ((SELECT id FROM financial_accounts WHERE account_name = 'Sara''s Checking Account'), 'expense', 120.00, 'Electricity Bill', 'Utilities', '2023-06-15');

-- Budgets
INSERT INTO budgets (profile_id, budget_name, budget_type, total_amount, start_date, end_date) VALUES
  ((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'Monthly Budget', 'personal', 3000.00, '2023-06-01', '2023-06-30'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'Monthly Budget', 'personal', 2500.00, '2023-06-01', '2023-06-30'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'Monthly Budget', 'personal', 3500.00, '2023-06-01', '2023-06-30'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'Monthly Budget', 'personal', 4000.00, '2023-06-01', '2023-06-30');

-- Budget Categories
INSERT INTO budget_categories (budget_id, category_name, allocated_amount) VALUES
  ((SELECT id FROM budgets WHERE budget_name = 'Monthly Budget' AND profile_id = (SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile')), 'Food', 500.00),
  ((SELECT id FROM budgets WHERE budget_name = 'Monthly Budget' AND profile_id = (SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile')), 'Transportation', 200.00),
  ((SELECT id FROM budgets WHERE budget_name = 'Monthly Budget' AND profile_id = (SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile')), 'Housing', 1000.00),
  ((SELECT id FROM budgets WHERE budget_name = 'Monthly Budget' AND profile_id = (SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile')), 'Utilities', 300.00),
  ((SELECT id FROM budgets WHERE budget_name = 'Monthly Budget' AND profile_id = (SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile')), 'Entertainment', 300.00),
  ((SELECT id FROM budgets WHERE budget_name = 'Monthly Budget' AND profile_id = (SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile')), 'Shopping', 400.00),
  ((SELECT id FROM budgets WHERE budget_name = 'Monthly Budget' AND profile_id = (SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile')), 'Healthcare', 500.00),
  ((SELECT id FROM budgets WHERE budget_name = 'Monthly Budget' AND profile_id = (SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile')), 'Education', 500.00),
  ((SELECT id FROM budgets WHERE budget_name = 'Monthly Budget' AND profile_id = (SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile')), 'Fitness', 200.00),
  ((SELECT id FROM budgets WHERE budget_name = 'Monthly Budget' AND profile_id = (SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile')), 'Insurance', 300.00),
  ((SELECT id FROM budgets WHERE budget_name = 'Monthly Budget' AND profile_id = (SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile')), 'Subscriptions', 150.00);

-- Financial Goals
INSERT INTO financial_goals (profile_id, goal_name, goal_type, target_amount, current_amount, target_date) VALUES
  ((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'Emergency Fund', 'savings', 20000.00, 10000.00, '2024-12-31'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'Vacation Fund', 'savings', 5000.00, 2000.00, '2023-12-31'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'Retirement Fund', 'investment', 500000.00, 100000.00, '2040-12-31'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'Education Fund for Kids', 'savings', 50000.00, 10000.00, '2030-08-31');

-- Income Sources
INSERT INTO income_sources (profile_id, income_type, amount, frequency, start_date) VALUES
  ((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'Salary', 5000.00, 'monthly', '2023-01-01'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'Salary', 4000.00, 'monthly', '2023-01-01'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'Freelance', 1000.00, 'monthly', '2023-01-01'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'Salary', 6000.00, 'monthly', '2023-01-01'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'Salary', 5500.00, 'monthly', '2023-01-01'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'Bonus', 2000.00, 'annually', '2023-12-01'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'Gift', 500.00, 'once', '2023-06-15');

-- Investment Accounts
INSERT INTO investment_accounts (profile_id, account_type, account_name, balance, currency) VALUES
  ((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'brokerage', 'John''s Brokerage Account', 50000.00, 'USD'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'retirement', 'Jane''s Retirement Account', 80000.00, 'USD'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'brokerage', 'Mike''s Brokerage Account', 60000.00, 'USD'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'retirement', 'Sara''s Retirement Account', 75000.00, 'USD');

-- Investment Holdings
INSERT INTO investment_holdings (investment_id, holding_type, symbol, quantity, purchase_price, purchase_date) VALUES
  ((SELECT id FROM investment_accounts WHERE account_name = 'John''s Brokerage Account'), 'stock', 'AAPL', 100.00, 150.00, '2022-01-01'),
  ((SELECT id FROM investment_accounts WHERE account_name = 'John''s Brokerage Account'), 'stock', 'AMZN', 50.00, 2000.00, '2022-02-01'),
  ((SELECT id FROM investment_accounts WHERE account_name = 'Jane''s Retirement Account'), 'mutual_fund', 'VFIAX', 500.00, 300.00, '2021-01-01'),
  ((SELECT id FROM investment_accounts WHERE account_name = 'Mike''s Brokerage Account'), 'etf', 'SPY', 200.00, 400.00, '2022-03-01'),
  ((SELECT id FROM investment_accounts WHERE account_name = 'Sara''s Retirement Account'), 'bond', 'VTBIX', 1000.00, 100.00, '2021-05-01');

-- Debt Accounts
INSERT INTO debt_accounts (profile_id, debt_type, account_name, balance, interest_rate, minimum_payment, due_date) VALUES
  ((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'credit_card', 'John''s Credit Card', 1000.00, 15.00, 100.00, '2023-07-01'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'student_loan', 'Jane''s Student Loan', 20000.00, 5.00, 500.00, '2023-07-15'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'mortgage', 'Mike''s Mortgage', 250000.00, 3.50, 1500.00, '2023-07-01'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'car_loan', 'Sara''s Car Loan', 15000.00, 4.00, 300.00, '2023-07-10');

-- Debt Payments
INSERT INTO debt_payments (debt_id, payment_amount, payment_date) VALUES
  ((SELECT id FROM debt_accounts WHERE account_name = 'John''s Credit Card'), 500.00, '2023-06-15'),
  ((SELECT id FROM debt_accounts WHERE account_name = 'Jane''s Student Loan'), 1000.00, '2023-06-30'),
  ((SELECT id FROM debt_accounts WHERE account_name = 'Mike''s Mortgage'), 1500.00, '2023-06-01'),
  ((SELECT id FROM debt_accounts WHERE account_name = 'Sara''s Car Loan'), 300.00, '2023-06-10'),
  ((SELECT id FROM debt_accounts WHERE account_name = 'John''s Credit Card'), 100.00, '2023-05-15'),
  ((SELECT id FROM debt_accounts WHERE account_name = 'Jane''s Student Loan'), 500.00, '2023-05-30');

-- Bills
INSERT INTO bills (profile_id, bill_name, description, amount, due_date, payment_status) VALUES
  ((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'Electricity Bill', 'Monthly electricity bill', 80.00, '2023-07-10', 'pending'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'Internet Bill', 'Monthly internet bill', 60.00, '2023-07-05', 'pending'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'Water Bill', 'Quarterly water bill', 120.00, '2023-08-15', 'pending'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'Phone Bill', 'Monthly phone bill', 50.00, '2023-07-20', 'pending'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'Rent', 'Monthly rent payment', 1000.00, '2023-07-01', 'paid'),
  ((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s PersonalProfile'), 'Gym Membership', 'Monthly gym membership fee', 50.00, '2023-07-01', 'paid');
-- Savings Goals
INSERT INTO savings_goals (profile_id, goal_name, target_amount, current_amount, target_date) VALUES
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'Down Payment Fund', 50000.00, 20000.00, '2025-12-31'),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'Emergency Fund', 10000.00, 5000.00, '2024-06-30'),
((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'Car Replacement Fund', 30000.00, 10000.00, '2026-12-31'),
((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'Travel Fund', 8000.00, 3000.00, '2024-09-30');
-- Notifications
INSERT INTO notifications (profile_id, notification_type, notification_text) VALUES
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'budget_alert', 'You have reached 90% of your food budget for this month.'),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'bill_reminder', 'Your internet bill is due in 3 days.'),
((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'goal_milestone', 'Congratulations! You have reached 50% of your car replacement fund goal.'),
((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'account_update', 'Your checking account balance has fallen below $1,000.'),
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'investment_alert', 'Your stock portfolio has increased by 5% in the last month.');
-- Reminders
INSERT INTO reminders (profile_id, reminder_type, reminder_data, reminder_date) VALUES
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'goal_milestone', '{"goal_name": "Emergency Fund", "milestone_amount": 15000}', '2023-12-31'),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'bill_payment', '{"bill_name": "Electricity Bill", "amount": 80}', '2023-07-09'),
((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'debt_payment', '{"debt_name": "Mortgage", "amount": 1500}', '2023-07-01'),
((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'subscription_renewal', '{"subscription_name": "Magazine Subscription", "renewal_date": "2023-08-01"}', '2023-07-25');
-- Loan Calculations
INSERT INTO calculator_inputs (profile_id, calculator_type, input_name, input_value) VALUES
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'loan', 'principal', 10000.00),
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'loan', 'interest_rate', 5.00),
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'loan', 'loan_term', 60),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'loan', 'principal', 5000.00),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'loan', 'interest_rate', 4.50),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'loan', 'loan_term', 36);
-- Currency Conversions
INSERT INTO calculator_inputs (profile_id, calculator_type, input_name, input_value) VALUES
((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'currency', 'base_currency', 'USD'),
((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'currency', 'target_currency', 'EUR'),
((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'currency', 'amount', 1000.00),
((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'currency', 'base_currency', 'GBP'),
((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'currency', 'target_currency', 'JPY'),
((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'currency', 'amount', 500.00);
-- Compound Interest Calculations
INSERT INTO calculator_inputs (profile_id, calculator_type, input_name, input_value) VALUES
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'compound_interest', 'principal', 10000.00),
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'compound_interest', 'annual_interest_rate', 6.00),
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'compound_interest', 'compounds_per_year', 12),
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'compound_interest', 'investment_duration', 10),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'compound_interest', 'principal', 5000.00),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'compound_interest', 'annual_interest_rate', 5.00),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'compound_interest', 'compounds_per_year', 4),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'compound_interest', 'investment_duration', 5);
-- Financial Education Content
INSERT INTO education_categories (category_name, description) VALUES
('Budgeting', 'Articles and resources related to creating and managing a budget'),
('Investing', 'Guides and tutorials on investing strategies and portfolio management'),
('Retirement Planning', 'Information and advice on planning for retirement'),
('Debt Management', 'Tips and strategies for managing and paying off debt'),
('Taxes', 'Resources and information related to taxes and tax planning');
INSERT INTO education_content (category_id, content_type, title, description, url) VALUES
((SELECT id FROM education_categories WHERE category_name = 'Budgeting'), 'article', 'How to Create a Realistic Budget', 'Learn the steps to create a budget that works for you', 'https://example.com/budgeting-guide'),
((SELECT id FROM education_categories WHERE category_name = 'Investing'), 'video', 'Introduction to Stock Market Investing', 'Understand the basics of investing in the stock market', 'https://example.com/stock-investing-video'),
((SELECT id FROM education_categories WHERE category_name = 'Retirement Planning'), 'article', '10 Tips for Saving for Retirement', 'Discover strategies to save effectively for your retirement years', 'https://example.com/retirement-savings-tips'),
((SELECT id FROM education_categories WHERE category_name = 'Debt Management'), 'article', 'How to Pay Off Debt Faster', 'Learn techniques to accelerate your debt repayment', 'https://example.com/debt-payoff-guide'),
((SELECT id FROM education_categories WHERE category_name = 'Taxes'), 'video', 'Understanding Tax Deductions and Credits', 'Explore common tax deductions and credits to reduce your tax liability', 'https://example.com/tax-deductions-video');
-- Advisor Interactions and Recommendations
INSERT INTO user_preferences (profile_id, preferences) VALUES
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), '{"risk_tolerance": "moderate", "investment_goals": ["retirement", "emergency_fund"]}'),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), '{"risk_tolerance": "conservative", "investment_goals": ["college_fund", "home_purchase"]}'),
((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), '{"risk_tolerance": "aggressive", "investment_goals": ["wealth_building", "early_retirement"]}'),
((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), '{"risk_tolerance": "moderate", "investment_goals": ["vacation_fund", "car_purchase"]}');
INSERT INTO ai_recommendations (profile_id, recommendation_type, recommendation_data) VALUES
((SELECT id FROM user_profiles WHERE profile_name = 'John''s Personal Profile'), 'investment', '{"recommendation": "Consider increasing your allocation to index funds for long-term growth potential."}'),
((SELECT id FROM user_profiles WHERE profile_name = 'Jane''s Personal Profile'), 'savings', '{"recommendation": "Increase your monthly contributions to your college fund by 10% to stay on track."}'),
((SELECT id FROM user_profiles WHERE profile_name = 'Mike''s Personal Profile'), 'retirement', '{"recommendation": "Explore the possibility of contributing to a Roth IRA for tax-free growth and withdrawals in retirement."}'),
((SELECT id FROM user_profiles WHERE profile_name = 'Sara''s Personal Profile'), 'budgeting', '{"recommendation": "Review your discretionary spending categories and look for areas to cut back and redirect funds to your vacation fund."}');
