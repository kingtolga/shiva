engine_started = False

while True:
    user_input = input("Enter 'start', 'stop', or 'exit': ").lower()

    if user_input == 'start':
        if engine_started:
            print("Engine is already running.")
        else:
            engine_started = True
            print("Engine started.")
    elif user_input == 'stop':
        if engine_started:
            engine_started = False
            print("Engine stopped.")
        else:
            print("Engine is already stopped.")
    elif user_input == 'exit':
        break
    else:
        print("Invalid input. Please enter 'start', 'stop', or 'exit'.")
