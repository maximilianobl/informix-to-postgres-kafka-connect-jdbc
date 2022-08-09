. /home/informix/.bashrc
dbaccess -e testdb << EOF
insert into test (id, first_name) values (test_id_seq.NEXTVAL, 'Maximiliano');

insert into test (id, first_name) values (test_id_seq.NEXTVAL, 'Luciano');

insert into test_increm (id, first_name) values (test_increm_id_seq.NEXTVAL, 'Jorge');

insert into test_increm (id, first_name) values (test_increm_id_seq.NEXTVAL, 'sol');

update test_increm set first_name = "Soledad", update_ts = (select CURRENT TIMESTAMP) where first_name= 'sol';

insert into test_increm (id, first_name) values (test_increm_id_seq.NEXTVAL, 'Ignacio');

update test_increm set first_name = "Juan Ignacio", update_ts = (select CURRENT TIMESTAMP) where first_name= 'Ignacio';
EOF
