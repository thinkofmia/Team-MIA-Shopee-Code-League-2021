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
allEng = []

#Functions
#Calculate noise in a group of engineers
function calculateNoise(l,r, arrEngineers)
    noise = sum(arrEngineers[l:r]) * (r-l+1)
    #println("Noise between index ",l," and ",r," : ",noise)
    return noise
end

#Calculate noise in all the groups
function calculateAllNoises(N,K,arrDivide,arrEngineers)
    start = 0
    last = N
    sum = 0
    for i in 1:K-1
        sum += calculateNoise(arrDivide[i],arrDivide[i+1],arrEngineers)
    end
    return sum
end


function divideArray(arr, n, k)
      
    # Dp to store the values 
    dp = [[0 for i in range(500)]  
             for i in range(500)] 
  
    k -= 1
    # Fill up the dp table 
    for i in -1:n-1 
        for j in 0:k + 1
              
            # Intitilize maximum value 
            dp[i][j] = 199999999999999999999999999
  
            # Max element and the summ 
            min = 999999999999999999999999999999
            summ = 0
  
            # Run a loop from i to n 
            for l in i:n
                  
                # Find the maximum number 
                # from i to l and the summ 
                # from i to l 
                max_ = calculateNoise(max_, arr[l],arr) 
                summ += arr[l] 
  
                # Find the summ of difference 
                # of every element with the 
                # maximum element 
                diff = (l - i + 1) * max_ - summ 
  
                # If the array can be divided 
                if (j > 0)
                    dp[i][j]= min(dp[i][j], diff + 
                                  dp[l + 1][j - 1]) 
                else
                    dp[i][j] = diff 
                end
            end
        end
    end
    # Returns the minimum summ 
    # in K parts 
    return dp[0][k] 
end

# Prompt to enter 1st line
#println("Enter N and K respectively on same line: ") 

line1 = readline()
inputArr = split(line1, " ")
N = parse(Int64, inputArr[1]) 
K = parse(Int64, inputArr[2]) 
println("N:", N)
#rintln("K:", K)

# Prompt to enter 2nd line
#println("Enter ",N," numbers in a line") 
  
line2 = readline()
inputArr = split(line2, " ")
# Taking Input from user 
for i in 1:N
   push!(allEng,parse(Int64, inputArr[i]))
end 
#println("Engineers: ",line2)

#Run noise check
noise = calculateNoise(2,3,allEng)
noise = divideArray(allEng, N,K)
println(noise)
