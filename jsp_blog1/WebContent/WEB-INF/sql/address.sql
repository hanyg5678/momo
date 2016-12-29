-- 테이블명 : address
-- 컬럼명 : no, name, phone, zipcode, address1, address2, wdate

create table address(
	no number not null,
	name varchar(100) not null,
	phone varchar(100) not null,
	zipcode varchar(100) not null,
	address1 varchar(200) not null,
	address2 varchar(200) not null,
	wdate date not null,
	primary key(no)
)

-- dml, dql 작성
-- 일련번호
select nvl(max(no),0)+1 from address
-- create
insert into address
(no, name, phone, zipcode, address1, address2, wdate)
values
((select nvl(max(no),0)+1 from address), '사나', '010-1111-1111', '12345', '서울특별시 종로구 관철동', '코아빌딩 5층,10층', sysdate)

--read
select * from address
where no = 1

-- update
update address
set phone = '010-2222-2222',
zipcode = '98765',
address1 = '트와이스',
address2 = '개이쁨'
where no = 2;

update address
set name = '다현',
phone = '010-3333-3333',
zipcode = '98765',
address1 = '트와이스',
address2 = '귀여움'
where no = 3;

-- list
select no, name, phone, to_char(wdate, 'yyyy-mm-dd') wdate, r
from (
	select no, name, phone, wdate, rownum r
	from (
		select no, name, phone, wdate 
		from address
		order by no desc
	)
) where r>=1 and r<= 5


