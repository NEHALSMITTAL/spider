#!/bin/bash
Generateuser() {
local user=${1}
local username=${2}
local wing=${3}
local homedirectory=”./${username}”

sudo mkdir -p “${homedirectory}”

if [ [$user == ”doctor” ]]; then
sudo touch “${homedirectory}/Available.txt”
sudo touch “${homedirectory}/appointment.txt”
elif [[$user == “patient”]]; then
sudo touch “${homedirectory}/patientdetails.txt”
sudo touch “${homedirectory}/prescription.txt”
elif [[$user == “wingadmin”]];then
sudo mkdir -p “${homedirectory}/patient”
sudo mkdir -p “${homedirectory}/doctor”
sudo mkdir -p “${homedirectory}/doctor/indoctor.txt”
sudo mkdir -p “${homedirectory}/patient/inpatient.txt”

fi 
}
Setpermissions () {
local user=${1}
local username=${2}
local homedirectory=${3}
local wing =${4}

if [[ $user == ”doctor” ]];then
sudo chmod 600  “${homedirectory}/Available.txt”
sudo chmod 600  “${homedirectory}/appointment.txt”
sudo chmod 600  “${homedirectory}/prescription.txt”
sudo chmod 400  “${homedirectory}/patientdetails.txt”
sudo chmod 600 “${homedirectory}/doctor/indoctor.txt”

elif [[$user == “patient”]]; then
sudo chmod  600 “${homedirectory}/patientdetails.txt”
sudo chmod  400 “${homedirectory}/appointment.txt”
sudo chmod  600 “${homedirectory}/patient/inpatient.txt”


elif [[$user == “wingadmin”]];then
sudo chmod 700 “${homedirectory}/patient”
sudo chmod 700 “${homedirectory}/doctor”
sudo chmod 600 “${homedirectory}/doctor/indoctor.txt”
sudo chmod 600 “${homedirectory}/patient/inpatient.txt”
fi 
}

bookappointment() {
local doctorusername =${1}
local patientusername=${2}
local appointment=”./${3}”
local doctorhome=”./${4}”


grep -q “$appointment “ “$doctorhome/available.txt”

if [[$?  -eq  0 ]]; then 
grep -q “$appointment”   “$doctorhome/appointment.txt”
if [[$? -eq 0 ]];then
echo “slot is already booked .“
else
echo “$appointment” >> “$doctorhome/appointment.txt”
echo “$doctorusername : $appointment” >> ”$patienthome/inpatient.txt
echo “appointment booked.”
Fi
else
echo “no appointment slot”
fi 
}

#doctors user
Sudo useradd -m -d  “doctor” “doctor1” “wing1”
Sudo useradd -m -d “doctor”  “doctor2” “wing2”
Sudo useradd -m -d “doctor”  “doctor3” “wing3”
Sudo useradd -m -d “patient”  “patient1” “wing1”
Sudo useradd -m -d “patient”  “patient2” “wing2”
Sudo useradd -m -d  “wing”

done
