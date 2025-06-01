![1](https://github.com/user-attachments/assets/4e1c08da-4305-480c-a717-579762caefe4)

These Scripts can be used to send Email when your Public IP changes. This action is Performed using Postfix and Mailx.

This script also has a lockfile so it checks for ip chnage every minute (or any user defined time) but only sends email once until Reseted. Resseting can be Performed by running "ipmailreset.sh" script.

Should add cron job to automate.

Also add output file to store the output of the script.
