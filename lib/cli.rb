# ---------------
# | SLASHCODE CLI
# |-- version: dev-2

require 'thor'
require "slashcode/Compiler"

module SlashCLI
	class CLI < Thor
		desc "| compile <filename> <output>", "|-- Compile a slashcode file"
		def compile(file: "main.slash", output: "output.rb")
			puts ""
			puts "Preparing compiler..."
			functions_file = File.expand_path("../../config/slashcode.toml", __FILE__)
			compiler = Compiler::Compiler.new(file, functions_file, output)
			puts "Compiling #{file}..."
			compiler.compile
			puts "#{file} has been compiled to #{output}!"
			puts ""
		end

		desc "| help", "|-- Show help information"
		def help
			puts ""
			puts "| Help information for the slashcode CLI:"
			puts "|----------------------------------------"
			puts "|"
			puts "| help"
			puts "|-- Show this help text"
			puts "|"
			puts "| compile <filename>"
			puts "|-- Compile a slahscode file"
			puts "|"
			puts "|----------------------------------------"
			puts ""
		end

		def method_missing(command, *args)
			puts ""
			puts "| Unknown subcommand: #{command}."
			puts "|-- Use 'slash help' for available commands."
			puts ""
		end
	end
end
