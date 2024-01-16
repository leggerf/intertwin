wget -nc https://repo.data.kit.edu/data-kit-edu-rockylinux9.repo
wget -nc https://repository.egi.eu/sw/production/cas/1/current/repo-files/egi-trustanchors.repo

cp $HOME/.globus/usercert.pem .
cp $HOME/.globus/userkey.pem .

docker build --progress plain --tag rucio-intertwin .

rm -f usercert.pem
rm -f userkey.pem
