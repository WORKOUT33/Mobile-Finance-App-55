-- User Authentication
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    username VARCHAR(100),
    role VARCHAR(20) NOT NULL DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Social Authentication
CREATE TABLE social_auth_providers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    client_id VARCHAR(255) NOT NULL,
    client_secret VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_social_auths (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    provider_id INTEGER REFERENCES social_auth_providers(id),
    social_user_id VARCHAR(255) NOT NULL,
    access_token VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- JWT Tokens
CREATE TABLE jwt_tokens (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    token VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Password Reset and Account Recovery
CREATE TABLE password_reset_tokens (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    token VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User Profiles
CREATE TABLE profiles (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    profile_type VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    pin VARCHAR(6) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Profile-specific Data Tables
CREATE TABLE profile_financial_accounts (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    account_type VARCHAR(50) NOT NULL,
    account_name VARCHAR(100) NOT NULL,
    balance DECIMAL(18, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE profile_transactions (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    account_id INTEGER REFERENCES profile_financial_accounts(id),
    amount DECIMAL(18, 2) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    transaction_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Other profile-specific tables...

-- Financial Accounts
CREATE TABLE financial_accounts (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    account_type VARCHAR(50) NOT NULL,
    account_name VARCHAR(100) NOT NULL,
    balance DECIMAL(18, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Budgets and Expenses
CREATE TABLE budgets (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    name VARCHAR(100) NOT NULL,
    total_amount DECIMAL(18, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE budget_categories (
    id SERIAL PRIMARY KEY,
    budget_id INTEGER REFERENCES budgets(id),
    name VARCHAR(100) NOT NULL,
    allocated_amount DECIMAL(18, 2) NOT NULL
);

CREATE TABLE expenses (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    amount DECIMAL(18, 2) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    expense_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Financial Goals
CREATE TABLE financial_goals (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    name VARCHAR(100) NOT NULL,
    target_amount DECIMAL(18, 2) NOT NULL,
    current_amount DECIMAL(18, 2) NOT NULL DEFAULT 0,
    target_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Investment Portfolios
CREATE TABLE investment_portfolios (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE investment_holdings (
    id SERIAL PRIMARY KEY,
    portfolio_id INTEGER REFERENCES investment_portfolios(id),
    symbol VARCHAR(20) NOT NULL,
    quantity DECIMAL(18, 8) NOT NULL,
    purchase_price DECIMAL(18, 2) NOT NULL,
    purchase_date DATE NOT NULL
);

-- Debts
CREATE TABLE debts (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    debt_type VARCHAR(50) NOT NULL,
    description TEXT,
    total_amount DECIMAL(18, 2) NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL,
    minimum_payment DECIMAL(18, 2) NOT NULL,
    due_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reports and Data Visualization
CREATE TABLE report_templates (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE report_data (
    id SERIAL PRIMARY KEY,
    template_id INTEGER REFERENCES report_templates(id),
    data_type VARCHAR(50) NOT NULL,
    data_value JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Financial Accounts
CREATE TABLE financial_accounts (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    account_type VARCHAR(50) NOT NULL,
    account_name VARCHAR(100) NOT NULL,
    balance DECIMAL(18, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INTEGER REFERENCES financial_accounts(account_id),
    transaction_type VARCHAR(20) NOT NULL,
    amount DECIMAL(18, 2) NOT NULL,
    description VARCHAR(255),
    category VARCHAR(50),
    transaction_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Budgets and Expenses
CREATE TABLE budgets (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    name VARCHAR(100) NOT NULL,
    total_amount DECIMAL(18, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE budget_categories (
    id SERIAL PRIMARY KEY,
    budget_id INTEGER REFERENCES budgets(id),
    name VARCHAR(100) NOT NULL,
    allocated_amount DECIMAL(18, 2) NOT NULL
);

CREATE TABLE expenses (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    amount DECIMAL(18, 2) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    expense_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Financial Goals
CREATE TABLE financial_goals (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    name VARCHAR(100) NOT NULL,
    target_amount DECIMAL(18, 2) NOT NULL,
    current_amount DECIMAL(18, 2) NOT NULL DEFAULT 0,
    target_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Investment Portfolios
CREATE TABLE investment_portfolios (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE investment_holdings (
    id SERIAL PRIMARY KEY,
    portfolio_id INTEGER REFERENCES investment_portfolios(id),
    symbol VARCHAR(20) NOT NULL,
    quantity DECIMAL(18, 8) NOT NULL,
    purchase_price DECIMAL(18, 2) NOT NULL,
    purchase_date DATE NOT NULL
);

-- Debts
CREATE TABLE debts (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    debt_type VARCHAR(50) NOT NULL,
    description TEXT,
    total_amount DECIMAL(18, 2) NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL,
    minimum_payment DECIMAL(18, 2) NOT NULL,
    due_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reports and Data Visualization
CREATE TABLE report_templates (
    id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES profiles(id),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE report_data (
    id SERIAL PRIMARY KEY,
    template_id INTEGER REFERENCES report_templates(id),
    data_type VARCHAR(50) NOT NULL,
    data_value JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE profile_permissions (
    permission_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    user_id INTEGER REFERENCES users(user_id),
    permission_type VARCHAR(20) NOT NULL
);

-- Expense and Income Tracking
CREATE TABLE income_sources (
    income_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    income_type VARCHAR(50) NOT NULL,
    amount DECIMAL(18, 2) NOT NULL,
    frequency VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Investment Portfolios and Performance
CREATE TABLE investment_accounts (
    investment_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    account_type VARCHAR(20) NOT NULL,
    account_name VARCHAR(50) NOT NULL,
    balance DECIMAL(18, 2) NOT NULL,
    currency VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE investment_holdings (
    holding_id SERIAL PRIMARY KEY,
    investment_id INTEGER REFERENCES investment_accounts(investment_id),
    holding_type VARCHAR(20) NOT NULL,
    symbol VARCHAR(20) NOT NULL,
    quantity DECIMAL(18, 8) NOT NULL,
    purchase_price DECIMAL(18, 2) NOT NULL,
    purchase_date DATE NOT NULL
);

-- Debt Management and Repayment
CREATE TABLE debt_accounts (
    debt_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    debt_type VARCHAR(20) NOT NULL,
    account_name VARCHAR(50) NOT NULL,
    balance DECIMAL(18, 2) NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL,
    minimum_payment DECIMAL(18, 2) NOT NULL,
    due_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE debt_payments (
    payment_id SERIAL PRIMARY KEY,
    debt_id INTEGER REFERENCES debt_accounts(debt_id),
    payment_amount DECIMAL(18, 2) NOT NULL,
    payment_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bill Management and Reminders
CREATE TABLE bills (
    bill_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    bill_name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    amount DECIMAL(18, 2) NOT NULL,
    due_date DATE NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Savings Goals and Progress Tracking
CREATE TABLE savings_goals (
    savings_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    goal_name VARCHAR(50) NOT NULL,
    target_amount DECIMAL(18, 2) NOT NULL,
    current_amount DECIMAL(18, 2) NOT NULL,
    target_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Financial Calculators and Tools
CREATE TABLE calculator_inputs (
    input_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    calculator_type VARCHAR(50) NOT NULL,
    input_name VARCHAR(50) NOT NULL,
    input_value DECIMAL(18, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE calculator_results (
    result_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    calculator_type VARCHAR(50) NOT NULL,
    result_name VARCHAR(50) NOT NULL,
    result_value DECIMAL(18, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reporting and Data Visualization
CREATE TABLE report_templates (
    template_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    template_name VARCHAR(50) NOT NULL,
    template_type VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE report_data (
    data_id SERIAL PRIMARY KEY,
    template_id INTEGER REFERENCES report_templates(template_id),
    data_type VARCHAR(20) NOT NULL,
    data_value DECIMAL(18, 2) NOT NULL,
    data_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- AI-Powered Insights and Recommendations
CREATE TABLE user_preferences (
    preference_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    preference_type VARCHAR(50) NOT NULL,
    preference_value VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ai_insights (
    insight_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    insight_type VARCHAR(50) NOT NULL,
    insight_text TEXT NOT NULL,
    insight_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ai_recommendations (
    recommendation_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    recommendation_type VARCHAR(50) NOT NULL,
    recommendation_text TEXT NOT NULL,
    recommendation_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Notifications, Alerts, and Reminders
CREATE TABLE notification_preferences (
    preference_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    notification_type VARCHAR(50) NOT NULL,
    preference_value BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE notifications (
    notification_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    notification_type VARCHAR(50) NOT NULL,
    notification_text TEXT NOT NULL,
    is_read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reminders (
    reminder_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    reminder_type VARCHAR(50) NOT NULL,
    reminder_text TEXT NOT NULL,
    reminder_date DATE NOT NULL,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Financial Education Resources and Content
CREATE TABLE education_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE education_content (
    content_id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES education_categories(category_id),
    content_type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_progress (
    progress_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    content_id INTEGER REFERENCES education_content(content_id),
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    completed_at TIMESTAMP
);

-- Integration with External Services and APIs
CREATE TABLE external_services (
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(50) NOT NULL,
    description TEXT,
    api_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_service_connections (
    connection_id SERIAL PRIMARY KEY,
    profile_id INTEGER REFERENCES user_profiles(profile_id),
    service_id INTEGER REFERENCES external_services(service_id),
    access_token VARCHAR(255) NOT NULL,
    refresh_token VARCHAR(255),
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);