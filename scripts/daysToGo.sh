
#!/bin/bash

# Target date: 12 November 2025 (format: YYYY-MM-DD)
target_date="2025-11-12"

# Today's date in seconds since epoch
today_seconds=$(date +%s)

# Target date in seconds since epoch
target_seconds=$(date -d "$target_date" +%s)

# Calculate the difference in seconds
diff_seconds=$((target_seconds - today_seconds))

# Convert to days
days_to_go=$((diff_seconds / 86400))

# Display result
if [ "$days_to_go" -gt 1 ]; then
    echo "$days_to_go days left"
elif [ "$days_to_go" -eq 1 ]; then
    echo "1 day left"
elif [ "$days_to_go" -eq 0 ]; then
    echo "Today is the day!"
else
    echo "$((-days_to_go)) days ago"
fi
