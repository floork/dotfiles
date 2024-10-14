import json
import re
import subprocess

try:
    day = subprocess.run(["taim-o-meter", "day"], stdout=subprocess.PIPE, check=True)
    day_out = day.stdout.decode()

    remaining_time_match = re.search(r"Remaining time for today: (\d+h \d+m)", day_out)
    total_time = "8h 30m"

    output = {}

    if remaining_time_match:
        remaining_time = remaining_time_match.group(1)
        formatted_output = f"{remaining_time.replace(' ', ':')}h"
        output["text"] = formatted_output

    week = subprocess.run(["taim-o-meter", "week"], stdout=subprocess.PIPE, check=True)
    week_out = week.stdout.decode()

    output["tooltip"] = week_out

    data = json.dumps(output)

    print(data)


except:
    pass
