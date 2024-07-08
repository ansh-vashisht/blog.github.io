create database op;
use op;
create table login(
id int auto_increment,
name varchar(20),
age int ,
gender varchar(20),
email varchar(20),
password varchar(20),
primary key(id,email)); 

select * from login;
drop table blog;
create table blog(
id int auto_increment primary key,
title varchar(2000),
topic varchar(200),
descr varchar(4294967294),
img MEDIUMTEXT,
author varchar(20),
extra varchar(200)
);
select * from blog;
SHOW GRANTS FOR 'root'@'localhost';


INSERT INTO blog (title, topic, descr, img, author,extra) 
VALUES ('Scrum vs. SAFe: Which Agile framework is right for your team?', 'Science', 'While both frameworks are popular, they can reshape your organization in different ways. So, when deciding between Scrum vs. SAFe, you have to consider your resources and goals. To help you pick the best framework, we’ll describe both approaches, their similarities and differences, and the kind of teams they’re best suited for.', 'https://www.pluralsight.com/content/dam/pluralsight2/siege-blog-assets/safe-definition-process.webp', 'Deepti','https://www.pluralsight.com/blog/software-development/scrum-vs-safe');

INSERT INTO blog (title, topic, descr, img, author,extra) 
VALUES ('Bard vs ChatGPT: What’s the difference?', 'Technology', 'The biggest difference between ChatGPT and Bard is the Large Language Models (LLMs) they are powered by. ChatGPT uses the Generative Pre-trained Transformer 4 (GPT-4), while Bard uses the Language Model for Dialogue Applications (LaMBDA). Also, ChatGPT is developed by OpenAI, while Bard was built by Google.', 'https://www.pluralsight.com/content/dam/ps/images/resource-center/blog/header-hero-images/ChatGPT-vs-Bard-c.png', 'a','https://www.pluralsight.com/blog/software-development/chatgpt-vs-bard-coding');

create table contact(
id int auto_increment primary key,
name varchar(20),
email varchar(20),
query varchar(2000)
);