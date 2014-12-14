module Kakutani
  module Bestsellers
    # Overview of all bestseller list for a given week
    #
    # The main property of an Overview object is the {#lists} property, which is
    # and Array of {List} objects. Each {List} is represents a best-seller list
    # for a particular genre or market. The main property of each {List} is its
    # {#books} property, which is the list of bestsellers in ranked order
    #
    # @example Getting the name of each list and its top-selling author
    #   > require "kakutani"
    #   > c = Kakutani::Client.new('your-api-key')
    #   > o = c.bestsellers_overview
    #   > o.lists.each{|k,v| puts "#{k}: #{v.books.first.author}"}; nil
    #   Combined Print and E-Book Fiction: John Grisham
    #   Combined Print and E-Book Nonfiction: Laura Hillenbrand
    #   Hardcover Fiction: James Patterson
    #   Hardcover Nonfiction: Brandon Stanton
    #   Trade Fiction Paperback: Gillian Flynn
    #   Mass Market Paperback: Laurell K Hamilton
    #   Paperback Nonfiction: Laura Hillenbrand
    #   E-Book Fiction: Mark Greaney
    #   E-Book Nonfiction: Laura Hillenbrand
    #   Advice How-To and Miscellaneous: Ina Garten
    #   Picture Books: B J Novak
    #   Childrens Middle Grade: James Patterson and Chris Grabenstein
    #   Young Adult: John Green
    #   Series Books: Jeff Kinney
    #   Hardcover Graphic Books: Roz Chast
    #   Paperback Graphic Books: Raina Telgemeier
    #   Manga: Masashi Kishimoto
    #   Business Books: Tony Robbins
    #   Hardcover Political Books: Bill O'Reilly and Martin Dugard
    #   Science: Atul Gawande
    #   Food and Fitness: Ina Garten
    #   Sports: Laura Hillenbrand
    #   Humor: Amy Poehler
    #   Education: Malala Yousafzai with Christina Lamb
    #   Travel: Cheryl Strayed
    #   Family: Brooke Shields
    #   Health: Richard Preston
    #   Fashion Manners and Customs: Diane Von Furstenberg
    #   Relationships: Andy Cohen
    #   Culture: Cary Elwes with Joe Layden
    #   Religion Spirituality and Faith: Anne Lamott
    #   Celebrities: Amy Poehler
    #   Animals: Matthew Inman
    #   Crime and Punishment: Ann Rule
    #   Games and Activities: Matthew Needler and Phil Southam
    #   
    # @example Checking that the lists are all the same length
    #   > o.lists.map{|k,v| v.books.count}.uniq
    #    => [5]
    # 
    #
    #
    class Overview < Resource
      attr_reader :lists

      def initialize(data)
        super(data)
        @lists = get_lists(data['lists'], 
                           data['bestsellers_date'], 
                           data['published_date'])
      end

      # URL of the API endpoint for this data
      # @param date [Date] The date of the requested list
      # @param name [String] The name of the requested list
      # @return [String]
      def self.path
        Bestsellers::path(['overview'])
      end

      private
      def get_lists(lst, list_date, pub_date)
        Hash[lst.map{|l| [l['list_name'], 
                          List.new(l, 
                                   {
                                     :list_date => list_date, 
                                     :pub_date => pub_date
                                   })
                         ]
             }]
      end
    end
  end
end
