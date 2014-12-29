factory :plant do
    name '10th Spruce'
    address "10th Spruce; Philadelphia; PA"
  end
    
  factory :metro do
    sequence(:name) { |n| "mike#{n}"}
    xero_tax_type 'OUTPUT'
    tax_rate '8'
    time_zone 'Eastern Time (US & Canada)' 
  end
  factory :product do 
    name 'Towel'
    unit_of_measurement 'piece'
    product_type 'rental'
    unit_price 5    
  end
///////////////////////////////////////////
