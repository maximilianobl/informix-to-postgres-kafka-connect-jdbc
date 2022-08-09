. /home/informix/.bashrc
dbaccess -e testdb << EOF
select * from test;
EOF
