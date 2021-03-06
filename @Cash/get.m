function s = get (obj, property)
  if (nargin == 1)
    s = obj.name;
  elseif (nargin == 2)
    if (ischar (property))
      switch (property)
        case 'name'
          s = obj.name;
        case 'id'
          s = obj.id;
        case 'description'
          s = obj.description; 
        case 'type'
          s = obj.type; 
        case 'asset_class'
          s = obj.asset_class;   
        case 'currency'
          s = obj.currency;
        case 'valuation_date'
          s = obj.valuation_date;
        case 'value_mc'
          s = obj.value_mc; 
        case 'value_base'
          s = obj.value_base;   
        case 'value_stress'
          s = obj.value_stress;
        case 'sub_type'
          s = obj.sub_type;  
        case 'timestep_mc'
          s = obj.timestep_mc; 
        case 'cf_dates'
          s = obj.cf_dates; 
        case 'cf_values'
          s = obj.cf_values; 
        case 'discount_curve'
          s = obj.discount_curve;  
        otherwise
          error ('get: invalid property %s', property);
      end
    else
      error ('get: expecting the property to be a string');
    end
  else
    print_usage ();
  end
end