![1](https://github.com/user-attachments/assets/4e1c08da-4305-480c-a717-579762caefe4)

These Scripts can be used to send Email when your Public IP changes. This action is Performed using Postfix and Mailx.

This script also has a lockfile so it checks for ip chnage every minute (or any user defined time) but only sends email once until Reseted. Resseting can be Performed by running "ipmailreset.sh" script.

Should add cron job to automate.

Also add output file to store the output of the script.

# Please Follow Steps Below To Make your own SMTP Server

Install "postfix" and "mailx"

##### Move in "/etc/postfix" 

Edit "main.cfg"  {Make a backup first}

Add these lines in "main.cfg"


relayhost = [smtp.gmail.com]:587
myhostname= your_hostname


#### At the end of "main.cf" add

##### Location of sasl_passwd we saved

smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd { Or give any other path for "passwd" file }

##### Enables SASL authentication for postfix

smtp_sasl_auth_enable = yes
smtp_tls_security_level = encrypt

##### Disallow methods that allow anonymous authentication

smtp_sasl_security_options = noanonymous



### Then Create a file in "/etc/postfix/sasl/"  with filename "sasl_passwd" { or as stated in location of sasl map }

In file "sasl_passwd" add

[smtp.gmail.com]:587 email@gmail.com:password { Where "email@gmail.com is your email id and password is password you get from google" }

##### TO get password from google:

1. Make sure 2 step authentication is enabled
2. Search for "App Paswords" 
3. Select "Others" in the options and name it
4. Then Copy the passowrd {It will be shown only once}

Paste password in "sasl_passwd" file. 

Then Convert "sasl_passwd" file in db file

To convert "sasl_passwd" file use "postmap" {postmap /file path}

##### Then add permissions 

"Chmod 600 "

### Start postfix service 

Systemctl Start/Enable postfix.service

##### Try sending test main 
echo "Test Mail" | mail -s "Postfix TEST" receiver@mail.com


## After these steps Edit "ipchangemail.sh" with your own Credentials and needs.

Hope It Helps
