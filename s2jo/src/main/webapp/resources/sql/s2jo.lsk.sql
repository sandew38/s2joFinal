select *
from tab;

create table final_traininfo
( traintype     number(2)  not null      -- 기차종류 (1: ktx, 2: 3: )
, trainno       number    not null     -- 열차번호
, perminuterate number  not null    -- 분당운임 
, constraint PK_final_traininfo_trainno Primary key (trainno)
, constraint CK_final_traininfo_traintype check (traintype in ( 1,2,3)) 
);

drop sequence seq_traincode;

create sequence seq_traincode
start with 1
increment by 1
nomaxvalue
nominvalue
nocache
nocycle;

insert into final_traininfo (traintype, trainno, perminuterate)
values(1, 101, 380);

insert into final_traininfo (traintype, trainno, perminuterate)
values( 1, 271, 380);

insert into final_traininfo (traintype, trainno, perminuterate)
values(1, 103, 380);

insert into final_traininfo (traintype, trainno, perminuterate)
values(1, 105, 380);

insert into final_traininfo (traintype, trainno, perminuterate)
values(1, 201, 380);

insert into final_traininfo (traintype, trainno, perminuterate)
values(1, 282, 380);

insert into final_traininfo (traintype, trainno, perminuterate)
values(1, 202, 380);

insert into final_traininfo (traintype, trainno, perminuterate)
values(1, 276, 380);

insert into final_traininfo (traintype, trainno, perminuterate)
values(1, 284, 380);

insert into final_traininfo (traintype, trainno, perminuterate)
values( 1, 102, 380);

select *
from final_traininfo;

commit;

-- drop table final_runinfo;

create table final_runinfo 
(runinfoseq           number    not null  -- 운행정보 시퀀스
, trainno               number   not null   -- 열차번호
, departure           varchar2(20)  not null   -- 출발지
, departuretime     varchar2(20)   not null   -- 출발시각
, arrival               varchar2(20)   not null   -- 도착지
, arrivaltime         varchar2(20)    not null  -- 도착시간
, constraint PK_final_runinfo_runinfoseq Primary Key (runinfoseq)
, constraint FK_final_runinfo_trainno Foreign Key (trainno)
                                              references final_traininfo (trainno)
);
-- drop sequence runinfoseq;
create sequence runinfoseq
start with 1
increment by 1
nominvalue
nomaxvalue
nocache
nocycle;

select runinfoseq, trainno, departure, departuretime, arrival, arrivaltime
from final_runinfo;

select count(*)
from final_runinfo;

commit;

-- 소요시간 뽑아서 장 당 가격 뽑기!!! 성공!!!!
select trainno, traintype, departure, departuretime, arrival, arrivaltime
        , case when (substr(turnaroundtime,1,2) >0) then hour*60+min else min end as turnaroundrate
        , perminuterate
        , case when (substr(turnaroundtime,1,2) >0) then hour*60+min else min end  * perminuterate as rate
from 
(
  select trainno, traintype, departure, departuretime, arrival, arrivaltime
          , turnaroundtime
          , hour, min
          , perminuterate
  from
    (
      select A.trainno, departure, departuretime, arrival, arrivaltime 
              , case when traintype = 1 then 'KTX' else '무궁화' end as traintype, B.Perminuterate
              , to_number(arrivaltime)-to_number(departuretime) as turnaroundtime
              , substr(arrivaltime,1,2) - substr(departuretime,1,2) as hour
              , substr(arrivaltime,3,4) - substr(departuretime,3,4) as min
      from final_runinfo A join Final_Traininfo B
      on A.Trainno = B.Trainno
    )
 )T;

create or replace view trainview
as (
select trainno, traintype, departure, departuretime, arrival, arrivaltime
        , case when (substr(turnaroundtime,1,2) >0) then hour*60+min else min end as turnaroundtime
        , perminuterate
        , case when (substr(turnaroundtime,1,2) >0) then hour*60+min else min end  * perminuterate as rate
from 
(
  select trainno, traintype, departure, departuretime, arrival, arrivaltime
          , turnaroundtime
          , hour, min
          , perminuterate
  from
    (
      select A.trainno, departure, departuretime, arrival, arrivaltime 
              , case when traintype = 1 then 'KTX' else '무궁화' end as traintype, B.Perminuterate
              , to_number(arrivaltime)-to_number(departuretime) as turnaroundtime
              , substr(arrivaltime,1,2) - substr(departuretime,1,2) as hour
              , substr(arrivaltime,3,4) - substr(departuretime,3,4) as min
      from final_runinfo A join Final_Traininfo B
      on A.Trainno = B.Trainno
    )
 )T
 );

select *
from trainview;

select trainno, traintype, departure, departuretime, arrival, arrivaltime, turnaroundtime, perminuterate, rate
from trainview;

commit;


-- 기차 운행정보 insert

 ------------------ 101번 기차 ----------------- 
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval,101,'서울','0515','광명','0531');


 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval,101,'서울','0515','대전','0612');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval,101,'서울','0515','동대구','0658');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval,101,'서울','0515','부산','0751');

insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval,101,'광명','0531','대전','0612');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval,101,'광명','0531','동대구','0658');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval,101,'광명','0531','부산','0751');

 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 101,'대전','0612','동대구','0658');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 101,'대전','0612','부산','0751');
 
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 101,'동대구','0658','부산','0751');

------------------ 101번 기차 -----------------



------------------ 271번 기차 -----------------
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 271,'서울','0520','광명','0536');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 271,'서울','0520','대전','0617');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 271,'서울','0520','동대구','0703');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 271,'서울','0520','부산','0811');

insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 271,'광명','0536','대전','0617');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 271,'광명','0536','동대구','0703');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 271,'광명','0536','부산','0811');
 
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 271,'대전','0617','동대구','0703');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 271,'대전','0617','부산','0811');
 
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 271,'동대구','0703','부산','0811');
------------------ 271번 기차 -----------------

delete from final_traintest3
where codeno = 103;
commit;
------------------ 103번 기차 -----------------
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 103,'광명','0546','대전','0632');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 103,'광명','0546','동대구','0724');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 103,'광명','0546','부산','0817');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 103,'대전','0632','동대구','0724');

insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 103,'대전','0632','부산','0817');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 103,'동대구','0724','부산','0817');
------------------ 103번 기차 ----------------- 


------------------ 105번 기차 -----------------
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 105,'서울','0600','광명','0616');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 105,'서울','0600','대전','0703');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 105,'서울','0600','동대구','0749');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 105,'서울','0600','부산','0837');

insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 105,'광명','0616','대전','0703');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 105,'광명','0616','동대구','0749');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 105,'광명','0616','부산','0837');
 
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 105,'대전','0703','동대구','0749');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 105,'대전','0703','부산','0837');
 
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 105,'동대구','0749','부산','0837');
------------------ 105번 기차 -----------------

--------------- 201번 기차 ---------------

 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 201,'서울','0610','대전','0714');

 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 201,'서울','0610','동대구','0806');

 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 201,'서울','0610','부산','0850');

 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 201,'대전','0714','동대구','0806');

 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 201,'대전','0714','부산','0850');

insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 201,'동대구','0806','부산','0850');
--------------- 201번 기차 ---------------


commit;

--------------- 282번 기차 ---------------
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 282,'대전','0555','광명','0649');

 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 282,'대전','0555','서울','0711');

 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 282,'광명','0649','서울','0711');
--------------- 282번 기차 ---------------


----------202번 기차 -------------

select *
from final_runinfo;

update final_runinfo set departuretime = '0'||departuretime
where trainno = 202 and departure = '부산' and arrival = '동대구';

 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 202,'부산','0445','동대구','0541');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 202,'부산','0445','대전','0624');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 202,'부산','0445','광명','0714');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 202,'부산','0445','서울','0729');

insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 202,'동대구','0541','대전','0624');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 202,'동대구','0541','광명','0714');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 202,'동대구','0541','서울','0729');
 
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 202,'대전','0624','광명','0714');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 202,'대전','0624','서울','0729');
 
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 202,'광명','0649','서울','0729');

------------ 202번기차 ----------------
commit;
------------276번기차 ------------

 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 276,'부산','0435','동대구','0555');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 276,'부산','0435','대전','0637');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 276,'부산','0435','광명','0731');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 276,'부산','0435','서울','0745');

insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 276,'동대구','0555','대전','0637');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 276,'동대구','0555','광명','0731');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 276,'동대구','0555','서울','0745');
 
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 276,'대전','0637','광명','0731');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 276,'대전','0637','서울','0731');
 
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 276,'광명','0731','서울','0745');

commit;
-------------276번 기차 -------------



------------284번 기차 ----------------

insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 284,'대전','0637','광명','0731');

insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 284,'대전','0637','서울','0745');

insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 284,'광명','0731','서울','0745');

commit;
------------284번 기차 ----------------



------------102번 기차 ----------------
 
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 102,'부산','0510','동대구','0600');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 102,'부산','0510','대전','0647');
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 102,'부산','0510','광명','0735');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 102,'부산','0510','서울','0758');

insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 102,'동대구','0600','대전','0648');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 102,'동대구','0600','광명','0735');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 102,'동대구','0600','서울','0758');
 
insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 102,'대전','0647','광명','0735');
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 102,'대전','0647','서울','0758');
 
 insert into final_runinfo(runinfoseq, trainno, departure, departuretime, arrival, arrivaltime)
 values(runinfoseq.nextval, 102,'광명','0735','서울','0758');
------------102번 기차 ----------------

commit;
select *
from final_runinfo;
