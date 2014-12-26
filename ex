['Philadelphia','Washington DC'].each do |metro|  
    factory :"#{metro}", class: Metro do 
      factory :metro do 
        name "#{Faker::Name.name}"
        xero_tax_type 'OUTPUT'
        tax_rate '8'
        time_zone 'Eastern Time (US & Canada)'    

      end
    end

  factory :product do 
        
  end
  //////////////////////
