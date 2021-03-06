#Import modules
#import Pkg; Pkg.add("DataFrames")
#import Pkg; Pkg.add("JSONTables")
#import Pkg; Pkg.add("CSV")

#Using the following modules
using JSON
using DataFrames, JSONTables
using CSV

#Parse file
parsedFile = JSON.parsefile("contacts.json")
#println(parsedFile)

#Create new dictionary
userDatabase = Dict()
#Format is as such
# userDatabase = {
#   userid => {
#   "Emails" => [email1, email2],
#   "Phones" => [phone1, phone2, phone3],
#   "OrderIds" => [order1, order2],
#   "totalcontacts" => totalcontacts
#       }
#   }

function newUser(target)
    println()
    print("Adding new user ")
    print(target["OrderId"])
    userDatabase[target["OrderId"]] = Dict(
        "Emails" => [target["Email"]],
        "Phones" => [target["Phone"]],
        "OrderIds" => [target["OrderId"]],
        "TicketIds" => [target["Id"]],
        "TotalContacts" => target["Contacts"]
    )

end

function addToUser(uid, target)
    println()
    print("Updating user ")
    print(target["OrderId"])
    #Emails
    if !(target["Email"] in userDatabase[uid]["Emails"])
        push!(userDatabase[uid]["Emails"],target["Email"])
    elseif (isempty(userDatabase[uid]["Emails"]))#If not email record, start emails
        userDatabase[uid]["Emails"] = [target["Email"]]
    end

    #Phones
    if !(target["Phone"] in userDatabase[uid]["Phones"])
        push!(userDatabase[uid]["Phones"],target["Phone"])
    elseif (isempty(userDatabase[uid]["Phones"]))   #If no phone record, start array
        userDatabase[uid]["Phones"] = [target["Phone"]]
    end

    #Order Id
    if !(target["OrderId"] in userDatabase[uid]["OrderIds"])
        push!(userDatabase[uid]["OrderIds"],target["OrderId"])
    elseif (isempty(userDatabase[uid]["OrderIds"]))   #If no order record, start array
        userDatabase[uid]["OrderIds"] = [target["OrderId"]]
    end
    
    userDatabase[uid]["TotalContacts"]+= target["Contacts"]

end

#Search Criteria, user id refers to the individual user, target refers to the matching record
function searchCriterias(uid, target)
    #Boolean for found
    recordFound = false
    if (target["Email"] in userDatabase[uid]["Emails"])
        recordFound = true
    elseif (target["Phone"] in userDatabase[uid]["Phones"])
        recordFound = true
    elseif (target["OrderId"] in userDatabase[uid]["OrderIds"])
        recordFound = true
    end

    return recordFound
end

#Find record
function findRecord(target, searchType="Normal")
    #variable to start search
    searchBegin = true
    userFound = false
    #Get all users
    users = keys(userDatabase)
    #Loop for each user
    for (user) in users
        #Start search in target user
        findUser = searchCriterias(user, target)
        #if search ends, break out of loop
        if (findUser)
            if (searchType=="Normal") 
                addToUser(user,target)
            else
                return getTrace(user)
            end
            userFound = true
            break
        end
    end
    if (!userFound)
        if (searchType=="Normal") 
            newUser(target)
        end
    end
end


#Loop for each contact in json
for (contact) in parsedFile
    #print(contact);
    findRecord(contact)
end

println()
print("Total Users: ")
print(size(userDatabase))

#Create databank to export
exportIds = []
exportDatabank = []
for (contact) in parsedFile
    userRecords = findRecord(contact,"Look")
    ticketTrace = join(userDatabase[userRecords]["TicketIds"], "-")
    totalcontacts = userDatabase[userRecords]["TotalContacts"]
    output = ticketTrace * ", " * totalcontacts
    push!(exportIds,contact)
    push!(exportDatabank,output)
end

#Writing CSV
# new file created 
touch("miaResults.csv")  
  
# file handling in write mode 
efg = open("miaResults.csv", "w")  

#Store them into data frame
df = DataFrame(ticket_id = exportIds, 
                ticket_trace/contact = exportDatabank 
             )
println()
print("Exporting df")

CSV.write("miaResults.csv", df)