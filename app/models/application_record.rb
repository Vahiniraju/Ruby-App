class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def hello
	render html: "Hello"
  end
  
  
end
