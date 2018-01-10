require_relative "configuration_dependencies/dependencies"

module GithubScore
  class Github_Score_Abacus

    # attr_accessor - allows for read/write instance variables
    attr_accessor :json_url, :event_type_point_value, :total_score

    #
    def initialize
      # @json_url to github repository
      @json_url = "https://api.github.com/users/dhh/events/public"

      # created event type as a hash - allowing to access key,value pair
      @event_type_point_value = {

          "IssuesEvent": 7,
          "IssueCommentEvent": 6,
          "PushEvent": 5,
          "PullRequestReviewCommentEvent": 4,
          "WatchEvent": 3,
          "CreateEvent": 2,
          "Any other event": 1,
      }
      # initialize score to 0
      @total_score = 0
    end

=begin
  This function does the following:
    1. assigns @json_data to the parsed json from the url above
    2. @total_score is the calculated score.
      2.a. Notes: we are setting the accumulator to 0
      2.b. Each run of the block adds the given item (based on type) to the result total
            and then stores the result back into the accumulator.
            The next block call has this new value, adds to it, stores it again, and repeats.

=end
    def github_score_calculation
      @json_data = JSON.parse(open(json_url).read)
      @total_score = @json_data.inject(0) do |result, item|
        event_type = item["type"].to_sym

        #   if has key check key type and assign appropriate point value
        if @event_type_point_value.has_key? event_type
          # it does so assign it value
          result += @event_type_point_value[event_type]
        else
          result += @event_type_point_value[:"Any other event"]
        end
        # return result
        result
      end
    end

    def start
      begin
        github_score_calculation
        "DHH's github score is #{@total_score}"


      rescue Exception => e
        puts e.message

      end
    end

  end
end

@runClass = GithubScore::Github_Score_Abacus.new
puts @runClass.start
