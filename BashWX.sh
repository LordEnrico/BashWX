# You Will need to replace anything that point to Miami FL with your local WFO
# Honestly just use common sense and replace anything that looks like it needs replacing.
# You may also need to change some of the formatting depending on your local WFO


# Generate

curl -s -o forecast.xml "https://forecast.weather.gov/product.php?site=CRH&issuedby=MFL&product=ZFP&format=TXT&version=1"

curl -s -o hazards.xml "https://forecast.weather.gov/product.php?site=CRH&issuedby=MFL&product=HWO&format=TXT&version=1"

curl -s -o surf.xml "https://forecast.weather.gov/product.php?site=CRH&issuedby=MFL&product=SRF&format=TXT&version=1"

sed -n '/National Weather Service Miami FL/,/$$/p;  /$$/q' hazards.xml | head -n -5 | tail -n +26 - | ./mimic1/mimic - -voice ./mimic1/rms.flitevox -o hazards.wav

sed -n '/000/,/$$/p;  /$$/q' forecast.xml | head -n -2 | tail -n +13 - | ./mimic1/mimic - -voice ./mimic1/rms.flitevox -o forecast.wav

sed -n '/000/,/&&/p;  /&&/q' surf.xml | head -n -2 | tail -n +13 - | tr -d '*' | ./mimic1/mimic - -voice ./mimic1/rms.flitevox -o surf.wav

echo "You are listening to INSERT CALLSIGN HERE Weather Radio All Hazards. Station INSERT CALLSIGN HERE dash W X, serving the Greater Miami Dade area, and broadcasting under Internet Protocol at https://github.com/libmarleu/BashWX." | flite -voice kal16 --ssml -f - -o stationid.wav

echo "This station is a participant of the International Weather Broadcasting Network. More information about I W B N can be found at, w w w dot, w x stream dot org, slash I W B N." | flite -voice kal16 --ssml -f - -o stationid2.wav

echo "A full station information card for this station can be found at, w w w dot alt f m, dot, w x radio dot org." | flite -voice kal16 --ssml -f - -o stationid3.wav

echo "Please note, This station is not an official NOAA Weather Radio Station. The official N W R Transmitter INSERT LOCAL WXR CALLSIGN, can be found on a frequency of INSERT WXR FREQ Megahertz using a weather radio." | flite -voice kal16 --ssml -f - -o stationid4.wav

date +"The Current Time is. "%H." "%M." Eastern Standard Time." | flite -voice kal16 --ssml -f - -o time.wav

echo "Here is the official National Weather Service Forcast for Miami-Dade and surrounding areas." | ./mimic1/mimic - -voice ./mimic1/rms.flitevox -o forcastid.wav

echo "Here is the official National Weather Service Hazardous Weather Outlook for Miami-Dade and surrounding areas." | ./mimic1/mimic - -voice ./mimic1/rms.flitevox -o  hazardsid.wav

echo "Here is the official National Weather Service Surf Forcast for the greater Miami-Dade area" | ./mimic1/mimic - -voice ./mimic1/rms.flitevox -o  surfid.wav

# Playback

aplay "stationid.wav"
sleep 1
aplay "stationid2.wav"
sleep 1
aplay "stationid3.wav"
sleep 1
aplay "stationid4.wav"
sleep 3
aplay "time.wav"
sleep 5
aplay "forcastid.wav"
sleep 3
aplay "forecast.wav"
sleep 3
aplay "hazardsid.wav"
sleep 3
aplay "hazards.wav"
sleep 3
aplay "surfid.wav"
sleep 3
aplay "surf.wav"
