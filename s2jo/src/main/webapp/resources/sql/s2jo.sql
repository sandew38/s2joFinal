select *
from tab;

select *
from final_nonmember A join FINAL_TICKETSUMMARY B
on A.NONNO= B.NONNO
join final_ticketdetail C
on B.ORDERSEQ = C.ORDERSEQ
join final_seat D
on D.SEATSEQ = C.SEATSEQ
join final_runinfo E
on E.RUNINFOSEQ = D.RUNINFOSEQ;
23


-- 비회원용
select d.runinfoseq as 운행코드번호, trainno as 열차번호, classno as 호차, c.seatseq as 좌석시퀀스, seatno as 좌석번호 , orderstatus as 예약여부
      , departure as 출발지, departuretime as 출발시각, arrival as 도착지, arrivaltime as 도착시각, ppt as 한장당가격
      , a.nonno as 비회원번호, nhp as 비회원핸드폰번호, npwd as 비회원비밀번호, status as 비회원상태
      , b.orderseq as 주문번호, userid as 유저ID, tqty as 예약매수, orderdate as 주문일자, departuredate as 출발일자     
      , ageline as 연령대
from final_nonmember A join FINAL_TICKETSUMMARY B
on A.NONNO= B.NONNO
join final_ticketdetail C
on B.ORDERSEQ = C.ORDERSEQ
join final_seat D
on D.SEATSEQ = C.SEATSEQ
join final_runinfo E
on E.RUNINFOSEQ = D.RUNINFOSEQ
where nhp='01052498336';


-- 회원용
select d.runinfoseq as 운행코드번호, trainno as 열차번호, classno as 호차, c.seatseq as 좌석시퀀스, seatno as 좌석번호 , orderstatus as 예약여부
      , departure as 출발지, departuretime as 출발시각, arrival as 도착지, arrivaltime as 도착시각, ppt as 한장당가격
      , a.userid as 회원ID, status as 회원상태
      , b.orderseq as 주문번호, tqty as 예약매수, orderdate as 주문일자, departuredate as 출발일자     
      , ageline as 연령대
from final_member A join FINAL_TICKETSUMMARY B
on A.USERID = B.USERID
join final_ticketdetail C
on B.ORDERSEQ = C.ORDERSEQ
join final_seat D
on D.SEATSEQ = C.SEATSEQ
join final_runinfo E
on E.RUNINFOSEQ = D.RUNINFOSEQ
where a.userid = 'sandew38';

select *
from final_member;

select *
from final_ticketdetail;

select *
from final_ticketsummary;

select *
from final_traininfo;

-- 열차번호, 출발지, 도착지로 운행정보 가져오기
select * 
from final_runinfo A join final_seat B
on A.RUNINFOSEQ = B.RUNINFOSEQ
join FINAL_TICKETDETAIL C
on B.SEATSEQ = C.SEATSEQ
where a.trainno='101' and a.departure = '서울' and a.arrival = '부산';

create table final_traininfo
( traintype     number(2)  not null      -- 기차종류 (1: ktx, 2: 3: )
, trainno       number    not null     -- 열차번호
, perminuterate number  not null    -- 분당운임 
, constraint PK_final_traininfo_trainno Primary key (trainno)
, constraint CK_final_traininfo_traintype check (traintype in ( 1,2,3)) 
);

COMMENT ON TABLE final_traininfo IS '기차정보';

COMMENT ON COLUMN final_traininfo.trainno IS '기차종류 (1: ktx, 2: 3: )';

COMMENT ON COLUMN final_traininfo.traintype IS '열차번호';

COMMENT ON COLUMN final_traininfo.perminuterate IS '분당운임 ';

SELECT * FROM ALL_COL_COMMENTS WHERE OWNER = 'S2JO';


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

select *
from final_runinfo;

select case when traintype = 1 then 'KHX' 
      else '무궁화' end
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


COMMENT ON COLUMN final_runinfo.runinfoseq IS '운행정보 시퀀스';

COMMENT ON COLUMN final_runinfo.trainno IS '열차번호';

COMMENT ON COLUMN final_runinfo.departure IS '출발지';

COMMENT ON COLUMN final_runinfo.departuretime IS '출발시각';

COMMENT ON COLUMN final_runinfo.arrival IS '도착지';

COMMENT ON COLUMN final_runinfo.arrivaltime IS '도착시간';

commit;

select runinfoseq, trainno, departure, departuretime, arrival, arrivaltime
from final_runinfo;

select count(*)
from final_runinfo;

commit;

-- 소요시간 뽑아서 장 당 가격 뽑기!!! 성공!!!!
select trainno, case when traintype = 1 then 'KHX' else '무궁화' end as traintype, departure, departuretime, arrival, arrivaltime
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
              , traintype, B.Perminuterate
              , to_number(arrivaltime)-to_number(departuretime) as turnaroundtime
              , substr(arrivaltime,1,2) - substr(departuretime,1,2) as hour
              , substr(arrivaltime,3,4) - substr(departuretime,3,4) as min
      from final_runinfo A join Final_Traininfo B
      on A.Trainno = B.Trainno
    )
 )T
 where traintype = 1 and departure = '서울' and arrival = '부산';

commit;


select trainno, traintype, departure, departuretime, arrival, arrivaltime, turnaroundrate, perminuterate, rate
from 
(
  select trainno, case when traintype = 1 then 'KHX' else '무궁화' end as traintype, departure, departuretime, arrival, arrivaltime
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
                , traintype, B.Perminuterate
                , to_number(arrivaltime)-to_number(departuretime) as turnaroundtime
                , substr(arrivaltime,1,2) - substr(departuretime,1,2) as hour
                , substr(arrivaltime,3,4) - substr(departuretime,3,4) as min
        from final_runinfo A join Final_Traininfo B
        on A.Trainno = B.Trainno
      )
   )T
   where traintype = 1 and departure = '서울' and arrival = '부산'
);

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

-- 좌석 테이블 임의 데이터 입력
insert into final_seat(seatseq, runinfoseq, classno, seatno)
values(seatseq.nextval, '4', '2', '29');

insert into final_seat(seatseq, runinfoseq, classno, seatno)
values(seatseq.nextval, '4', '2', '30');

-- 좌석 테이블 조회
select *
from final_seat
order by seatseq desc;

-- DROP TABLE final_seat ;
/* 좌석 */
CREATE TABLE final_seat (
	seatseq VARCHAR2(20) NOT NULL, /* 좌석시퀀스 */
	runinfoseq NUMBER NOT NULL, /* 운행코드번호 */
	classno VARCHAR2(20) NOT NULL, /* 호차 ( 특실 : 1~3호차  일반실 : 4~8호차)*/
	seatno VARCHAR2(20) NOT NULL /* 좌석번호 */
);


create sequence seatseq
start with 1
increment by 1
nominvalue
nomaxvalue
nocycle
nocache;


COMMENT ON COLUMN final_seat.seatseq IS '좌석시퀀스';

COMMENT ON COLUMN final_seat.runinfoseq IS '운행코드번호';

COMMENT ON COLUMN final_seat.classno IS '호차번호 ( 특실 : 1~3호차  일반실 : 4~8호차) ';

COMMENT ON COLUMN final_seat.seatno IS '좌석번호';

ALTER TABLE final_seat
	ADD
		CONSTRAINT PK_final_seat
		PRIMARY KEY (
			seatseq
		);

-- 이거 만들어야함
ALTER TABLE final_seat
	ADD
		CONSTRAINT FK_final_class_TO_final_seat
		FOREIGN KEY (
			classno
		)
		REFERENCES final_class (
			classno
		);
-- 여기까지

ALTER TABLE final_seat
	ADD
		CONSTRAINT FK_final_runinfo_TO_final_seat
		FOREIGN KEY (
			runinfoseq
		)
		REFERENCES final_runinfo (
			runinfoseq
		);


insert into final_class(classno, classrate)
values('8','1');
    
select *
from final_class;

commit;
    
/* 호차등급 */
CREATE TABLE final_class (
	classno VARCHAR2(20) NOT NULL, /* 호차 */
	classrate VARCHAR2(20) NOT NULL /* 등급별 할인율 */
);

COMMENT ON COLUMN final_class.classno IS '1~3호차 : 특실
4~8호차 : 일반실';

COMMENT ON COLUMN final_class.classrate IS '등급별 할인율 ( 특실 : 1.2배, 일반 : 1배 )';

ALTER TABLE final_class
	ADD
		CONSTRAINT PK_final_class
		PRIMARY KEY (
			classno
		);
    
    
select *
from final_ageline;

/* 연령대 */
CREATE TABLE final_ageline (
	ageline VARCHAR2(20) NOT NULL, /* 연령대 */
	agelinerate VARCHAR2(20) /* 연령대별 할인율 */
);

insert into final_ageline (ageline, agelinerate)
values('중고생','0.80');

COMMENT ON COLUMN final_ageline.ageline IS '연령대 ( 일반 / 노약자 / 중고생)';

COMMENT ON COLUMN final_ageline.agelinerate IS '연령대별 할인율 ( 일반 : 1.0, 노약자 : 0.75, 중고생 : 0.80 )';

ALTER TABLE final_ageline
	ADD
		CONSTRAINT PK_final_ageline
		PRIMARY KEY (
			ageline
		);


select *
from final_ticketdetail A join final_seat B
on A.SEATSEQ = B.SEATSEQ
join final_runinfo C
on B.RUNINFOSEQ = C.RUNINFOSEQ;

commit;

select *
from final_ticketsummary;

select ticketno, orderseq, departuredate, ppt, ageline, seatseq, orderstatus
from final_ticketdetail
where departuredate = '20170712';

-- 좌석 선택 가능한지 알아오기 
select a.ticketno, a.orderseq, a.departuredate, a.ppt, a.ageline, a.seatseq, a.orderstatus, b.runinfoseq, b.classno, b.seatno, C.Trainno
from final_ticketdetail A join final_seat B
on A.Seatseq = B.Seatseq
join final_runinfo C
on C.Runinfoseq = B.Runinfoseq
where departuredate = '20170712' and c.trainno = '101' and departure = '서울' and arrival = '부산' and orderstatus = 1;


-- 좌석 선택 가능한지 알아오기 
select count(*)
from final_ticketdetail A join final_seat B
on A.Seatseq = B.Seatseq
join final_runinfo C
on C.Runinfoseq = B.Runinfoseq
where departuredate = '20170712' and c.trainno = '101' and departure = '서울' and arrival = '부산' and orderstatus = 1 and seatno = '1';


-- 티켓 상세 테이블 임의 데이터 입력
insert into final_ticketdetail (ticketno, orderseq, departuredate, ppt , ageline, seatseq, orderstatus)
values(ticketno.nextval, '11', '20170630','7296', '일반', '1','1');

-- 이거 아래 2개 입력해야함
insert into final_ticketdetail (ticketno, orderseq, departuredate, ppt , ageline, seatseq, orderstatus)
values(ticketno.nextval, '14', '20170712','59280', '일반', '2','1'); 

insert into final_ticketdetail (ticketno, orderseq, departuredate, ppt , ageline, seatseq, orderstatus)
values(ticketno.nextval, '14', '20170712','44460', '65세이상', '3','1');

commit;

/* 티켓상세 */
CREATE TABLE final_ticketdetail (
	ticketno VARCHAR2(30) NOT NULL, /* 티켓번호 */
	orderseq VARCHAR2(20) NOT NULL, /* 주문번호(seq) */
	departuredate VARCHAR2(20) NOT NULL, /* 탑승일자 */
	ppt VARCHAR2(20), /* 한 장 가격 */
	ageline VARCHAR2(20) NOT NULL, /* 연령대 */
	seatseq VARCHAR2(20) NOT NULL, /* 좌석시퀀스 */
	orderstatus VARCHAR2(20) NOT NULL /* 예약여부 */
);

create sequence orderseq
start with 1
increment by 1
nominvalue
nomaxvalue
nocycle
nocache;

COMMENT ON COLUMN final_ticketdetail.ticketno IS '좌석이 선택가능한 지 여기서 알 수 있음
기차코드번호_운행코드번호_날짜 (K_1h_1_20170609)';

COMMENT ON COLUMN final_ticketdetail.orderseq IS '주문번호 시퀀스';

COMMENT ON COLUMN final_ticketdetail.departuredate IS '탑승일자
';

COMMENT ON COLUMN final_ticketdetail.ppt IS '한 장당 가격( price per ticket )
(소요시간*분당운임*등급별운임*연령별할인)';

COMMENT ON COLUMN final_ticketdetail.ageline IS '연령대 ( 일반 / 노약자 / 중고생)';

COMMENT ON COLUMN final_ticketdetail.seatseq IS '좌석시퀀스';

COMMENT ON COLUMN final_ticketdetail.orderstatus IS '예약여부 (0: 취소됨, 1: 예약됨, 2: 사용됨)';


ALTER TABLE final_ticketdetail
	ADD
		CONSTRAINT PK_final_ticketdetail
		PRIMARY KEY (
			ticketno
		);

ALTER TABLE final_ticketdetail
	ADD
		CONSTRAINT FK_final_ageline_tktdetail
		FOREIGN KEY (
			ageline
		)
		REFERENCES final_ageline (
			ageline
		);

ALTER TABLE final_ticketdetail
	ADD
		CONSTRAINT FK_final_seat_ticketdetail
		FOREIGN KEY (
			seatseq
		)
		REFERENCES final_seat (
			seatseq
		);

ALTER TABLE final_ticketdetail
	ADD
		CONSTRAINT FK_final_tktsummary_tktdetail
		FOREIGN KEY (
			orderseq
		)
		REFERENCES final_ticketsummary (
			orderseq
		);
    
    
    
select *
from final_nonmember
order by nonno desc;

commit;

-- 비회원 테이블 임의 데이터 입력
insert into final_nonmember(nonno, nhp, npwd, status)
values(SEQ_FINAL_NONMEMBER.nextval, '01086982950', '4321', default);

insert into final_nonmember(nonno, nhp, npwd, status)
values(SEQ_FINAL_NONMEMBER.nextval, '01000000000', '1234', default);


/* 비회원로그인 */
CREATE TABLE final_nonmember (
	nonno VARCHAR2(20) NOT NULL, /* 비회원번호 */
	nhp VARCHAR2(20) NOT NULL, /* 핸드폰번호 */
	npwd VARCHAR2(4) NOT NULL, /* 임의비밀번호 */
	status NUMBER(1) DEFAULT 1 /* 가입상태 */
);


COMMENT ON COLUMN final_nonmember.nonno IS 'non-member-number ( 비회원번호 )';

COMMENT ON COLUMN final_nonmember.nhp IS '비회원가입용 핸드폰번호 11자리 입력';

COMMENT ON COLUMN final_nonmember.npwd IS '비회원 비밀번호 숫자 4자리,문자1개';

COMMENT ON COLUMN final_nonmember.status IS '가입상태 - 체크키 constraint CK_s2jo_member_status check( status in (0,1) )
0이면 회원탈퇴, 1이면 회원가입상태';

ALTER TABLE final_nonmember
	ADD
		CONSTRAINT PK_final_nonmember
		PRIMARY KEY (
			nonno
		);
    
select *
from final_ticketsummary;
    
commit;
    
select *
from final_member;

select *
from final_nonmember;


    
-- 티켓개요 테이블 임의 데이터 입력
insert into final_ticketsummary (orderseq, userid, nonno, tqty, orderdate)
values(orderseq.nextval, 'null','4', '3', '20170615');

insert into final_ticketsummary (orderseq, userid, nonno, tqty, orderdate)
values(orderseq.nextval, 'sandew38','8', '2', '20170616'); -- 여기

commit;
    
/* 티켓개요 */
CREATE TABLE final_ticketsummary (
	orderseq VARCHAR2(20) NOT NULL, /* 주문번호(seq) */
	userid VARCHAR2(20), /* 회원ID */
	nonno VARCHAR2(20), /* 비회원번호 */
	tqty VARCHAR(20), /* 매수 */
	orderdate VARCHAR2(20)NOT NULL /* 주문일시 */
);

drop table final_ticketsummary;
drop table final_ticketdetail;

create sequence orderseq
start with 1
increment by 1 
nominvalue
nomaxvalue
nocache
nocycle;

COMMENT ON COLUMN final_ticketsummary.orderseq IS '주문번호(seq)';

COMMENT ON COLUMN final_ticketsummary.userid IS '회원ID';

COMMENT ON COLUMN final_ticketsummary.tqty IS 'ticket quantity';

COMMENT ON COLUMN final_ticketsummary.orderdate IS '주문일시';


ALTER TABLE final_ticketsummary
	ADD
		CONSTRAINT PK_final_ticketsummary
		PRIMARY KEY (
			orderseq
		);

ALTER TABLE final_ticketsummary
	ADD
		CONSTRAINT FK_final_member_ticketsummary
		FOREIGN KEY (
			userid
		)
		REFERENCES final_member (
			userid
		);

ALTER TABLE final_ticketsummary
	ADD
		CONSTRAINT FK_final_nonmember_tktsummary
		FOREIGN KEY (
			nonno
		)
		REFERENCES final_nonmember (
			nonno
		);
    
commit;    
    
insert into final_member (userid, name, pwd, email,joindate, status, birthday)
values('sandew38','기명주','qwer1234$','sandew38@gmail.com', default,default,'930412');
    
/* 회원가입 */
CREATE TABLE final_member (
	userid VARCHAR2(20) NOT NULL, /* 회원ID */
	name VARCHAR2(20) NOT NULL, /* 회원명 */
	pwd VARCHAR2(15) NOT NULL, /* 비밀번호 */
	email VARCHAR2(50) NOT NULL, /* 이메일주소 */
	hp VARCHAR2(11), /* 핸드폰번호 */
	post VARCHAR2(20), /* 우편번호 */
	addr1 VARCHAR2(100), /* 집주소 */
	addr2 VARCHAR2(100), /* 상세집주소 */
	joindate DATE DEFAULT sysdate, /* 가입날짜 */
	status NUMBER(1) DEFAULT 1, /* 가입상태 */
	birthday VARCHAR2(30) NOT NULL, /* 생년월일 */
	gender NUMBER(1) /* 성별 */
);

insert into final_member (userid, name, pwd, email,joindate, status, birthday)
values('null','null','qwer1234$','null', default,default,'000000');

commit;

COMMENT ON TABLE final_member IS '회원가입 테이블//모든 정보의 기본!';

COMMENT ON COLUMN final_member.userid IS '회원ID
';

COMMENT ON COLUMN final_member.name IS '회원명';

COMMENT ON COLUMN final_member.pwd IS '비밀번호';

COMMENT ON COLUMN final_member.email IS '이메일주소';

COMMENT ON COLUMN final_member.hp IS '핸드폰번호 (유니크 키)';

COMMENT ON COLUMN final_member.post IS '우편번호';

COMMENT ON COLUMN final_member.addr1 IS '주소';

COMMENT ON COLUMN final_member.addr2 IS '상세주소';

COMMENT ON COLUMN final_member.joindate IS '가입날짜';

COMMENT ON COLUMN final_member.status IS '가입상태 - 체크키 constraint CK_s2jo_member_status check( status in (0,1) )
0이면 회원탈퇴, 1이면 회원가입상태';

COMMENT ON COLUMN final_member.birthday IS '생년월일';

COMMENT ON COLUMN final_member.gender IS '성별 - 체크키 constraint CK_s2jo_member_gender check( status in (1,2) )
1이면 남
2이면 여';

select *
from final_member;


ALTER TABLE final_member
	ADD
		CONSTRAINT PK_final_member
		PRIMARY KEY (
			userid
		);
    
select * from user_tables;

select * 
from final_paysummary;

-- 결제 테이블 임의 데이터 입력
insert into final_paysummary(paymentcode, paydate, totalprice, userid, nonno, paystatus )
values(paymentcode.nextval, default, '7296', 'null', '4', default); 

insert into final_paysummary(paymentcode, paydate, totalprice, userid, nonno, paystatus )
values(paymentcode.nextval, default, '103740', 'sandew38', '8', default); 

commit;

/* 결제 */
CREATE TABLE final_paysummary (
	paymentcode VARCHAR2(30) NOT NULL, /* 결제코드번호 */
	paydate DATE DEFAULT sysdate NOT NULL, /* 결제일자 */
	totalprice VARCHAR2(20) NOT NULL, /* 총 가격 */
	userid VARCHAR2(20), /* 회원ID */
	nonno VARCHAR2(20), /* 비회원번호 */
	paystatus NUMBER DEFAULT 1 NOT NULL /* 결제상태 */
);

create sequence paymentcode
start with 1
increment by 1
nomaxvalue
nominvalue
nocache
nocycle;

COMMENT ON COLUMN final_paysummary.paymentcode IS '결제코드번호 ( seq )';

COMMENT ON COLUMN final_paysummary.paydate IS '결제일자';

COMMENT ON COLUMN final_paysummary.totalprice IS '예매한 티켓 수에 대한 총 가격
';

COMMENT ON COLUMN final_paysummary.userid IS '회원 ID';

COMMENT ON COLUMN final_paysummary.nonno IS '비회원번호';

COMMENT ON COLUMN final_paysummary.paystatus IS '결제 상태 ( 0: 취소됨, 1: 사용가능, 2: 사용됨 )
';


ALTER TABLE final_paysummary
	ADD
		CONSTRAINT PK_final_paysummary
		PRIMARY KEY (
			paymentcode
		);
    
    
ALTER TABLE final_paysummary
	ADD
		CONSTRAINT FK_final_member_paysummary
		FOREIGN KEY (
			userid
		)
		REFERENCES final_member (
			userid
		);

ALTER TABLE final_paysummary
	ADD
		CONSTRAINT FK_final_nonmember_paysummary
		FOREIGN KEY (
			nonno
		)
		REFERENCES final_nonmember (
			nonno
		);

insert into final_paydetail()
values(paydetailseq.nextval, '티켓번호')
    
select *
from final_paydetail;
  
-- 결제 상세 테이블 임의 데이터 입력  
insert into final_paydetail (paydetailseq, ticketno, paymentcode)
values(paydetailseq.nextval, '3','2');

insert into final_paydetail (paydetailseq, ticketno, paymentcode)
values(paydetailseq.nextval, '5','3');

insert into final_paydetail (paydetailseq, ticketno, paymentcode)
values(paydetailseq.nextval, '6','3');

commit;
  
/* 결제상세 */
CREATE TABLE final_paydetail (
	paydetailseq VARCHAR2(20) NOT NULL, /* 결제상세번호 */
	ticketno VARCHAR2(30) NOT NULL, /* 티켓번호 */
	paymentcode VARCHAR2(30) NOT NULL /* 결제코드번호 */
);

create sequence paydetailseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocache
nocycle;

 
COMMENT ON COLUMN final_paydetail.paydetailseq IS '결제 상세 번호 ( seq )';


ALTER TABLE final_paydetail
	ADD
		CONSTRAINT PK_final_paydetail
		PRIMARY KEY (
			paydetailseq
		);


ALTER TABLE final_paydetail
	ADD
		CONSTRAINT FK_final_paysummary_paydetail
		FOREIGN KEY (
			paymentcode
		)
		REFERENCES final_paysummary (
			paymentcode
		);
    
ALTER TABLE final_paydetail
	ADD
		CONSTRAINT FK_final_tktdetail_paydetail
		FOREIGN KEY (
			ticketno
		)
		REFERENCES final_ticketdetail (
			ticketno
		);
    
    
commit;    

/* 유실물센터(관리자) */
CREATE TABLE final_adminloss (
	lostno NUMBER(13) NOT NULL, /* 관리번호 */
	losthave NUMBER(1) , /* 유실물상태 */
	storageplace VARCHAR2(30), /* 보관장소 */
	losttype VARCHAR2(20), /* 분실물종류 */
	lostdate VARCHAR2(20), /* 습득일 */
	lostimg VARCHAR2(40), /* 첨부파일 */
	lostplace VARCHAR2(30), /* 습득장소 */
	lostcontent CLOB, /* 비고 */
	article VARCHAR2(20), /* 습득물명 */
	losttname VARCHAR2(6) /* 분실자명 */
);


ALTER TABLE final_adminloss
	ADD
		CONSTRAINT PK_final_adminloss
		PRIMARY KEY (
			lostno
		);
    
    
/* 유실물등록(고객) */
CREATE TABLE final_userloss (
	userid VARCHAR2(20) NOT NULL, /* 회원ID */
	losskind VARCHAR2(30), /* 분실물종류 */
	finddate VARCHAR2(20), /* 습득일 */
	findplace VARCHAR2(20), /* 습득장소 */
	note CLOB, /* 비고 */
	lossname VARCHAR2(6), /* 분실자명 */
	article VARCHAR2(20) /* 습득물명 */
);

ALTER TABLE final_userloss
	ADD
		CONSTRAINT PK_final_userloss
		PRIMARY KEY (
			userid
		);

ALTER TABLE final_userloss
	ADD
		CONSTRAINT FK_final_member_userloss
		FOREIGN KEY (
			userid
		)
		REFERENCES final_member (
			userid
		);

commit;


select DISTINCT(departure)
from final_runinfo;


