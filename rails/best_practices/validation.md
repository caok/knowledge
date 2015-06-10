```ruby
module Validations
  module EmployeeInfo
    def self.included(base)
      base.class_eval do
        include ActiveModel::Validations
        validate :check_dob_by_ability
        validate :check_ssn_by_ability

        def self.define_check_function(name)
          f_name = "check_#{name}_by_ability"
          define_method(f_name) {
            current_user = User.current_user
            return if !self.send("#{name}_changed?") or new_record? or current_user.has_hbx_staff_role?

            if current_user.has_employer_staff_role?
              unless is_linkable?
                errors.add(name.to_sym, 'has not ability to change after linked')
              end
            else
              errors.add(name.to_sym, 'has not ability to change')
            end
          }
        end

        define_check_function :dob
        define_check_function :ssn
      end
    end
  end
end
```
