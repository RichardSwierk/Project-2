#!bin/bash

emails=(rswierk10@gmail.com richardswierk8@gmail.com rtswierk@gmail.com)

#Loop through all of the emails in the list
for x in "${emails[@]}"
do
  email=$x
  #Get everything before the @
  username=${x%@*}
  #Create temp random password with a length of 12
  tempPass="$(openssl rand -base64 12)"
  #Create user with a home directory, add the user to group CSI230, set the users password to the random password created above
  useradd -m -g CSI230 -p $tempPass $username
  #Makes the user change there password after the first time they login
  chage -d 0 $username
  #Create the email
  echo -e 'Subject: Your temp account password\nPassword must be changed after first login\nUsername: $username\nPassword: $tempPass' > email.txt
  #Send the email
  sendmail $email < email.txt
done



