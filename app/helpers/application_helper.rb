module ApplicationHelper
	def placeholder src
		"#{ENV['AWS_PLACEHOLDER']}#{src}"		
	end
end
