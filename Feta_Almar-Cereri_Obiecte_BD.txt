--Ex11_1 Afisati destinatiile in ordine alfabetica a zborurilor care au pretul la clasa a 2 a mai mic decat 200 si 
--pleaca cu un avion pilotat de Barbu Sebastian

select r.destinatie
from ruta r, zbor z, avion a, angajat e
where r.id_ruta = z.id_ruta and
    z.id_avion = a.id_avion and
    a.id_avion = e.id_avion and
    z.pret_clasa2 < 200 and
    lower(e.nume) = 'barbu' and
    lower(e.prenume) = 'sebastian'
order by r.destinatie;



--Ex11_2 Afisati salariul angajatilor dupa ce se aplica o marire astfel: cei angajati de 195 de luni primesc un bonus de 10%,
--iar cei angajati de 210 luni primesc un bonus de 20%, restul ramanand neschimbat.

select decode(round(months_between(sysdate, data_angajare)), 210, 120*nvl(salariu,0)/100, 195, 110*nvl(salariu,0)/100, nvl(salariu,0))
from angajat;



--Ex11_3 Scrieti o cerere care afiseaza numele departamentelor si suma salariilor angajatilor din acel departament 
--care au salariul maxim mai mare de 5000.
--De asemenea, se vor afisa doar departamentele a caror suma a salariilor este mai mare decat 10000.

with aux as (select d.nume_departament, sum(a.salariu) as suma_salariu
            from angajat a, departament d
            where a.id_departament = d.id_departament
            group by d.nume_departament
            having max(a.salariu) > 5000)
select *
from aux
where suma_salariu > 10000;



--Ex11_4 Afisati numele si prenumele angajatului intr-o singura coloana si cel al departamentului in care lucreaza, pentru cei care
--castiga cat minimul dintr-un job

select concat(a.nume || ' ', a.prenume) as "Nume si prenume", d.nume_departament
from angajat a, departament d
where a.id_departament = d.id_departament and
    a.salariu in (select j.sal_min from job j);
 


--Ex11_5 Sa se afiseze numele angajatilor si cel al departamentelor in care lucreza cei mai slab
--platiti angajati din jobul din care fac parte si pentru acestia sa se afiseze si
--o marire cu 10% pentru cei ce lucreaza in avion

select a1.nume, d.nume_departament, case nvl(a1.id_avion, '0')
                                    when '0' then a1.salariu
                                    else 110*a1.salariu/100
                                    end as "Salariu modificat"
from angajat a1, departament d
where a1.id_departament = d.id_departament and
    a1.salariu = (select min(a2.salariu)
                    from angajat a2
                    where a1.id_job = a2.id_job);



--Ex12_1 Actualizati salariul angajatilor (crestere cu 1000) care lucreaza in departamentul 201

update angajat
set salariu = salariu + 1000
where id_angajat in (select id_angajat
                    from angajat
                    where id_departament = 201);



--Ex12_2 Actualizati zborurile spre Paris sa plece de pe pista 604

update zbor
set id_pista = 604
where id_ruta in (select z.id_ruta
                    from ruta r, zbor z 
                    where z.id_ruta = r.id_ruta and
                    lower(r.destinatie) = 'paris');



--Ex12_3 Actualizati salariul minim al pilotului din tabela job cu valoarea celui mai mic salariu al unui pilot din tabela angajati

update job
set sal_min = (select min(salariu) from angajat where id_job = 101)
where lower(nume_job) = 'pilot';



--Ex13
create sequence seq_loc_parcare
start with 806
maxvalue 810
nocycle
nocache;

insert into parcare
values (seq_loc_parcare.nextval, 'C532');
insert into parcare
values (seq_loc_parcare.nextval, 'D345');
insert into parcare
values (seq_loc_parcare.nextval, 'E123');
insert into parcare
values (seq_loc_parcare.nextval, 'E456');
insert into parcare
values (seq_loc_parcare.nextval, 'F789');

select * from parcare;



--Ex16_1 Sa se afiseze numele angajatilor, numele departamentului in care lucreaza, cel al jobului si compania aeriana
--a avionului in care lucreaza. Se vor afisa si cei care nu au asociat un avion, un departament sau un job.

select a.nume, d.nume_departament, j.nume_job, av.companie_aeriana
from angajat a, job j, departament d, avion av
where a.id_job = j.id_job(+) and
    a.id_departament = d.id_departament(+) and
    a.id_avion = av.id_avion(+);



