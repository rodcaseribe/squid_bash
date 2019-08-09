ls -Fltr | cut -c47-65 > lista
sed 's/^/rm -rf /' lista > lista2
./lista2
