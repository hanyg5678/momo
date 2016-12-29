drop table team1;

create table team1 (
	no number not null,
	name varchar(20) not null,
	gender varchar(5) not null,
	phone varchar(20) not null,
	zipcode varchar(6) not null,
	address1 varchar(200) not null,
	address2 varchar(200) not null,
	skill varchar(100) not null,
	hobby varchar(100) not null,
	filename varchar(50) default 'member.jpg',
	primary key(no)
)

select nvl(max(no),0)+1 from team1

-- create
insert into team1
(no,name,gender,phone,zipcode,address1,address2,skill,hobby,filename)
values
((select nvl(max(no),0)+1 from team1),
'홍길동','남','010-1111-1111','12345','서울시 종로구 관철동','코아빌딩 5층,10층','Java,JSP,MVC','기술서적읽기','member.jpg'
)

-- read
select * from team1
where no = 1

-- update
update team1
set
phone = '010-0000-0000',
zipcode = '00000',
address1 = '서울시 강남구 역삼동',
address2 = '테헤란로',
skill = 'Java,JSP,MVC,Spring',
hobby = '독서'
where no =1

-- delete
delete from team1
where no = 1

-- list

select no, name, phone, skill, filename, r
from (
	select no, name, phone, skill, filename, rownum r
	from (
		select no, name, phone, skill, filename
		from team1
		where name like '%사나%'
		order by no desc
	)
) where r>=1 and r<=10

update team1
set filename = '01.jpg'
where no = 6

update team1
set name = '워윅'
where no = 6






