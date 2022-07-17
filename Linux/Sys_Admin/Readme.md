# SYS ADMIN LINUX

### sed:

- it replaces a string in a file with another string.
- sed -i 's/sai/kale/g' file.txt (-i: save changes to the file, s: replacement, sai: the word that will be replaced, kale: teh replacement, g:global across the file)
- sed -i '/sai/d' file.txt (d: delete all the lines that has sai)
- sed -i '/^$/d' file.txt (delete all the empty lines, ^ file start and $ file end)
- sed '1,2d' file.txt (delete 1 and 2 lines)
- sed 's/\t/ /g' file.txt (remove tabs in the file)
- sed -n 12,18p file.txt (see lines from 12-18)
- sed 12,18d file.txt (displays all the lines except for 12-18)
- sed G file.txt (adds a empty line between the lines of the file)
- sed '8!s/S/G/g' (replaces all teh S with G except for the 8th line)

### User account management:

- useradd : add a user to a group. 
    - if you dont specify a group automatically a group is created with the name of the user
    - useradd spiderman (adds a user spiderman, to group spiderman, verify with command (id username)
- groupadd:
    - groupadd superheros (adds a new group)
- userdel
    - userdel spiderman  (deletes the user , use the command with -r to delete the home directory as well   )
- groupdel
- usermod:
    - usermod -G superheros spiderman (adding spiderman to the superheros grp)
    
- Files where the changes are stored: /etc/passwd, /etc/group, /etc/shadow
- new users get append at the bottom of the /etc/passwd and /etc/group as well. /etc/shadow stores the passwords and expiration dates of those passwords.(they are encrypted so we dont see it)
- command to add a user to a exsisting group and shell etc,.. **useradd -G superheros  -s bin/bash -c "Ironman charater" -m -d /home/ironman ironma**
- to check if its created **id ironman**
- to create a psswd **passwd ironman**

### Password Aging:

- 