n = 0
for n in range(1,101):
    if n % 15 == 0:
        print(f"{n} - FizzBuzz")
    elif n % 3 == 0:
        print(f"{n} - Fizz")
    elif n % 5 == 0:
        print(f"{n} - Buzz")
    else:
        print(f"{n} - Nothing")
    n += 1
print("Done")
