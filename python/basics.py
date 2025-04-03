#################################### Variables ####################################

kids_ages = [ 13, 16 ]

father_bio = {
    "Name": "Johny",
    "Age": 40
}

print(kids_ages)
print(father_bio)

#################################### Mathematical Expressions ####################################

birth_year = 1990
current_year = 2025
age = current_year - birth_year
print("I am" , age , "years old.")

#################################### Input from User ####################################

birth_year = int(input("Enter your birth year: "))
current_year = int(input("Enter the current year: "))
age = current_year - birth_year
print("I am" , age , "years old.")

# ----------------------------------------------------------------------------------

# Write a python program that checks whether people are eligible to be US Presidential election base on age

birth_year = int(input("Enter your birth year: "))
current_year = int(input("Enter the current year: "))
age = current_year - birth_year

if age > 80:
    print("You are too old to be a US President!")
elif age <= 40:
    print("You are too young to be a US President!")
else:
    print("You are eligible to be a US President!")
    
# ----------------------------------------------------------------------------------

# Write a program that takes a number from a user
# - if that number is divisible by 3, print "Foo"
# - if that number is divisible by 5, print "Bar"
# - if that number is divisible by both 3 & 5, print "Foo Bar"

num = int(input("Enter any number: "))

if num % 3 == 0 and num % 5 == 0:
    print("Foo Bar")
elif num % 5 == 0:
    print("Bar")
elif num % 3 == 0:
    print("Foo")
else:
    print("The", num, "you entered is neither divisible by 3 or 5, please try again")

#################################### Loops ####################################

names = {
    "first_name": "Obama",
    "age" : 60
}

print(names["first_name"])
print(names["age"])

# ----------------------------------------------------------------------------------

numbers = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]

numbers.append(11)
print(num)

numbers.sort()
print(numbers)

numbers.reverse()
print(numbers)

# Go trhouth a list of numbers and print each

for num in numbers:
    print (num)

# ----------------------------------------------------------------------------------

numbers = range(1, 100)
multiples_three_five = []
multiples_three = []
multiples_five = []
not_multiples_three_five = []

for num in numbers:
    ### divisible by 3 & 5
    if num % 3 == 0 and num % 5 == 0:
        multiples_three_five.append(num)
    ### divisible by 3 only
    elif num % 3 == 0:
        multiples_three.append(num)
    ### divisible by 5 only
    elif num % 5 == 0:
        multiples_five.append(num)
    ### NOT divisible by 3 & 5
    elif num % 3 != 0 and num % 5 != 0:
        not_multiples_three_five.append(num)

print(multiples_three_five)

# ----------------------------------------------------------------------------------

### Lists
names = [
    {
        "first_name": "Barack",
        "last_name": "Obama",
        "age": 60
    },
    {
        "first_name": "Joe",
        "last_name": "Biden",
        "age": 82
    }
]

# print(names[0]["first_name"] + " " + names[0]["last_name"])
# print(names[1]["first_name"] + " " + names[1]["last_name"])

for item in names:
    for key, value in item.items():
        print(key, str(value))

### Dictionary
names = {
    "first_name": "Barack",
    "last_name": "Obama",
    "age": 60
}

print(type(names))
for key, value in names.items():
    print(key, str(value))

#################################### Temperature Conversion ####################################

# Write a program that takes a temperature in Celsius from a user and converts it to Fahrenheit

# The formula to convert temperature from Celsius to Fahrenheit is F = (°C x 9/5) + 32

temp_in_celsius = float(input("Please enter temperature in celsius: "))
temp_in_fahrenheit = ((temp_in_celsius * (9/5)) + 32)
print("The temperature value of", temp_in_celsius, "is equivalent to", temp_in_fahrenheit, "in Fahrenheit")

#################################### Functions ####################################

def celsius_to_fahrenheit(temp_in_celsius):
    temp_in_fahrenheit = ((temp_in_celsius * (9/5)) + 32)
    return temp_in_fahrenheit

some_input = float(input("Please enter temperature in celsius: "))

temp_value = celsius_to_fahrenheit(some_input)

### Tell if the weather is bad or good

if temp_value <= 40:
    print("The temperature today is", temp_value, "°F, so the weather is too bad today. School is canceled.")
else:
    print("The temperature today is", temp_value, "°F, so the weather is ok to go out. School is in session.")
