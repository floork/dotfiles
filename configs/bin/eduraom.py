#!/bin/python

import subprocess
import time


def check_uplink():
    try:
        # Ping Google's DNS server to check for an uplink
        subprocess.check_output(
            ["ping", "-c", "1", "8.8.8.8"], stderr=subprocess.STDOUT
        )
        return True
    except subprocess.CalledProcessError:
        return False


def bring_up_connection():
    try:
        # Use nmcli to bring up the eduroam connection
        subprocess.run(
            ["nmcli", "connection", "up", "eduroam"],
            check=True,
            stdout=subprocess.DEVNULL,
        )
        print("Attempting to bring up eduroam connection...")
    except subprocess.CalledProcessError as e:
        print(f"Failed to bring up eduroam: {e}")


def main():
    print("monitoring eduroam")
    while True:
        if check_uplink():
            time.sleep(1)
        else:
            print("No internet uplink. Bringing up eduroam...")
            bring_up_connection()
            time.sleep(1)  # Wait before retrying


if __name__ == "__main__":
    main()
