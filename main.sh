#!bin/bash

emails=(rswierk10@gmail.com richardswierk8@gmail.com rtswierk@gmail.com)

for x in "${emails[@]}"
do
  email=$x
  username=
done


echo 'Subject: Your temp account password\nPassword: $tempPass' > email.txt
sendmail something@gmail.com < email.txt
