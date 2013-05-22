data=`curl --silent "http://weather.yahooapis.com/forecastrss?w=2362930&u=f"`
data2=`curl --silent "http://weather.yahoo.com/united-states/connecticut/storrs-12760328/" | grep "forecast-icon" | sed "s/.*background\:url(\'\(.*\)\')\;\ _background.*/\1/" | xargs curl --silent -o /tmp/weather.png'

style="background:url('http://l.yimg.com/os/mit/media/m/weather/images/icons/l/11n-100567.png') no-repeat
id="obs-current-weather" style="background:url('http://l.yimg.com/os/mit/media/m/weather/images/icons/l/26n-100567.png

img=`echo $data | sed "s/.*CDATA\[ <img src=\"\(.*gif\).*/\1/"`
echo $data | sed "s/.*Conditions\:<\/b><br \/>\([^\<]*\)<BR \/>.*/\1/"|sed "s/^ //"
curl --silent -o /tmp/weather.gif $img
echo $desc
