
#!/bin/bash                                                                 
while read i;            
do
        users=${i%%,*}                            
        echo ${users#*=} >> user         
done < ./ldapusers                                                                             
while read i;        
do          
        echo useradd $i                            
done < ./user