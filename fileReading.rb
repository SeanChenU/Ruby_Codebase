require 'tempfile'
require 'fileutils'

# $file_path = "#{Dir.pwd}/#{__FILE__}"
$file_path = "#{Dir.pwd}/empty.js"

puts "Reading file: #{$file_path}"
# puts $file_path

#Simple read file
# File.open("#{$file_path}", "r") do |file|
#     file.each_line do |line|
#         puts line
#     end
# end


# Simple write file
# File.open("#{$file_path}", "w") do |file|
#     file.write("name: {\n\ttype:'string',\n\trequired:true\n}")
# end

# Simple replace text using regExp (by replacing whole text)
# text = File.read("#{$file_path}")
# puts text
# new_text = text.gsub(/attributes/, 'money')
# puts new_text
# File.open("#{$file_path}", "w") {|file| file.puts new_text}

# Insert text
$reg = /attributes: {/
$line_to_add = "\tname: {\n\t\ttype:'string',\n\t\trequired:true\n\t},"

def insertTextAfter(reg, line_to_add)
    @regFound = false

    temp_file = Tempfile.new("temp") # create a temp copy
    begin
        File.readlines("#{$file_path}").each do |line| # Read each line
            temp_file.puts(line) # Copy to temp file
            if line =~ reg # If regExp matched
                temp_file.puts(line_to_add) # Insert text in next line
                @regFound = true
            end
        end
        temp_file.close
        FileUtils.mv(temp_file.path, $file_path) # Replace original one with temp file content
    ensure
        temp_file.delete # Remove the temp file
    end

    if @regFound == false
        puts "[Error] \"#{reg}\" not found"
    end
end

# insertTextAfter($reg, $line_to_add)

def addTextInSailsModelAttributes(line_to_add)
    @reg = /attributes: {/
    insertTextAfter(@reg, line_to_add)
end

addTextInSailsModelAttributes($line_to_add)
