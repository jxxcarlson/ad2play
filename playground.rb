#!/usr/bin/env ruby

# File:        ad2pl
# Purpose:     Convert files written in asciidoc (asciidoctor) to Swift playgrounds
# Usage:       $ ad2pl foo.ad
#              This will produce a Swift playground named foo.playgound
# Author:      James Carlson (@epsilon2718, http://square-the-circle.com)
# Date:        August 1, 2014
# License:     MIT License
# Code status: hacked together


require 'asciidoctor'

class Tokenizer
  
  attr_accessor  :input
  
  # states -- 
  
  def get_input(input)
    @input = input
    @index = 0
    @begin_chars = ["[", "("]
    @end_chars = ["]", ")"]
    @stop_char = "§" 
  end
  
  def get_char
    
    if @index < @input.length
      output = @input[@index]
      @index += 1
      return output
    else
      return nil
    end
    
  end
  
  def current_char
    
    if @index < @input.length
      return  @input[@index]
    else
      return nil
    end
    
  end
  
  def delimited_token(c)
    
    token = ""
    index = @begin_chars.index(c)
    endchar = @end_chars[index]
    
    ch = get_char
    
    while ch != endchar
      token += ch
      ch = get_char
    end
    token += ch
    get_char
    return token
    
  end 
  
  def normal_token(c)
    
    token = "" 
    
    ch = get_char
    
    while ch != nil && ch != @stop_char && ch != '\n' && ch != ' '
      token += ch  
      ch = get_char
    end
    return token
   
  end
  
  
  def get_token
    
    c = current_char
    
    if c == nil
      return nil
    elsif c == "\n" || c == " "
      get_char
      return c   
    elsif @begin_chars.include? c
      return delimited_token(c)
    else
      return normal_token(c)
    end
    
  end
  
  def test
    puts "\nTOKENS:"
    puts "-------"
    count = 0
    token = get_token
    while token != nil
      count += 1
      puts "#{count}: >#{token}<"
      token = get_token
    end 
    puts     
  end
  
  def print_tokens(count)
    token = get_token
    while token != nil
      count += 1
      puts "#{count}: #{token}"
      token = get_token
    end 
    return count
  end
  
  
end

class Parser
  
   attr_accessor  :output_names, :debug
  
  def set_up(input_file)
    
    @debug = false
    
    basename = File.basename(input_file, ".ad")
    @target_directory = basename + ".playground"
    @documentation_directory = @target_directory+"/Documentation"
    @image_directory = @documentation_directory + "/images"
    @css_file = @documentation_directory + "/asciidoctor.css"
    @css_source_file = "asciidoctor.css"
    
    @output_names = []

    if !Dir.exists? @target_directory
      Dir.mkdir @target_directory
    end

    if !Dir.exists? @documentation_directory
      Dir.mkdir @documentation_directory
    end
    
    if !Dir.exists? @image_directory
      Dir.mkdir @image_directory
    end
    
    if !File.exists? @css_file
      FileUtils.cp(@css_source_file, @css_file)
    end
        
    @file_count = 0
    @file_contents = ""
    @state = :text
    @previous_state = @state
    @tk = Tokenizer.new
    
  end
  
  
  def change_state
  
    @saved_state = @state
    
    if /\[source.*\]/ =~ @token
      @state = :code1
    elsif ((/--/ =~ @token) == 0) and (@state == :code1)  
      @state = :code2
    elsif  (/--/ =~ @token) == 0 and @state == :code2
      @state = :code3
    elsif  @previous_state == :code2 and @state == :code3
      @state = :text
    end
    
  end
  
  def code_element(name)
    value = '    <code source-file-name="' + name + '">' + "\n" + '    </code>'
  end
  
  def text_element(name)
    value = '    <documentation relative-path="' + name + '">' + "\n" + '    </documentation>'
  end
  
  
  def write_manifest
    
    xml_string = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
    playground_string = '<playground version="3.0" sdk="macosx" allows-reset="YES">'
    
    manifest = xml_string + "\n"
    manifest += playground_string + "\n"
    manifest += "  <sections>\n"
    for name in @output_names
      if /.swift/ =~ name
        manifest += code_element(name) + "\n"
      else
        manifest += text_element(name) + "\n"
      end   
    end
    manifest += "  </sections>\n"
    manifest += "</playground>\n"
    
    manifest_name = 'contents.xcplayground'
    path = @target_directory + "/" + manifest_name
    File.open(path, 'w') {|f| f.write(manifest) }
    
    # puts manifest   
    
  end
  
  
  def write_out(str)
    
    if @previous_state == :text 
      
      source_filename = "section-#{@file_count}.ad"
      html_filename = "section-#{@file_count}.html"
      @output_names << html_filename
      
      # html_content = Asciidoctor.render(@file_contents)
          
      source_path =  @documentation_directory + "/" + source_filename
      html_path =  @documentation_directory + "/" + html_filename
      
      @file_contents = ":last-update-label!:\n\n\n" +  @file_contents
      File.open(source_path, 'w') {|f| f.write(@file_contents) }
      Asciidoctor.render_file(source_path, :in_place => true)

      if !@debug
        FileUtils.rm(source_path)
      end
           
      puts "  #{html_filename}"
      
    else
      filename = "section-#{@file_count}.swift"
      @output_names << filename
      path = @target_directory + "/" + filename
      puts "  #{filename}"
      File.open(path, 'w') {|f| f.write(@file_contents) }
    end
    
    @file_contents = "" 
    @file_count += 1   
    
  end
  
  def handle_token
    
    if @debug
      puts "states: #{@previous_state}, #{@state}, token: |#{@token}|"
    end
        
    if @state != :code1 and @state!= :code3 and !(@state == :code2 and @token.strip == "--") and (@token != "!end!")
      if @token != "\n"
        text_to_add = @token + " "
      else
        text_to_add = "\n"
      end
      if @debug 
        puts "add: |#{text_to_add}|"
      end
      @file_contents += text_to_add      
    end
    
    if @previous_state != @state and @previous_state == :text
      write_out(@file_contents)
      @file_contents = ""
      # @state =  :code1     
    elsif @previous_state != @state and @state == :code3 
      write_out(@file_contents)
      @file_contents = ""
      @state = :text     
    end 
    
    @previous_state = @state
         
  end
    
 
  def parse_line(line)
    
    @tk.get_input(line )    
    @token = @tk.get_token()
    if @token != nil
      change_state
      handle_token
    end
    while @token != nil
      @token = @tk.get_token()
      if @token != nil
        change_state
        handle_token
      end
    end 
  end 
  
  def finish_up
    @state = :end
    @token = "!end!"
    handle_token 
  end
  
end


# source_file = "test.ad"

source_file = ARGV[0]

count = 0
pa = Parser.new
pa.set_up(source_file)
# pa.debug = true

puts "\n  Writing playground ..."


File.readlines(source_file).each do |line|
  pa.parse_line(line)
end
pa.finish_up
puts
pa.write_manifest
# puts pa.output_names








