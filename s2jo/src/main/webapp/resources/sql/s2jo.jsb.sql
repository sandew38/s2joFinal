show user;

select *
from tab;

select *
from final_member;

 insert into final_member(userid, name,pwd,email,birthday)
values('asd','asd','asd123!@#','wltmdqo12@naver.com',sysdate); 
--추천게시판
create table final_recommendBoard
(seq           number                not null   -- 글번호
,userid        varchar2(20)          not null   -- 사용자ID
,name          Nvarchar2(20)         not null   -- 글쓴이
,subject       Nvarchar2(200)        not null   -- 글제목
,content       Nvarchar2(2000)       not null   -- 글내용    -- clob
,pw            varchar2(20)          not null   -- 글암호
,readCount     number default 0      not null   -- 글조회수
,regDate       date default sysdate  not null   -- 글쓴시간
,status        number(1) default 1   not null   -- 글삭제여부  1:사용가능한글,  0:삭제된글 
,commentCount  number default 0      not null   -- 댓글수
,groupno       number                not null   -- 답변글쓰기에 있어서 그룹번호
                                                -- 원글(부모글)과 답변글은 동일한 groupno 를 가진다. 
                                                -- 답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.  
                                                
,fk_seq        number default 0      not null   -- fk_seq 컬럼은 절대로 foreign key가 아니다.
                                                -- fk_seq 컬럼은 자신의 글(답변글)에 있어서 
                                                -- 원글(부모글)이 누구인지에 대한 정보값이다.
                                                -- 답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 
                                                -- 원글(부모글)의 seq 컬럼의 값을 가지게 되며,
                                                -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
                                                
,depthno       number default 0       not null  -- 답변글쓰기에 있어서 답변글 이라면                                                
                                                -- 원글(부모글)의 depthno + 1 을 가지게 되며,
                                                -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.

, fileName     varchar2(255)     -- WAS(톰캣)에 저장될 파일명(20161121324325454354353333432.png)
, orgFilename  varchar2(255)     -- 진짜 파일명(강아지.png)   // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
, fileSize     number            -- 파일크기

,constraint  PK_final_recommendBoard_seq primary key(seq)
,constraint  FK_final_recommendBoard_userid foreign key(userid) 
                                       references final_member(userid)
,constraint  CK_final_recommendBoard_status check( status in(0,1) )
);
--drop table final_recommendBoard purge;

create sequence final_recommendBoard_Seq
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;

select *
from final_recommendBoard;

delete from final_recommendBoard;
commit;



create table final_recommendComment
(seq        number               not null   -- 댓글번호
,userid     varchar2(20)         not null   -- 사용자ID
,name       varchar2(20)         not null   -- 성명
,content    varchar2(1000)       not null   -- 댓글내용
,regDate    date default sysdate not null   -- 작성일자
,parentSeq  number               not null   -- 원게시물 글번호
,status     number(1) default 1  not null   -- 글삭제여부
                                            -- 1 : 사용가능한 글,  0 : 삭제된 글
                                            -- 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
,constraint PK_final_recComment_seq primary key(seq)
,constraint FK_final_recComment_userid foreign key(userid)
                                        references final_member(userid)
,constraint FK_final_recComment_parentSeq foreign key(parentSeq) 
                                           references final_recommendBoard(seq)
,constraint CK_final_recComment_status check( status in(1,0) ) 
);


create sequence final_recComment_Seq
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;


--함께해요게시판
create table final_togetherBoard
(seq           number                not null   -- 글번호
,userid        varchar2(20)          not null   -- 사용자ID
,name          Nvarchar2(20)         not null   -- 글쓴이
,subject       Nvarchar2(200)        not null   -- 글제목
,content       Nvarchar2(2000)       not null   -- 글내용    -- clob
,pw            varchar2(20)          not null   -- 글암호
,readCount     number default 0      not null   -- 글조회수
,regDate       date default sysdate  not null   -- 글쓴시간
,status        number(1) default 1   not null   -- 글삭제여부  1:사용가능한글,  0:삭제된글 
,commentCount  number default 0      not null   -- 댓글수
,groupno       number                not null   -- 답변글쓰기에 있어서 그룹번호
                                                -- 원글(부모글)과 답변글은 동일한 groupno 를 가진다. 
                                                -- 답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.  
                                                
,fk_seq        number default 0      not null   -- fk_seq 컬럼은 절대로 foreign key가 아니다.
                                                -- fk_seq 컬럼은 자신의 글(답변글)에 있어서 
                                                -- 원글(부모글)이 누구인지에 대한 정보값이다.
                                                -- 답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 
                                                -- 원글(부모글)의 seq 컬럼의 값을 가지게 되며,
                                                -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
                                                
,depthno       number default 0       not null  -- 답변글쓰기에 있어서 답변글 이라면                                                
                                                -- 원글(부모글)의 depthno + 1 을 가지게 되며,
                                                -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.

, fileName     varchar2(255)     -- WAS(톰캣)에 저장될 파일명(20161121324325454354353333432.png)
, orgFilename  varchar2(255)     -- 진짜 파일명(강아지.png)   // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
, fileSize     number            -- 파일크기

,constraint  PK_final_togetherBoard_seq primary key(seq)
,constraint  FK_final_togetherBoard_userid foreign key(userid) 
                                       references final_member(userid)
,constraint  CK_final_togetherBoard_status check( status in(0,1) )
);
--drop table final_recommendBoard purge;

create sequence final_togetherBoard_Seq
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;



create table final_togetherComment
(seq        number               not null   -- 댓글번호
,userid     varchar2(20)         not null   -- 사용자ID
,name       varchar2(20)         not null   -- 성명
,content    varchar2(1000)       not null   -- 댓글내용
,regDate    date default sysdate not null   -- 작성일자
,parentSeq  number               not null   -- 원게시물 글번호
,status     number(1) default 1  not null   -- 글삭제여부
                                            -- 1 : 사용가능한 글,  0 : 삭제된 글
                                            -- 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
,constraint PK_final_togeComment_seq primary key(seq)
,constraint FK_final_togeComment_userid foreign key(userid)
                                        references final_member(userid)
,constraint FK_final_togeComment_parentSeq foreign key(parentSeq) 
                                           references final_recommendBoard(seq)
,constraint CK_final_togeComment_status check( status in(1,0) ) 
);


create sequence final_togeComment_Seq
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;


--위험해요게시판
create table final_worryingBoard
(seq           number                not null   -- 글번호
,userid        varchar2(20)          not null   -- 사용자ID
,name          Nvarchar2(20)         not null   -- 글쓴이
,subject       Nvarchar2(200)        not null   -- 글제목
,content       Nvarchar2(2000)       not null   -- 글내용    -- clob
,pw            varchar2(20)          not null   -- 글암호
,readCount     number default 0      not null   -- 글조회수
,regDate       date default sysdate  not null   -- 글쓴시간
,status        number(1) default 1   not null   -- 글삭제여부  1:사용가능한글,  0:삭제된글 
,commentCount  number default 0      not null   -- 댓글수
,groupno       number                not null   -- 답변글쓰기에 있어서 그룹번호
                                                -- 원글(부모글)과 답변글은 동일한 groupno 를 가진다. 
                                                -- 답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.  
                                                
,fk_seq        number default 0      not null   -- fk_seq 컬럼은 절대로 foreign key가 아니다.
                                                -- fk_seq 컬럼은 자신의 글(답변글)에 있어서 
                                                -- 원글(부모글)이 누구인지에 대한 정보값이다.
                                                -- 답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 
                                                -- 원글(부모글)의 seq 컬럼의 값을 가지게 되며,
                                                -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
                                                
,depthno       number default 0       not null  -- 답변글쓰기에 있어서 답변글 이라면                                                
                                                -- 원글(부모글)의 depthno + 1 을 가지게 되며,
                                                -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.

, fileName     varchar2(255)     -- WAS(톰캣)에 저장될 파일명(20161121324325454354353333432.png)
, orgFilename  varchar2(255)     -- 진짜 파일명(강아지.png)   // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
, fileSize     number            -- 파일크기

,constraint  PK_final_worryingBoard_seq primary key(seq)
,constraint  FK_final_worryingBoard_userid foreign key(userid) 
                                       references final_member(userid)
,constraint  CK_final_worryingBoard_status check( status in(0,1) )
);
--drop table final_recommendBoard purge;

create sequence final_worryingBoard_Seq
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;



create table final_worryingComment
(seq        number               not null   -- 댓글번호
,userid     varchar2(20)         not null   -- 사용자ID
,name       varchar2(20)         not null   -- 성명
,content    varchar2(1000)       not null   -- 댓글내용
,regDate    date default sysdate not null   -- 작성일자
,parentSeq  number               not null   -- 원게시물 글번호
,status     number(1) default 1  not null   -- 글삭제여부
                                            -- 1 : 사용가능한 글,  0 : 삭제된 글
                                            -- 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
,constraint PK_final_worComment_seq primary key(seq)
,constraint FK_final_worComment_userid foreign key(userid)
                                        references final_member(userid)
,constraint FK_final_worComment_parentSeq foreign key(parentSeq) 
                                           references final_recommendBoard(seq)
,constraint CK_final_worComment_status check( status in(1,0) ) 
);


create sequence final_worComment_Seq
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;


delete from r_alarm_comment;
commit;

select sum(boardseq)
from r_alarm_comment
where userid = 'sandew38';
drop table r_alarm_comment purge;
create table r_alarm_comment
(seq        number            not null -- p.k
,userid     varchar2(20)      not null -- 글쓴이
,boardSeq   number            not null -- 글번호
,boardSubject Nvarchar2(200)  not null -- 글제목
,count      number default 0  not null -- 댓글수
,constraint PK_r_alarm_comment_seq primary key(seq)
,constraint FK_r_alarm_comment_userid foreign key(userid)
                                    references final_member(userid)

);



create table alarm_result
(
userid     varchar2(20)      not null
,resultCount      number default 0  not null

,constraint FK_alarm_result_userid foreign key(userid)    
                                   references final_member(userid)
);

drop table alarm_result purge;
 
select *              
from alarm_result;

select *
from r_alarm_comment;

delete from  alarm_result;
commit;
--insert into alarm_result(userid)
--        select userid
--        from r_alarm_comment
--        where userid in(select userid
--        				from r_alarm_comment
--        				minus
--        				select userid
--        				from alarm_result);
--          
--select userid
--from r_alarm_comment
--minus
--select userid
--from alarm_result;
--
--        select userid
--        from r_alarm_comment
--        where userid in(select userid
--        				from r_alarm_comment
--        				minus
--        				select userid
--        				from alarm_result);
--   


insert into alarm_result(userid)
        select userid
        from r_alarm_comment
        minus
        select userid
        from alarm_result;                
                

update alarm_result set resultCount = resultCount + (select sum(count)
                                                      from r_alarm_comment
                                                      where userid = 'sandew38')
where userid='sandew38';


select *
from alarm_result;



desc final_member;

create sequence r_alarm_comment_Seq
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;


create sequence alarm_result_Seq
start with 1
increment by 1
nomaxvalue 
nominvalue
nocycle
nocache;

select *
from r_alarm_comment;

select *
from t_alarm_comment;

select *
from w_alarm_comment;

select *
from alarm_result;

drop table w_alarm_comment purge; 

delete from t_alarm_comment;
delete from  alarm_result;
commit;
create table w_alarm_comment
(seq        number            not null -- p.k
,userid     varchar2(20)      not null -- 글쓴이
,boardSeq   number            not null -- 글번호
,boardSubject Nvarchar2(200)  not null -- 글제목
,count      number default 0  not null -- 댓글수
,constraint PK_w_alarm_comment_seq primary key(seq)
,constraint FK_w_alarm_comment_userid foreign key(userid)
                                    references final_member(userid)

);


select seq, subject, next_seq, next_subject, next_userid, pre_seq, pre_subject, pre_userid 
from
( 
  select seq, subject,
        lead(seq,1) over (order by seq) next_seq,
        lead(subject,1,'다음글') over (order by seq) next_subject,
        lead(userid,1,'작성자') over (order by seq) next_userid,
        lag(seq,1) over (order by seq) pre_seq,
        lag(subject,1,'이전글') over (order by seq) pre_subject,
        lag(userid,1,'작성자') over (order by seq) pre_userid
  from final_recommendBoard
  where status = 1  
)
where seq = 132;

select *
from final_recommendBoard;



 create table recommend_like
 (userid      varchar2(20) not null
 ,rseq        number(8) not null
 ,constraint PK_recommend_like primary key(userid, rseq)
 ,constraint FK_recommend_like_userid foreign key(userid) references final_member(userid)
 ,constraint FK_recommend_like_rseq foreign key(rseq) references final_recommendBoard(seq)
 );
 
 create table recommend_dislike
 (userid      varchar2(20) not null
 ,rseq        number(8) not null
 ,constraint PK_recommend_dislike primary key(userid, rseq)
 ,constraint FK_recommend_dislike_userid foreign key(userid) references final_member(userid)
 ,constraint FK_recommend_dislike_rseq foreign key(rseq) references final_recommendBoard(seq)
 );
 
 
 select ( select count(*)
          from jsp_like
          where pnum = 6) as likecnt
       ,( select count(*)
          from jsp_dislike
          where pnum = 6) as dislikecnt
 from dual;
 
 select *
 from recommend_like;
 
 select *
 from recommend_dislike;
 
 select *
 from final_reviewDislike;
 
 
 create table together_like
 (userid      varchar2(20) not null
 ,rseq        number(8) not null
 ,constraint PK_together_like primary key(userid, rseq)
 ,constraint FK_together_like_userid foreign key(userid) references final_member(userid)
 ,constraint FK_together_like_rseq foreign key(rseq) references final_togetherBoard(seq)
 );
 
 create table together_dislike
 (userid      varchar2(20) not null
 ,rseq        number(8) not null
 ,constraint PK_together_dislike primary key(userid, rseq)
 ,constraint FK_together_dislike_userid foreign key(userid) references final_member(userid)
 ,constraint FK_together_dislike_rseq foreign key(rseq) references final_togetherBoard(seq)
 );
 
  create table worrying_like
 (userid      varchar2(20) not null
 ,rseq        number(8) not null
 ,constraint PK_worrying_like primary key(userid, rseq)
 ,constraint FK_worrying_like_userid foreign key(userid) references final_member(userid)
 ,constraint FK_worrying_like_rseq foreign key(rseq) references final_worryingBoard(seq)
 );
 
 create table worrying_dislike
 (userid      varchar2(20) not null
 ,rseq        number(8) not null
 ,constraint PK_worrying_dislike primary key(userid, rseq)
 ,constraint FK_worrying_dislike_userid foreign key(userid) references final_member(userid)
 ,constraint FK_worrying_dislike_rseq foreign key(rseq) references final_worryingBoard(seq)
 );
 
 
 select *
 from worrying_like;
 
 
 select *
 from worrying_dislike;
 
 select *
 from user_tables;
 
  
  
  
 select *
 from recommend_like;
 
 select *
 from recommend_dislike;
 

select count(*)
from recommend_like
where rseq=136
minus
select count(*)
from recommend_dislike
where rseq=136;




