#Import modules
#import Pkg; Pkg.add("DataFrames")
#import Pkg; Pkg.add("JSONTables")

#Using the following modules
using JSON
using DataFrames, JSONTables

#Parse file
parsedFile = JSON.parsefile("contacts.json")
#println(parsedFile)

#Create new dictionary
results = Dict()

#Loop for each contact in json
for (contact) in parsedFile
    #print(contact);
    ks = keys(results)
    #Categorize by emails
    if (contact["Email"] in ks)
        push!(results[contact["Email"]],contact["Id"])
    else
        results[contact["Email"]] = [contact["Id"]]
    end
end

print(results)