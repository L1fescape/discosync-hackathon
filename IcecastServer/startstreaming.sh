jackdmp -d coreaudio &
sleep 2
icecast -c ./icecast.xml &
sleep 2
darkice -c ./darkice.cfg &
sleep 2
ipconfig getifaddr en0
ipconfig getifaddr en1