#! /bin/bash
logfile=/tmp/log.txt
display()
{
blankline="---------------------------------------------------------------------------------------------------"
echo "$blankline" >>$logfile
echo -e "\t \tSSO Application helath Status" >>$logfile
echo "$blankline" >>$logfile
echo -e "\t \tHealth check performed on `date "+%Y-%m-%d %H:%M"`" >>$logfile
echo "$blankline" >>$logfile
echo -e "\t\t\tEnvironment" >>$logfile
echo "$blankline" >>$logfile
echo  -e "\t\t\t\tstg01\tstg02\tstg03\tstg04" >>$logfile
echo "$blankline" >>$logfile
echo -e "SSO Application URL \t\t$sso_stg01\t$sso_stg02\t$sso_stg03\t$sso_stg04" >>$logfile
echo -e "Canada Post     URL \t\t$canadapost_stg10\t$canadapost_stg11\t$canadapost_stg12\t$canadapost_stg13" >>$logfile 
echo -e "PBE-PRE             \t\t$pbe_pfe_stg001\t$pbe_pfe_stg002\t$pbe_pfe_stg003\t$pbe_pfe_stg004" >>$logfile
echo -e "LDAP-PRE            \t\t$ldap_pfe_stg001\t$ldap_pfe_stg002\t$ldap_pfe_stg003\t$ldap_pfe_stg004" >>$logfile
echo -e "EBOX-PRE            \t\t$ebox_pfe_stg001\t$ebox_pfe_stg002\t$ebox_pfe_stg003\t$ebox_pfe_stg004" >>$logfile
echo -e "CRM-PRE             \t\t$crm_pfe_stg001\t$crm_pfe_stg002\t$crm_pfe_stg003\t$crm_pfe_stg004" >>$logfile
echo -e "GOOGLE Capcha-PRE   \t\t$gc_pfe_stg001\t$gc_pfe_stg002\t$gc_pfe_stg003\t$gc_pfe_stg004" >>$logfile
echo -e "Memory Details-PRE  \t\t$md_pfe_stg001\t$md_pfe_stg002\t$md_pfe_stg003\t$md_pfe_stg004" >>$logfile
echo -e "CPU Details-PRE     \t\t$cpu_pfe_stg001\t$cpu_pfe_stg002\t$cpu_pfe_stg003\t$cpu_pfe_stg004" >>$logfile

}

declare sso_stg01 sso_stg02 sso_stg03 sso_stg04 canadapost_stg10 canadapost_stg11 canadapost_stg12 canadapost_stg13 pbe_pfe_stg001 pbe_pfe_stg002 pbe_pfe_stg003 pbe_pfe_stg004 ldap_pfe_stg001 ldap_pfe_stg002 ldap_pfe_stg003 ldap_pfe_stg004 ebox_pfe_stg001 ebox_pfe_stg002 ebox_pfe_stg003 ebox_pfe_stg004 crm_pfe_stg001 crm_pfe_stg002 crm_pfe_stg003 crm_pfe_stg004  gc_pfe_stg001 gc_pfe_stg002 gc_pfe_stg003 gc_pfe_stg004 md_pfe_stg001 md_pfe_stg002 md_pfe_stg003 md_pfe_stg004 cpu_pfe_stg001 cpu_pfe_stg002 cpu_pfe_stg003 cpu_pfe_stg004

[ "$(curl -o /dev/null -s -w 200 `cat input.txt |grep -i sso_stg01| awk '{print $NF}'`)" -eq "200" ] && sso_stg01=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || sso_stg01=$(echo "$(tput setaf 1) DOWN $(tput sgr0)" )
[ "$(curl -o /dev/null -s -w 200 `cat input.txt |grep -i sso_stg02| awk '{print $NF}'`)" -eq "200" ] && sso_stg02=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || sso_stg02=$(echo "$(tput setaf 1) DOWN $(tput sgr0)" )
[ "$(curl -o /dev/null -s -w 200 `cat input.txt |grep -i sso_stg03| awk '{print $NF}'`)" -eq "200" ] && sso_stg03=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || sso_stg03=$(echo "$(tput setaf 1) DOWN $(tput sgr0)" )
[ "$(curl -o /dev/null -s -w 200 `cat input.txt |grep -i sso_stg04| awk '{print $NF}'`)" -eq "200" ] && sso_stg04=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || sso_stg04=$(echo "$(tput setaf 1) DOWN $(tput sgr0)" )
[ "$(curl -o /dev/null -s -w 200 `cat input.txt |grep -i canadapost_stg10| awk '{print $NF}'`)" -eq "200" ] && canadapost_stg10=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || canadapost_stg10=$(echo "$(tput setaf 1) DOWN $(tput sgr0)" )
[ "$(curl -o /dev/null -s -w 200 `cat input.txt |grep -i canadapost_stg11| awk '{print $NF}'`)" -eq "200" ] && canadapost_stg11=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || canadapost_stg11=$(echo "$(tput setaf 1) DOWN $(tput sgr0)" )
[ "$(curl -o /dev/null -s -w 200 `cat input.txt |grep -i canadapost_stg12| awk '{print $NF}'`)" -eq "200" ] && canadapost_stg12=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || canadapost_stg12=$(echo "$(tput setaf 1) DOWN $(tput sgr0)" )
[ "$(curl -o /dev/null -s -w 200 `cat input.txt |grep -i canadapost_stg13| awk '{print $NF}'`)" -eq "200" ] && canadapost_stg13=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || canadapost_stg13=$(echo "$(tput setaf 1) DOWN $(tput sgr0)" )

pbe_pfe_stg001=$(curl -s `grep -i "^pfe_stg001" input.txt` |  grep -i -A1 "PBE" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
pbe_pfe_stg002=$(curl -s `grep -i "^pfe_stg002" input.txt` |  grep -i -A1 "PBE" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
pbe_pfe_stg003=$(curl -s `grep -i "^pfe_stg003" input.txt` |  grep -i -A1 "PBE" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
pbe_pfe_stg004=$(curl -s `grep -i "^pfe_stg004" input.txt` |  grep -i -A1 "PBE" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
[ $pbe_pfe_stg001 -eq 200 ] && pbe_pfe_stg001=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || pbe_pfe_stg001=$(echo "$(tput setaf 1)$pbe_pfe_stg001 $(tput sgr0)" )
[ $pbe_pfe_stg002 -eq 200 ] && pbe_pfe_stg002=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || pbe_pfe_stg002=$(echo "$(tput setaf 1)$pbe_pfe_stg002 $(tput sgr0)" )
[ $pbe_pfe_stg003 -eq 200 ] && pbe_pfe_stg003=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || pbe_pfe_stg003=$(echo "$(tput setaf 1)$pbe_pfe_stg003 $(tput sgr0)" )
[ $pbe_pfe_stg004 -eq 200 ] && pbe_pfe_stg004=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || pbe_pfe_stg004=$(echo "$(tput setaf 1)$pbe_pfe_stg004 $(tput sgr0)" )

ldap_pfe_stg001=$(curl -s `grep -i "^pfe_stg001" input.txt` |  grep -i -A1 "ldap" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
ldap_pfe_stg002=$(curl -s `grep -i "^pfe_stg002" input.txt` |  grep -i -A1 "ldap" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
ldap_pfe_stg003=$(curl -s `grep -i "^pfe_stg003" input.txt` |  grep -i -A1 "ldap" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
ldap_pfe_stg004=$(curl -s `grep -i "^pfe_stg004" input.txt` |  grep -i -A1 "ldap" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
[ $ldap_pfe_stg001 -eq 200 ] && ldap_pfe_stg001=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || ldap_pfe_stg001=$(echo "$(tput setaf 1)$ldap_pfe_stg001 $(tput sgr0)" )
[ $ldap_pfe_stg002 -eq 200 ] && ldap_pfe_stg002=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || ldap_pfe_stg002=$(echo "$(tput setaf 1)$ldap_pfe_stg002 $(tput sgr0)" )
[ $ldap_pfe_stg003 -eq 200 ] && ldap_pfe_stg003=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || ldap_pfe_stg003=$(echo "$(tput setaf 1)$ldap_pfe_stg003 $(tput sgr0)" )
[ $ldap_pfe_stg004 -eq 200 ] && ldap_pfe_stg004=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || ldap_pfe_stg004=$(echo "$(tput setaf 1)$ldap_pfe_stg004 $(tput sgr0)" )

ebox_pfe_stg001=$(curl -s `grep -i "^pfe_stg001" input.txt` |  grep -i -A1 "ebox" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
ebox_pfe_stg002=$(curl -s `grep -i "^pfe_stg002" input.txt` |  grep -i -A1 "ebox" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
ebox_pfe_stg003=$(curl -s `grep -i "^pfe_stg003" input.txt` |  grep -i -A1 "ebox" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
ebox_pfe_stg004=$(curl -s `grep -i "^pfe_stg004" input.txt` |  grep -i -A1 "ebox" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
[ $ebox_pfe_stg001 -eq 200 ] && ebox_pfe_stg001=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || ebox_pfe_stg001=$(echo "$(tput setaf 1)$ebox_pfe_stg001 $(tput sgr0)")
[ $ebox_pfe_stg002 -eq 200 ] && ebox_pfe_stg002=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || ebox_pfe_stg002=$(echo "$(tput setaf 1)$ebox_pfe_stg002 $(tput sgr0)")
[ $ebox_pfe_stg003 -eq 200 ] && ebox_pfe_stg003=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || ebox_pfe_stg003=$(echo "$(tput setaf 1)$ebox_pfe_stg003 $(tput sgr0)")
[ $ebox_pfe_stg004 -eq 200 ] && ebox_pfe_stg004=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || ebox_pfe_stg004=$(echo "$(tput setaf 1)$ebox_pfe_stg004 $(tput sgr0)")

crm_pfe_stg001=$(curl -s `grep -i "^pfe_stg001" input.txt` |  grep -i -A1 "crm" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
crm_pfe_stg002=$(curl -s `grep -i "^pfe_stg002" input.txt` |  grep -i -A1 "crm" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
crm_pfe_stg003=$(curl -s `grep -i "^pfe_stg003" input.txt` |  grep -i -A1 "crm" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
crm_pfe_stg004=$(curl -s `grep -i "^pfe_stg004" input.txt` |  grep -i -A1 "crm" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
[ $crm_pfe_stg001 -eq 200 ] && crm_pfe_stg001=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || crm_pfe_stg001=$(echo "$(tput setaf 1)$crm_pfe_stg001 $(tput sgr0)" )
[ $crm_pfe_stg002 -eq 200 ] && crm_pfe_stg002=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || crm_pfe_stg002=$(echo "$(tput setaf 1)$crm_pfe_stg002 $(tput sgr0)" )
[ $crm_pfe_stg003 -eq 200 ] && crm_pfe_stg003=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || crm_pfe_stg003=$(echo "$(tput setaf 1)$crm_pfe_stg003 $(tput sgr0)" )
[ $crm_pfe_stg004 -eq 200 ] && crm_pfe_stg004=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || crm_pfe_stg004=$(echo "$(tput setaf 1)$crm_pfe_stg004 $(tput sgr0)" )

gc_pfe_stg001=$(curl -s `grep -i "^pfe_stg001" input.txt` |  grep -i -A1 "Google Captcha" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
gc_pfe_stg002=$(curl -s `grep -i "^pfe_stg002" input.txt` |  grep -i -A1 "Google Captcha" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
gc_pfe_stg003=$(curl -s `grep -i "^pfe_stg003" input.txt` |  grep -i -A1 "Google Captcha" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
gc_pfe_stg004=$(curl -s `grep -i "^pfe_stg004" input.txt` |  grep -i -A1 "Google Captcha" |tail -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
[ $gc_pfe_stg001 -eq 200 ] && gc_pfe_stg001=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || gc_pfe_stg001=$(echo "$(tput setaf 1)$gc_pfe_stg001 $(tput sgr0)" )
[ $gc_pfe_stg002 -eq 200 ] && gc_pfe_stg002=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || gc_pfe_stg002=$(echo "$(tput setaf 1)$gc_pfe_stg002 $(tput sgr0)" )
[ $gc_pfe_stg003 -eq 200 ] && gc_pfe_stg003=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || gc_pfe_stg003=$(echo "$(tput setaf 1)$gc_pfe_stg003 $(tput sgr0)" )
[ $gc_pfe_stg004 -eq 200 ] && gc_pfe_stg004=$(echo "$(tput setaf 2) UP $(tput sgr0)" ) || gc_pfe_stg004=$(echo "$(tput setaf 1)$gc_pfe_stg004 $(tput sgr0)" )

md_pfe_stg001=$(curl -s `grep -i "^pfe_stg001" input.txt` | grep -i -A4 "Memory Details" |tail -3 | head -1| awk -F ':' '{print $NF}' | awk -F ',' '{print $1}'| awk -F ' ' '{print $2" "$3" "$4" "$5}'| sed 's/\"//')
md_pfe_stg002=$(curl -s `grep -i "^pfe_stg002" input.txt` | grep -i -A4 "Memory Details" |tail -3 | head -1| awk -F ':' '{print $NF}' | awk -F ',' '{print $1}'| awk -F ' ' '{print $2" "$3" "$4" "$5}'| sed 's/\"//')
md_pfe_stg003=$(curl -s `grep -i "^pfe_stg003" input.txt` | grep -i -A4 "Memory Details" |tail -3 | head -1| awk -F ':' '{print $NF}' | awk -F ',' '{print $1}'| awk -F ' ' '{print $2" "$3" "$4" "$5}'| sed 's/\"//')
md_pfe_stg004=$(curl -s `grep -i "^pfe_stg004" input.txt` | grep -i -A4 "Memory Details" |tail -3 | head -1| awk -F ':' '{print $NF}' | awk -F ',' '{print $1}'| awk -F ' ' '{print $2" "$3" "$4" "$5}'| sed 's/\"//')
cpu_pfe_stg001=$(curl -s `grep -i "^pfe_stg001" input.txt` | grep -i -A3 "CPU Details" |tail -2|head -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
cpu_pfe_stg002=$(curl -s `grep -i "^pfe_stg002" input.txt` | grep -i -A3 "CPU Details" |tail -2|head -1| awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
cpu_pfe_stg003=$(curl -s `grep -i "^pfe_stg003" input.txt` | grep -i -A3 "CPU Details" |tail -2|head -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
cpu_pfe_stg004=$(curl -s `grep -i "^pfe_stg004" input.txt` | grep -i -A3 "CPU Details" |tail -2|head -1 | awk -F ':' '{print $NF}' | awk -F ',' '{print $1}')
 

display


