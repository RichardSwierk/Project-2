#!bin/bash
#Author: Richard T Swierk

#List of the emails used
emails=(rswierk10@gmail.com richardswierk8@gmail.com rtswierk@gmail.com)

#Check if the script is run as root and exits if false
if [ "$EUID" -ne 0 ]
  then echo "Must Run as Root"
  exit
fi

#Loop through all of the emails in the list
for x in "${emails[@]}"
do
  email=$x
  #Get everything before the @
  username=${x%@*}
  #Create temp random password with a length of 12
  tempPass="$(openssl rand -base64 12)"
  #Check if the user exists
  if id "$username" &>/dev/null
  then
    #If user exists then change user password, set default shell to bash, and add them to the CSI230 group
    usermod -p $tempPass -s /bin/bash -g CSI230 $username
  else
    #IF the user does not exist then create user with a home directory, add the user to group CSI230, set the users password to the random password created above
    useradd -m -g CSI230 -p $tempPass -s /bin/bash $username
  fi
  #Makes the user change there password after the first time they login
  chage -d 0 $username
  #Create the email
  echo -e 'Subject: Your temp account password\nPassword must be changed after first login\nUsername: $username\nPassword: $tempPass' > email.txt
  #Send the email
  sendmail $email < email.txt
  rm email.txt
done



