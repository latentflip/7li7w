#---
# Excerpted from "Seven Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/btlang for more book information.
#---
module ActsAsCsv
  class CsvRow
    attr_reader :headers, :contents
    def initialize(headers, contents)
      @headers = headers
      @contents = contents
    end

    def method_missing(method_name, *args, &block)
      if headers.include? method_name.to_s
        contents[headers.index(method_name.to_s)]
      end
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end
  
  module InstanceMethods   
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end
    
    attr_accessor :headers, :csv_contents
    def initialize
      read 
    end

    def rows
      @rows ||= csv_contents.map {|row_csv| CsvRow.new(headers, row_csv)}
    end

    def each(&block)
      rows.each { |row| block.call(row) }
    end
  end
end

class RubyCsv  # no inheritance! You can mix it in
  include ActsAsCsv
  acts_as_csv
end

m = RubyCsv.new

m.each {|row| puts row.one}
