jackdmp -d coreaudio &
sleep 1
icecast -c ./icecast.xml &
sleep 1
darkice -c ./darkice.cfg &
sleep 1
ipconfig getifaddr en0
ipconfig getifaddr en1