#!/bin/bash

diagnose_patient() {
  local doctor_username=${1}
  local patient_username=${2}
  local diagnosis=${3}
  local prescription=${4}
  local doctorhome="./${doctorusername}"
  local patienthome="./${patientusername}"


  echo "$(date '+%Y-%m-%d %H:%M:%S') - ${diagnosis}" >> "${patienthome}/patientdetails.txt"


  echo -e "$prescription\n" >> "${doctorhome}/prescription.txt"

  echo "Diagnosis and prescription added."
}


allot_room() {
  local wingadminusername=$1
  local patientusername=$2
  local doctorusername=$3
  local wingadminhome="./${wingadminusername}"
  local patienthome="./${patientusername}"
  local doctorhome="./${doctorusername}"


  local targetwing="${wingadminhome}"
  if [[ ${diagnosis} == "critical" ]]; then
    targetwing="./${doctorusername}"
  fi


  local numpatients=$(wc -l < "${targetwing}/patient/inpatient.txt")
  local numinfectious=$(grep -c "infectious" "${targetwing}/patient/inpatient.txt")
  local nummental=$(grep -c "mental" "${targetwing}/patient/inpatient.txt")


  if [[ $numpatients -ge 10 ]]; then
    echo "The wing is full."
    return
  fi


  if [[ $diagnosis == "infectious" && $numinfectious -ge 4 ]]; then
    echo "The wing cannot accommodate more infectious patients."
    return
  elif [[ $diagnosis == "mental" && $nummental -ge 3 ]]; then
    echo "The wing cannot accommodate more mental patients."
    return
  fi


  if [[ $diagnosis == "infectious" && $numinfectious -ge 2 && $nummental -ge 1 ]]; then
    echo "The wing crosses the number  of patients  more than two infectious patients with a mental person. Reallocating patients..."
    oldestpatient=$(head -n 1 "${targetwing}/patient/inpatient.txt")
    if [[ -n $oldestpatient ]]; then

      local targetwingname="${targetwing##*/}"
      local newwing
      if [[ ${targetwingname} == "wing1" ]]; then
        new_wing="./wing2"
      else
        new_wing="./wing1"
      fi
      echo "$oldestpatient" >> "$newwing/patient/inpatient.txt"
      sed -i "1d" "$targetwing/patient/inpatient.txt"
      echo "Oldest patient moved to $newwing."
    fi
  fi
  echo "$patientusername" >> "$targetwing/patient/inpatient.txt"
  echo "Room allotted to patient."
}
sudo useradd -m -d "wingadmin" "wingadmin1" "wing1"
sudo useradd -m -d "wingadmin" "wingadmin2" "wing2"
 done
