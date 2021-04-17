#!/bin/python3

import math
import os
import random
import re
import sys
from itertools import combinations

#
# Complete the 'maxSubstring' function below.
#
# The function is expected to return a STRING.
# The function accepts STRING s as parameter.
#

def findShoffee(coffeeBeanAndExpectation, preferenceValue):
    # Write your code here
    coffeeBeanAndExpectation = coffeeBeanAndExpectation.split(' ')
    N = int(coffeeBeanAndExpectation[0])
    K = int(coffeeBeanAndExpectation[1])
    
    preferenceValue = preferenceValue.split(' ')
    preferences = []
    for i in preferenceValue:
        preferences.append(int(i))

    result = []
    for a in range(len(preferences)+1):
        result.append(list(combinations(preferences, a)))

    resultClean = [item for sublist in result for item in sublist]
    
    resultClean.pop(0)
    resultClean = list(dict.fromkeys(resultClean))

    another = []
    for i in resultClean:
        myList = list(i)
        sums = 0

        for j in myList:
            sums += j
        
        another.append(sums / len(myList))

    count = 0
    for i in another:
        if i >= K:
            count += 1

    return count


if __name__ == '__main__':

    coffeeBeanAndExpectation = input()
    preferenceValue = input()

    result = findShoffee(coffeeBeanAndExpectation, preferenceValue)
    print(result)
