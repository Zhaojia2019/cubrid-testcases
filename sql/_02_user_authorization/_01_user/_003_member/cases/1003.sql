-- [er]add non-exisiting member(user) to public group 
autocommit off;

call login('dba','') on class db_user;

call find_user ('public') on class db_user to admin;

call add_member('user1') ON admin;

DROP user user1;
rollback;

autocommit on;
