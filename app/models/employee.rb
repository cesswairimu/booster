class Employee < ApplicationRecord
  after_commit :flush_cache

  VALID_GENDER = %w(male female)

  scope :by_gender, -> (gender) do
    if VALID_GENDER.include?(gender)
      Rails.cache.fetch("employees_#{gender}") { puts 'Evaluating...' ; where gender: gender }
    else
      Rails.cache.fetch('all_employees') { puts 'Evaluating...' ;  all }
    end
  end

  def final_salary
    Rails.cache.fetch("#{cache_tax}/tax") { puts 'Calculating tax...'; salary - salary * 0.13 }
  end

  private

  def flush_cache
    puts 'Flushing cache ...'
    Rails.cache.delete 'all_employees'
    Rails.cache.delete "employees_ #{gender}"
  end
end
