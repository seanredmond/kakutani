module Kakutani
  module Bestsellers
    # An age group as recognized by the Bestsellers API
    #
    # @!attribute [r] age_range
    #   The recognized label for the age group
    #   @return [String]
    #
    # @!attribute [r] min
    #   The lower bound for the age group. Nil means there is no lower bound. In
    #   practise, a nil lower bound only occurs in the age group "All ages"
    #   @return [Fixnum, nil]
    #
    # @!attribute [r] max
    #   The upper bound for the age group. Nil means there is no upper bound, as
    #   if often found in age groups such as "Ages 10 and up"
    #   @return [Fixnum, nil]
    class AgeGroup < Resource
      attr_reader :min, :max
      def initialize(data)
        super(data)
        (@min, @max) = get_range(age_group)
      end

      # URL of the API endpoint for this data
      # @return [String]
      def self.path
        Bestsellers::path('age-groups')
      end

      private
      def get_range(rng)
        return [nil, nil] if rng == "All ages"
        # The \s+ is required because of an extra space in the label
        # "Ages 12 and  up"
        return [$1.to_i, nil] if rng =~ /^Ages (\d+) and\s+up$/
        return [$1.to_i, $2.to_i] if rng =~ /^Ages (\d+) to (\d+)$/
        raise ParameterError.new("Can't parse age range \"#{rng}\"")
      end
    end
  end
end
