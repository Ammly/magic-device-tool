clear
echo ""
echo "Installing AOSP 7.1 Nougat - 24/11/2016 (Rom by @Santhosh M) without Gapps"
echo ""
sleep 1
echo "Please boot your Nexus 5 into bootloader/fastboot mode by pressing Power & Volume Down (-)"
echo ""
sleep 1
echo -n "Is your Nexus 5 in bootloader/fastboot mode now? [Y] "; read bootloadermode
if [ "$bootloadermode"==Y -o "$bootloadermode"==y -o "$bootloadermode"=="" ]; then
  clear
  echo ""
  echo "Detecting device"
  echo ""
  sleep 1
  fastboot devices > /tmp/AttachedDevices
fi
if grep 'device$\|fastboot$' /tmp/AttachedDevices
then
  echo "Device detected !"
  sleep 1
  clear
  fastboot format cache
  fastboot format userdata
  fastboot reboot-bootloader
  sleep 6
  clear
  echo ""
  echo "Downloading TWRP recovery"
  echo ""
  wget -c --quiet --show-progress --tries=10 http://people.ubuntu.com/~misterq/magic-device-tool/recoverys/twrp-3.0.2-0-hammerhead.img
  sleep 1
  echo ""
  echo "Downloading AOSP 7.1 Nougat.."
  echo ""
  sleep 1
  one=$(wget -c --quiet --show-progress --tries=10 http://tx2.androidfilehost.com/dl/E2CWds7grXLm3KrdR2zelw/1480566537/385035244224401091/aosp_hammerhead-7.1-nougat-20161124.zip)
    if [[ $one != 0 ]]; then
        echo "Error downloading file. Trying another server."
        sleep 1

        two=$(wget -c --quiet --show-progress --tries=10 https://de1.androidfilehost.com/dl/pBMf2gaTDYvQ5VAk1ajjig/1480566532/385035244224401091/aosp_hammerhead-7.1-nougat-20161124.zip)
        if [[ $two != 0 ]]; then
            echo "Error downloading file. Trying another server." 
            sleep 1

            three=$(wget -c --quiet --show-progress --tries=10 https://va1.androidfilehost.com/dl/E2CWds7grXLm3KrdR2zelw/1480566537/385035244224401091/aosp_hammerhead-7.1-nougat-20161124.zip)
            if [[ $three != 0 ]]; then
                echo "Error downloading file. Trying another server." 
                sleep 1

                four=$(wget -c --quiet --show-progress --tries=10 http://qc4.androidfilehost.com/dl/H65mFP55ekUIdRqWpm54-Q/1480566535/385035244224401091/aosp_hammerhead-7.1-nougat-20161124.zip)
                if [[ $four != 0 ]]; then
                    echo "Error downloading file. Trying another server." 
                    sleep 1

                    five=$(wget -c --quiet --show-progress --tries=10 https://tx1.androidfilehost.com/dl/wHmH_IBQlIX0j0xw7Azk0w/1480566536/385035244224401091/aosp_hammerhead-7.1-nougat-20161124.zip)
                    if [[ $five != 0 ]]; then
                        echo "Error downloading file. Exiting..." 
                        exit
                        sleep 1
                    else
                        echo "Success. Cont"
                        sleep 1
                    fi    
                else
                    echo "Success. Cont"
                    sleep 1
                fi   
            else
                echo "Success. Cont"
                sleep 1
            fi   
        else
            echo "Success. Cont"
            sleep 1
        fi  
    else
        echo "Success. Cont"
        sleep 1
    fi
  echo ""
  sleep 2
  clear
  echo ""
  echo "Installing TWRP recovery"
  echo ""
  fastboot flash recovery twrp-3.0.2-0-hammerhead.img
  sleep 1
  echo ""
  echo "Rebooting device.."
  echo ""
  echo "This will take ~35 seconds. Don't disconnect your device!"
  echo ""
  fastboot reboot-bootloader
  sleep 7
  fastboot boot twrp-3.0.2-0-hammerhead.img
  sleep 7
  adb reboot recovery
  sleep 15
  echo ""
  clear
  echo ""
  echo "Pushing zip's to device"
  sleep 1
  echo ""
  echo "Please wait this can take a while"
  echo ""
  echo "You may see a prompt asking you for read/write permissions"
  echo "Ignore that prompt, the tool will take care of the installation"
  echo ""
  echo "  → AOSP 7.1 Nougat zip "
  adb push -p aosp_hammerhead-7.1-nougat-20161124.zip /sdcard/
  echo ""
  echo "========================================="
  sleep 1
  echo ""
  echo "Installing AOSP 7.1 Nougat (By Santhosh M).."
  echo ""
  adb shell twrp install /sdcard/aosp_hammerhead-7.1-nougat-20161124.zip
  sleep 1
  echo ""
  echo "Wipe cache.."
  echo ""
  adb shell twrp wipe cache
  adb shell twrp wipe dalvik
  echo ""
  adb reboot
  echo "The device is now rebooting. Give it time to flash the new ROM. It will boot on its own."
  echo ""
  sleep 5
  echo ""
  echo "Cleaning up.."
  rm -f /tmp/AttachedDevices
  echo ""
  sleep 1
  echo "Exiting script. Bye Bye"
  sleep 1

else
  echo "Device not found"
  rm -f /tmp/AttachedDevices
  sleep 1
  echo ""
  echo "Back to menu"
  sleep 1
  . ./launcher.sh
fi
