CREATE TABLE videos(
  id serial8 primary key, 
  title varchar(225),
  description text,
  url varchar(225),
  genre varchar(30)
);

insert into videos (title, description, url, genre) values ('Mura Masa - The Way I Want U', 'Cool', 'https://www.youtube.com/watch?v=s9LAvsC3f0w', 'indie')

insert into videos (title, description, url, genre) values ('OutKast - Roses (PLS&TY Remix)', 'Dance', 'https://www.youtube.com/watch?v=1xMBiJiVRgA', 'Remix')

insert into videos (title, description, url, genre) values ('Tenterhook - What I Like', 'Folky', 'https://www.youtube.com/watch?v=PlDgyMiqlZU', 'Folk')

