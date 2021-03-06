#Import modules
#import Pkg; Pkg.add("DataFrames")
#import Pkg; Pkg.add("JSONTables")

#Using the following
using JSON
using DataFrames, JSONTables

parsedFile = JSON.parsefile("contacts.json")

println(parsedFile)
