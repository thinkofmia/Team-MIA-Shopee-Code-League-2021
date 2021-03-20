#=
Problem: Divider
Max. score: 20

Shopee has N software engineers. 
Shopee accommodates them by arranging N tables on a 1D plane. 
However, many people raise concerns that the work environment is too noisy. 
To mitigate this issue, Shopee decides to group the engineers into K groups.
A group is a non-overlapping segment of contiguous engineers. 
Shopee will then put dividers between the groups.

Shopee wants to minimize the total noise value. 
Please help Shopee to find the minimum total noise value possible.
=#


# Julia program to calculate sum of  
# 5 integers obtained from console/user input 

#Variables
line1 = ""
line2 = ""

#Functions
function calculateNoise(l,r, arrEngineers)
    noise = sum(arrEngineers[l:r]) * (r-l+1)
    println("Noise between index ",l," and ",r," : ",noise)
    return noise
end

# Prompt to enter 1st line
println("Enter N and K respectively on same line: ") 

line1 = readline()
inputArr = split(line1, " ")
N = parse(Int64, inputArr[1]) 
K = parse(Int64, inputArr[2]) 
println("N:", N)
println("K:", K)

# Prompt to enter 2nd line
println("Enter ",N," numbers in a line") 
  
line2 = readline()
inputArr = split(line2, " ")
allEng = []
# Taking Input from user 
for i in 1:N
   push!(allEng,parse(Int64, inputArr[i]))
end 
println("Engineers: ",line2)

#Run noise check
noise = calculateNoise(2,3,allEng)
