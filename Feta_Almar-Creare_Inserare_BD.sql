create table JOB (
    id_job number(4) constraint pk_job primary key,
    nume_job varchar2(20) constraint null_nume_job not null,
    sal_min number(8,2),
    sal_max number(8,2)
    );
    
create table DEPARTAMENT (
    id_departament number(4) constraint pk_departament primary key,
    nume_departament varchar2(20) constraint null_nume_departament not null
    );
    
create table HANGAR (
    id_hangar number(4) constraint pk_hangar primary key,
    cod_hangar varchar2(10) constraint null_cod_hangar not null
    );
    
create table RUTA (
    id_ruta number(4) constraint pk_ruta primary key,
    destinatie varchar2(20) constraint null_destinatie not null,
    distanta number(6,2)
    );
    
create table PISTE (
    id_pista number(4) constraint pk_pista primary key,
    cod_pista varchar2(10) constraint null_cod_pista not null
    );
    
create table PORTI (
    id_poarta number(4) constraint pk_poarta primary key,
    numar varchar2(10) constraint null_numar not null
    );
    
create table PARCARE (
    id_parcare number(4) constraint pk_parcare primary key,
    numar_loc varchar2(10) constraint null_numar_loc not null
    );
    
create table TRANSPORT (
    id_transport number(4) constraint pk_transport primary key,
    tip_vehicul varchar2(10) constraint null_tip_vehicul not null,
    nr_locuri number(2)
    );    
    
create table AVION (
    id_avion varchar2(10) constraint pk_avion primary key,
    tip_avion varchar2(20) constraint null_tip_avion not null,
    companie_aeriana varchar2(20) constraint null_companie_aeriana not null,
    id_hangar number(4),
    constraint fk_id_hangar foreign key(id_hangar) references HANGAR(id_hangar)
    );
    
create table ANGAJAT (
    id_angajat number(4) constraint pk_angajat primary key,
    nume varchar2(20) constraint null_nume not null,
    prenume varchar2(20) constraint null_prenume not null,
    CNP number(13) constraint null_cnp not null,
    data_angajare date default sysdate constraint null_data_angajare not null,
    salariu number(8,2),
    email varchar2(30),
    telefon number(15),
    id_departament number(4),
    id_job number(4) constraint null_id_job not null,
    id_avion varchar2(10),
    constraint fk_id_departament foreign key(id_departament) references DEPARTAMENT(id_departament),
    constraint fk_id_job foreign key(id_job) references JOB(id_job),
    constraint fk_id_avion foreign key(id_avion) references AVION(id_avion)
    );
    
create table ISTORIC (
    id_istoric number(4) constraint pk_istoric primary key,
    id_angajat number(4) constraint null_id_angajat not null,
    id_avion varchar2(10) constraint null_id_avion not null,
    data_inceput date default sysdate,
    data_sfarsit date default sysdate,
    constraint fk_id_angajat foreign key(id_angajat) references ANGAJAT(id_angajat),
    constraint fk_id_avion_istoric foreign key(id_avion) references AVION(id_avion)
    );
    
create table ZBOR (
    id_zbor varchar2(10) constraint pk_zbor primary key,
    data_plecare date default sysdate constraint null_data_plecare not null,
    data_sosire date default sysdate constraint null_date_sosire not null,
    pret_clasa1 number(6,2),
    pret_clasa2 number(6,2),
    id_avion varchar2(10) constraint null_id_avion_zbor not null,
    id_ruta number(4) constraint null_id_ruta not null,
    id_pista number(4) constraint null_id_pista not null,
    id_poarta number(4) constraint null_id_poarta not null,
    constraint fk_id_avion_zbor foreign key(id_avion) references AVION(id_avion),
    constraint fk_id_ruta foreign key(id_ruta) references RUTA(id_ruta),
    constraint fk_id_pista foreign key(id_pista) references PISTE(id_pista),
    constraint fk_id_poarta foreign key(id_poarta) references PORTI(id_poarta)
    );
    
create table CLIENT (
    id_client number(4) constraint pk_client primary key,
    nume varchar(20) constraint null_nume_client not null,
    prenume varchar(20) constraint null_prenume_client not null,
    CNP number(13) constraint null_cnp_client not null,
    telefon number(15),
    id_zbor varchar2(10) constraint null_id_zbor not null,
    id_parcare number(4),
    id_transport number(4),
    constraint fk_id_zbor foreign key(id_zbor) references ZBOR(id_zbor),
    constraint fk_id_parcare foreign key(id_parcare) references PARCARE(id_parcare),
    constraint fk_id_transport foreign key(id_transport) references TRANSPORT(id_transport)
    );
    
create table BAGAJE (
    id_bagaj number(4) constraint pk_bagajt primary key,
    tip_bagaj varchar2(10) constraint null_tip_bagaj not null,
    id_client number(4) constraint null_id_client not null,
    greutate number(4,2),
    constraint fk_id_clinet foreign key(id_client) references CLIENT(id_client)
    );
    
create table BILET (
    id_bilet number(4) constraint pk_bilet primary key,
    id_zbor varchar2(10) constraint null_zbor_bilet not null,
    id_client number(4) constraint null_client_bilet not null,
    constraint fk_id_zbor_bilet foreign key(id_zbor) references ZBOR(id_zbor),
    constraint fk_id_client_bilet foreign key(id_client) references CLIENT(id_client)
    );




insert into JOB
values (101, 'Pilot', 8000, 15000);
insert into JOB
values (102, 'Insotitor de zbor', 3000, 8000);
insert into JOB
values (103, 'Controlor de zbor', 10000, 20000);
insert into JOB
values (104, 'Vames', 3000, 9000);
insert into JOB
values (105, 'Casier', 2000, 5000);

insert into DEPARTAMENT
values (201, 'Deplasari');
insert into DEPARTAMENT
values (202, 'Control trafic si IT');
insert into DEPARTAMENT
values (203, 'Securitate');
insert into DEPARTAMENT
values (204, 'Vanzari');
insert into DEPARTAMENT
values (205, 'Administrare');

insert into HANGAR
values (301, 'H100');
insert into HANGAR
values (302, 'H230');
insert into HANGAR
values (303, 'H483');
insert into HANGAR
values (304, 'H500');
insert into HANGAR
values (305, 'H345');

insert into AVION
values ('B_101', 'Boeing', 'WizzAir', 301);
insert into AVION
values ('B_102', 'Boeing', 'BlueAir', 303);
insert into AVION
values ('AB_103', 'AirBus', 'Lufthansa', 301);
insert into AVION
values ('AB_104', 'AirBus', 'Emirates', 302);
insert into AVION
values ('B_105', 'AirBus', 'Tarom', null);

insert into ANGAJAT
values (401, 'Barbu', 'Sebastian', 5010101132843, to_date('12.02.2005','dd-mm-yyyy'), 10000, null, 40767823456, 201, 101, 'B_102');
insert into ANGAJAT
values (402, 'Ciuraru', 'Mihai', 5010202132854, to_date('02.12.2006','dd-mm-yyyy'), 3000, 'ciurarumihai@gmail.com', null, 203, 104, null);
insert into ANGAJAT
values (403, 'Nedelcu', 'Andrei', 5010303132865, to_date('15.06.2005','dd-mm-yyyy'), 20000, 'nedelcuandrei@yahoo.com', 40753467876, 202, 103, null);
insert into ANGAJAT
values (404, 'Toader', 'Gabriala', 6010405132854, to_date('23.11.2003','dd-mm-yyyy'), 7000, null, null, 201, 102, 'AB_104');
insert into ANGAJAT
values (405, 'Dan', 'Ioana', 6010606132812, to_date('30.11.2005', 'dd-mm-yyyy'), 5000, 'ioanadan@gmail.com', 40782345678, 204, 105, null);

insert into ISTORIC
values (1, 401, 'B_101', to_date('12.02.2005', 'dd-mm-yyyy'), to_date('13.04.2006', 'dd-mm-yyyy'));
insert into ISTORIC
values (2, 401, 'AB_103', to_date('13.04.2006', 'dd-mm-yyyy'), to_date('20.12.2008', 'dd-mm-yyyy'));
insert into ISTORIC
values (3, 401, 'B_105', to_date('20.12.2008', 'dd-mm-yyyy'), to_date('26.10.2016', 'dd-mm-yyyy'));
insert into ISTORIC
values (4, 404, 'AB_103', to_date('23.11.2003', 'dd-mm-yyyy'), to_date('12.06.2006', 'dd-mm-yyyy'));
insert into ISTORIC
values (5, 404, 'B_105', to_date('12.06.2006', 'dd-mm-yyyy'), to_date('27.08.2014', 'dd-mm-yyyy'));

insert into RUTA
values (501, 'Roma', 1500);
insert into RUTA
values (502, 'Paris', 2000);
insert into RUTA
values (503, 'Moscova', 3000);
insert into RUTA
values (504, 'Madrid', 2500);
insert into RUTA
values (505, 'Dubai', 5000);

insert into PISTE
values (601, 'P_433');
insert into PISTE
values (602, 'P_656');
insert into PISTE
values (603, 'P_545');
insert into PISTE
values (604, 'P_123');
insert into PISTE
values (605, 'P_762');

insert into PORTI
values (701, 'A');
insert into PORTI
values (702, 'B');
insert into PORTI
values (703, 'C');
insert into PORTI
values (704, 'D');
insert into PORTI
values (705, 'E');

insert into ZBOR
values ('Z_101', to_date('12.02.2021', 'dd-mm-yyyy'), to_date('12.02.2021', 'dd-mm-yyyy'), 200, 100, 'B_101', 501, 601, 701);
insert into ZBOR
values ('Z_102', to_date('02.04.2021', 'dd-mm-yyyy'), to_date('03.04.2021', 'dd-mm-yyyy'), 250, 150, 'B_102', 502, 602, 702);
insert into ZBOR
values ('Z_103', to_date('14.10.2021', 'dd-mm-yyyy'), to_date('14.10.2021', 'dd-mm-yyyy'), 300, 150, 'B_105', 504, 602, 703);
insert into ZBOR
values ('Z_104', to_date('13.11.2021', 'dd-mm-yyyy'), to_date('15.11.2021', 'dd-mm-yyyy'), 400, 200, 'AB_104', 503, 603, 704);
insert into ZBOR
values ('Z_105', to_date('25.09.2021', 'dd-mm-yyyy'), to_date('26.09.2021', 'dd-mm-yyyy'), 500, 300, 'AB_103', 505, 605, 705);

insert into PARCARE
values (801, 'A101');
insert into PARCARE
values (802, 'B201');
insert into PARCARE
values (803, 'A110');
insert into PARCARE
values (804, 'B202');
insert into PARCARE
values (805, 'C300');

insert into TRANSPORT
values (901, 'Autobuz', 50);
insert into TRANSPORT
values (902, 'Autobuz', 30);
insert into TRANSPORT
values (903, 'Microbuz', 15);
insert into TRANSPORT
values (904, 'Microbuz', 10);
insert into TRANSPORT
values (905, 'Taxi', 5);

insert into CLIENT
values (1001, 'Ion', 'George', 5010203040506, 40712345678, null, 801, 905);
insert into CLIENT
values (1002, 'Vrinceanu', 'Costin', 5010203123456, 40712365478, null, null, 901);
insert into CLIENT
values (1003, 'Matei', 'Elena', 6010203040534, null, null, null, 901);
insert into CLIENT
values (1004, 'Blenche', 'Roxana', 6010203032506, 40712312378, null, null, null);
insert into CLIENT
values (1005, 'Belei', 'Ionut', 5010203032506, null, null, 804, null);

insert into BAGAJE
values(1101, 'De cala', 1001, 30);
insert into BAGAJE
values(1102, 'De cala', 1002, 24);
insert into BAGAJE
values(1103, 'Geanta', 1001, 5);
insert into BAGAJE
values(1104, 'Geanta', 1003, 3);
insert into BAGAJE
values(1105, 'De cala', 1004, 20);

insert into BILET
values (1201, 'Z_101', 1001);
insert into BILET
values (1202, 'Z_101', 1002);
insert into BILET
values (1203, 'Z_102', 1003);
insert into BILET
values (1204, 'Z_102', 1004);
insert into BILET
values (1205, 'Z_103', 1005);
insert into BILET
values (1206, 'Z_103', 1001);
insert into BILET
values (1207, 'Z_104', 1002);
insert into BILET
values (1208, 'Z_105', 1003);
insert into BILET
values (1209, 'Z_105', 1004);
insert into BILET
values (1210, 'Z_105', 1005);

    
