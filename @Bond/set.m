function s = set (bond, varargin)
  s = bond;
  if (length (varargin) < 2 || rem (length (varargin), 2) ~= 0)
    error ('set: expecting property/value pairs');
  end
  while (length (varargin) > 1)
    prop = varargin{1};
    prop = lower(prop);
    val = varargin{2};
    varargin(1:2) = [];
    if (ischar (prop) && strcmp (prop, 'soy'))
      if (isvector (val) && isreal (val))
        s.soy = val;
      else
        error ('set: expecting the value to be a real vector');
      end
    elseif (ischar (prop) && strcmp (prop, 'convexity'))   
      if (isreal (val))
        s.convexity = val;
      else
        error ('set: expecting the value to be a real number');
      end
    % ====================== set rates_mc: if isvector -> append to existing vector / matrix, if ismatrix -> replace existing value
    elseif (ischar (prop) && strcmp (prop, 'cf_values_mc'))   
      if (isreal (val))
        [mc_rows mc_cols mc_stack] = size(s.cf_values_mc);
        if ( mc_cols > 0 || mc_rows > 0) % appending vector to existing vector
            if ( length(val) == length(s.cf_values_mc(:,:,mc_stack)))
                s.cf_values_mc(:,:,mc_stack + 1) = val;
            else
                error('set: expecting length of new input vector to equal length of already existing rate vector');
            end
        else    % setting vector
            s.cf_values_mc(:,:,1) = val;
        end  
        
      else
        error ('set: expecting the mc cf values to be real ');
      end 
    % ====================== set cf_values_stress ======================
    elseif (ischar (prop) && strcmp (prop, 'cf_values_stress'))   
      if (isreal (val))
        s.cf_values_stress = val;
      else
        error ('set: expecting the cf stress value to be real ');
      end
    % ====================== set cf_values ======================
    elseif (ischar (prop) && strcmp (prop, 'cf_values'))   
      if (isvector (val) && isreal (val))
        s.cf_values = val;
      else
        error ('set: expecting the base values to be a real vector');
      end
    % ====================== set cf_dates ======================
    elseif (ischar (prop) && strcmp (prop, 'cf_dates'))   
      if (isvector (val) && isreal (val))
        s.cf_dates = val;
      else
        error ('set: expecting the value to be a real vector');
      end 
    % ====================== set timestep_mc_cf: appending or setting timestep vector ======================
    elseif (ischar (prop) && strcmp (prop, 'timestep_mc_cf'))   
      if (iscell(val) && length(val) == 1)
        tmp_cell = s.timestep_mc_cf;
        if ( length(tmp_cell) > 0 ) % appending vector to existing vector
            s.timestep_mc_cf{length(tmp_cell) + 1} = char(val);
        else    % setting vector
            s.timestep_mc_cf = val;
        end      
      elseif (iscell(val) && length(val) > 1) % replacing timestep_mc_cf cell vector with new vector
        s.timestep_mc_cf = val;
      elseif ( ischar(val) )
        tmp_cell = s.timestep_mc_cf;
        if ( length(tmp_cell) > 0 ) % appending vector to existing vector
            s.timestep_mc_cf{length(tmp_cell) + 1} = char(val);
        else    % setting vector
            s.timestep_mc_cf = cellstr(val);
        end 
      else
        error ('set: expecting the cell value to be a cell vector');
      end   
    % ====================== set value_mc: if isvector -> append to existing vector / matrix, if ismatrix -> replace existing value
    elseif (ischar (prop) && strcmp (prop, 'value_mc'))   
      if (isvector (val) && isreal (val))
        tmp_vector = [s.value_mc];
        if ( rows(tmp_vector) > 0 ) % appending vector to existing vector
            if ( rows(tmp_vector) == rows(val) )
                s.value_mc = [tmp_vector, val];
            else
                error ('set: expecting equal number of rows')
            end
        else    % setting vector
            s.value_mc = val;
        end      
      elseif (ismatrix(val) && isreal(val)) % replacing value_mc matrix with new matrix
        s.value_mc = val;
      else
        if ( isempty(val))
            s.value_mc = [];
        else
            error ('set: expecting the value to be a real vector');
        end
      end
    % ====================== set timestep_mc: appending or setting timestep vector ======================
    elseif (ischar (prop) && strcmp (prop, 'timestep_mc'))   
      if (iscell(val) && length(val) == 1)
        tmp_cell = s.timestep_mc;
        if ( length(tmp_cell) > 0 ) % appending vector to existing vector
            s.timestep_mc{length(tmp_cell) + 1} = char(val);
        else    % setting vector
            s.timestep_mc = val;
        end      
      elseif (iscell(val) && length(val) > 1) % replacing timestep_mc cell vector with new vector
        s.timestep_mc = val;
      elseif ( ischar(val) )
        tmp_cell = s.timestep_mc;
        if ( length(tmp_cell) > 0 ) % appending vector to existing vector
            s.timestep_mc{length(tmp_cell) + 1} = char(val);
        else    % setting vector
            s.timestep_mc = cellstr(val);
        end 
      else
        error ('set: expecting the cell value to be a cell vector');
      end  
    % ====================== set value_stress ======================
    elseif (ischar (prop) && strcmp (prop, 'value_stress'))   
      if (isvector (val) && isreal (val))
        s.value_stress = val;
      else
        if ( isempty(val))
            s.value_stress = [];
        else
            error ('set: expecting the value to be a real vector');
        end
      end
    % ====================== set value_base ======================
    elseif (ischar (prop) && strcmp (prop, 'value_base'))   
      if (isreal (val) && isnumeric(val))
        s.value_base = val;
      else
        error ('set: expecting the value to be a real numeric vector');
      end 
    % ====================== set name ======================
    elseif (ischar (prop) && strcmp (prop, 'name'))   
      if (ischar (val) )
        s.name = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end
    % ====================== set id ======================
    elseif (ischar (prop) && strcmp (prop, 'id'))   
      if (ischar(val))
        s.id = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end
    % ====================== set maturity_date ======================
    elseif (ischar (prop) && strcmp (prop, 'maturity_date'))   
      if (ischar (val))
        s.maturity_date = datestr(strtrim(val),1);
      else
        error ('set: expecting the value to be a char');
      end
    % ====================== set issue_date ======================
    elseif (ischar (prop) && strcmp (prop, 'issue_date'))   
      if (ischar (val))
        s.issue_date = datestr(strtrim(val),1);
      else
        error ('set: expecting the value to be a char');
      end  
    % ====================== set spread_curve  ======================
    elseif (ischar (prop) && strcmp (prop, 'spread_curve'))   
      if (ischar (val))
        s.spread_curve = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end 
      
    % ====================== set reference_curve  ======================
    elseif (ischar (prop) && strcmp (prop, 'reference_curve'))   
      if (ischar (val))
        s.reference_curve = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end  
    % ====================== set discount_curve  ======================
    elseif (ischar (prop) && strcmp (prop, 'discount_curve'))   
      if (ischar (val))
        s.discount_curve = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end 
    % ====================== set coupon_generation_method  ======================
    elseif (ischar (prop) && strcmp (prop, 'coupon_generation_method'))   
      if (ischar (val))
        s.coupon_generation_method = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end 
    % ====================== set term ======================
    elseif (ischar (prop) && strcmp (prop, 'term'))   
      if (isnumeric (val) && isreal (val))
        s.term = val;
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set compounding_freq  ======================
    elseif (ischar (prop) && strcmp (prop, 'compounding_freq'))   
      if (isnumeric (val) && isreal(val))
        s.compounding_freq  = val;
      elseif (ischar(val))
        s.compounding_freq  = val;
      else
        error ('set: expecting the value to be a real number or char');
      end       
    % ====================== set day_count_convention ======================
    elseif (ischar (prop) && strcmp (prop, 'day_count_convention'))   
      if (ischar (val))
        s.day_count_convention = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end 
    % ====================== set compounding_type ======================
    elseif (ischar (prop) && strcmp (prop, 'compounding_type'))   
      if (ischar (val))
        s.compounding_type = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end 
    % ====================== set sub_type ======================
    elseif (ischar (prop) && strcmp (prop, 'sub_type'))   
      if (ischar (val))
        s.sub_type = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end   
    % ====================== set valuation_date ======================
    elseif (ischar (prop) && strcmp (prop, 'valuation_date'))   
      if (ischar (val))
        s.valuation_date = datestr(strtrim(val),1);
      else
        error ('set: expecting the value to be a char');
      end 
    % ====================== set asset_class ======================
    elseif (ischar (prop) && strcmp (prop, 'asset_class'))   
      if (ischar (val))
        s.asset_class = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end 
    % ====================== set currency ======================
    elseif (ischar (prop) && strcmp (prop, 'currency'))   
      if (ischar (val))
        s.currency = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end 
    % ====================== set description ======================
    elseif (ischar (prop) && strcmp (prop, 'description'))   
      if (ischar (val))
        s.description = strtrim(val);
      else
        error ('set: expecting the value to be a char');
      end 
    % ====================== set notional ======================
    elseif (ischar (prop) && strcmp (prop, 'notional'))   
      if (isnumeric (val) && isreal (val))
        s.notional = val;
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set coupon_rate ======================
    elseif (ischar (prop) && strcmp (prop, 'coupon_rate'))   
      if (isnumeric (val) && isreal (val))
        s.coupon_rate = val;
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set business_day_rule ======================
    elseif (ischar (prop) && strcmp (prop, 'business_day_rule'))   
      if (isnumeric (val) && isreal (val))
        s.business_day_rule = val;
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set business_day_direction ======================
    elseif (ischar (prop) && strcmp (prop, 'business_day_direction'))   
      if (isnumeric (val) && isreal (val))
        s.business_day_direction = val;
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set enable_business_day_rule ======================
    elseif (ischar (prop) && strcmp (prop, 'enable_business_day_rule'))   
      if (isnumeric (val) && isreal (val))
        s.enable_business_day_rule = logical(val);
      elseif ( ischar(val))
        if ( strcmp('false',lower(val)))
            s.enable_business_day_rule = logical(0);
        elseif ( strcmp('true',lower(val)))
            s.enable_business_day_rule = logical(1);
        else
            printf('WARNING: Unknown val: >>%s<<. Setting enable_business_day_rule to false.',val);
            s.enable_business_day_rule = logical(0);
        end
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set spread ======================
    elseif (ischar (prop) && strcmp (prop, 'spread'))   
      if (isnumeric (val) && isreal (val))
        s.spread = val;
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set long_first_period ======================
    elseif (ischar (prop) && strcmp (prop, 'long_first_period'))   
      if (isnumeric (val) && isreal (val))
        s.long_first_period = logical(val);
      elseif ( ischar(val))
        if ( strcmp('false',lower(val)))
            s.long_first_period = logical(0);
        elseif ( strcmp('true',lower(val)))
            s.long_first_period = logical(1);
        else
            printf('WARNING: Unknown val: >>%s<<. Setting long_first_period to false.',val);
            s.long_first_period = logical(0);
        end
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set long_last_period ======================
    elseif (ischar (prop) && strcmp (prop, 'long_last_period'))   
      if (isnumeric (val) && isreal (val))
        s.long_last_period = logical(val);
      elseif ( ischar(val))
        if ( strcmp('false',lower(val)))
            s.long_last_period = logical(0);
        elseif ( strcmp('true',lower(val)))
            s.long_last_period = logical(1);
        else
            printf('WARNING: Unknown val: >>%s<<. Setting long_last_period to false.',val);
            s.long_last_period = logical(0);
        end
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set last_reset_rate ======================
    elseif (ischar (prop) && strcmp (prop, 'last_reset_rate'))   
      if (isnumeric (val) && isreal (val))
        s.last_reset_rate = val;
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set in_arrears ======================
    elseif (ischar (prop) && strcmp (prop, 'in_arrears'))   
      if (isnumeric (val) && isreal (val))
        s.in_arrears = logical(val);
      elseif ( ischar(val))
        if ( strcmp('false',lower(val)))
            s.in_arrears = logical(0);
        elseif ( strcmp('true',lower(val)))
            s.in_arrears = logical(1);
        else
            printf('WARNING: Unknown val: >>%s<<. Setting in_arrears to false.',val);
            s.in_arrears = logical(0);
        end
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set fixed_annuity ======================
    elseif (ischar (prop) && strcmp (prop, 'fixed_annuity'))   
      if (isnumeric (val) && isreal (val))
        s.fixed_annuity = logical(val);
      elseif ( ischar(val))
        if ( strcmp('false',lower(val)))
            s.fixed_annuity = logical(0);
        elseif ( strcmp('true',lower(val)))
            s.fixed_annuity = logical(1);
        else
            printf('WARNING: Unknown val: >>%s<<. Setting fixed_annuity to false.',val);
            s.fixed_annuity = logical(0);
        end
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set notional_at_start ======================
    elseif (ischar (prop) && strcmp (prop, 'notional_at_start'))   
      if (isnumeric (val) && isreal (val))
        s.notional_at_start = logical(val);
      elseif ( ischar(val))
        if ( strcmp('false',lower(val)))
            s.notional_at_start = logical(0);
        elseif ( strcmp('true',lower(val)))
            s.notional_at_start = logical(1);
        else
            printf('WARNING: Unknown val: >>%s<<. Setting notional_at_start to false.',val);
            s.notional_at_start = logical(0);
        end
      else
        error ('set: expecting the value to be a real number');
      end 
    % ====================== set notional_at_end  ======================
    elseif (ischar (prop) && strcmp (prop, 'notional_at_end '))   
      if (isnumeric (val) && isreal (val))
        s.notional_at_end = logical(val);
      elseif ( ischar(val))
        if ( strcmp('false',lower(val)))
            s.notional_at_end = logical(0);
        elseif ( strcmp('true',lower(val)))
            s.notional_at_end = logical(1);
        else
            printf('WARNING: Unknown val: >>%s<<. Setting notional_at_end to false.',val);
            s.notional_at_end = logical(0);
        end
      else
        error ('set: expecting the value to be a real number');
      end       
    else
      error ('set: invalid property of bond class: %s',prop);
    end
  end
end