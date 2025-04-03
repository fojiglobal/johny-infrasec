# Write a python program that convert temperature from Fahrenheit to Celsius and weather warnings for proper dressing. Program should accept input from the user and display 
# If temperature is above 30 degrees, "The Weather is very Hard Outside So be careful with Heat Waves"
# If temperature is between 20 and 30 degrees "The weather is warm, do not wear thick clothes"
# If temperature is between 10 and 19 degrees "The weather is a bit cold so dress warmer"
# If temperature is below 10 degrees, "The weather is very cold outside so wear thick clothes"

# The formula to convert temperature from Fahrenheit to Celsius is C = (F - 32) * (5/9)

# Function to convert temperature from Fahrenheit to Celsius
def fahrenheit_to_celsius(temp_f):
    temp_c = (temp_f - 32) * (5/9)
    return temp_c

# # Check if the entry is correct
# while True:
#     user_input = input("Please enter a temperature in fahrenheit: ")

#     try:
#         # Attempt to convert input to float
#         temp_in_fahrenheit = float(user_input)  
        
#         # Converstion of the temprature from Fahrenheit to Celsius and the value captured for further processing
#         temps_in_celcius = fahrenheit_to_celsius(temp_in_fahrenheit)
        
#         ### Tell if the weather is bad or good
#         if temps_in_celcius < 10 :
#             print("The temperature today is", temps_in_celcius, "°F. The weather is very cold outside so wear thick clothes.")
#         elif temps_in_celcius >= 10 and temps_in_celcius <= 19:
#             print("The temperature today is", temps_in_celcius, "°F. The weather is a bit cold so dress warmer.")
#         elif temps_in_celcius >= 20 and temps_in_celcius < 30:
#             print("The temperature today is", temps_in_celcius, "°F. The weather is warm, do not wear thick clothes.")
#         elif temps_in_celcius >= 30:
#             print("The temperature today is", temps_in_celcius, "°F. The Weather is very Hard Outside. So be careful with Heat Waves.")      
#         break
    
#     # Handle invalid input
#     except ValueError:
#         print("Invalid input. Please enter a numeric value.")  
  
# Input of the temperaature in fahrenheit by a user
temp_in_fahrenheit = float(input("Please enter a temperature in fahrenheit: "))

# Converstion of the temprature from Fahrenheit to Celcius and the result captured for further processing
temp_in_celcius = fahrenheit_to_celsius(temp_in_fahrenheit)
        
### Tell if the weather is bad or good
if temp_in_celcius < 10 :
    print("The temperature today is", temp_in_celcius, "°F. The weather is very cold outside so wear thick clothes.")
elif temp_in_celcius >= 10 and temp_in_celcius <= 19:
    print("The temperature today is", temp_in_celcius, "°F. The weather is a bit cold so dress warmer.")
elif temp_in_celcius >= 20 and temp_in_celcius < 30:
    print("The temperature today is", temp_in_celcius, "°F. The weather is warm, do not wear thick clothes.")
elif temp_in_celcius >= 30:
    print("The temperature today is", temp_in_celcius, "°F. The Weather is very Hard Outside. So be careful with Heat Waves.")        


    