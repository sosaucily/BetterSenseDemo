class AccountExistsValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    Rails.logger.info("validating the parent object: " + object.to_s + " and account object: = " + value.to_s + " and the attribute in q is: " + attribute.to_s)
    object.errors[attribute] << (options[:message] || "is not valid") unless Account.find_by_id(value)
  end
end

