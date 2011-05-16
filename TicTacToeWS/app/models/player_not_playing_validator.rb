class PlayerNotPlayingValidator < ActiveModel::EachValidator
   def validate_each(record, attribute, value)
	record[attribute] << "Is already playing" if User.find_by_name(value).playing
   end
end
