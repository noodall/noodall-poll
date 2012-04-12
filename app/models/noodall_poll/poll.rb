module NoodallPoll
  class Poll
    include MongoMapper::Document
    key :name, String
    key :question, String
    key :summary, String
    key :button_label, String
    key :thank_you_message, String
    timestamps!

    many :response_options, :class => NoodallPoll::ResponseOption
    many :responses, :class => NoodallPoll::PollResponse

    validates_presence_of(:name, :question)

    before_save :remove_empty_response_options

    def button_label
      super.blank? ? 'Submit' : super
    end

    def thank_you_message
      super || 'Thank you'
    end

    def submitted_label
      @submitted_label ||= "submitted_#{self.id}".to_sym
    end

    def summary
      super.blank? ? question : super
    end

    def results
      poll_responses = PollResponse.responses_for_poll(self)
      output = Array.new
      for response_option in response_options
        number = poll_responses[response_option.text] || 0
        output << {:text => response_option.text, :count => number}
        poll_responses.delete(response_option.text)
      end
      poll_responses.each do |text, count|
        output << {:text => text, :count => count}
      end
      add_bar_sizes(output)
      return output
    end

    private
    def add_bar_sizes(output)
      max_count = output.inject(0){|max, entry| entry[:count].to_i > max ? entry[:count].to_i : max}
      output.each do |entry|
        entry[:bar_size] = max_count > 0 ? entry[:count].to_f / max_count.to_f : 0
      end
    end

    def remove_empty_response_options
      response_options.delete_if{|response_option| !response_option.text or response_option.text.blank?}
    end
      
  end
end
