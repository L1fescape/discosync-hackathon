jackdmp -d coreaudio &
sleep 2
icecast -c ./icecast.xml &
sleep 2
darkice -c ./darkice.cfg &