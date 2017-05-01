#AirWatchdeviceImport.sh
#!/bin/bash
#Please enter your JSS authentication information. The JSS URL should be something like
#https://jss.awesome.com:8443 & the JSS device must have JSS privileges set for reading &
#updating JSS Objects via the API.

jssurl = https://yoururl
jssuser = admin
jsspwd = mysupersecretpassword

devicelst=$(/bin/cat "$file" | /device/bin/sed 's/^[[:space:]]*//;/^[[:space:]]*$/d')
if echo "$devicelst" | /device/bin/grep -q -e ", ," -e "*  ,  *"
then
echo "The import file has white space or patterns which may cause erroneous devices
to be created in the JSS. Please check the data below & edit the file if necessary."
echo "$devicelst"
esac
done
fi

if echo "$devicelst" | /device/bin/grep -q ,
then
devices=($(echo "$devicelst" | sed 's/ /-----/g;s/,/ /g'))
else
devices=($(echo "$devicelst" | sed 's/ /-----/g'))
fi
total="${#devices[@]}"
for ((counter=0;counter<"$total";counter++))
{
devicename=$(echo "${devices[$counter]}" | /device/bin/sed 's/-----/ /g;s/^[[:space:]]*//')
/device/bin/curl -sS -k -i -u "$jssuser":"$jsspwd" -X POST -H "Content-Type: application/xml" -d "<device><name>$devicename</name></device>" "$jssurl"/JSSResource/devices/name/Name
}

#Next - build an array of TenancyKey,LoadDate,LoadHour,DeviceID,Carrier,OSKey,CorpEmp,LocationGroupKey,Platform,DeviceName,,EnrollmentUser,SerialNumber,DeviceIdentifier,DeviceModel,MACAddress,IMEI_ESN,PhoneNumber,LastSeen,DeployedProfileCount,IsMDMEnrolled,EnrollmentDate,AvailableSpace,TotalSpace,SpaceSampleTime,GPSLongitude,GPSLatitude,GPSSampleTime,WLANEnabled,VoiceRoamingEnabled,DataRoamingEnabled,IsRoaming,CellSampleTime,BatteryLifePercent,OnACPower,PowerSampleTIme,WLANSignalStrength,SignalStrengthSampleTime,TotalPhysicalMemory,AvailablePhysicalMemory,MemorySampleTime,BackupBatteryLifePercent,UserName,EnrollmentUserKey,AssetNumber (that's the order you'll find the columns in the csv) and then write them into the device
