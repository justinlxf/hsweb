use ���ݿ���
go
If Object_ID('web_users','U') Is Null
CREATE TABLE web_users (
   user_id int identity (1,1) primary key, --�û�id
   parent_id int  NOT NULL DEFAULT '0', --��id��΢�̳���ʱ����
   password varchar(255) not null, --���룬΢�̳���ʱû��
   serial_num varchar(255) not null --�û����к�
 );
If Object_ID('web_user_invited_link','U') Is Null
CREATE TABLE web_user_invited_link (
  user_id int  NOT NULL,    --�û�id
  invited_id int  NOT NULL, --�����û�id
  invite_time DATETIME DEFAULT(GETDATE()) --����ʱ��
);

If Object_ID('web_oauth_login','U') Is Null
begin
CREATE TABLE web_oauth_login (
   login_id int identity (1,1) primary key, --����id
   oauth_id varchar(255) NOT NULL,    --��΢��openid
   user_id int NOT NULL,  --�û�id
   oauth_name varchar(255) not null,  --��½����Ϣ
   oauth_access_token varchar(255) not null,--��½����Ϣ
   oauth_expires varchar(255) not null,--��½����Ϣ
   is_subcribe bit not null ,    --�Ƿ��ע
   is_subscribe_show bit not null default 1, --΢�̳�δʹ��
   is_point_send bit not null default 0, --΢�̳�δʹ��
 );
end
CREATE NONCLUSTERED INDEX oauthIdx ON web_oauth_login(oauth_id)


If Object_ID('web_user_profiles','U') Is Null
begin
CREATE TABLE web_user_profiles(
   profile_id int identity (1,1) primary key, --����id
   user_id int  NOT NULL, --�û�id
   image varchar(255) NOT NULL default '', --�û�ͷ��
   email varchar(255) NOT NULL default '', --΢�̳�δʹ��
   phone varchar(32) NOT NULL DEFAULT '',  --������ϰ壬��Ӧ���ֻ���½�ֻ���
   name varchar(255) NOT NULL DEFAULT'',  --�û���
   nick_name varchar(255) NOT NULL DEFAULT'', --�ǳ�
   login_count smallint NOT NULL DEFAULT 0, --΢�̳�δʹ��
   regist_time  DATETIME DEFAULT(GETDATE()), --ע��ʱ��
   is_active bit NOT NULL DEFAULT '1', --΢�̳�δʹ��
   ip_addr varchar(255) not null default '', --΢�̳�δʹ��
   vip_image varchar(255) NOT NULL default '', --��ά���ַ
   vip_jbarcode varchar(255) NOT NULL default '', --�������ַ
   last_buy DATETIME DEFAULT null, --���һ�ι���ʱ��
);
end
CREATE NONCLUSTERED INDEX uidIdx ON web_oauth_login(user_id)


If Object_ID('web_payment_orders','U') Is Null
begin
CREATE TABLE web_payment_orders(
   payment_order_id int identity (1,1) primary key, --֧������id
   user_id int  NOT NULL, --�û�id
   payment_id int  NOT NULL, --֧����ʽid
   payment_serial_num varchar(255) NOT NULL, --֧������
   transaction_id varchar(255) NOT NULL DEFAULT '', --�ⲿ֧�����׺�
   money decimal(20,2) NOT NULL DEFAULT '0.00', --֧�����
   transaction_type smallint not null default 1, --�������� 1Ϊ��Ʒ������2Ϊ��ֵ����
   is_completed bit NOT NULL DEFAULT '0', --�Ƿ����֧��
   create_time DATETIME DEFAULT(GETDATE()), --����ʱ��
   complete_time DATETIME DEFAULT null, --���ʱ��
   is_sync bit not null default 0  --�Ƿ���ͬ����������ʯϵͳ
);
end
CREATE NONCLUSTERED INDEX uidIdx ON web_payment_orders(user_id)


If Object_ID('web_orders','U') Is Null
begin
CREATE TABLE web_orders(
   order_id int identity (1,1) primary key, --����id
   order_serial_num varchar(255) NOT NULL DEFAULT '', --������
   user_id int  NOT NULL , --�û�id
   store_id int NOT NULL,  --���˵�id
   payment_order_id int NOT NULL DEFAULT 0, --֧����id
   province VARCHAR(255) not null default '', --ʡ��
   city VARCHAR(255) not null default '', --����
   region VARCHAR(255) not null default '', --����
   addr_detail VARCHAR(255) not null default '', --��ϸ��ַ
   name VARCHAR(255) not null default '', --�ջ���
   phone VARCHAR(255) not null default '', --�ջ�����
   zip_code VARCHAR(255) not null default '', --�ʱ�
   create_time DATETIME DEFAULT(GETDATE()), -- ����ʱ��
   pay_time DATETIME DEFAULT null, -- ֧��ʱ��
   shipping_cost decimal(20,2) NOT NULL DEFAULT '0.00', --�˷�
   total_price decimal(20,2) NOT NULL, --�ܼ�
   voucher_price decimal(20,2) NOT NULL default 0.00, --����ȯʹ�ý��
   voucher_code VARCHAR(255) not null default '',  --����ȯ���
   status smallint NOT NULL DEFAULT '1', --״̬��1δ֧����2��֧��
   remark VARCHAR(255) not null default '', --��ע
   pick_time DATETIME DEFAULT null,--ȡ��ʱ��
   is_self_pick bit not null default 0,--�Ƿ�����
   first_dist_id int not null default 0, --��һ������id
   first_dist_money decimal(20,2) NOT NULL default 0, --һ���������
   second_dist_id int not null default 0, --��������id
   second_dist_money decimal(20,2) NOT NULL default 0, --�����������
   sync_status smallint NOT NULL DEFAULT '100',
);
end
CREATE NONCLUSTERED INDEX orderSerialNumIdx ON web_orders(order_serial_num)


If Object_ID('web_order_items','U') Is Null
begin
CREATE TABLE web_order_items(
   item_id int identity (1,1) primary key,
   item_serial_num varchar(255) NOT NULL DEFAULT '',
   order_id int NOT NULL ,
   store_id int NOT NULL,
   product_id int NOT NULL,
   image_url varchar(255) NOT NULL DEFAULT '',
   value_id int NOT NULL,
   value varchar(255) not null default '',
   amount smallint NOT NULL DEFAULT 0,
   price decimal(20,2) NOT NULL
);
end
CREATE NONCLUSTERED INDEX orderIdx ON web_order_items(order_id)


If Object_ID('web_payments','U') Is Null
CREATE TABLE web_payments(
   payment_id int identity (1,1) primary key,
   payment_name varchar(255) NOT NULL ,
   unit varchar(255) not null default '',
   platform varchar(255) not null default '',
   is_active bit NOT NULL DEFAULT '1',
   strategy_class_name varchar(255) not  NULL
);

If Object_ID('web_vars','U') Is Null
CREATE TABLE web_vars (
  var_id int identity (1,1) primary key,
  platform varchar(255) NOT NULL DEFAULT '',
  name varchar(255) NOT NULL DEFAULT '',
  storage_time DATETIME DEFAULT(GETDATE()),
  value varchar(1024) NOT NULL DEFAULT '',
);

If Object_ID('web_roles','U') Is Null
CREATE TABLE web_roles(
   role_id int identity (1,1) primary key,
   role varchar(255) NOT NULL ,
   parent_id int NOT NULL default 0,
   is_active bit NOT NULL DEFAULT '1',
   is_in_list bit not null default '1'
);

If Object_ID('web_user_role_link','U') Is Null
CREATE TABLE web_user_role_link(
   user_id int NOT NULL,
   role_id int NOT NULL
);

If Object_ID('web_permissions','U') Is Null
CREATE TABLE web_permissions(
   permission_id int identity (1,1) primary key,
   permission varchar(255) NOT NULL,
   tag VARCHAR(255) NOT NULL DEFAULT '',
   name varchar(255) NOT NULL,
   is_active bit NOT NULL DEFAULT '1'
);


If Object_ID('web_role_permission_link','U') Is Null
CREATE TABLE web_role_permission_link(
   role_id int  NOT NULL,
   permission_id int NOT NULL
);

If Object_ID('web_categories','U') Is Null
CREATE TABLE web_categories(
   category_id int identity (1,1) primary key,
   category  varchar(255) NOT NULL,
   parent_id int NOT NULL
);

If Object_ID('web_products_categories_link','U') Is Null
CREATE TABLE web_products_categories_link(
   product_id int NOT NULL,
   category_id int NOT NULL
);

If Object_ID('web_products','U') Is Null
CREATE TABLE web_products (
   product_id int identity (1,1) primary key,
   title varchar(255) NOT NULL DEFAULT '', 
   description varchar(255) NOT NULL DEFAULT '', 
   create_time DATETIME DEFAULT(GETDATE()), 
   last_modify DATETIME DEFAULT(GETDATE()),
   is_active bit NOT NULL DEFAULT '0',
   price decimal(20,2) NOT NULL DEFAULT '0.00',
 );
 alter table web_products add is_shipping_free bit not null DEFAULT 0;
 alter table web_products add is_show bit not null default 1;
 alter table web_products add Explain varchar(255);
 
 

If Object_ID('web_product_images_link','U') Is Null
 CREATE TABLE web_product_images_link(
   link_id int identity (1,1) primary key,
   product_id int NOT NULL ,
   image_url varchar(255) NOT NULL DEFAULT ''
);

If Object_ID('web_specifications','U') Is Null
 CREATE TABLE web_specifications(
   specification_id int identity (1,1) primary key,
   specification varchar(255) NOT NULL DEFAULT ''
);

If Object_ID('web_specification_values','U') Is Null
CREATE TABLE web_specification_values(
   value_id int identity (1,1) primary key,
   specification_id int not null,
   value varchar(255) NOT NULL DEFAULT '',
   hs_goods_code varchar(255) not null,
   hs_goods_price decimal(20,2) NOT NULL DEFAULT '0.00',
   hs_stock int not null,
   pre_price decimal(20,2) NOT NULL DEFAULT '0.00'
);

If Object_ID('web_products_specifications_values_link','U') Is Null
 CREATE TABLE web_products_specifications_values_link(
   specification_id int  NOT NULL,
   value_id int  NOT NULL,
   product_id int not null
);

If Object_ID('web_product_groups','U') Is Null
 CREATE TABLE web_product_groups (
  group_id int identity (1,1) primary key,
  group_name varchar(255) NOT NULL,
  tag varchar(255) not null default '',
  display_type varchar(255) not null default '',
  is_active bit NOT NULL DEFAULT '0'
);

If Object_ID('web_product_group_links','U') Is Null
CREATE TABLE web_product_group_links (
  group_id int not null,
  product_id int  NOT NULL,
  position int  NOT NULL default 0
);

If Object_ID('web_napa_stores','U') Is Null
 create table web_napa_stores(
   store_id int identity (1,1) primary key,
   user_id int not null,
   store_name varchar(255) not null,
   province varchar(255) not null,
   city varchar(255) not null,
   region varchar(255) not null,
   addr_detail varchar(255) not null,
   longitude varchar(255) not null,
   latitude varchar(255) not null,
   hs_code varchar(255) not null
);

If Object_ID('web_specification_value_store_link','U') Is Null
CREATE TABLE web_specification_value_store_link (
   value_id int not null,
   store_id int not null
 );

If Object_ID('web_province','U') Is Null
 CREATE TABLE web_province(
   province_id int primary key,
   province varchar(255) NOT NULL ,
);

If Object_ID('web_cities','U') Is Null
CREATE TABLE web_cities(
   city_id int primary key,
   province_id int NOT NULL,
   city varchar(255) NOT NULL 
);

If Object_ID('web_regions','U') Is Null
CREATE TABLE web_regions(
   region_id int primary key,
   city_id int  NOT NULL,
   region varchar(255) NOT NULL 
);

If Object_ID('web_deliver_addrs','U') Is Null
begin
CREATE TABLE web_deliver_addrs(
  
 deliverAddr_id int identity (1,1) primary key,
  
 user_id int  NOT NULL ,
  
 name varchar(255) NOT NULL DEFAULT '',
  
 phone varchar(32) NOT NULL DEFAULT '',
   
province varchar(32) NOT NULL DEFAULT '',
   
city varchar(32) NOT NULL DEFAULT '',
 
  region varchar(32) NOT NULL DEFAULT '',
 
  addr_detail varchar(255) NOT NULL DEFAULT'',
 
  zipCode varchar(32) NOT NULL DEFAULT '',
 
  is_default bit NOT NULL DEFAULT 0,
 
  longitude varchar(255) not null default '',
  
 latitude varchar(255) not null default ''

);
end
CREATE NONCLUSTERED INDEX userIdx ON web_deliver_addrs(user_id);


If Object_ID('web_cart','U') Is Null
begin
create table web_cart(
   cart_id int identity (1,1) primary key,
   user_id int not null,
   product_id int not null,
   specification_value_id int not null,
   amount int not null,
   create_time DATETIME DEFAULT(GETDATE())
);
end
CREATE NONCLUSTERED INDEX userIdx ON web_cart(user_id);

If Object_ID('web_datasource','U') Is Null
CREATE TABLE web_datasource (
  id int identity (1,1) primary key,
  driver_class_name varchar(255) NOT NULL,
  url varchar(255) NOT NULL,
  username varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  merchant_code varchar(255) NOT NULL
);

If Object_ID('web_config','U') Is Null
create table web_config(
  id int identity (1,1) primary key,
  tag varchar(255) not null,
  value varchar(255) not null
);

If Object_ID('web_sign_record','U') Is Null
create table web_sign_record(
  id int identity (1,1) primary key,
  user_id int not null,
  sign_time DATETIME DEFAULT(GETDATE()),
  point int not null default 0
);

If Object_ID('web_balance','U') Is Null
create table web_balance(
  id int identity (1,1) primary key,
  user_id int not null,
  balance decimal(20,2) NOT NULL,
);

If Object_ID('web_balance_log','U') Is Null
create table web_balance_log(
  id int identity (1,1) primary key,
  user_id int not null,
  money decimal(20,2) NOT NULL,
  balance decimal(20,2) NOT NULL,
  create_time DATETIME DEFAULT(GETDATE())
);

If Object_ID('web_freight','U') Is Null
create table web_freight(
  id int identity (1,1) primary key,
  condition float not null default 0.00,
  money decimal(20,2) NOT NULL
);

If Object_ID('web_recharge_config','U') Is Null
create table web_recharge_config(
  id int identity (1,1) primary key,
  money decimal(20,2) NOT NULL,
  rewards decimal(20,2) NOT NULL default 0,
  voucher_code varchar(255) not null default '',
  type int not null default 1,
  start_time DATETIME DEFAULT(GETDATE()),
  end_time DATETIME DEFAULT(GETDATE())
);

If Object_ID('web_lottery_draw_config','U') Is Null
create table web_lottery_draw_config(
  id int identity(1,1) primary key,
  voucher_code varchar(255) default null,
  money decimal(20,2) default null,
  product_id int not null default 0,
  code varchar(255) not null default '',
  rate float not null default 0.00,
  count int not null default 0,
  is_end bit not null default 0,
  limits int not null default 10000,
  start_time DATETIME DEFAULT(GETDATE()),
  end_time DATETIME DEFAULT(GETDATE())
);

If Object_ID('web_lottery_record','U') Is Null
create table web_lottery_record(
  id int identity(1,1) primary key,
  user_id int not null,
  time DATETIME DEFAULT(GETDATE())
);

If Object_ID('web_banner','U') Is Null
create table web_banner(
  id int identity(1,1) primary key,
  image_url varchar(255) not null default '',
  link varchar(255) not null default ''
);

If Object_ID('web_shake_record','U') Is Null
create table web_shake_record(
  id int identity(1,1) primary key,
  user_id int not null,
  time DATETIME DEFAULT(GETDATE()),
  is_show bit not null default 0
);

If Object_ID('web_winning_record','U') Is Null
create table web_winning_record(
  id int identity(1,1) primary key,
  user_id int not null,
  winning_level int not null,
  time DATETIME DEFAULT(GETDATE()) 
);

If Object_ID('web_store_info','U') Is Null
create table web_store_info(
  id int identity(1,1) primary key,
  description varchar(255) not null default '',
);

If Object_ID('web_product_sale','U') Is Null
create table web_product_sale(
  id int identity(1,1) primary key,
  product_id int not null ,
  count int not null default 0,
);

If Object_ID('web_msg_record','U') Is Null
create table web_msg_record(
  id int identity(1,1) primary key,
  user_id int not null ,
  type int not null default 0,
  time DATETIME DEFAULT(GETDATE()),
);
/*������*/
If Object_ID('web_home_quick_navi ','U') Is Null
CREATE TABLE web_home_quick_navi (
  navi_id int identity (1,1) primary key,
  title varchar(255) NOT NULL DEFAULT '',
  image_url varchar(255) NOT NULL DEFAULT ''
);

If Object_ID('web_quick_navi_product_link  ','U') Is Null
CREATE TABLE web_quick_navi_product_link (
  id int identity (1,1) primary key,   
  navi_id int  NOT NULL, 
  product_id int  NOT NULL, 
);


If Object_ID('web_message  ','U') Is Null
CREATE TABLE web_message (
  id int identity (1,1) primary key,
  oauth_id varchar(255) NOT NULL DEFAULT '',
  order_num varchar(255) not null DEFAULT '',
  time DATETIME DEFAULT(GETDATE()),
  money decimal(20,2) NOT NULL DEFAULT '0.00',
  pay_type varchar(255) not null DEFAULT '',
  is_send bit NOT NULL DEFAULT 0
);

If Object_ID('web_comment  ','U') Is Null
CREATE TABLE web_comment (
  id int identity (1,1) primary key,
  user_id int not null,
  order_serial_num varchar(255) NOT NULL,
  title varchar(1024) not null DEFAULT '',
  deliver int NOT NULL DEFAULT 5,
  service int NOT NULL DEFAULT 5,
  quality int NOT NULL DEFAULT 5,
  back_title varchar(1024) not null DEFAULT '',
  time DATETIME DEFAULT(GETDATE()),
  back_time DATETIME DEFAULT null
);

alter table web_recharge_config add amount int default 0;
alter table web_recharge_config add amount_second int default 0;
alter table web_recharge_config add amount_third int default 0;
alter table web_recharge_config add voucher_code_second varchar(255) default null;
alter table web_recharge_config add voucher_code_third varchar(255) default null;
alter table web_recharge_config add limit int default 0;
alter table web_recharge_config add start_time DATETIME DEFAULT null;
alter table web_recharge_config add end_time DATETIME DEFAULT null;

If Object_ID('web_birth_voucher  ','U') Is Null
CREATE TABLE web_birth_voucher (
  id int identity (1,1) primary key,
  voucher_code varchar(255) NOT NULL DEFAULT '',
  amount int NOT NULL DEFAULT 0,
  time DATETIME DEFAULT(GETDATE())
);

If Object_ID('web_shipping_full_cut  ','U') Is Null
CREATE TABLE web_shipping_full_cut (
  id int identity (1,1) primary key,
  s_limit float not null ,
  u_limit float not null ,
  condition decimal(15,2) not null ,
  time DATETIME DEFAULT(GETDATE()),
  start_time DATETIME DEFAULT null,
  end_time DATETIME DEFAULT null
);

If Object_ID('web_recharge_rewards_record  ','U') Is Null
CREATE TABLE web_recharge_rewards_record (
  id int identity (1,1) primary key,
  user_id int not null,
  config_id int not null,
  count int not null default 0
);

If Object_ID('web_full_cut ','U') Is Null
CREATE TABLE web_full_cut (
  id int identity (1,1) primary key,
  condition decimal(15,2) not null,
  cut decimal(15,2) not null ,
  time DATETIME DEFAULT(GETDATE()),
  start_time DATETIME DEFAULT null,
  end_time DATETIME DEFAULT null
);

If Object_ID('web_binding_rewards  ','U') Is Null
CREATE TABLE web_binding_rewards (
  id int identity (1,1) primary key,
  point int not null default 0,
  voucher_code varchar(255) NOT NULL DEFAULT '',
  amount int NOT NULL DEFAULT 1,
  time DATETIME DEFAULT(GETDATE())
);

alter table web_orders add cut decimal(15,2) not null default 0 ;

alter table web_orders add pick_up_image varchar(255) not null default '';
alter table web_orders add pick_up_barcode varchar(255) not null default '';

/*2017/10/25*/
If Object_ID('web_napa_store_user_link','U') Is Null
create table web_napa_store_user_link(
  id int identity(1,1) primary key,
  user_id int not null ,
  store_id int not null 
);


insert into web_napa_store_user_link (store_id,user_id) select store_id,user_id from web_napa_stores;


alter table web_napa_stores drop column user_id;
 
/*web_banner��ʼ����*/
insert into web_banner (image_url) values ('http://120.25.193.220/group1/M00/31/AD/eBnB3Fk9GD6AIPnoAABjjVg2HRo57.file');
insert into web_banner (image_url) values ('http://120.25.193.220/group1/M00/31/AD/eBnB3Fk9GFaAEUgtAACT8LBtwhw95.file');
insert into web_banner (image_url) values ('http://120.25.193.220/group1/M00/31/AD/eBnB3Fk9GBSAPOnyAACmblVhynw90.file');

/*web_freight��ʼ����*/
insert into web_freight (condition,money) values (10,8);
  insert into web_freight (condition,money) values (20,10);
    insert into web_freight (condition,money) values (30,12);

/*web_product_groups��ʼ����*/
insert into web_product_groups(group_name,tag,display_type,is_active) values ('�����Ƽ�','recommend','horizontal','1');
insert into web_product_groups(group_name,tag,display_type,is_active) values ('���̾�Ʒ','hotProduct','vertical','1');

/*web_payments����ʼ����*/
insert into web_payments (payment_name,unit,platform,is_active,strategy_class_name) values ('΢��֧��','WeChat','WAP',1,'WCJSAPIPaymentStrategy');
 insert into web_payments (payment_name,unit,platform,is_active,strategy_class_name) values ('��Ա��֧��','VipCard','WAP',1,'MemberCardPaymentStrategy');
 insert into web_payments (payment_name,unit,platform,is_active,strategy_class_name) values ('֧����֧��','Alipay','WAP',1,'AlipayPaymentStrategy');

/*web_recharge_config*/
insert into web_recharge_config (money,rewards) values (50,10);
insert into web_recharge_config (money,rewards) values (100,15);
insert into web_recharge_config (money,rewards) values (150,20);
insert into web_recharge_config (money,rewards) values (200,25);
insert into web_recharge_config (money,rewards) values (250,30);
insert into web_recharge_config (money,rewards) values (300,35);
insert into web_recharge_config (money,rewards) values (400,40);
insert into web_recharge_config (money,rewards) values (500,50);
insert into web_recharge_config (money,rewards) values (800,80);
insert into web_recharge_config (money,rewards) values (1000,100);

/*web_categories*/
insert into web_categories (category,parent_id) values ('�����',0);
insert into web_categories (category,parent_id) values ('���',0);
insert into web_categories (category,parent_id) values ('���յ���',0);
insert into web_categories (category,parent_id) values ('�ɿ�������',0);
insert into web_categories (category,parent_id) values ('�ʹ�����',0);
insert into web_categories (category,parent_id) values ('֥ʿĽ˹����',0);
insert into web_categories (category,parent_id) values ('��㵰��',0);
insert into web_categories (category,parent_id) values ('���ӵ���',0);
insert into web_categories (category,parent_id) values ('���յ���',0);


/*web_role*/
insert into web_roles (role,parent_id,is_active) values ('admin',0,1);
insert into web_roles (role,parent_id,is_active) values ('user',0,1);
insert into web_roles (role,parent_id,is_active) values ('business',0,1);

/*web_var*/
insert into web_vars (platform,name,storage_time,value) values ('WX','access_token','2017-01-01 00:00:00','CO4OuunYImgxUl1tZu6BDcyDlT2RhISAkfuv_rUE2RKKUhoRjtVWJeTLwkzq5DCO6TJwlhcLgIHTd8VsMzZzyC6Bui00l2eFBwoH_u-aVZxjBzy_Et77YqW0p71Klb5QXTPjADATPL');

/*web_specifications*/
insert into web_specifications(specification) values ('��ʽ');

/*web_config����ʼ����*/
insert into web_config (tag,value) values ('registPoint','10');
insert into web_config (tag,value) values ('signInPoint','10');
insert into web_config (tag,value) values ('drawPoint','10');
insert into web_config (tag,value) values ('firstDis','10');
insert into web_config (tag,value) values ('secondDis','10');
insert into web_config (tag,value) values ('appid','wx68abe3fb2a71dcc7');
insert into web_config (tag,value) values ('appsecret','00030b62032af67f83e535223616a0d6');
insert into web_config (tag,value) values ('appkey','00030b62032af67f83e535223616a0d6');
insert into web_config (tag,value) values ('merchantcode','1253393501');
insert into web_config (tag,value) values ('notifyurl','http://hs.uclee.com/seller/WCNotifyHandler');
insert into web_config (tag,value) values ('partner','');
insert into web_config (tag,value) values ('sellerId','');
insert into web_config (tag,value) values ('key','');
insert into web_config (tag,value) values ('alipayNotifyUrl','');
insert into web_config (tag,value) values ('firstPrize',2);
insert into web_config (tag,value) values ('secondPrize',10);
insert into web_config (tag,value) values ('thirdPrize',30);
insert into web_config (tag,value) values ('signName','��ʯ����');
insert into web_config (tag,value) values ('firstCount',2);
insert into web_config (tag,value) values ('secondCount',10);
insert into web_config (tag,value) values ('thirdCount',30);
insert into web_config (tag,value) values ('aliAppkey','LTAIb36ti4sJYhwY');
insert into web_config (tag,value) values ('aliAppSecret','wDkzuBidUH6oog7jvdxW9A4JNS42br');
insert into web_config (tag,value) values ('templateCode','SMS_94630154');
insert into web_config (tag,value) values ('birthTmpId','EMzRY8T0fa90sGTBYZkINvxTGn_nvwKjHZUxtpTmVew');
insert into web_config (tag,value) values ('buyTmpId','EMzRY8T0fa90sGTBYZkINvxTGn_nvwKjHZUxtpTmVew');
insert into web_config (tag,value) values ('payTmpId','S3vfLhEEbVICFmwgpHedYUtlm7atyY3zl-GxJYY20ok');
insert into web_config (tag,value) values ('rechargeTmpId','TBY-Wrn9sQuOoM_BUNZO2aEjX56AG6RRNxHrEH8k_pI');
insert into web_config (tag,value) values ('bindText','');
insert into web_config (tag,value) values ('supportDeliver','');
insert into web_config (tag,value) values ('domain','');
insert into web_config (tag,value) values ('hsMerchantCode','');
insert into web_config (tag,value) values ('logoUrl','http://wsc.in80s.com/file/file1507708577132837.jpg');
insert into web_config (tag,value) values ('ucenterImg','http://wsc.in80s.com/file/file1507708606025464.jpg');
insert into web_config (tag,value) values ('birthText','');
insert into web_config (tag,value) values ('salesText','');
insert into web_config (tag,value) values ('restrictedDistance','50');






/*province��ʼ����*/
insert into web_province (province_id,province) values (11,'����');
insert into web_province (province_id,province) values (12,'���');
insert into web_province (province_id,province) values (13,'�ӱ�ʡ');
insert into web_province (province_id,province) values (14,'ɽ��ʡ');
insert into web_province (province_id,province) values (15,'���ɹ�������');
insert into web_province (province_id,province) values (21,'����ʡ');
insert into web_province (province_id,province) values (22,'����ʡ');
insert into web_province (province_id,province) values (23,'������ʡ');
insert into web_province (province_id,province) values (31,'�Ϻ�');
insert into web_province (province_id,province) values (32,'����ʡ');
insert into web_province (province_id,province) values (33,'�㽭ʡ');
insert into web_province (province_id,province) values (34,'����ʡ');
insert into web_province (province_id,province) values (35,'����ʡ');
insert into web_province (province_id,province) values (36,'����ʡ');
insert into web_province (province_id,province) values (37,'ɽ��ʡ');
insert into web_province (province_id,province) values (41,'����ʡ');
insert into web_province (province_id,province) values (42,'����ʡ');
insert into web_province (province_id,province) values (43,'����ʡ');
insert into web_province (province_id,province) values (44,'�㶫ʡ');
insert into web_province (province_id,province) values (45,'����׳��������');
insert into web_province (province_id,province) values (46,'����ʡ');
insert into web_province (province_id,province) values (50,'����');
insert into web_province (province_id,province) values (51,'�Ĵ�ʡ');
insert into web_province (province_id,province) values (52,'����ʡ');
insert into web_province (province_id,province) values (53,'����ʡ');
insert into web_province (province_id,province) values (54,'����������');
insert into web_province (province_id,province) values (61,'����ʡ');
insert into web_province (province_id,province) values (62,'����ʡ');
insert into web_province (province_id,province) values (63,'�ຣʡ');
insert into web_province (province_id,province) values (64,'���Ļ���������');
insert into web_province (province_id,province) values (65,'�½�ά���������');
insert into web_province (province_id,province) values (71,'̨��');
insert into web_province (province_id,province) values (81,'����ر�������');
insert into web_province (province_id,province) values (82,'�����ر�������');
insert into web_province (province_id,province) values (90,'���㵺');

/*web_city��ʼ����*/
insert into web_cities (city_id,province_id,city) values (1101,11,'������');
insert into web_cities (city_id,province_id,city) values (1201,12,'�����');
insert into web_cities (city_id,province_id,city) values (1301,13,'ʯ��ׯ��');
insert into web_cities (city_id,province_id,city) values (1302,13,'��ɽ��');
insert into web_cities (city_id,province_id,city) values (1303,13,'�ػʵ���');
insert into web_cities (city_id,province_id,city) values (1304,13,'������');
insert into web_cities (city_id,province_id,city) values (1305,13,'��̨��');
insert into web_cities (city_id,province_id,city) values (1306,13,'������');
insert into web_cities (city_id,province_id,city) values (1307,13,'�żҿ���');
insert into web_cities (city_id,province_id,city) values (1308,13,'�е���');
insert into web_cities (city_id,province_id,city) values (1309,13,'������');
insert into web_cities (city_id,province_id,city) values (1310,13,'�ȷ���');
insert into web_cities (city_id,province_id,city) values (1311,13,'��ˮ��');
insert into web_cities (city_id,province_id,city) values (1401,14,'̫ԭ��');
insert into web_cities (city_id,province_id,city) values (1402,14,'��ͬ��');
insert into web_cities (city_id,province_id,city) values (1403,14,'��Ȫ��');
insert into web_cities (city_id,province_id,city) values (1404,14,'������');
insert into web_cities (city_id,province_id,city) values (1405,14,'������');
insert into web_cities (city_id,province_id,city) values (1406,14,'˷����');
insert into web_cities (city_id,province_id,city) values (1407,14,'������');
insert into web_cities (city_id,province_id,city) values (1408,14,'�˳���');
insert into web_cities (city_id,province_id,city) values (1409,14,'������');
insert into web_cities (city_id,province_id,city) values (1410,14,'�ٷ���');
insert into web_cities (city_id,province_id,city) values (1411,14,'������');
insert into web_cities (city_id,province_id,city) values (1501,15,'���ͺ�����');
insert into web_cities (city_id,province_id,city) values (1502,15,'��ͷ��');
insert into web_cities (city_id,province_id,city) values (1503,15,'�ں���');
insert into web_cities (city_id,province_id,city) values (1504,15,'�����');
insert into web_cities (city_id,province_id,city) values (1505,15,'ͨ����');
insert into web_cities (city_id,province_id,city) values (1506,15,'������˹��');
insert into web_cities (city_id,province_id,city) values (1507,15,'���ױ�����');
insert into web_cities (city_id,province_id,city) values (1508,15,'�����׶���');
insert into web_cities (city_id,province_id,city) values (1509,15,'�����첼��');
insert into web_cities (city_id,province_id,city) values (1522,15,'�˰���');
insert into web_cities (city_id,province_id,city) values (1525,15,'���ֹ�����');
insert into web_cities (city_id,province_id,city) values (1529,15,'��������');
insert into web_cities (city_id,province_id,city) values (2101,21,'������');
insert into web_cities (city_id,province_id,city) values (2102,21,'������');
insert into web_cities (city_id,province_id,city) values (2103,21,'��ɽ��');
insert into web_cities (city_id,province_id,city) values (2104,21,'��˳��');
insert into web_cities (city_id,province_id,city) values (2105,21,'��Ϫ��');
insert into web_cities (city_id,province_id,city) values (2106,21,'������');
insert into web_cities (city_id,province_id,city) values (2107,21,'������');
insert into web_cities (city_id,province_id,city) values (2108,21,'Ӫ����');
insert into web_cities (city_id,province_id,city) values (2109,21,'������');
insert into web_cities (city_id,province_id,city) values (2110,21,'������');
insert into web_cities (city_id,province_id,city) values (2111,21,'�̽���');
insert into web_cities (city_id,province_id,city) values (2112,21,'������');
insert into web_cities (city_id,province_id,city) values (2113,21,'������');
insert into web_cities (city_id,province_id,city) values (2114,21,'��«����');
insert into web_cities (city_id,province_id,city) values (2115,21,'��������');
insert into web_cities (city_id,province_id,city) values (2201,22,'������');
insert into web_cities (city_id,province_id,city) values (2202,22,'������');
insert into web_cities (city_id,province_id,city) values (2203,22,'��ƽ��');
insert into web_cities (city_id,province_id,city) values (2204,22,'��Դ��');
insert into web_cities (city_id,province_id,city) values (2205,22,'ͨ����');
insert into web_cities (city_id,province_id,city) values (2206,22,'��ɽ��');
insert into web_cities (city_id,province_id,city) values (2207,22,'��ԭ��');
insert into web_cities (city_id,province_id,city) values (2208,22,'�׳���');
insert into web_cities (city_id,province_id,city) values (2224,22,'�ӱ߳�����������');
insert into web_cities (city_id,province_id,city) values (2301,23,'��������');
insert into web_cities (city_id,province_id,city) values (2302,23,'���������');
insert into web_cities (city_id,province_id,city) values (2303,23,'������');
insert into web_cities (city_id,province_id,city) values (2304,23,'�׸���');
insert into web_cities (city_id,province_id,city) values (2305,23,'˫Ѽɽ��');
insert into web_cities (city_id,province_id,city) values (2306,23,'������');
insert into web_cities (city_id,province_id,city) values (2307,23,'������');
insert into web_cities (city_id,province_id,city) values (2308,23,'��ľ˹��');
insert into web_cities (city_id,province_id,city) values (2309,23,'��̨����');
insert into web_cities (city_id,province_id,city) values (2310,23,'ĵ������');
insert into web_cities (city_id,province_id,city) values (2311,23,'�ں���');
insert into web_cities (city_id,province_id,city) values (2312,23,'�绯��');
insert into web_cities (city_id,province_id,city) values (2327,23,'���˰������');
insert into web_cities (city_id,province_id,city) values (3101,31,'�Ϻ���');
insert into web_cities (city_id,province_id,city) values (3201,32,'�Ͼ���');
insert into web_cities (city_id,province_id,city) values (3202,32,'������');
insert into web_cities (city_id,province_id,city) values (3203,32,'������');
insert into web_cities (city_id,province_id,city) values (3204,32,'������');
insert into web_cities (city_id,province_id,city) values (3205,32,'������');
insert into web_cities (city_id,province_id,city) values (3206,32,'��ͨ��');
insert into web_cities (city_id,province_id,city) values (3207,32,'���Ƹ���');
insert into web_cities (city_id,province_id,city) values (3208,32,'������');
insert into web_cities (city_id,province_id,city) values (3209,32,'�γ���');
insert into web_cities (city_id,province_id,city) values (3210,32,'������');
insert into web_cities (city_id,province_id,city) values (3211,32,'����');
insert into web_cities (city_id,province_id,city) values (3212,32,'̩����');
insert into web_cities (city_id,province_id,city) values (3213,32,'��Ǩ��');
insert into web_cities (city_id,province_id,city) values (3301,33,'������');
insert into web_cities (city_id,province_id,city) values (3302,33,'������');
insert into web_cities (city_id,province_id,city) values (3303,33,'������');
insert into web_cities (city_id,province_id,city) values (3304,33,'������');
insert into web_cities (city_id,province_id,city) values (3305,33,'������');
insert into web_cities (city_id,province_id,city) values (3306,33,'������');
insert into web_cities (city_id,province_id,city) values (3307,33,'����');
insert into web_cities (city_id,province_id,city) values (3308,33,'������');
insert into web_cities (city_id,province_id,city) values (3309,33,'��ɽ��');
insert into web_cities (city_id,province_id,city) values (3310,33,'̨����');
insert into web_cities (city_id,province_id,city) values (3311,33,'��ˮ��');
insert into web_cities (city_id,province_id,city) values (3312,33,'��ɽȺ������');
insert into web_cities (city_id,province_id,city) values (3401,34,'�Ϸ���');
insert into web_cities (city_id,province_id,city) values (3402,34,'�ߺ���');
insert into web_cities (city_id,province_id,city) values (3403,34,'������');
insert into web_cities (city_id,province_id,city) values (3404,34,'������');
insert into web_cities (city_id,province_id,city) values (3405,34,'����ɽ��');
insert into web_cities (city_id,province_id,city) values (3406,34,'������');
insert into web_cities (city_id,province_id,city) values (3407,34,'ͭ����');
insert into web_cities (city_id,province_id,city) values (3408,34,'������');
insert into web_cities (city_id,province_id,city) values (3410,34,'��ɽ��');
insert into web_cities (city_id,province_id,city) values (3411,34,'������');
insert into web_cities (city_id,province_id,city) values (3412,34,'������');
insert into web_cities (city_id,province_id,city) values (3413,34,'������');
insert into web_cities (city_id,province_id,city) values (3415,34,'������');
insert into web_cities (city_id,province_id,city) values (3416,34,'������');
insert into web_cities (city_id,province_id,city) values (3417,34,'������');
insert into web_cities (city_id,province_id,city) values (3418,34,'������');
insert into web_cities (city_id,province_id,city) values (3501,35,'������');
insert into web_cities (city_id,province_id,city) values (3502,35,'������');
insert into web_cities (city_id,province_id,city) values (3503,35,'������');
insert into web_cities (city_id,province_id,city) values (3504,35,'������');
insert into web_cities (city_id,province_id,city) values (3505,35,'Ȫ����');
insert into web_cities (city_id,province_id,city) values (3506,35,'������');
insert into web_cities (city_id,province_id,city) values (3507,35,'��ƽ��');
insert into web_cities (city_id,province_id,city) values (3508,35,'������');
insert into web_cities (city_id,province_id,city) values (3509,35,'������');
insert into web_cities (city_id,province_id,city) values (3601,36,'�ϲ���');
insert into web_cities (city_id,province_id,city) values (3602,36,'��������');
insert into web_cities (city_id,province_id,city) values (3603,36,'Ƽ����');
insert into web_cities (city_id,province_id,city) values (3604,36,'�Ž���');
insert into web_cities (city_id,province_id,city) values (3605,36,'������');
insert into web_cities (city_id,province_id,city) values (3606,36,'ӥ̶��');
insert into web_cities (city_id,province_id,city) values (3607,36,'������');
insert into web_cities (city_id,province_id,city) values (3608,36,'������');
insert into web_cities (city_id,province_id,city) values (3609,36,'�˴���');
insert into web_cities (city_id,province_id,city) values (3610,36,'������');
insert into web_cities (city_id,province_id,city) values (3611,36,'������');
insert into web_cities (city_id,province_id,city) values (3701,37,'������');
insert into web_cities (city_id,province_id,city) values (3702,37,'�ൺ��');
insert into web_cities (city_id,province_id,city) values (3703,37,'�Ͳ���');
insert into web_cities (city_id,province_id,city) values (3704,37,'��ׯ��');
insert into web_cities (city_id,province_id,city) values (3705,37,'��Ӫ��');
insert into web_cities (city_id,province_id,city) values (3706,37,'��̨��');
insert into web_cities (city_id,province_id,city) values (3707,37,'Ϋ����');
insert into web_cities (city_id,province_id,city) values (3708,37,'������');
insert into web_cities (city_id,province_id,city) values (3709,37,'̩����');
insert into web_cities (city_id,province_id,city) values (3710,37,'������');
insert into web_cities (city_id,province_id,city) values (3711,37,'������');
insert into web_cities (city_id,province_id,city) values (3712,37,'������');
insert into web_cities (city_id,province_id,city) values (3713,37,'������');
insert into web_cities (city_id,province_id,city) values (3714,37,'������');
insert into web_cities (city_id,province_id,city) values (3715,37,'�ĳ���');
insert into web_cities (city_id,province_id,city) values (3716,37,'������');
insert into web_cities (city_id,province_id,city) values (3717,37,'������');
insert into web_cities (city_id,province_id,city) values (4101,41,'֣����');
insert into web_cities (city_id,province_id,city) values (4102,41,'������');
insert into web_cities (city_id,province_id,city) values (4103,41,'������');
insert into web_cities (city_id,province_id,city) values (4104,41,'ƽ��ɽ��');
insert into web_cities (city_id,province_id,city) values (4105,41,'������');
insert into web_cities (city_id,province_id,city) values (4106,41,'�ױ���');
insert into web_cities (city_id,province_id,city) values (4107,41,'������');
insert into web_cities (city_id,province_id,city) values (4108,41,'������');
insert into web_cities (city_id,province_id,city) values (4109,41,'�����');
insert into web_cities (city_id,province_id,city) values (4110,41,'������');
insert into web_cities (city_id,province_id,city) values (4111,41,'�����');
insert into web_cities (city_id,province_id,city) values (4112,41,'����Ͽ��');
insert into web_cities (city_id,province_id,city) values (4113,41,'������');
insert into web_cities (city_id,province_id,city) values (4114,41,'������');
insert into web_cities (city_id,province_id,city) values (4115,41,'������');
insert into web_cities (city_id,province_id,city) values (4116,41,'�ܿ���');
insert into web_cities (city_id,province_id,city) values (4117,41,'פ������');
insert into web_cities (city_id,province_id,city) values (4190,41,'ֱϽ�ؼ�');
insert into web_cities (city_id,province_id,city) values (4201,42,'�人��');
insert into web_cities (city_id,province_id,city) values (4202,42,'��ʯ��');
insert into web_cities (city_id,province_id,city) values (4203,42,'ʮ����');
insert into web_cities (city_id,province_id,city) values (4205,42,'�˲���');
insert into web_cities (city_id,province_id,city) values (4206,42,'������');
insert into web_cities (city_id,province_id,city) values (4207,42,'������');
insert into web_cities (city_id,province_id,city) values (4208,42,'������');
insert into web_cities (city_id,province_id,city) values (4209,42,'Т����');
insert into web_cities (city_id,province_id,city) values (4210,42,'������');
insert into web_cities (city_id,province_id,city) values (4211,42,'�Ƹ���');
insert into web_cities (city_id,province_id,city) values (4212,42,'������');
insert into web_cities (city_id,province_id,city) values (4213,42,'������');
insert into web_cities (city_id,province_id,city) values (4228,42,'��ʩ����������������');
insert into web_cities (city_id,province_id,city) values (4290,42,'ֱϽ�ؼ�');
insert into web_cities (city_id,province_id,city) values (4301,43,'��ɳ��');
insert into web_cities (city_id,province_id,city) values (4302,43,'������');
insert into web_cities (city_id,province_id,city) values (4303,43,'��̶��');
insert into web_cities (city_id,province_id,city) values (4304,43,'������');
insert into web_cities (city_id,province_id,city) values (4305,43,'������');
insert into web_cities (city_id,province_id,city) values (4306,43,'������');
insert into web_cities (city_id,province_id,city) values (4307,43,'������');
insert into web_cities (city_id,province_id,city) values (4308,43,'�żҽ���');
insert into web_cities (city_id,province_id,city) values (4309,43,'������');
insert into web_cities (city_id,province_id,city) values (4310,43,'������');
insert into web_cities (city_id,province_id,city) values (4311,43,'������');
insert into web_cities (city_id,province_id,city) values (4312,43,'������');
insert into web_cities (city_id,province_id,city) values (4313,43,'¦����');
insert into web_cities (city_id,province_id,city) values (4331,43,'��������������������');
insert into web_cities (city_id,province_id,city) values (4401,44,'������');
insert into web_cities (city_id,province_id,city) values (4402,44,'�ع���');
insert into web_cities (city_id,province_id,city) values (4403,44,'������');
insert into web_cities (city_id,province_id,city) values (4404,44,'�麣��');
insert into web_cities (city_id,province_id,city) values (4405,44,'��ͷ��');
insert into web_cities (city_id,province_id,city) values (4406,44,'��ɽ��');
insert into web_cities (city_id,province_id,city) values (4407,44,'������');
insert into web_cities (city_id,province_id,city) values (4408,44,'տ����');
insert into web_cities (city_id,province_id,city) values (4409,44,'ï����');
insert into web_cities (city_id,province_id,city) values (4412,44,'������');
insert into web_cities (city_id,province_id,city) values (4413,44,'������');
insert into web_cities (city_id,province_id,city) values (4414,44,'÷����');
insert into web_cities (city_id,province_id,city) values (4415,44,'��β��');
insert into web_cities (city_id,province_id,city) values (4416,44,'��Դ��');
insert into web_cities (city_id,province_id,city) values (4417,44,'������');
insert into web_cities (city_id,province_id,city) values (4418,44,'��Զ��');
insert into web_cities (city_id,province_id,city) values (4419,44,'��ݸ��');
insert into web_cities (city_id,province_id,city) values (4420,44,'��ɽ��');
insert into web_cities (city_id,province_id,city) values (4451,44,'������');
insert into web_cities (city_id,province_id,city) values (4452,44,'������');
insert into web_cities (city_id,province_id,city) values (4453,44,'�Ƹ���');
insert into web_cities (city_id,province_id,city) values (4501,45,'������');
insert into web_cities (city_id,province_id,city) values (4502,45,'������');
insert into web_cities (city_id,province_id,city) values (4503,45,'������');
insert into web_cities (city_id,province_id,city) values (4504,45,'������');
insert into web_cities (city_id,province_id,city) values (4505,45,'������');
insert into web_cities (city_id,province_id,city) values (4506,45,'���Ǹ���');
insert into web_cities (city_id,province_id,city) values (4507,45,'������');
insert into web_cities (city_id,province_id,city) values (4508,45,'�����');
insert into web_cities (city_id,province_id,city) values (4509,45,'������');
insert into web_cities (city_id,province_id,city) values (4510,45,'��ɫ��');
insert into web_cities (city_id,province_id,city) values (4511,45,'������');
insert into web_cities (city_id,province_id,city) values (4512,45,'�ӳ���');
insert into web_cities (city_id,province_id,city) values (4513,45,'������');
insert into web_cities (city_id,province_id,city) values (4514,45,'������');
insert into web_cities (city_id,province_id,city) values (4601,46,'������');
insert into web_cities (city_id,province_id,city) values (4602,46,'������');
insert into web_cities (city_id,province_id,city) values (4603,46,'��ɳ��');
insert into web_cities (city_id,province_id,city) values (4690,46,'ֱϽ�ؼ�');
insert into web_cities (city_id,province_id,city) values (5001,50,'������');
insert into web_cities (city_id,province_id,city) values (5003,50,'��������');
insert into web_cities (city_id,province_id,city) values (5101,51,'�ɶ���');
insert into web_cities (city_id,province_id,city) values (5103,51,'�Թ���');
insert into web_cities (city_id,province_id,city) values (5104,51,'��֦����');
insert into web_cities (city_id,province_id,city) values (5105,51,'������');
insert into web_cities (city_id,province_id,city) values (5106,51,'������');
insert into web_cities (city_id,province_id,city) values (5107,51,'������');
insert into web_cities (city_id,province_id,city) values (5108,51,'��Ԫ��');
insert into web_cities (city_id,province_id,city) values (5109,51,'������');
insert into web_cities (city_id,province_id,city) values (5110,51,'�ڽ���');
insert into web_cities (city_id,province_id,city) values (5111,51,'��ɽ��');
insert into web_cities (city_id,province_id,city) values (5113,51,'�ϳ���');
insert into web_cities (city_id,province_id,city) values (5114,51,'üɽ��');
insert into web_cities (city_id,province_id,city) values (5115,51,'�˱���');
insert into web_cities (city_id,province_id,city) values (5116,51,'�㰲��');
insert into web_cities (city_id,province_id,city) values (5117,51,'������');
insert into web_cities (city_id,province_id,city) values (5118,51,'�Ű���');
insert into web_cities (city_id,province_id,city) values (5119,51,'������');
insert into web_cities (city_id,province_id,city) values (5120,51,'������');
insert into web_cities (city_id,province_id,city) values (5132,51,'���Ӳ���Ǽ��������');
insert into web_cities (city_id,province_id,city) values (5133,51,'���β���������');
insert into web_cities (city_id,province_id,city) values (5134,51,'��ɽ����������');
insert into web_cities (city_id,province_id,city) values (5201,52,'������');
insert into web_cities (city_id,province_id,city) values (5202,52,'����ˮ��');
insert into web_cities (city_id,province_id,city) values (5203,52,'������');
insert into web_cities (city_id,province_id,city) values (5204,52,'��˳��');
insert into web_cities (city_id,province_id,city) values (5205,52,'�Ͻ���');
insert into web_cities (city_id,province_id,city) values (5206,52,'ͭ����');
insert into web_cities (city_id,province_id,city) values (5223,52,'ǭ���ϲ���������������');
insert into web_cities (city_id,province_id,city) values (5226,52,'ǭ�������嶱��������');
insert into web_cities (city_id,province_id,city) values (5227,52,'ǭ�ϲ���������������');
insert into web_cities (city_id,province_id,city) values (5301,53,'������');
insert into web_cities (city_id,province_id,city) values (5303,53,'������');
insert into web_cities (city_id,province_id,city) values (5304,53,'��Ϫ��');
insert into web_cities (city_id,province_id,city) values (5305,53,'��ɽ��');
insert into web_cities (city_id,province_id,city) values (5306,53,'��ͨ��');
insert into web_cities (city_id,province_id,city) values (5307,53,'������');
insert into web_cities (city_id,province_id,city) values (5308,53,'�ն���');
insert into web_cities (city_id,province_id,city) values (5309,53,'�ٲ���');
insert into web_cities (city_id,province_id,city) values (5323,53,'��������������');
insert into web_cities (city_id,province_id,city) values (5325,53,'��ӹ���������������');
insert into web_cities (city_id,province_id,city) values (5326,53,'��ɽ׳������������');
insert into web_cities (city_id,province_id,city) values (5328,53,'��˫���ɴ���������');
insert into web_cities (city_id,province_id,city) values (5329,53,'��������������');
insert into web_cities (city_id,province_id,city) values (5331,53,'�º���徰����������');
insert into web_cities (city_id,province_id,city) values (5333,53,'ŭ��������������');
insert into web_cities (city_id,province_id,city) values (5334,53,'�������������');
insert into web_cities (city_id,province_id,city) values (5401,54,'������');
insert into web_cities (city_id,province_id,city) values (5402,54,'�տ�����');
insert into web_cities (city_id,province_id,city) values (5403,54,'������');
insert into web_cities (city_id,province_id,city) values (5422,54,'ɽ�ϵ���');
insert into web_cities (city_id,province_id,city) values (5424,54,'��������');
insert into web_cities (city_id,province_id,city) values (5425,54,'�������');
insert into web_cities (city_id,province_id,city) values (5426,54,'��֥����');
insert into web_cities (city_id,province_id,city) values (6101,61,'������');
insert into web_cities (city_id,province_id,city) values (6102,61,'ͭ����');
insert into web_cities (city_id,province_id,city) values (6103,61,'������');
insert into web_cities (city_id,province_id,city) values (6104,61,'������');
insert into web_cities (city_id,province_id,city) values (6105,61,'μ����');
insert into web_cities (city_id,province_id,city) values (6106,61,'�Ӱ���');
insert into web_cities (city_id,province_id,city) values (6107,61,'������');
insert into web_cities (city_id,province_id,city) values (6108,61,'������');
insert into web_cities (city_id,province_id,city) values (6109,61,'������');
insert into web_cities (city_id,province_id,city) values (6110,61,'������');
insert into web_cities (city_id,province_id,city) values (6111,61,'��������');
insert into web_cities (city_id,province_id,city) values (6201,62,'������');
insert into web_cities (city_id,province_id,city) values (6202,62,'��������');
insert into web_cities (city_id,province_id,city) values (6203,62,'�����');
insert into web_cities (city_id,province_id,city) values (6204,62,'������');
insert into web_cities (city_id,province_id,city) values (6205,62,'��ˮ��');
insert into web_cities (city_id,province_id,city) values (6206,62,'������');
insert into web_cities (city_id,province_id,city) values (6207,62,'��Ҵ��');
insert into web_cities (city_id,province_id,city) values (6208,62,'ƽ����');
insert into web_cities (city_id,province_id,city) values (6209,62,'��Ȫ��');
insert into web_cities (city_id,province_id,city) values (6210,62,'������');
insert into web_cities (city_id,province_id,city) values (6211,62,'������');
insert into web_cities (city_id,province_id,city) values (6212,62,'¤����');
insert into web_cities (city_id,province_id,city) values (6229,62,'���Ļ���������');
insert into web_cities (city_id,province_id,city) values (6230,62,'���ϲ���������');
insert into web_cities (city_id,province_id,city) values (6301,63,'������');
insert into web_cities (city_id,province_id,city) values (6302,63,'������');
insert into web_cities (city_id,province_id,city) values (6322,63,'��������������');
insert into web_cities (city_id,province_id,city) values (6323,63,'���ϲ���������');
insert into web_cities (city_id,province_id,city) values (6325,63,'���ϲ���������');
insert into web_cities (city_id,province_id,city) values (6326,63,'�������������');
insert into web_cities (city_id,province_id,city) values (6327,63,'��������������');
insert into web_cities (city_id,province_id,city) values (6328,63,'�����ɹ������������');
insert into web_cities (city_id,province_id,city) values (6401,64,'������');
insert into web_cities (city_id,province_id,city) values (6402,64,'ʯ��ɽ��');
insert into web_cities (city_id,province_id,city) values (6403,64,'������');
insert into web_cities (city_id,province_id,city) values (6404,64,'��ԭ��');
insert into web_cities (city_id,province_id,city) values (6405,64,'������');
insert into web_cities (city_id,province_id,city) values (6501,65,'��³ľ����');
insert into web_cities (city_id,province_id,city) values (6502,65,'����������');
insert into web_cities (city_id,province_id,city) values (6521,65,'��³������');
insert into web_cities (city_id,province_id,city) values (6522,65,'���ܵ���');
insert into web_cities (city_id,province_id,city) values (6523,65,'��������������');
insert into web_cities (city_id,province_id,city) values (6527,65,'���������ɹ�������');
insert into web_cities (city_id,province_id,city) values (6528,65,'���������ɹ�������');
insert into web_cities (city_id,province_id,city) values (6529,65,'�����յ���');
insert into web_cities (city_id,province_id,city) values (6530,65,'�������տ¶�����������');
insert into web_cities (city_id,province_id,city) values (6531,65,'��ʲ����');
insert into web_cities (city_id,province_id,city) values (6532,65,'�������');
insert into web_cities (city_id,province_id,city) values (6540,65,'���������������');
insert into web_cities (city_id,province_id,city) values (6542,65,'���ǵ���');
insert into web_cities (city_id,province_id,city) values (6543,65,'����̩����');
insert into web_cities (city_id,province_id,city) values (6590,65,'ֱϽ�ؼ�');
insert into web_cities (city_id,province_id,city) values (7101,71,'̨����');
insert into web_cities (city_id,province_id,city) values (7102,71,'������');
insert into web_cities (city_id,province_id,city) values (7103,71,'��¡��');
insert into web_cities (city_id,province_id,city) values (7104,71,'̨����');
insert into web_cities (city_id,province_id,city) values (7105,71,'̨����');
insert into web_cities (city_id,province_id,city) values (7106,71,'������');
insert into web_cities (city_id,province_id,city) values (7107,71,'������');
insert into web_cities (city_id,province_id,city) values (7108,71,'�±���');
insert into web_cities (city_id,province_id,city) values (7122,71,'������');
insert into web_cities (city_id,province_id,city) values (7123,71,'��԰��');
insert into web_cities (city_id,province_id,city) values (7124,71,'������');
insert into web_cities (city_id,province_id,city) values (7125,71,'������');
insert into web_cities (city_id,province_id,city) values (7127,71,'�û���');
insert into web_cities (city_id,province_id,city) values (7128,71,'��Ͷ��');
insert into web_cities (city_id,province_id,city) values (7129,71,'������');
insert into web_cities (city_id,province_id,city) values (7130,71,'������');
insert into web_cities (city_id,province_id,city) values (7133,71,'������');
insert into web_cities (city_id,province_id,city) values (7134,71,'̨����');
insert into web_cities (city_id,province_id,city) values (7135,71,'������');
insert into web_cities (city_id,province_id,city) values (7136,71,'�����');
insert into web_cities (city_id,province_id,city) values (7137,71,'������');
insert into web_cities (city_id,province_id,city) values (7138,71,'������');
insert into web_cities (city_id,province_id,city) values (8101,81,'��۵�');
insert into web_cities (city_id,province_id,city) values (8102,81,'����');
insert into web_cities (city_id,province_id,city) values (8103,81,'�½�');
insert into web_cities (city_id,province_id,city) values (8201,82,'���Ű뵺');
insert into web_cities (city_id,province_id,city) values (8202,82,'���е�');
insert into web_cities (city_id,province_id,city) values (8203,82,'·����');

/*web_regions��ʼ����*/
insert into web_regions (region_id,city_id,region) values (110101,1101,'������');
insert into web_regions (region_id,city_id,region) values (110102,1101,'������');
insert into web_regions (region_id,city_id,region) values (110105,1101,'������');
insert into web_regions (region_id,city_id,region) values (110106,1101,'��̨��');
insert into web_regions (region_id,city_id,region) values (110107,1101,'ʯ��ɽ��');
insert into web_regions (region_id,city_id,region) values (110108,1101,'������');
insert into web_regions (region_id,city_id,region) values (110109,1101,'��ͷ����');
insert into web_regions (region_id,city_id,region) values (110111,1101,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (110112,1101,'ͨ����');
insert into web_regions (region_id,city_id,region) values (110113,1101,'˳����');
insert into web_regions (region_id,city_id,region) values (110114,1101,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (110115,1101,'������');
insert into web_regions (region_id,city_id,region) values (110116,1101,'������');
insert into web_regions (region_id,city_id,region) values (110117,1101,'ƽ����');
insert into web_regions (region_id,city_id,region) values (110228,1101,'������');
insert into web_regions (region_id,city_id,region) values (110229,1101,'������');
insert into web_regions (region_id,city_id,region) values (120101,1201,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (120102,1201,'�Ӷ���');
insert into web_regions (region_id,city_id,region) values (120103,1201,'������');
insert into web_regions (region_id,city_id,region) values (120104,1201,'�Ͽ���');
insert into web_regions (region_id,city_id,region) values (120105,1201,'�ӱ���');
insert into web_regions (region_id,city_id,region) values (120106,1201,'������');
insert into web_regions (region_id,city_id,region) values (120110,1201,'������');
insert into web_regions (region_id,city_id,region) values (120111,1201,'������');
insert into web_regions (region_id,city_id,region) values (120112,1201,'������');
insert into web_regions (region_id,city_id,region) values (120113,1201,'������');
insert into web_regions (region_id,city_id,region) values (120114,1201,'������');
insert into web_regions (region_id,city_id,region) values (120115,1201,'������');
insert into web_regions (region_id,city_id,region) values (120116,1201,'��������');
insert into web_regions (region_id,city_id,region) values (120221,1201,'������');
insert into web_regions (region_id,city_id,region) values (120223,1201,'������');
insert into web_regions (region_id,city_id,region) values (120225,1201,'����');
insert into web_regions (region_id,city_id,region) values (130102,1301,'������');
insert into web_regions (region_id,city_id,region) values (130104,1301,'������');
insert into web_regions (region_id,city_id,region) values (130105,1301,'�»���');
insert into web_regions (region_id,city_id,region) values (130107,1301,'�������');
insert into web_regions (region_id,city_id,region) values (130108,1301,'ԣ����');
insert into web_regions (region_id,city_id,region) values (130109,1301,'޻����');
insert into web_regions (region_id,city_id,region) values (130110,1301,'¹Ȫ��');
insert into web_regions (region_id,city_id,region) values (130111,1301,'�����');
insert into web_regions (region_id,city_id,region) values (130121,1301,'������');
insert into web_regions (region_id,city_id,region) values (130123,1301,'������');
insert into web_regions (region_id,city_id,region) values (130125,1301,'������');
insert into web_regions (region_id,city_id,region) values (130126,1301,'������');
insert into web_regions (region_id,city_id,region) values (130127,1301,'������');
insert into web_regions (region_id,city_id,region) values (130128,1301,'������');
insert into web_regions (region_id,city_id,region) values (130129,1301,'�޻���');
insert into web_regions (region_id,city_id,region) values (130130,1301,'�޼���');
insert into web_regions (region_id,city_id,region) values (130131,1301,'ƽɽ��');
insert into web_regions (region_id,city_id,region) values (130132,1301,'Ԫ����');
insert into web_regions (region_id,city_id,region) values (130133,1301,'����');
insert into web_regions (region_id,city_id,region) values (130181,1301,'������');
insert into web_regions (region_id,city_id,region) values (130183,1301,'������');
insert into web_regions (region_id,city_id,region) values (130184,1301,'������');
insert into web_regions (region_id,city_id,region) values (130202,1302,'·����');
insert into web_regions (region_id,city_id,region) values (130203,1302,'·����');
insert into web_regions (region_id,city_id,region) values (130204,1302,'��ұ��');
insert into web_regions (region_id,city_id,region) values (130205,1302,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (130207,1302,'������');
insert into web_regions (region_id,city_id,region) values (130208,1302,'������');
insert into web_regions (region_id,city_id,region) values (130209,1302,'��������');
insert into web_regions (region_id,city_id,region) values (130223,1302,'����');
insert into web_regions (region_id,city_id,region) values (130224,1302,'������');
insert into web_regions (region_id,city_id,region) values (130225,1302,'��ͤ��');
insert into web_regions (region_id,city_id,region) values (130227,1302,'Ǩ����');
insert into web_regions (region_id,city_id,region) values (130229,1302,'������');
insert into web_regions (region_id,city_id,region) values (130281,1302,'����');
insert into web_regions (region_id,city_id,region) values (130283,1302,'Ǩ����');
insert into web_regions (region_id,city_id,region) values (130302,1303,'������');
insert into web_regions (region_id,city_id,region) values (130303,1303,'ɽ������');
insert into web_regions (region_id,city_id,region) values (130304,1303,'��������');
insert into web_regions (region_id,city_id,region) values (130321,1303,'��������������');
insert into web_regions (region_id,city_id,region) values (130322,1303,'������');
insert into web_regions (region_id,city_id,region) values (130323,1303,'������');
insert into web_regions (region_id,city_id,region) values (130324,1303,'¬����');
insert into web_regions (region_id,city_id,region) values (130402,1304,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (130403,1304,'��̨��');
insert into web_regions (region_id,city_id,region) values (130404,1304,'������');
insert into web_regions (region_id,city_id,region) values (130406,1304,'������');
insert into web_regions (region_id,city_id,region) values (130421,1304,'������');
insert into web_regions (region_id,city_id,region) values (130423,1304,'������');
insert into web_regions (region_id,city_id,region) values (130424,1304,'�ɰ���');
insert into web_regions (region_id,city_id,region) values (130425,1304,'������');
insert into web_regions (region_id,city_id,region) values (130426,1304,'����');
insert into web_regions (region_id,city_id,region) values (130427,1304,'����');
insert into web_regions (region_id,city_id,region) values (130428,1304,'������');
insert into web_regions (region_id,city_id,region) values (130429,1304,'������');
insert into web_regions (region_id,city_id,region) values (130430,1304,'����');
insert into web_regions (region_id,city_id,region) values (130431,1304,'������');
insert into web_regions (region_id,city_id,region) values (130432,1304,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (130433,1304,'������');
insert into web_regions (region_id,city_id,region) values (130434,1304,'κ��');
insert into web_regions (region_id,city_id,region) values (130435,1304,'������');
insert into web_regions (region_id,city_id,region) values (130481,1304,'�䰲��');
insert into web_regions (region_id,city_id,region) values (130502,1305,'�Ŷ���');
insert into web_regions (region_id,city_id,region) values (130503,1305,'������');
insert into web_regions (region_id,city_id,region) values (130521,1305,'��̨��');
insert into web_regions (region_id,city_id,region) values (130522,1305,'�ٳ���');
insert into web_regions (region_id,city_id,region) values (130523,1305,'������');
insert into web_regions (region_id,city_id,region) values (130524,1305,'������');
insert into web_regions (region_id,city_id,region) values (130525,1305,'¡Ң��');
insert into web_regions (region_id,city_id,region) values (130526,1305,'����');
insert into web_regions (region_id,city_id,region) values (130527,1305,'�Ϻ���');
insert into web_regions (region_id,city_id,region) values (130528,1305,'������');
insert into web_regions (region_id,city_id,region) values (130529,1305,'��¹��');
insert into web_regions (region_id,city_id,region) values (130530,1305,'�º���');
insert into web_regions (region_id,city_id,region) values (130531,1305,'������');
insert into web_regions (region_id,city_id,region) values (130532,1305,'ƽ����');
insert into web_regions (region_id,city_id,region) values (130533,1305,'����');
insert into web_regions (region_id,city_id,region) values (130534,1305,'�����');
insert into web_regions (region_id,city_id,region) values (130535,1305,'������');
insert into web_regions (region_id,city_id,region) values (130581,1305,'�Ϲ���');
insert into web_regions (region_id,city_id,region) values (130582,1305,'ɳ����');
insert into web_regions (region_id,city_id,region) values (130602,1306,'������');
insert into web_regions (region_id,city_id,region) values (130603,1306,'������');
insert into web_regions (region_id,city_id,region) values (130604,1306,'������');
insert into web_regions (region_id,city_id,region) values (130621,1306,'������');
insert into web_regions (region_id,city_id,region) values (130622,1306,'��Է��');
insert into web_regions (region_id,city_id,region) values (130623,1306,'�ˮ��');
insert into web_regions (region_id,city_id,region) values (130624,1306,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (130625,1306,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (130626,1306,'������');
insert into web_regions (region_id,city_id,region) values (130627,1306,'����');
insert into web_regions (region_id,city_id,region) values (130628,1306,'������');
insert into web_regions (region_id,city_id,region) values (130629,1306,'�ݳ���');
insert into web_regions (region_id,city_id,region) values (130630,1306,'�Դ��');
insert into web_regions (region_id,city_id,region) values (130631,1306,'������');
insert into web_regions (region_id,city_id,region) values (130632,1306,'������');
insert into web_regions (region_id,city_id,region) values (130633,1306,'����');
insert into web_regions (region_id,city_id,region) values (130634,1306,'������');
insert into web_regions (region_id,city_id,region) values (130635,1306,'���');
insert into web_regions (region_id,city_id,region) values (130636,1306,'˳ƽ��');
insert into web_regions (region_id,city_id,region) values (130637,1306,'��Ұ��');
insert into web_regions (region_id,city_id,region) values (130638,1306,'����');
insert into web_regions (region_id,city_id,region) values (130681,1306,'������');
insert into web_regions (region_id,city_id,region) values (130682,1306,'������');
insert into web_regions (region_id,city_id,region) values (130683,1306,'������');
insert into web_regions (region_id,city_id,region) values (130684,1306,'�߱�����');
insert into web_regions (region_id,city_id,region) values (130702,1307,'�Ŷ���');
insert into web_regions (region_id,city_id,region) values (130703,1307,'������');
insert into web_regions (region_id,city_id,region) values (130705,1307,'������');
insert into web_regions (region_id,city_id,region) values (130706,1307,'�»�԰��');
insert into web_regions (region_id,city_id,region) values (130721,1307,'������');
insert into web_regions (region_id,city_id,region) values (130722,1307,'�ű���');
insert into web_regions (region_id,city_id,region) values (130723,1307,'������');
insert into web_regions (region_id,city_id,region) values (130724,1307,'��Դ��');
insert into web_regions (region_id,city_id,region) values (130725,1307,'������');
insert into web_regions (region_id,city_id,region) values (130726,1307,'ε��');
insert into web_regions (region_id,city_id,region) values (130727,1307,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (130728,1307,'������');
insert into web_regions (region_id,city_id,region) values (130729,1307,'��ȫ��');
insert into web_regions (region_id,city_id,region) values (130730,1307,'������');
insert into web_regions (region_id,city_id,region) values (130731,1307,'��¹��');
insert into web_regions (region_id,city_id,region) values (130732,1307,'�����');
insert into web_regions (region_id,city_id,region) values (130733,1307,'������');
insert into web_regions (region_id,city_id,region) values (130802,1308,'˫����');
insert into web_regions (region_id,city_id,region) values (130803,1308,'˫����');
insert into web_regions (region_id,city_id,region) values (130804,1308,'ӥ��Ӫ�ӿ���');
insert into web_regions (region_id,city_id,region) values (130821,1308,'�е���');
insert into web_regions (region_id,city_id,region) values (130822,1308,'��¡��');
insert into web_regions (region_id,city_id,region) values (130823,1308,'ƽȪ��');
insert into web_regions (region_id,city_id,region) values (130824,1308,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (130825,1308,'¡����');
insert into web_regions (region_id,city_id,region) values (130826,1308,'��������������');
insert into web_regions (region_id,city_id,region) values (130827,1308,'��������������');
insert into web_regions (region_id,city_id,region) values (130828,1308,'Χ�������ɹ���������');
insert into web_regions (region_id,city_id,region) values (130902,1309,'�»���');
insert into web_regions (region_id,city_id,region) values (130903,1309,'�˺���');
insert into web_regions (region_id,city_id,region) values (130921,1309,'����');
insert into web_regions (region_id,city_id,region) values (130922,1309,'����');
insert into web_regions (region_id,city_id,region) values (130923,1309,'������');
insert into web_regions (region_id,city_id,region) values (130924,1309,'������');
insert into web_regions (region_id,city_id,region) values (130925,1309,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (130926,1309,'������');
insert into web_regions (region_id,city_id,region) values (130927,1309,'��Ƥ��');
insert into web_regions (region_id,city_id,region) values (130928,1309,'������');
insert into web_regions (region_id,city_id,region) values (130929,1309,'����');
insert into web_regions (region_id,city_id,region) values (130930,1309,'�ϴ����������');
insert into web_regions (region_id,city_id,region) values (130981,1309,'��ͷ��');
insert into web_regions (region_id,city_id,region) values (130982,1309,'������');
insert into web_regions (region_id,city_id,region) values (130983,1309,'������');
insert into web_regions (region_id,city_id,region) values (130984,1309,'�Ӽ���');
insert into web_regions (region_id,city_id,region) values (131002,1310,'������');
insert into web_regions (region_id,city_id,region) values (131003,1310,'������');
insert into web_regions (region_id,city_id,region) values (131022,1310,'�̰���');
insert into web_regions (region_id,city_id,region) values (131023,1310,'������');
insert into web_regions (region_id,city_id,region) values (131024,1310,'�����');
insert into web_regions (region_id,city_id,region) values (131025,1310,'�����');
insert into web_regions (region_id,city_id,region) values (131026,1310,'�İ���');
insert into web_regions (region_id,city_id,region) values (131028,1310,'�󳧻���������');
insert into web_regions (region_id,city_id,region) values (131081,1310,'������');
insert into web_regions (region_id,city_id,region) values (131082,1310,'������');
insert into web_regions (region_id,city_id,region) values (131102,1311,'�ҳ���');
insert into web_regions (region_id,city_id,region) values (131121,1311,'��ǿ��');
insert into web_regions (region_id,city_id,region) values (131122,1311,'������');
insert into web_regions (region_id,city_id,region) values (131123,1311,'��ǿ��');
insert into web_regions (region_id,city_id,region) values (131124,1311,'������');
insert into web_regions (region_id,city_id,region) values (131125,1311,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (131126,1311,'�ʳ���');
insert into web_regions (region_id,city_id,region) values (131127,1311,'����');
insert into web_regions (region_id,city_id,region) values (131128,1311,'������');
insert into web_regions (region_id,city_id,region) values (131181,1311,'������');
insert into web_regions (region_id,city_id,region) values (131182,1311,'������');
insert into web_regions (region_id,city_id,region) values (140105,1401,'С����');
insert into web_regions (region_id,city_id,region) values (140106,1401,'ӭ����');
insert into web_regions (region_id,city_id,region) values (140107,1401,'�ӻ�����');
insert into web_regions (region_id,city_id,region) values (140108,1401,'���ƺ��');
insert into web_regions (region_id,city_id,region) values (140109,1401,'�������');
insert into web_regions (region_id,city_id,region) values (140110,1401,'��Դ��');
insert into web_regions (region_id,city_id,region) values (140121,1401,'������');
insert into web_regions (region_id,city_id,region) values (140122,1401,'������');
insert into web_regions (region_id,city_id,region) values (140123,1401,'¦����');
insert into web_regions (region_id,city_id,region) values (140181,1401,'�Ž���');
insert into web_regions (region_id,city_id,region) values (140202,1402,'����');
insert into web_regions (region_id,city_id,region) values (140203,1402,'����');
insert into web_regions (region_id,city_id,region) values (140211,1402,'�Ͻ���');
insert into web_regions (region_id,city_id,region) values (140212,1402,'������');
insert into web_regions (region_id,city_id,region) values (140221,1402,'������');
insert into web_regions (region_id,city_id,region) values (140222,1402,'������');
insert into web_regions (region_id,city_id,region) values (140223,1402,'������');
insert into web_regions (region_id,city_id,region) values (140224,1402,'������');
insert into web_regions (region_id,city_id,region) values (140225,1402,'��Դ��');
insert into web_regions (region_id,city_id,region) values (140226,1402,'������');
insert into web_regions (region_id,city_id,region) values (140227,1402,'��ͬ��');
insert into web_regions (region_id,city_id,region) values (140302,1403,'����');
insert into web_regions (region_id,city_id,region) values (140303,1403,'����');
insert into web_regions (region_id,city_id,region) values (140311,1403,'����');
insert into web_regions (region_id,city_id,region) values (140321,1403,'ƽ����');
insert into web_regions (region_id,city_id,region) values (140322,1403,'����');
insert into web_regions (region_id,city_id,region) values (140402,1404,'����');
insert into web_regions (region_id,city_id,region) values (140411,1404,'����');
insert into web_regions (region_id,city_id,region) values (140421,1404,'������');
insert into web_regions (region_id,city_id,region) values (140423,1404,'��ԫ��');
insert into web_regions (region_id,city_id,region) values (140424,1404,'������');
insert into web_regions (region_id,city_id,region) values (140425,1404,'ƽ˳��');
insert into web_regions (region_id,city_id,region) values (140426,1404,'�����');
insert into web_regions (region_id,city_id,region) values (140427,1404,'������');
insert into web_regions (region_id,city_id,region) values (140428,1404,'������');
insert into web_regions (region_id,city_id,region) values (140429,1404,'������');
insert into web_regions (region_id,city_id,region) values (140430,1404,'����');
insert into web_regions (region_id,city_id,region) values (140431,1404,'��Դ��');
insert into web_regions (region_id,city_id,region) values (140481,1404,'º����');
insert into web_regions (region_id,city_id,region) values (140502,1405,'����');
insert into web_regions (region_id,city_id,region) values (140521,1405,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (140522,1405,'������');
insert into web_regions (region_id,city_id,region) values (140524,1405,'�괨��');
insert into web_regions (region_id,city_id,region) values (140525,1405,'������');
insert into web_regions (region_id,city_id,region) values (140581,1405,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (140602,1406,'˷����');
insert into web_regions (region_id,city_id,region) values (140603,1406,'ƽ³��');
insert into web_regions (region_id,city_id,region) values (140621,1406,'ɽ����');
insert into web_regions (region_id,city_id,region) values (140622,1406,'Ӧ��');
insert into web_regions (region_id,city_id,region) values (140623,1406,'������');
insert into web_regions (region_id,city_id,region) values (140624,1406,'������');
insert into web_regions (region_id,city_id,region) values (140702,1407,'�ܴ���');
insert into web_regions (region_id,city_id,region) values (140721,1407,'������');
insert into web_regions (region_id,city_id,region) values (140722,1407,'��Ȩ��');
insert into web_regions (region_id,city_id,region) values (140723,1407,'��˳��');
insert into web_regions (region_id,city_id,region) values (140724,1407,'������');
insert into web_regions (region_id,city_id,region) values (140725,1407,'������');
insert into web_regions (region_id,city_id,region) values (140726,1407,'̫����');
insert into web_regions (region_id,city_id,region) values (140727,1407,'����');
insert into web_regions (region_id,city_id,region) values (140728,1407,'ƽң��');
insert into web_regions (region_id,city_id,region) values (140729,1407,'��ʯ��');
insert into web_regions (region_id,city_id,region) values (140781,1407,'������');
insert into web_regions (region_id,city_id,region) values (140802,1408,'�κ���');
insert into web_regions (region_id,city_id,region) values (140821,1408,'�����');
insert into web_regions (region_id,city_id,region) values (140822,1408,'������');
insert into web_regions (region_id,city_id,region) values (140823,1408,'��ϲ��');
insert into web_regions (region_id,city_id,region) values (140824,1408,'�ɽ��');
insert into web_regions (region_id,city_id,region) values (140825,1408,'�����');
insert into web_regions (region_id,city_id,region) values (140826,1408,'���');
insert into web_regions (region_id,city_id,region) values (140827,1408,'ԫ����');
insert into web_regions (region_id,city_id,region) values (140828,1408,'����');
insert into web_regions (region_id,city_id,region) values (140829,1408,'ƽ½��');
insert into web_regions (region_id,city_id,region) values (140830,1408,'�ǳ���');
insert into web_regions (region_id,city_id,region) values (140881,1408,'������');
insert into web_regions (region_id,city_id,region) values (140882,1408,'�ӽ���');
insert into web_regions (region_id,city_id,region) values (140902,1409,'�ø���');
insert into web_regions (region_id,city_id,region) values (140921,1409,'������');
insert into web_regions (region_id,city_id,region) values (140922,1409,'��̨��');
insert into web_regions (region_id,city_id,region) values (140923,1409,'����');
insert into web_regions (region_id,city_id,region) values (140924,1409,'������');
insert into web_regions (region_id,city_id,region) values (140925,1409,'������');
insert into web_regions (region_id,city_id,region) values (140926,1409,'������');
insert into web_regions (region_id,city_id,region) values (140927,1409,'�����');
insert into web_regions (region_id,city_id,region) values (140928,1409,'��կ��');
insert into web_regions (region_id,city_id,region) values (140929,1409,'����');
insert into web_regions (region_id,city_id,region) values (140930,1409,'������');
insert into web_regions (region_id,city_id,region) values (140931,1409,'������');
insert into web_regions (region_id,city_id,region) values (140932,1409,'ƫ����');
insert into web_regions (region_id,city_id,region) values (140981,1409,'ԭƽ��');
insert into web_regions (region_id,city_id,region) values (141002,1410,'Ң����');
insert into web_regions (region_id,city_id,region) values (141021,1410,'������');
insert into web_regions (region_id,city_id,region) values (141022,1410,'������');
insert into web_regions (region_id,city_id,region) values (141023,1410,'�����');
insert into web_regions (region_id,city_id,region) values (141024,1410,'�鶴��');
insert into web_regions (region_id,city_id,region) values (141025,1410,'����');
insert into web_regions (region_id,city_id,region) values (141026,1410,'������');
insert into web_regions (region_id,city_id,region) values (141027,1410,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (141028,1410,'����');
insert into web_regions (region_id,city_id,region) values (141029,1410,'������');
insert into web_regions (region_id,city_id,region) values (141030,1410,'������');
insert into web_regions (region_id,city_id,region) values (141031,1410,'����');
insert into web_regions (region_id,city_id,region) values (141032,1410,'������');
insert into web_regions (region_id,city_id,region) values (141033,1410,'����');
insert into web_regions (region_id,city_id,region) values (141034,1410,'������');
insert into web_regions (region_id,city_id,region) values (141081,1410,'������');
insert into web_regions (region_id,city_id,region) values (141082,1410,'������');
insert into web_regions (region_id,city_id,region) values (141102,1411,'��ʯ��');
insert into web_regions (region_id,city_id,region) values (141121,1411,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (141122,1411,'������');
insert into web_regions (region_id,city_id,region) values (141123,1411,'����');
insert into web_regions (region_id,city_id,region) values (141124,1411,'����');
insert into web_regions (region_id,city_id,region) values (141125,1411,'������');
insert into web_regions (region_id,city_id,region) values (141126,1411,'ʯ¥��');
insert into web_regions (region_id,city_id,region) values (141127,1411,'���');
insert into web_regions (region_id,city_id,region) values (141128,1411,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (141129,1411,'������');
insert into web_regions (region_id,city_id,region) values (141130,1411,'������');
insert into web_regions (region_id,city_id,region) values (141181,1411,'Т����');
insert into web_regions (region_id,city_id,region) values (141182,1411,'������');
insert into web_regions (region_id,city_id,region) values (150102,1501,'�³���');
insert into web_regions (region_id,city_id,region) values (150103,1501,'������');
insert into web_regions (region_id,city_id,region) values (150104,1501,'��Ȫ��');
insert into web_regions (region_id,city_id,region) values (150105,1501,'������');
insert into web_regions (region_id,city_id,region) values (150121,1501,'��Ĭ������');
insert into web_regions (region_id,city_id,region) values (150122,1501,'�п�����');
insert into web_regions (region_id,city_id,region) values (150123,1501,'���ָ����');
insert into web_regions (region_id,city_id,region) values (150124,1501,'��ˮ����');
insert into web_regions (region_id,city_id,region) values (150125,1501,'�䴨��');
insert into web_regions (region_id,city_id,region) values (150202,1502,'������');
insert into web_regions (region_id,city_id,region) values (150203,1502,'��������');
insert into web_regions (region_id,city_id,region) values (150204,1502,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (150205,1502,'ʯ����');
insert into web_regions (region_id,city_id,region) values (150206,1502,'���ƶ�������');
insert into web_regions (region_id,city_id,region) values (150207,1502,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (150221,1502,'��Ĭ������');
insert into web_regions (region_id,city_id,region) values (150222,1502,'������');
insert into web_regions (region_id,city_id,region) values (150223,1502,'�����ï����������');
insert into web_regions (region_id,city_id,region) values (150302,1503,'��������');
insert into web_regions (region_id,city_id,region) values (150303,1503,'������');
insert into web_regions (region_id,city_id,region) values (150304,1503,'�ڴ���');
insert into web_regions (region_id,city_id,region) values (150402,1504,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (150403,1504,'Ԫ��ɽ��');
insert into web_regions (region_id,city_id,region) values (150404,1504,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (150421,1504,'��³�ƶ�����');
insert into web_regions (region_id,city_id,region) values (150422,1504,'��������');
insert into web_regions (region_id,city_id,region) values (150423,1504,'��������');
insert into web_regions (region_id,city_id,region) values (150424,1504,'������');
insert into web_regions (region_id,city_id,region) values (150425,1504,'��ʲ������');
insert into web_regions (region_id,city_id,region) values (150426,1504,'��ţ����');
insert into web_regions (region_id,city_id,region) values (150428,1504,'��������');
insert into web_regions (region_id,city_id,region) values (150429,1504,'������');
insert into web_regions (region_id,city_id,region) values (150430,1504,'������');
insert into web_regions (region_id,city_id,region) values (150502,1505,'�ƶ�����');
insert into web_regions (region_id,city_id,region) values (150521,1505,'�ƶ�����������');
insert into web_regions (region_id,city_id,region) values (150522,1505,'�ƶ�����������');
insert into web_regions (region_id,city_id,region) values (150523,1505,'��³��');
insert into web_regions (region_id,city_id,region) values (150524,1505,'������');
insert into web_regions (region_id,city_id,region) values (150525,1505,'������');
insert into web_regions (region_id,city_id,region) values (150526,1505,'��³����');
insert into web_regions (region_id,city_id,region) values (150581,1505,'���ֹ�����');
insert into web_regions (region_id,city_id,region) values (150602,1506,'��ʤ��');
insert into web_regions (region_id,city_id,region) values (150621,1506,'��������');
insert into web_regions (region_id,city_id,region) values (150622,1506,'׼�����');
insert into web_regions (region_id,city_id,region) values (150623,1506,'���п�ǰ��');
insert into web_regions (region_id,city_id,region) values (150624,1506,'���п���');
insert into web_regions (region_id,city_id,region) values (150625,1506,'������');
insert into web_regions (region_id,city_id,region) values (150626,1506,'������');
insert into web_regions (region_id,city_id,region) values (150627,1506,'���������');
insert into web_regions (region_id,city_id,region) values (150702,1507,'��������');
insert into web_regions (region_id,city_id,region) values (150703,1507,'����ŵ����');
insert into web_regions (region_id,city_id,region) values (150721,1507,'������');
insert into web_regions (region_id,city_id,region) values (150722,1507,'Ī�����ߴ��Ӷ���������');
insert into web_regions (region_id,city_id,region) values (150723,1507,'���״�������');
insert into web_regions (region_id,city_id,region) values (150724,1507,'���¿���������');
insert into web_regions (region_id,city_id,region) values (150725,1507,'�°Ͷ�����');
insert into web_regions (region_id,city_id,region) values (150726,1507,'�°Ͷ�������');
insert into web_regions (region_id,city_id,region) values (150727,1507,'�°Ͷ�������');
insert into web_regions (region_id,city_id,region) values (150781,1507,'��������');
insert into web_regions (region_id,city_id,region) values (150782,1507,'����ʯ��');
insert into web_regions (region_id,city_id,region) values (150783,1507,'��������');
insert into web_regions (region_id,city_id,region) values (150784,1507,'���������');
insert into web_regions (region_id,city_id,region) values (150785,1507,'������');
insert into web_regions (region_id,city_id,region) values (150802,1508,'�ٺ���');
insert into web_regions (region_id,city_id,region) values (150821,1508,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (150822,1508,'�����');
insert into web_regions (region_id,city_id,region) values (150823,1508,'������ǰ��');
insert into web_regions (region_id,city_id,region) values (150824,1508,'����������');
insert into web_regions (region_id,city_id,region) values (150825,1508,'�����غ���');
insert into web_regions (region_id,city_id,region) values (150826,1508,'��������');
insert into web_regions (region_id,city_id,region) values (150902,1509,'������');
insert into web_regions (region_id,city_id,region) values (150921,1509,'׿����');
insert into web_regions (region_id,city_id,region) values (150922,1509,'������');
insert into web_regions (region_id,city_id,region) values (150923,1509,'�̶���');
insert into web_regions (region_id,city_id,region) values (150924,1509,'�˺���');
insert into web_regions (region_id,city_id,region) values (150925,1509,'������');
insert into web_regions (region_id,city_id,region) values (150926,1509,'���������ǰ��');
insert into web_regions (region_id,city_id,region) values (150927,1509,'�������������');
insert into web_regions (region_id,city_id,region) values (150928,1509,'�������������');
insert into web_regions (region_id,city_id,region) values (150929,1509,'��������');
insert into web_regions (region_id,city_id,region) values (150981,1509,'������');
insert into web_regions (region_id,city_id,region) values (152201,1522,'����������');
insert into web_regions (region_id,city_id,region) values (152202,1522,'����ɽ��');
insert into web_regions (region_id,city_id,region) values (152221,1522,'�ƶ�������ǰ��');
insert into web_regions (region_id,city_id,region) values (152222,1522,'�ƶ�����������');
insert into web_regions (region_id,city_id,region) values (152223,1522,'��������');
insert into web_regions (region_id,city_id,region) values (152224,1522,'ͻȪ��');
insert into web_regions (region_id,city_id,region) values (152501,1525,'����������');
insert into web_regions (region_id,city_id,region) values (152502,1525,'���ֺ�����');
insert into web_regions (region_id,city_id,region) values (152522,1525,'���͸���');
insert into web_regions (region_id,city_id,region) values (152523,1525,'����������');
insert into web_regions (region_id,city_id,region) values (152524,1525,'����������');
insert into web_regions (region_id,city_id,region) values (152525,1525,'������������');
insert into web_regions (region_id,city_id,region) values (152526,1525,'������������');
insert into web_regions (region_id,city_id,region) values (152527,1525,'̫������');
insert into web_regions (region_id,city_id,region) values (152528,1525,'�����');
insert into web_regions (region_id,city_id,region) values (152529,1525,'�������');
insert into web_regions (region_id,city_id,region) values (152530,1525,'������');
insert into web_regions (region_id,city_id,region) values (152531,1525,'������');
insert into web_regions (region_id,city_id,region) values (152921,1529,'����������');
insert into web_regions (region_id,city_id,region) values (152922,1529,'����������');
insert into web_regions (region_id,city_id,region) values (152923,1529,'�������');
insert into web_regions (region_id,city_id,region) values (210102,2101,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (210103,2101,'�����');
insert into web_regions (region_id,city_id,region) values (210104,2101,'����');
insert into web_regions (region_id,city_id,region) values (210105,2101,'�ʹ���');
insert into web_regions (region_id,city_id,region) values (210106,2101,'������');
insert into web_regions (region_id,city_id,region) values (210111,2101,'�ռ�����');
insert into web_regions (region_id,city_id,region) values (210112,2101,'������');
insert into web_regions (region_id,city_id,region) values (210113,2101,'������');
insert into web_regions (region_id,city_id,region) values (210114,2101,'�ں���');
insert into web_regions (region_id,city_id,region) values (210122,2101,'������');
insert into web_regions (region_id,city_id,region) values (210123,2101,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (210124,2101,'������');
insert into web_regions (region_id,city_id,region) values (210181,2101,'������');
insert into web_regions (region_id,city_id,region) values (210202,2102,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (210203,2102,'������');
insert into web_regions (region_id,city_id,region) values (210204,2102,'ɳ�ӿ���');
insert into web_regions (region_id,city_id,region) values (210211,2102,'�ʾ�����');
insert into web_regions (region_id,city_id,region) values (210212,2102,'��˳����');
insert into web_regions (region_id,city_id,region) values (210213,2102,'������');
insert into web_regions (region_id,city_id,region) values (210224,2102,'������');
insert into web_regions (region_id,city_id,region) values (210281,2102,'�߷�����');
insert into web_regions (region_id,city_id,region) values (210282,2102,'��������');
insert into web_regions (region_id,city_id,region) values (210283,2102,'ׯ����');
insert into web_regions (region_id,city_id,region) values (210302,2103,'������');
insert into web_regions (region_id,city_id,region) values (210303,2103,'������');
insert into web_regions (region_id,city_id,region) values (210304,2103,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (210311,2103,'ǧɽ��');
insert into web_regions (region_id,city_id,region) values (210321,2103,'̨����');
insert into web_regions (region_id,city_id,region) values (210323,2103,'�������������');
insert into web_regions (region_id,city_id,region) values (210381,2103,'������');
insert into web_regions (region_id,city_id,region) values (210402,2104,'�¸���');
insert into web_regions (region_id,city_id,region) values (210403,2104,'������');
insert into web_regions (region_id,city_id,region) values (210404,2104,'������');
insert into web_regions (region_id,city_id,region) values (210411,2104,'˳����');
insert into web_regions (region_id,city_id,region) values (210421,2104,'��˳��');
insert into web_regions (region_id,city_id,region) values (210422,2104,'�±�����������');
insert into web_regions (region_id,city_id,region) values (210423,2104,'��ԭ����������');
insert into web_regions (region_id,city_id,region) values (210502,2105,'ƽɽ��');
insert into web_regions (region_id,city_id,region) values (210503,2105,'Ϫ����');
insert into web_regions (region_id,city_id,region) values (210504,2105,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (210505,2105,'�Ϸ���');
insert into web_regions (region_id,city_id,region) values (210521,2105,'��Ϫ����������');
insert into web_regions (region_id,city_id,region) values (210522,2105,'��������������');
insert into web_regions (region_id,city_id,region) values (210602,2106,'Ԫ����');
insert into web_regions (region_id,city_id,region) values (210603,2106,'������');
insert into web_regions (region_id,city_id,region) values (210604,2106,'����');
insert into web_regions (region_id,city_id,region) values (210624,2106,'��������������');
insert into web_regions (region_id,city_id,region) values (210681,2106,'������');
insert into web_regions (region_id,city_id,region) values (210682,2106,'�����');
insert into web_regions (region_id,city_id,region) values (210702,2107,'������');
insert into web_regions (region_id,city_id,region) values (210703,2107,'�����');
insert into web_regions (region_id,city_id,region) values (210711,2107,'̫����');
insert into web_regions (region_id,city_id,region) values (210726,2107,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (210727,2107,'����');
insert into web_regions (region_id,city_id,region) values (210781,2107,'�躣��');
insert into web_regions (region_id,city_id,region) values (210782,2107,'������');
insert into web_regions (region_id,city_id,region) values (210802,2108,'վǰ��');
insert into web_regions (region_id,city_id,region) values (210803,2108,'������');
insert into web_regions (region_id,city_id,region) values (210804,2108,'����Ȧ��');
insert into web_regions (region_id,city_id,region) values (210811,2108,'�ϱ���');
insert into web_regions (region_id,city_id,region) values (210881,2108,'������');
insert into web_regions (region_id,city_id,region) values (210882,2108,'��ʯ����');
insert into web_regions (region_id,city_id,region) values (210902,2109,'������');
insert into web_regions (region_id,city_id,region) values (210903,2109,'������');
insert into web_regions (region_id,city_id,region) values (210904,2109,'̫ƽ��');
insert into web_regions (region_id,city_id,region) values (210905,2109,'�������');
insert into web_regions (region_id,city_id,region) values (210911,2109,'ϸ����');
insert into web_regions (region_id,city_id,region) values (210921,2109,'�����ɹ���������');
insert into web_regions (region_id,city_id,region) values (210922,2109,'������');
insert into web_regions (region_id,city_id,region) values (211002,2110,'������');
insert into web_regions (region_id,city_id,region) values (211003,2110,'��ʥ��');
insert into web_regions (region_id,city_id,region) values (211004,2110,'��ΰ��');
insert into web_regions (region_id,city_id,region) values (211005,2110,'��������');
insert into web_regions (region_id,city_id,region) values (211011,2110,'̫�Ӻ���');
insert into web_regions (region_id,city_id,region) values (211021,2110,'������');
insert into web_regions (region_id,city_id,region) values (211081,2110,'������');
insert into web_regions (region_id,city_id,region) values (211102,2111,'˫̨����');
insert into web_regions (region_id,city_id,region) values (211103,2111,'��¡̨��');
insert into web_regions (region_id,city_id,region) values (211121,2111,'������');
insert into web_regions (region_id,city_id,region) values (211122,2111,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (211202,2112,'������');
insert into web_regions (region_id,city_id,region) values (211204,2112,'�����');
insert into web_regions (region_id,city_id,region) values (211221,2112,'������');
insert into web_regions (region_id,city_id,region) values (211223,2112,'������');
insert into web_regions (region_id,city_id,region) values (211224,2112,'��ͼ��');
insert into web_regions (region_id,city_id,region) values (211281,2112,'����ɽ��');
insert into web_regions (region_id,city_id,region) values (211282,2112,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (211302,2113,'˫����');
insert into web_regions (region_id,city_id,region) values (211303,2113,'������');
insert into web_regions (region_id,city_id,region) values (211321,2113,'������');
insert into web_regions (region_id,city_id,region) values (211322,2113,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (211324,2113,'�����������ɹ���������');
insert into web_regions (region_id,city_id,region) values (211381,2113,'��Ʊ��');
insert into web_regions (region_id,city_id,region) values (211382,2113,'��Դ��');
insert into web_regions (region_id,city_id,region) values (211402,2114,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (211403,2114,'������');
insert into web_regions (region_id,city_id,region) values (211404,2114,'��Ʊ��');
insert into web_regions (region_id,city_id,region) values (211421,2114,'������');
insert into web_regions (region_id,city_id,region) values (211422,2114,'������');
insert into web_regions (region_id,city_id,region) values (211481,2114,'�˳���');
insert into web_regions (region_id,city_id,region) values (211501,2115,'��������');
insert into web_regions (region_id,city_id,region) values (211502,2115,'��������');
insert into web_regions (region_id,city_id,region) values (211503,2115,'��˰��');
insert into web_regions (region_id,city_id,region) values (220102,2201,'�Ϲ���');
insert into web_regions (region_id,city_id,region) values (220103,2201,'������');
insert into web_regions (region_id,city_id,region) values (220104,2201,'������');
insert into web_regions (region_id,city_id,region) values (220105,2201,'������');
insert into web_regions (region_id,city_id,region) values (220106,2201,'��԰��');
insert into web_regions (region_id,city_id,region) values (220112,2201,'˫����');
insert into web_regions (region_id,city_id,region) values (220113,2201,'��̨��');
insert into web_regions (region_id,city_id,region) values (220122,2201,'ũ����');
insert into web_regions (region_id,city_id,region) values (220182,2201,'������');
insert into web_regions (region_id,city_id,region) values (220183,2201,'�»���');
insert into web_regions (region_id,city_id,region) values (220202,2202,'������');
insert into web_regions (region_id,city_id,region) values (220203,2202,'��̶��');
insert into web_regions (region_id,city_id,region) values (220204,2202,'��Ӫ��');
insert into web_regions (region_id,city_id,region) values (220211,2202,'������');
insert into web_regions (region_id,city_id,region) values (220221,2202,'������');
insert into web_regions (region_id,city_id,region) values (220281,2202,'�Ժ���');
insert into web_regions (region_id,city_id,region) values (220282,2202,'�����');
insert into web_regions (region_id,city_id,region) values (220283,2202,'������');
insert into web_regions (region_id,city_id,region) values (220284,2202,'��ʯ��');
insert into web_regions (region_id,city_id,region) values (220302,2203,'������');
insert into web_regions (region_id,city_id,region) values (220303,2203,'������');
insert into web_regions (region_id,city_id,region) values (220322,2203,'������');
insert into web_regions (region_id,city_id,region) values (220323,2203,'��ͨ����������');
insert into web_regions (region_id,city_id,region) values (220381,2203,'��������');
insert into web_regions (region_id,city_id,region) values (220382,2203,'˫����');
insert into web_regions (region_id,city_id,region) values (220402,2204,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (220403,2204,'������');
insert into web_regions (region_id,city_id,region) values (220421,2204,'������');
insert into web_regions (region_id,city_id,region) values (220422,2204,'������');
insert into web_regions (region_id,city_id,region) values (220502,2205,'������');
insert into web_regions (region_id,city_id,region) values (220503,2205,'��������');
insert into web_regions (region_id,city_id,region) values (220521,2205,'ͨ����');
insert into web_regions (region_id,city_id,region) values (220523,2205,'������');
insert into web_regions (region_id,city_id,region) values (220524,2205,'������');
insert into web_regions (region_id,city_id,region) values (220581,2205,'÷�ӿ���');
insert into web_regions (region_id,city_id,region) values (220582,2205,'������');
insert into web_regions (region_id,city_id,region) values (220602,2206,'�뽭��');
insert into web_regions (region_id,city_id,region) values (220605,2206,'��Դ��');
insert into web_regions (region_id,city_id,region) values (220621,2206,'������');
insert into web_regions (region_id,city_id,region) values (220622,2206,'������');
insert into web_regions (region_id,city_id,region) values (220623,2206,'���׳�����������');
insert into web_regions (region_id,city_id,region) values (220681,2206,'�ٽ���');
insert into web_regions (region_id,city_id,region) values (220702,2207,'������');
insert into web_regions (region_id,city_id,region) values (220721,2207,'ǰ������˹�ɹ���������');
insert into web_regions (region_id,city_id,region) values (220722,2207,'������');
insert into web_regions (region_id,city_id,region) values (220723,2207,'Ǭ����');
insert into web_regions (region_id,city_id,region) values (220781,2207,'������');
insert into web_regions (region_id,city_id,region) values (220802,2208,'䬱���');
insert into web_regions (region_id,city_id,region) values (220821,2208,'������');
insert into web_regions (region_id,city_id,region) values (220822,2208,'ͨ����');
insert into web_regions (region_id,city_id,region) values (220881,2208,'�����');
insert into web_regions (region_id,city_id,region) values (220882,2208,'����');
insert into web_regions (region_id,city_id,region) values (222401,2224,'�Ӽ���');
insert into web_regions (region_id,city_id,region) values (222402,2224,'ͼ����');
insert into web_regions (region_id,city_id,region) values (222403,2224,'�ػ���');
insert into web_regions (region_id,city_id,region) values (222404,2224,'������');
insert into web_regions (region_id,city_id,region) values (222405,2224,'������');
insert into web_regions (region_id,city_id,region) values (222406,2224,'������');
insert into web_regions (region_id,city_id,region) values (222424,2224,'������');
insert into web_regions (region_id,city_id,region) values (222426,2224,'��ͼ��');
insert into web_regions (region_id,city_id,region) values (230102,2301,'������');
insert into web_regions (region_id,city_id,region) values (230103,2301,'�ϸ���');
insert into web_regions (region_id,city_id,region) values (230104,2301,'������');
insert into web_regions (region_id,city_id,region) values (230108,2301,'ƽ����');
insert into web_regions (region_id,city_id,region) values (230109,2301,'�ɱ���');
insert into web_regions (region_id,city_id,region) values (230110,2301,'�㷻��');
insert into web_regions (region_id,city_id,region) values (230111,2301,'������');
insert into web_regions (region_id,city_id,region) values (230112,2301,'������');
insert into web_regions (region_id,city_id,region) values (230113,2301,'˫����');
insert into web_regions (region_id,city_id,region) values (230123,2301,'������');
insert into web_regions (region_id,city_id,region) values (230124,2301,'������');
insert into web_regions (region_id,city_id,region) values (230125,2301,'����');
insert into web_regions (region_id,city_id,region) values (230126,2301,'������');
insert into web_regions (region_id,city_id,region) values (230127,2301,'ľ����');
insert into web_regions (region_id,city_id,region) values (230128,2301,'ͨ����');
insert into web_regions (region_id,city_id,region) values (230129,2301,'������');
insert into web_regions (region_id,city_id,region) values (230183,2301,'��־��');
insert into web_regions (region_id,city_id,region) values (230184,2301,'�峣��');
insert into web_regions (region_id,city_id,region) values (230202,2302,'��ɳ��');
insert into web_regions (region_id,city_id,region) values (230203,2302,'������');
insert into web_regions (region_id,city_id,region) values (230204,2302,'������');
insert into web_regions (region_id,city_id,region) values (230205,2302,'����Ϫ��');
insert into web_regions (region_id,city_id,region) values (230206,2302,'����������');
insert into web_regions (region_id,city_id,region) values (230207,2302,'����ɽ��');
insert into web_regions (region_id,city_id,region) values (230208,2302,'÷��˹���Ӷ�����');
insert into web_regions (region_id,city_id,region) values (230221,2302,'������');
insert into web_regions (region_id,city_id,region) values (230223,2302,'������');
insert into web_regions (region_id,city_id,region) values (230224,2302,'̩����');
insert into web_regions (region_id,city_id,region) values (230225,2302,'������');
insert into web_regions (region_id,city_id,region) values (230227,2302,'��ԣ��');
insert into web_regions (region_id,city_id,region) values (230229,2302,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (230230,2302,'�˶���');
insert into web_regions (region_id,city_id,region) values (230231,2302,'��Ȫ��');
insert into web_regions (region_id,city_id,region) values (230281,2302,'ګ����');
insert into web_regions (region_id,city_id,region) values (230302,2303,'������');
insert into web_regions (region_id,city_id,region) values (230303,2303,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (230304,2303,'�ε���');
insert into web_regions (region_id,city_id,region) values (230305,2303,'������');
insert into web_regions (region_id,city_id,region) values (230306,2303,'���Ӻ���');
insert into web_regions (region_id,city_id,region) values (230307,2303,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (230321,2303,'������');
insert into web_regions (region_id,city_id,region) values (230381,2303,'������');
insert into web_regions (region_id,city_id,region) values (230382,2303,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (230402,2304,'������');
insert into web_regions (region_id,city_id,region) values (230403,2304,'��ũ��');
insert into web_regions (region_id,city_id,region) values (230404,2304,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (230405,2304,'�˰���');
insert into web_regions (region_id,city_id,region) values (230406,2304,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (230407,2304,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (230421,2304,'�ܱ���');
insert into web_regions (region_id,city_id,region) values (230422,2304,'�����');
insert into web_regions (region_id,city_id,region) values (230502,2305,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (230503,2305,'�붫��');
insert into web_regions (region_id,city_id,region) values (230505,2305,'�ķ�̨��');
insert into web_regions (region_id,city_id,region) values (230506,2305,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (230521,2305,'������');
insert into web_regions (region_id,city_id,region) values (230522,2305,'������');
insert into web_regions (region_id,city_id,region) values (230523,2305,'������');
insert into web_regions (region_id,city_id,region) values (230524,2305,'�ĺ���');
insert into web_regions (region_id,city_id,region) values (230602,2306,'����ͼ��');
insert into web_regions (region_id,city_id,region) values (230603,2306,'������');
insert into web_regions (region_id,city_id,region) values (230604,2306,'�ú�·��');
insert into web_regions (region_id,city_id,region) values (230605,2306,'�����');
insert into web_regions (region_id,city_id,region) values (230606,2306,'��ͬ��');
insert into web_regions (region_id,city_id,region) values (230621,2306,'������');
insert into web_regions (region_id,city_id,region) values (230622,2306,'��Դ��');
insert into web_regions (region_id,city_id,region) values (230623,2306,'�ֵ���');
insert into web_regions (region_id,city_id,region) values (230624,2306,'�Ŷ������ɹ���������');
insert into web_regions (region_id,city_id,region) values (230702,2307,'������');
insert into web_regions (region_id,city_id,region) values (230703,2307,'�ϲ���');
insert into web_regions (region_id,city_id,region) values (230704,2307,'�Ѻ���');
insert into web_regions (region_id,city_id,region) values (230705,2307,'������');
insert into web_regions (region_id,city_id,region) values (230706,2307,'������');
insert into web_regions (region_id,city_id,region) values (230707,2307,'������');
insert into web_regions (region_id,city_id,region) values (230708,2307,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (230709,2307,'��ɽ����');
insert into web_regions (region_id,city_id,region) values (230710,2307,'��Ӫ��');
insert into web_regions (region_id,city_id,region) values (230711,2307,'��������');
insert into web_regions (region_id,city_id,region) values (230712,2307,'��������');
insert into web_regions (region_id,city_id,region) values (230713,2307,'������');
insert into web_regions (region_id,city_id,region) values (230714,2307,'��������');
insert into web_regions (region_id,city_id,region) values (230715,2307,'������');
insert into web_regions (region_id,city_id,region) values (230716,2307,'�ϸ�����');
insert into web_regions (region_id,city_id,region) values (230722,2307,'������');
insert into web_regions (region_id,city_id,region) values (230781,2307,'������');
insert into web_regions (region_id,city_id,region) values (230803,2308,'������');
insert into web_regions (region_id,city_id,region) values (230804,2308,'ǰ����');
insert into web_regions (region_id,city_id,region) values (230805,2308,'������');
insert into web_regions (region_id,city_id,region) values (230811,2308,'����');
insert into web_regions (region_id,city_id,region) values (230822,2308,'������');
insert into web_regions (region_id,city_id,region) values (230826,2308,'�봨��');
insert into web_regions (region_id,city_id,region) values (230828,2308,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (230833,2308,'��Զ��');
insert into web_regions (region_id,city_id,region) values (230881,2308,'ͬ����');
insert into web_regions (region_id,city_id,region) values (230882,2308,'������');
insert into web_regions (region_id,city_id,region) values (230902,2309,'������');
insert into web_regions (region_id,city_id,region) values (230903,2309,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (230904,2309,'���Ӻ���');
insert into web_regions (region_id,city_id,region) values (230921,2309,'������');
insert into web_regions (region_id,city_id,region) values (231002,2310,'������');
insert into web_regions (region_id,city_id,region) values (231003,2310,'������');
insert into web_regions (region_id,city_id,region) values (231004,2310,'������');
insert into web_regions (region_id,city_id,region) values (231005,2310,'������');
insert into web_regions (region_id,city_id,region) values (231024,2310,'������');
insert into web_regions (region_id,city_id,region) values (231025,2310,'�ֿ���');
insert into web_regions (region_id,city_id,region) values (231081,2310,'��Һ���');
insert into web_regions (region_id,city_id,region) values (231083,2310,'������');
insert into web_regions (region_id,city_id,region) values (231084,2310,'������');
insert into web_regions (region_id,city_id,region) values (231085,2310,'������');
insert into web_regions (region_id,city_id,region) values (231102,2311,'������');
insert into web_regions (region_id,city_id,region) values (231121,2311,'�۽���');
insert into web_regions (region_id,city_id,region) values (231123,2311,'ѷ����');
insert into web_regions (region_id,city_id,region) values (231124,2311,'������');
insert into web_regions (region_id,city_id,region) values (231181,2311,'������');
insert into web_regions (region_id,city_id,region) values (231182,2311,'���������');
insert into web_regions (region_id,city_id,region) values (231202,2312,'������');
insert into web_regions (region_id,city_id,region) values (231221,2312,'������');
insert into web_regions (region_id,city_id,region) values (231222,2312,'������');
insert into web_regions (region_id,city_id,region) values (231223,2312,'�����');
insert into web_regions (region_id,city_id,region) values (231224,2312,'�찲��');
insert into web_regions (region_id,city_id,region) values (231225,2312,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (231226,2312,'������');
insert into web_regions (region_id,city_id,region) values (231281,2312,'������');
insert into web_regions (region_id,city_id,region) values (231282,2312,'�ض���');
insert into web_regions (region_id,city_id,region) values (231283,2312,'������');
insert into web_regions (region_id,city_id,region) values (232701,2327,'�Ӹ������');
insert into web_regions (region_id,city_id,region) values (232702,2327,'������');
insert into web_regions (region_id,city_id,region) values (232703,2327,'������');
insert into web_regions (region_id,city_id,region) values (232704,2327,'������');
insert into web_regions (region_id,city_id,region) values (232721,2327,'������');
insert into web_regions (region_id,city_id,region) values (232722,2327,'������');
insert into web_regions (region_id,city_id,region) values (232723,2327,'Į����');
insert into web_regions (region_id,city_id,region) values (310101,3101,'������');
insert into web_regions (region_id,city_id,region) values (310104,3101,'�����');
insert into web_regions (region_id,city_id,region) values (310105,3101,'������');
insert into web_regions (region_id,city_id,region) values (310106,3101,'������');
insert into web_regions (region_id,city_id,region) values (310107,3101,'������');
insert into web_regions (region_id,city_id,region) values (310108,3101,'բ����');
insert into web_regions (region_id,city_id,region) values (310109,3101,'�����');
insert into web_regions (region_id,city_id,region) values (310110,3101,'������');
insert into web_regions (region_id,city_id,region) values (310112,3101,'������');
insert into web_regions (region_id,city_id,region) values (310113,3101,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (310114,3101,'�ζ���');
insert into web_regions (region_id,city_id,region) values (310115,3101,'�ֶ�����');
insert into web_regions (region_id,city_id,region) values (310116,3101,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (310117,3101,'�ɽ���');
insert into web_regions (region_id,city_id,region) values (310118,3101,'������');
insert into web_regions (region_id,city_id,region) values (310120,3101,'������');
insert into web_regions (region_id,city_id,region) values (310230,3101,'������');
insert into web_regions (region_id,city_id,region) values (320102,3201,'������');
insert into web_regions (region_id,city_id,region) values (320104,3201,'�ػ���');
insert into web_regions (region_id,city_id,region) values (320105,3201,'������');
insert into web_regions (region_id,city_id,region) values (320106,3201,'��¥��');
insert into web_regions (region_id,city_id,region) values (320111,3201,'�ֿ���');
insert into web_regions (region_id,city_id,region) values (320113,3201,'��ϼ��');
insert into web_regions (region_id,city_id,region) values (320114,3201,'�껨̨��');
insert into web_regions (region_id,city_id,region) values (320115,3201,'������');
insert into web_regions (region_id,city_id,region) values (320116,3201,'������');
insert into web_regions (region_id,city_id,region) values (320117,3201,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (320118,3201,'�ߴ���');
insert into web_regions (region_id,city_id,region) values (320202,3202,'�簲��');
insert into web_regions (region_id,city_id,region) values (320203,3202,'�ϳ���');
insert into web_regions (region_id,city_id,region) values (320204,3202,'������');
insert into web_regions (region_id,city_id,region) values (320205,3202,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (320206,3202,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (320211,3202,'������');
insert into web_regions (region_id,city_id,region) values (320281,3202,'������');
insert into web_regions (region_id,city_id,region) values (320282,3202,'������');
insert into web_regions (region_id,city_id,region) values (320302,3203,'��¥��');
insert into web_regions (region_id,city_id,region) values (320303,3203,'������');
insert into web_regions (region_id,city_id,region) values (320305,3203,'������');
insert into web_regions (region_id,city_id,region) values (320311,3203,'Ȫɽ��');
insert into web_regions (region_id,city_id,region) values (320312,3203,'ͭɽ��');
insert into web_regions (region_id,city_id,region) values (320321,3203,'����');
insert into web_regions (region_id,city_id,region) values (320322,3203,'����');
insert into web_regions (region_id,city_id,region) values (320324,3203,'�����');
insert into web_regions (region_id,city_id,region) values (320381,3203,'������');
insert into web_regions (region_id,city_id,region) values (320382,3203,'������');
insert into web_regions (region_id,city_id,region) values (320402,3204,'������');
insert into web_regions (region_id,city_id,region) values (320404,3204,'��¥��');
insert into web_regions (region_id,city_id,region) values (320405,3204,'��������');
insert into web_regions (region_id,city_id,region) values (320411,3204,'�±���');
insert into web_regions (region_id,city_id,region) values (320412,3204,'�����');
insert into web_regions (region_id,city_id,region) values (320481,3204,'������');
insert into web_regions (region_id,city_id,region) values (320482,3204,'��̳��');
insert into web_regions (region_id,city_id,region) values (320505,3205,'������');
insert into web_regions (region_id,city_id,region) values (320506,3205,'������');
insert into web_regions (region_id,city_id,region) values (320507,3205,'�����');
insert into web_regions (region_id,city_id,region) values (320508,3205,'������');
insert into web_regions (region_id,city_id,region) values (320509,3205,'�⽭��');
insert into web_regions (region_id,city_id,region) values (320581,3205,'������');
insert into web_regions (region_id,city_id,region) values (320582,3205,'�żҸ���');
insert into web_regions (region_id,city_id,region) values (320583,3205,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (320585,3205,'̫����');
insert into web_regions (region_id,city_id,region) values (320602,3206,'�紨��');
insert into web_regions (region_id,city_id,region) values (320611,3206,'��բ��');
insert into web_regions (region_id,city_id,region) values (320612,3206,'ͨ����');
insert into web_regions (region_id,city_id,region) values (320621,3206,'������');
insert into web_regions (region_id,city_id,region) values (320623,3206,'�綫��');
insert into web_regions (region_id,city_id,region) values (320681,3206,'������');
insert into web_regions (region_id,city_id,region) values (320682,3206,'�����');
insert into web_regions (region_id,city_id,region) values (320684,3206,'������');
insert into web_regions (region_id,city_id,region) values (320703,3207,'������');
insert into web_regions (region_id,city_id,region) values (320706,3207,'������');
insert into web_regions (region_id,city_id,region) values (320707,3207,'������');
insert into web_regions (region_id,city_id,region) values (320722,3207,'������');
insert into web_regions (region_id,city_id,region) values (320723,3207,'������');
insert into web_regions (region_id,city_id,region) values (320724,3207,'������');
insert into web_regions (region_id,city_id,region) values (320802,3208,'�����');
insert into web_regions (region_id,city_id,region) values (320803,3208,'������');
insert into web_regions (region_id,city_id,region) values (320804,3208,'������');
insert into web_regions (region_id,city_id,region) values (320811,3208,'������');
insert into web_regions (region_id,city_id,region) values (320826,3208,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (320829,3208,'������');
insert into web_regions (region_id,city_id,region) values (320830,3208,'������');
insert into web_regions (region_id,city_id,region) values (320831,3208,'�����');
insert into web_regions (region_id,city_id,region) values (320902,3209,'ͤ����');
insert into web_regions (region_id,city_id,region) values (320903,3209,'�ζ���');
insert into web_regions (region_id,city_id,region) values (320921,3209,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (320922,3209,'������');
insert into web_regions (region_id,city_id,region) values (320923,3209,'������');
insert into web_regions (region_id,city_id,region) values (320924,3209,'������');
insert into web_regions (region_id,city_id,region) values (320925,3209,'������');
insert into web_regions (region_id,city_id,region) values (320981,3209,'��̨��');
insert into web_regions (region_id,city_id,region) values (320982,3209,'�����');
insert into web_regions (region_id,city_id,region) values (321002,3210,'������');
insert into web_regions (region_id,city_id,region) values (321003,3210,'������');
insert into web_regions (region_id,city_id,region) values (321012,3210,'������');
insert into web_regions (region_id,city_id,region) values (321023,3210,'��Ӧ��');
insert into web_regions (region_id,city_id,region) values (321081,3210,'������');
insert into web_regions (region_id,city_id,region) values (321084,3210,'������');
insert into web_regions (region_id,city_id,region) values (321102,3211,'������');
insert into web_regions (region_id,city_id,region) values (321111,3211,'������');
insert into web_regions (region_id,city_id,region) values (321112,3211,'��ͽ��');
insert into web_regions (region_id,city_id,region) values (321181,3211,'������');
insert into web_regions (region_id,city_id,region) values (321182,3211,'������');
insert into web_regions (region_id,city_id,region) values (321183,3211,'������');
insert into web_regions (region_id,city_id,region) values (321202,3212,'������');
insert into web_regions (region_id,city_id,region) values (321203,3212,'�߸���');
insert into web_regions (region_id,city_id,region) values (321204,3212,'������');
insert into web_regions (region_id,city_id,region) values (321281,3212,'�˻���');
insert into web_regions (region_id,city_id,region) values (321282,3212,'������');
insert into web_regions (region_id,city_id,region) values (321283,3212,'̩����');
insert into web_regions (region_id,city_id,region) values (321302,3213,'�޳���');
insert into web_regions (region_id,city_id,region) values (321311,3213,'��ԥ��');
insert into web_regions (region_id,city_id,region) values (321322,3213,'������');
insert into web_regions (region_id,city_id,region) values (321323,3213,'������');
insert into web_regions (region_id,city_id,region) values (321324,3213,'������');
insert into web_regions (region_id,city_id,region) values (330102,3301,'�ϳ���');
insert into web_regions (region_id,city_id,region) values (330103,3301,'�³���');
insert into web_regions (region_id,city_id,region) values (330104,3301,'������');
insert into web_regions (region_id,city_id,region) values (330105,3301,'������');
insert into web_regions (region_id,city_id,region) values (330106,3301,'������');
insert into web_regions (region_id,city_id,region) values (330108,3301,'������');
insert into web_regions (region_id,city_id,region) values (330109,3301,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (330110,3301,'�ຼ��');
insert into web_regions (region_id,city_id,region) values (330122,3301,'ͩ®��');
insert into web_regions (region_id,city_id,region) values (330127,3301,'������');
insert into web_regions (region_id,city_id,region) values (330182,3301,'������');
insert into web_regions (region_id,city_id,region) values (330183,3301,'������');
insert into web_regions (region_id,city_id,region) values (330185,3301,'�ٰ���');
insert into web_regions (region_id,city_id,region) values (330203,3302,'������');
insert into web_regions (region_id,city_id,region) values (330204,3302,'������');
insert into web_regions (region_id,city_id,region) values (330205,3302,'������');
insert into web_regions (region_id,city_id,region) values (330206,3302,'������');
insert into web_regions (region_id,city_id,region) values (330211,3302,'����');
insert into web_regions (region_id,city_id,region) values (330212,3302,'۴����');
insert into web_regions (region_id,city_id,region) values (330225,3302,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (330226,3302,'������');
insert into web_regions (region_id,city_id,region) values (330281,3302,'��Ҧ��');
insert into web_regions (region_id,city_id,region) values (330282,3302,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (330283,3302,'���');
insert into web_regions (region_id,city_id,region) values (330302,3303,'¹����');
insert into web_regions (region_id,city_id,region) values (330303,3303,'������');
insert into web_regions (region_id,city_id,region) values (330304,3303,'걺���');
insert into web_regions (region_id,city_id,region) values (330322,3303,'��ͷ��');
insert into web_regions (region_id,city_id,region) values (330324,3303,'������');
insert into web_regions (region_id,city_id,region) values (330326,3303,'ƽ����');
insert into web_regions (region_id,city_id,region) values (330327,3303,'������');
insert into web_regions (region_id,city_id,region) values (330328,3303,'�ĳ���');
insert into web_regions (region_id,city_id,region) values (330329,3303,'̩˳��');
insert into web_regions (region_id,city_id,region) values (330381,3303,'����');
insert into web_regions (region_id,city_id,region) values (330382,3303,'������');
insert into web_regions (region_id,city_id,region) values (330402,3304,'�Ϻ���');
insert into web_regions (region_id,city_id,region) values (330411,3304,'������');
insert into web_regions (region_id,city_id,region) values (330421,3304,'������');
insert into web_regions (region_id,city_id,region) values (330424,3304,'������');
insert into web_regions (region_id,city_id,region) values (330481,3304,'������');
insert into web_regions (region_id,city_id,region) values (330482,3304,'ƽ����');
insert into web_regions (region_id,city_id,region) values (330483,3304,'ͩ����');
insert into web_regions (region_id,city_id,region) values (330502,3305,'������');
insert into web_regions (region_id,city_id,region) values (330503,3305,'�����');
insert into web_regions (region_id,city_id,region) values (330521,3305,'������');
insert into web_regions (region_id,city_id,region) values (330522,3305,'������');
insert into web_regions (region_id,city_id,region) values (330523,3305,'������');
insert into web_regions (region_id,city_id,region) values (330602,3306,'Խ����');
insert into web_regions (region_id,city_id,region) values (330603,3306,'������');
insert into web_regions (region_id,city_id,region) values (330604,3306,'������');
insert into web_regions (region_id,city_id,region) values (330624,3306,'�²���');
insert into web_regions (region_id,city_id,region) values (330681,3306,'������');
insert into web_regions (region_id,city_id,region) values (330683,3306,'������');
insert into web_regions (region_id,city_id,region) values (330702,3307,'�ĳ���');
insert into web_regions (region_id,city_id,region) values (330703,3307,'����');
insert into web_regions (region_id,city_id,region) values (330723,3307,'������');
insert into web_regions (region_id,city_id,region) values (330726,3307,'�ֽ���');
insert into web_regions (region_id,city_id,region) values (330727,3307,'�Ͱ���');
insert into web_regions (region_id,city_id,region) values (330781,3307,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (330782,3307,'������');
insert into web_regions (region_id,city_id,region) values (330783,3307,'������');
insert into web_regions (region_id,city_id,region) values (330784,3307,'������');
insert into web_regions (region_id,city_id,region) values (330802,3308,'�³���');
insert into web_regions (region_id,city_id,region) values (330803,3308,'�齭��');
insert into web_regions (region_id,city_id,region) values (330822,3308,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (330824,3308,'������');
insert into web_regions (region_id,city_id,region) values (330825,3308,'������');
insert into web_regions (region_id,city_id,region) values (330881,3308,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (330902,3309,'������');
insert into web_regions (region_id,city_id,region) values (330903,3309,'������');
insert into web_regions (region_id,city_id,region) values (330921,3309,'�ɽ��');
insert into web_regions (region_id,city_id,region) values (330922,3309,'������');
insert into web_regions (region_id,city_id,region) values (331002,3310,'������');
insert into web_regions (region_id,city_id,region) values (331003,3310,'������');
insert into web_regions (region_id,city_id,region) values (331004,3310,'·����');
insert into web_regions (region_id,city_id,region) values (331021,3310,'����');
insert into web_regions (region_id,city_id,region) values (331022,3310,'������');
insert into web_regions (region_id,city_id,region) values (331023,3310,'��̨��');
insert into web_regions (region_id,city_id,region) values (331024,3310,'�ɾ���');
insert into web_regions (region_id,city_id,region) values (331081,3310,'������');
insert into web_regions (region_id,city_id,region) values (331082,3310,'�ٺ���');
insert into web_regions (region_id,city_id,region) values (331102,3311,'������');
insert into web_regions (region_id,city_id,region) values (331121,3311,'������');
insert into web_regions (region_id,city_id,region) values (331122,3311,'������');
insert into web_regions (region_id,city_id,region) values (331123,3311,'�����');
insert into web_regions (region_id,city_id,region) values (331124,3311,'������');
insert into web_regions (region_id,city_id,region) values (331125,3311,'�ƺ���');
insert into web_regions (region_id,city_id,region) values (331126,3311,'��Ԫ��');
insert into web_regions (region_id,city_id,region) values (331127,3311,'�������������');
insert into web_regions (region_id,city_id,region) values (331181,3311,'��Ȫ��');
insert into web_regions (region_id,city_id,region) values (331201,3312,'������');
insert into web_regions (region_id,city_id,region) values (331202,3312,'���ᵺ');
insert into web_regions (region_id,city_id,region) values (331203,3312,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (331204,3312,'��ɽ����������');
insert into web_regions (region_id,city_id,region) values (331205,3312,'�ɽ�����ϲ�');
insert into web_regions (region_id,city_id,region) values (331206,3312,'������');
insert into web_regions (region_id,city_id,region) values (331207,3312,'��Ҽ⵺');
insert into web_regions (region_id,city_id,region) values (331208,3312,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (331209,3312,'��Ϳ��');
insert into web_regions (region_id,city_id,region) values (331210,3312,'Ϻ�ŵ�');
insert into web_regions (region_id,city_id,region) values (340102,3401,'������');
insert into web_regions (region_id,city_id,region) values (340103,3401,'®����');
insert into web_regions (region_id,city_id,region) values (340104,3401,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (340111,3401,'������');
insert into web_regions (region_id,city_id,region) values (340121,3401,'������');
insert into web_regions (region_id,city_id,region) values (340122,3401,'�ʶ���');
insert into web_regions (region_id,city_id,region) values (340123,3401,'������');
insert into web_regions (region_id,city_id,region) values (340124,3401,'®����');
insert into web_regions (region_id,city_id,region) values (340181,3401,'������');
insert into web_regions (region_id,city_id,region) values (340202,3402,'������');
insert into web_regions (region_id,city_id,region) values (340203,3402,'߮����');
insert into web_regions (region_id,city_id,region) values (340207,3402,'𯽭��');
insert into web_regions (region_id,city_id,region) values (340208,3402,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (340221,3402,'�ߺ���');
insert into web_regions (region_id,city_id,region) values (340222,3402,'������');
insert into web_regions (region_id,city_id,region) values (340223,3402,'������');
insert into web_regions (region_id,city_id,region) values (340225,3402,'��Ϊ��');
insert into web_regions (region_id,city_id,region) values (340302,3403,'���Ӻ���');
insert into web_regions (region_id,city_id,region) values (340303,3403,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (340304,3403,'������');
insert into web_regions (region_id,city_id,region) values (340311,3403,'������');
insert into web_regions (region_id,city_id,region) values (340321,3403,'��Զ��');
insert into web_regions (region_id,city_id,region) values (340322,3403,'�����');
insert into web_regions (region_id,city_id,region) values (340323,3403,'������');
insert into web_regions (region_id,city_id,region) values (340402,3404,'��ͨ��');
insert into web_regions (region_id,city_id,region) values (340403,3404,'�������');
insert into web_regions (region_id,city_id,region) values (340404,3404,'л�Ҽ���');
insert into web_regions (region_id,city_id,region) values (340405,3404,'�˹�ɽ��');
insert into web_regions (region_id,city_id,region) values (340406,3404,'�˼���');
insert into web_regions (region_id,city_id,region) values (340421,3404,'��̨��');
insert into web_regions (region_id,city_id,region) values (340503,3405,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (340504,3405,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (340506,3405,'������');
insert into web_regions (region_id,city_id,region) values (340521,3405,'��Ϳ��');
insert into web_regions (region_id,city_id,region) values (340522,3405,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (340523,3405,'����');
insert into web_regions (region_id,city_id,region) values (340602,3406,'�ż���');
insert into web_regions (region_id,city_id,region) values (340603,3406,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (340604,3406,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (340621,3406,'�Ϫ��');
insert into web_regions (region_id,city_id,region) values (340702,3407,'ͭ��ɽ��');
insert into web_regions (region_id,city_id,region) values (340703,3407,'ʨ��ɽ��');
insert into web_regions (region_id,city_id,region) values (340711,3407,'����');
insert into web_regions (region_id,city_id,region) values (340721,3407,'ͭ����');
insert into web_regions (region_id,city_id,region) values (340802,3408,'ӭ����');
insert into web_regions (region_id,city_id,region) values (340803,3408,'�����');
insert into web_regions (region_id,city_id,region) values (340811,3408,'������');
insert into web_regions (region_id,city_id,region) values (340822,3408,'������');
insert into web_regions (region_id,city_id,region) values (340823,3408,'������');
insert into web_regions (region_id,city_id,region) values (340824,3408,'Ǳɽ��');
insert into web_regions (region_id,city_id,region) values (340825,3408,'̫����');
insert into web_regions (region_id,city_id,region) values (340826,3408,'������');
insert into web_regions (region_id,city_id,region) values (340827,3408,'������');
insert into web_regions (region_id,city_id,region) values (340828,3408,'������');
insert into web_regions (region_id,city_id,region) values (340881,3408,'ͩ����');
insert into web_regions (region_id,city_id,region) values (341002,3410,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (341003,3410,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (341004,3410,'������');
insert into web_regions (region_id,city_id,region) values (341021,3410,'���');
insert into web_regions (region_id,city_id,region) values (341022,3410,'������');
insert into web_regions (region_id,city_id,region) values (341023,3410,'����');
insert into web_regions (region_id,city_id,region) values (341024,3410,'������');
insert into web_regions (region_id,city_id,region) values (341102,3411,'������');
insert into web_regions (region_id,city_id,region) values (341103,3411,'������');
insert into web_regions (region_id,city_id,region) values (341122,3411,'������');
insert into web_regions (region_id,city_id,region) values (341124,3411,'ȫ����');
insert into web_regions (region_id,city_id,region) values (341125,3411,'��Զ��');
insert into web_regions (region_id,city_id,region) values (341126,3411,'������');
insert into web_regions (region_id,city_id,region) values (341181,3411,'�쳤��');
insert into web_regions (region_id,city_id,region) values (341182,3411,'������');
insert into web_regions (region_id,city_id,region) values (341202,3412,'�����');
insert into web_regions (region_id,city_id,region) values (341203,3412,'򣶫��');
insert into web_regions (region_id,city_id,region) values (341204,3412,'�Ȫ��');
insert into web_regions (region_id,city_id,region) values (341221,3412,'��Ȫ��');
insert into web_regions (region_id,city_id,region) values (341222,3412,'̫����');
insert into web_regions (region_id,city_id,region) values (341225,3412,'������');
insert into web_regions (region_id,city_id,region) values (341226,3412,'�����');
insert into web_regions (region_id,city_id,region) values (341282,3412,'������');
insert into web_regions (region_id,city_id,region) values (341302,3413,'������');
insert into web_regions (region_id,city_id,region) values (341321,3413,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (341322,3413,'����');
insert into web_regions (region_id,city_id,region) values (341323,3413,'�����');
insert into web_regions (region_id,city_id,region) values (341324,3413,'����');
insert into web_regions (region_id,city_id,region) values (341502,3415,'����');
insert into web_regions (region_id,city_id,region) values (341503,3415,'ԣ����');
insert into web_regions (region_id,city_id,region) values (341521,3415,'����');
insert into web_regions (region_id,city_id,region) values (341522,3415,'������');
insert into web_regions (region_id,city_id,region) values (341523,3415,'�����');
insert into web_regions (region_id,city_id,region) values (341524,3415,'��կ��');
insert into web_regions (region_id,city_id,region) values (341525,3415,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (341602,3416,'�۳���');
insert into web_regions (region_id,city_id,region) values (341621,3416,'������');
insert into web_regions (region_id,city_id,region) values (341622,3416,'�ɳ���');
insert into web_regions (region_id,city_id,region) values (341623,3416,'������');
insert into web_regions (region_id,city_id,region) values (341702,3417,'�����');
insert into web_regions (region_id,city_id,region) values (341721,3417,'������');
insert into web_regions (region_id,city_id,region) values (341722,3417,'ʯ̨��');
insert into web_regions (region_id,city_id,region) values (341723,3417,'������');
insert into web_regions (region_id,city_id,region) values (341802,3418,'������');
insert into web_regions (region_id,city_id,region) values (341821,3418,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (341822,3418,'�����');
insert into web_regions (region_id,city_id,region) values (341823,3418,'����');
insert into web_regions (region_id,city_id,region) values (341824,3418,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (341825,3418,'캵���');
insert into web_regions (region_id,city_id,region) values (341881,3418,'������');
insert into web_regions (region_id,city_id,region) values (350102,3501,'��¥��');
insert into web_regions (region_id,city_id,region) values (350103,3501,'̨����');
insert into web_regions (region_id,city_id,region) values (350104,3501,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (350105,3501,'��β��');
insert into web_regions (region_id,city_id,region) values (350111,3501,'������');
insert into web_regions (region_id,city_id,region) values (350121,3501,'������');
insert into web_regions (region_id,city_id,region) values (350122,3501,'������');
insert into web_regions (region_id,city_id,region) values (350123,3501,'��Դ��');
insert into web_regions (region_id,city_id,region) values (350124,3501,'������');
insert into web_regions (region_id,city_id,region) values (350125,3501,'��̩��');
insert into web_regions (region_id,city_id,region) values (350128,3501,'ƽ̶��');
insert into web_regions (region_id,city_id,region) values (350181,3501,'������');
insert into web_regions (region_id,city_id,region) values (350182,3501,'������');
insert into web_regions (region_id,city_id,region) values (350203,3502,'˼����');
insert into web_regions (region_id,city_id,region) values (350205,3502,'������');
insert into web_regions (region_id,city_id,region) values (350206,3502,'������');
insert into web_regions (region_id,city_id,region) values (350211,3502,'������');
insert into web_regions (region_id,city_id,region) values (350212,3502,'ͬ����');
insert into web_regions (region_id,city_id,region) values (350213,3502,'�谲��');
insert into web_regions (region_id,city_id,region) values (350302,3503,'������');
insert into web_regions (region_id,city_id,region) values (350303,3503,'������');
insert into web_regions (region_id,city_id,region) values (350304,3503,'�����');
insert into web_regions (region_id,city_id,region) values (350305,3503,'������');
insert into web_regions (region_id,city_id,region) values (350322,3503,'������');
insert into web_regions (region_id,city_id,region) values (350402,3504,'÷����');
insert into web_regions (region_id,city_id,region) values (350403,3504,'��Ԫ��');
insert into web_regions (region_id,city_id,region) values (350421,3504,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (350423,3504,'������');
insert into web_regions (region_id,city_id,region) values (350424,3504,'������');
insert into web_regions (region_id,city_id,region) values (350425,3504,'������');
insert into web_regions (region_id,city_id,region) values (350426,3504,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (350427,3504,'ɳ��');
insert into web_regions (region_id,city_id,region) values (350428,3504,'������');
insert into web_regions (region_id,city_id,region) values (350429,3504,'̩����');
insert into web_regions (region_id,city_id,region) values (350430,3504,'������');
insert into web_regions (region_id,city_id,region) values (350481,3504,'������');
insert into web_regions (region_id,city_id,region) values (350502,3505,'�����');
insert into web_regions (region_id,city_id,region) values (350503,3505,'������');
insert into web_regions (region_id,city_id,region) values (350504,3505,'�彭��');
insert into web_regions (region_id,city_id,region) values (350505,3505,'Ȫ����');
insert into web_regions (region_id,city_id,region) values (350521,3505,'�ݰ���');
insert into web_regions (region_id,city_id,region) values (350524,3505,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (350525,3505,'������');
insert into web_regions (region_id,city_id,region) values (350526,3505,'�»���');
insert into web_regions (region_id,city_id,region) values (350527,3505,'������');
insert into web_regions (region_id,city_id,region) values (350581,3505,'ʯʨ��');
insert into web_regions (region_id,city_id,region) values (350582,3505,'������');
insert into web_regions (region_id,city_id,region) values (350583,3505,'�ϰ���');
insert into web_regions (region_id,city_id,region) values (350602,3506,'ܼ����');
insert into web_regions (region_id,city_id,region) values (350603,3506,'������');
insert into web_regions (region_id,city_id,region) values (350622,3506,'������');
insert into web_regions (region_id,city_id,region) values (350623,3506,'������');
insert into web_regions (region_id,city_id,region) values (350624,3506,'گ����');
insert into web_regions (region_id,city_id,region) values (350625,3506,'��̩��');
insert into web_regions (region_id,city_id,region) values (350626,3506,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (350627,3506,'�Ͼ���');
insert into web_regions (region_id,city_id,region) values (350628,3506,'ƽ����');
insert into web_regions (region_id,city_id,region) values (350629,3506,'������');
insert into web_regions (region_id,city_id,region) values (350681,3506,'������');
insert into web_regions (region_id,city_id,region) values (350702,3507,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (350703,3507,'������');
insert into web_regions (region_id,city_id,region) values (350721,3507,'˳����');
insert into web_regions (region_id,city_id,region) values (350722,3507,'�ֳ���');
insert into web_regions (region_id,city_id,region) values (350723,3507,'������');
insert into web_regions (region_id,city_id,region) values (350724,3507,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (350725,3507,'������');
insert into web_regions (region_id,city_id,region) values (350781,3507,'������');
insert into web_regions (region_id,city_id,region) values (350782,3507,'����ɽ��');
insert into web_regions (region_id,city_id,region) values (350783,3507,'�����');
insert into web_regions (region_id,city_id,region) values (350802,3508,'������');
insert into web_regions (region_id,city_id,region) values (350821,3508,'��͡��');
insert into web_regions (region_id,city_id,region) values (350822,3508,'������');
insert into web_regions (region_id,city_id,region) values (350823,3508,'�Ϻ���');
insert into web_regions (region_id,city_id,region) values (350824,3508,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (350825,3508,'������');
insert into web_regions (region_id,city_id,region) values (350881,3508,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (350902,3509,'������');
insert into web_regions (region_id,city_id,region) values (350921,3509,'ϼ����');
insert into web_regions (region_id,city_id,region) values (350922,3509,'������');
insert into web_regions (region_id,city_id,region) values (350923,3509,'������');
insert into web_regions (region_id,city_id,region) values (350924,3509,'������');
insert into web_regions (region_id,city_id,region) values (350925,3509,'������');
insert into web_regions (region_id,city_id,region) values (350926,3509,'������');
insert into web_regions (region_id,city_id,region) values (350981,3509,'������');
insert into web_regions (region_id,city_id,region) values (350982,3509,'������');
insert into web_regions (region_id,city_id,region) values (360102,3601,'������');
insert into web_regions (region_id,city_id,region) values (360103,3601,'������');
insert into web_regions (region_id,city_id,region) values (360104,3601,'��������');
insert into web_regions (region_id,city_id,region) values (360105,3601,'������');
insert into web_regions (region_id,city_id,region) values (360111,3601,'��ɽ����');
insert into web_regions (region_id,city_id,region) values (360121,3601,'�ϲ���');
insert into web_regions (region_id,city_id,region) values (360122,3601,'�½���');
insert into web_regions (region_id,city_id,region) values (360123,3601,'������');
insert into web_regions (region_id,city_id,region) values (360124,3601,'������');
insert into web_regions (region_id,city_id,region) values (360202,3602,'������');
insert into web_regions (region_id,city_id,region) values (360203,3602,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (360222,3602,'������');
insert into web_regions (region_id,city_id,region) values (360281,3602,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (360302,3603,'��Դ��');
insert into web_regions (region_id,city_id,region) values (360313,3603,'�涫��');
insert into web_regions (region_id,city_id,region) values (360321,3603,'������');
insert into web_regions (region_id,city_id,region) values (360322,3603,'������');
insert into web_regions (region_id,city_id,region) values (360323,3603,'«Ϫ��');
insert into web_regions (region_id,city_id,region) values (360402,3604,'®ɽ��');
insert into web_regions (region_id,city_id,region) values (360403,3604,'�����');
insert into web_regions (region_id,city_id,region) values (360421,3604,'�Ž���');
insert into web_regions (region_id,city_id,region) values (360423,3604,'������');
insert into web_regions (region_id,city_id,region) values (360424,3604,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (360425,3604,'������');
insert into web_regions (region_id,city_id,region) values (360426,3604,'�°���');
insert into web_regions (region_id,city_id,region) values (360427,3604,'������');
insert into web_regions (region_id,city_id,region) values (360428,3604,'������');
insert into web_regions (region_id,city_id,region) values (360429,3604,'������');
insert into web_regions (region_id,city_id,region) values (360430,3604,'������');
insert into web_regions (region_id,city_id,region) values (360481,3604,'�����');
insert into web_regions (region_id,city_id,region) values (360482,3604,'�������');
insert into web_regions (region_id,city_id,region) values (360502,3605,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (360521,3605,'������');
insert into web_regions (region_id,city_id,region) values (360602,3606,'�º���');
insert into web_regions (region_id,city_id,region) values (360622,3606,'�཭��');
insert into web_regions (region_id,city_id,region) values (360681,3606,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (360702,3607,'�¹���');
insert into web_regions (region_id,city_id,region) values (360703,3607,'�Ͽ���');
insert into web_regions (region_id,city_id,region) values (360721,3607,'����');
insert into web_regions (region_id,city_id,region) values (360722,3607,'�ŷ���');
insert into web_regions (region_id,city_id,region) values (360723,3607,'������');
insert into web_regions (region_id,city_id,region) values (360724,3607,'������');
insert into web_regions (region_id,city_id,region) values (360725,3607,'������');
insert into web_regions (region_id,city_id,region) values (360726,3607,'��Զ��');
insert into web_regions (region_id,city_id,region) values (360727,3607,'������');
insert into web_regions (region_id,city_id,region) values (360728,3607,'������');
insert into web_regions (region_id,city_id,region) values (360729,3607,'ȫ����');
insert into web_regions (region_id,city_id,region) values (360730,3607,'������');
insert into web_regions (region_id,city_id,region) values (360731,3607,'�ڶ���');
insert into web_regions (region_id,city_id,region) values (360732,3607,'�˹���');
insert into web_regions (region_id,city_id,region) values (360733,3607,'�����');
insert into web_regions (region_id,city_id,region) values (360734,3607,'Ѱ����');
insert into web_regions (region_id,city_id,region) values (360735,3607,'ʯ����');
insert into web_regions (region_id,city_id,region) values (360781,3607,'�����');
insert into web_regions (region_id,city_id,region) values (360802,3608,'������');
insert into web_regions (region_id,city_id,region) values (360803,3608,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (360821,3608,'������');
insert into web_regions (region_id,city_id,region) values (360822,3608,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (360823,3608,'Ͽ����');
insert into web_regions (region_id,city_id,region) values (360824,3608,'�¸���');
insert into web_regions (region_id,city_id,region) values (360825,3608,'������');
insert into web_regions (region_id,city_id,region) values (360826,3608,'̩����');
insert into web_regions (region_id,city_id,region) values (360827,3608,'�촨��');
insert into web_regions (region_id,city_id,region) values (360828,3608,'����');
insert into web_regions (region_id,city_id,region) values (360829,3608,'������');
insert into web_regions (region_id,city_id,region) values (360830,3608,'������');
insert into web_regions (region_id,city_id,region) values (360881,3608,'����ɽ��');
insert into web_regions (region_id,city_id,region) values (360902,3609,'Ԭ����');
insert into web_regions (region_id,city_id,region) values (360921,3609,'������');
insert into web_regions (region_id,city_id,region) values (360922,3609,'������');
insert into web_regions (region_id,city_id,region) values (360923,3609,'�ϸ���');
insert into web_regions (region_id,city_id,region) values (360924,3609,'�˷���');
insert into web_regions (region_id,city_id,region) values (360925,3609,'������');
insert into web_regions (region_id,city_id,region) values (360926,3609,'ͭ����');
insert into web_regions (region_id,city_id,region) values (360981,3609,'�����');
insert into web_regions (region_id,city_id,region) values (360982,3609,'������');
insert into web_regions (region_id,city_id,region) values (360983,3609,'�߰���');
insert into web_regions (region_id,city_id,region) values (361002,3610,'�ٴ���');
insert into web_regions (region_id,city_id,region) values (361021,3610,'�ϳ���');
insert into web_regions (region_id,city_id,region) values (361022,3610,'�质��');
insert into web_regions (region_id,city_id,region) values (361023,3610,'�Ϸ���');
insert into web_regions (region_id,city_id,region) values (361024,3610,'������');
insert into web_regions (region_id,city_id,region) values (361025,3610,'�ְ���');
insert into web_regions (region_id,city_id,region) values (361026,3610,'�˻���');
insert into web_regions (region_id,city_id,region) values (361027,3610,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (361028,3610,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (361029,3610,'������');
insert into web_regions (region_id,city_id,region) values (361030,3610,'�����');
insert into web_regions (region_id,city_id,region) values (361102,3611,'������');
insert into web_regions (region_id,city_id,region) values (361121,3611,'������');
insert into web_regions (region_id,city_id,region) values (361122,3611,'�����');
insert into web_regions (region_id,city_id,region) values (361123,3611,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (361124,3611,'Ǧɽ��');
insert into web_regions (region_id,city_id,region) values (361125,3611,'�����');
insert into web_regions (region_id,city_id,region) values (361126,3611,'߮����');
insert into web_regions (region_id,city_id,region) values (361127,3611,'�����');
insert into web_regions (region_id,city_id,region) values (361128,3611,'۶����');
insert into web_regions (region_id,city_id,region) values (361129,3611,'������');
insert into web_regions (region_id,city_id,region) values (361130,3611,'��Դ��');
insert into web_regions (region_id,city_id,region) values (361181,3611,'������');
insert into web_regions (region_id,city_id,region) values (370102,3701,'������');
insert into web_regions (region_id,city_id,region) values (370103,3701,'������');
insert into web_regions (region_id,city_id,region) values (370104,3701,'������');
insert into web_regions (region_id,city_id,region) values (370105,3701,'������');
insert into web_regions (region_id,city_id,region) values (370112,3701,'������');
insert into web_regions (region_id,city_id,region) values (370113,3701,'������');
insert into web_regions (region_id,city_id,region) values (370124,3701,'ƽ����');
insert into web_regions (region_id,city_id,region) values (370125,3701,'������');
insert into web_regions (region_id,city_id,region) values (370126,3701,'�̺���');
insert into web_regions (region_id,city_id,region) values (370181,3701,'������');
insert into web_regions (region_id,city_id,region) values (370202,3702,'������');
insert into web_regions (region_id,city_id,region) values (370203,3702,'�б���');
insert into web_regions (region_id,city_id,region) values (370211,3702,'�Ƶ���');
insert into web_regions (region_id,city_id,region) values (370212,3702,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (370213,3702,'�����');
insert into web_regions (region_id,city_id,region) values (370214,3702,'������');
insert into web_regions (region_id,city_id,region) values (370281,3702,'������');
insert into web_regions (region_id,city_id,region) values (370282,3702,'��ī��');
insert into web_regions (region_id,city_id,region) values (370283,3702,'ƽ����');
insert into web_regions (region_id,city_id,region) values (370285,3702,'������');
insert into web_regions (region_id,city_id,region) values (370286,3702,'����������');
insert into web_regions (region_id,city_id,region) values (370302,3703,'�ʹ���');
insert into web_regions (region_id,city_id,region) values (370303,3703,'�ŵ���');
insert into web_regions (region_id,city_id,region) values (370304,3703,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (370305,3703,'������');
insert into web_regions (region_id,city_id,region) values (370306,3703,'�ܴ���');
insert into web_regions (region_id,city_id,region) values (370321,3703,'��̨��');
insert into web_regions (region_id,city_id,region) values (370322,3703,'������');
insert into web_regions (region_id,city_id,region) values (370323,3703,'��Դ��');
insert into web_regions (region_id,city_id,region) values (370402,3704,'������');
insert into web_regions (region_id,city_id,region) values (370403,3704,'Ѧ����');
insert into web_regions (region_id,city_id,region) values (370404,3704,'ỳ���');
insert into web_regions (region_id,city_id,region) values (370405,3704,'̨��ׯ��');
insert into web_regions (region_id,city_id,region) values (370406,3704,'ɽͤ��');
insert into web_regions (region_id,city_id,region) values (370481,3704,'������');
insert into web_regions (region_id,city_id,region) values (370502,3705,'��Ӫ��');
insert into web_regions (region_id,city_id,region) values (370503,3705,'�ӿ���');
insert into web_regions (region_id,city_id,region) values (370521,3705,'������');
insert into web_regions (region_id,city_id,region) values (370522,3705,'������');
insert into web_regions (region_id,city_id,region) values (370523,3705,'������');
insert into web_regions (region_id,city_id,region) values (370602,3706,'֥���');
insert into web_regions (region_id,city_id,region) values (370611,3706,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (370612,3706,'Ĳƽ��');
insert into web_regions (region_id,city_id,region) values (370613,3706,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (370634,3706,'������');
insert into web_regions (region_id,city_id,region) values (370681,3706,'������');
insert into web_regions (region_id,city_id,region) values (370682,3706,'������');
insert into web_regions (region_id,city_id,region) values (370683,3706,'������');
insert into web_regions (region_id,city_id,region) values (370684,3706,'������');
insert into web_regions (region_id,city_id,region) values (370685,3706,'��Զ��');
insert into web_regions (region_id,city_id,region) values (370686,3706,'��ϼ��');
insert into web_regions (region_id,city_id,region) values (370687,3706,'������');
insert into web_regions (region_id,city_id,region) values (370702,3707,'Ϋ����');
insert into web_regions (region_id,city_id,region) values (370703,3707,'��ͤ��');
insert into web_regions (region_id,city_id,region) values (370704,3707,'������');
insert into web_regions (region_id,city_id,region) values (370705,3707,'������');
insert into web_regions (region_id,city_id,region) values (370724,3707,'������');
insert into web_regions (region_id,city_id,region) values (370725,3707,'������');
insert into web_regions (region_id,city_id,region) values (370781,3707,'������');
insert into web_regions (region_id,city_id,region) values (370782,3707,'�����');
insert into web_regions (region_id,city_id,region) values (370783,3707,'�ٹ���');
insert into web_regions (region_id,city_id,region) values (370784,3707,'������');
insert into web_regions (region_id,city_id,region) values (370785,3707,'������');
insert into web_regions (region_id,city_id,region) values (370786,3707,'������');
insert into web_regions (region_id,city_id,region) values (370811,3708,'�γ���');
insert into web_regions (region_id,city_id,region) values (370812,3708,'������');
insert into web_regions (region_id,city_id,region) values (370826,3708,'΢ɽ��');
insert into web_regions (region_id,city_id,region) values (370827,3708,'��̨��');
insert into web_regions (region_id,city_id,region) values (370828,3708,'������');
insert into web_regions (region_id,city_id,region) values (370829,3708,'������');
insert into web_regions (region_id,city_id,region) values (370830,3708,'������');
insert into web_regions (region_id,city_id,region) values (370831,3708,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (370832,3708,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (370881,3708,'������');
insert into web_regions (region_id,city_id,region) values (370883,3708,'�޳���');
insert into web_regions (region_id,city_id,region) values (370902,3709,'̩ɽ��');
insert into web_regions (region_id,city_id,region) values (370911,3709,'�����');
insert into web_regions (region_id,city_id,region) values (370921,3709,'������');
insert into web_regions (region_id,city_id,region) values (370923,3709,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (370982,3709,'��̩��');
insert into web_regions (region_id,city_id,region) values (370983,3709,'�ʳ���');
insert into web_regions (region_id,city_id,region) values (371002,3710,'������');
insert into web_regions (region_id,city_id,region) values (371003,3710,'�ĵ���');
insert into web_regions (region_id,city_id,region) values (371082,3710,'�ٳ���');
insert into web_regions (region_id,city_id,region) values (371083,3710,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (371102,3711,'������');
insert into web_regions (region_id,city_id,region) values (371103,3711,'�ɽ��');
insert into web_regions (region_id,city_id,region) values (371121,3711,'������');
insert into web_regions (region_id,city_id,region) values (371122,3711,'����');
insert into web_regions (region_id,city_id,region) values (371202,3712,'������');
insert into web_regions (region_id,city_id,region) values (371203,3712,'�ֳ���');
insert into web_regions (region_id,city_id,region) values (371302,3713,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (371311,3713,'��ׯ��');
insert into web_regions (region_id,city_id,region) values (371312,3713,'�Ӷ���');
insert into web_regions (region_id,city_id,region) values (371321,3713,'������');
insert into web_regions (region_id,city_id,region) values (371322,3713,'۰����');
insert into web_regions (region_id,city_id,region) values (371323,3713,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (371324,3713,'������');
insert into web_regions (region_id,city_id,region) values (371325,3713,'����');
insert into web_regions (region_id,city_id,region) values (371326,3713,'ƽ����');
insert into web_regions (region_id,city_id,region) values (371327,3713,'������');
insert into web_regions (region_id,city_id,region) values (371328,3713,'������');
insert into web_regions (region_id,city_id,region) values (371329,3713,'������');
insert into web_regions (region_id,city_id,region) values (371402,3714,'�³���');
insert into web_regions (region_id,city_id,region) values (371403,3714,'�����');
insert into web_regions (region_id,city_id,region) values (371422,3714,'������');
insert into web_regions (region_id,city_id,region) values (371423,3714,'������');
insert into web_regions (region_id,city_id,region) values (371424,3714,'������');
insert into web_regions (region_id,city_id,region) values (371425,3714,'�����');
insert into web_regions (region_id,city_id,region) values (371426,3714,'ƽԭ��');
insert into web_regions (region_id,city_id,region) values (371427,3714,'�Ľ���');
insert into web_regions (region_id,city_id,region) values (371428,3714,'�����');
insert into web_regions (region_id,city_id,region) values (371481,3714,'������');
insert into web_regions (region_id,city_id,region) values (371482,3714,'������');
insert into web_regions (region_id,city_id,region) values (371502,3715,'��������');
insert into web_regions (region_id,city_id,region) values (371521,3715,'������');
insert into web_regions (region_id,city_id,region) values (371522,3715,'ݷ��');
insert into web_regions (region_id,city_id,region) values (371523,3715,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (371524,3715,'������');
insert into web_regions (region_id,city_id,region) values (371525,3715,'����');
insert into web_regions (region_id,city_id,region) values (371526,3715,'������');
insert into web_regions (region_id,city_id,region) values (371581,3715,'������');
insert into web_regions (region_id,city_id,region) values (371602,3716,'������');
insert into web_regions (region_id,city_id,region) values (371603,3716,'մ����');
insert into web_regions (region_id,city_id,region) values (371621,3716,'������');
insert into web_regions (region_id,city_id,region) values (371622,3716,'������');
insert into web_regions (region_id,city_id,region) values (371623,3716,'�����');
insert into web_regions (region_id,city_id,region) values (371625,3716,'������');
insert into web_regions (region_id,city_id,region) values (371626,3716,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (371627,3716,'��������');
insert into web_regions (region_id,city_id,region) values (371702,3717,'ĵ����');
insert into web_regions (region_id,city_id,region) values (371721,3717,'����');
insert into web_regions (region_id,city_id,region) values (371722,3717,'����');
insert into web_regions (region_id,city_id,region) values (371723,3717,'������');
insert into web_regions (region_id,city_id,region) values (371724,3717,'��Ұ��');
insert into web_regions (region_id,city_id,region) values (371725,3717,'۩����');
insert into web_regions (region_id,city_id,region) values (371726,3717,'۲����');
insert into web_regions (region_id,city_id,region) values (371727,3717,'������');
insert into web_regions (region_id,city_id,region) values (371728,3717,'������');
insert into web_regions (region_id,city_id,region) values (410102,4101,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (410103,4101,'������');
insert into web_regions (region_id,city_id,region) values (410104,4101,'�ܳǻ�����');
insert into web_regions (region_id,city_id,region) values (410105,4101,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (410106,4101,'�Ͻ���');
insert into web_regions (region_id,city_id,region) values (410108,4101,'�ݼ���');
insert into web_regions (region_id,city_id,region) values (410122,4101,'��Ĳ��');
insert into web_regions (region_id,city_id,region) values (410181,4101,'������');
insert into web_regions (region_id,city_id,region) values (410182,4101,'������');
insert into web_regions (region_id,city_id,region) values (410183,4101,'������');
insert into web_regions (region_id,city_id,region) values (410184,4101,'��֣��');
insert into web_regions (region_id,city_id,region) values (410185,4101,'�Ƿ���');
insert into web_regions (region_id,city_id,region) values (410202,4102,'��ͤ��');
insert into web_regions (region_id,city_id,region) values (410203,4102,'˳�ӻ�����');
insert into web_regions (region_id,city_id,region) values (410204,4102,'��¥��');
insert into web_regions (region_id,city_id,region) values (410205,4102,'����̨��');
insert into web_regions (region_id,city_id,region) values (410212,4102,'�����');
insert into web_regions (region_id,city_id,region) values (410221,4102,'���');
insert into web_regions (region_id,city_id,region) values (410222,4102,'ͨ����');
insert into web_regions (region_id,city_id,region) values (410223,4102,'ξ����');
insert into web_regions (region_id,city_id,region) values (410225,4102,'������');
insert into web_regions (region_id,city_id,region) values (410302,4103,'�ϳ���');
insert into web_regions (region_id,city_id,region) values (410303,4103,'������');
insert into web_regions (region_id,city_id,region) values (410304,4103,'�e�ӻ�����');
insert into web_regions (region_id,city_id,region) values (410305,4103,'������');
insert into web_regions (region_id,city_id,region) values (410306,4103,'������');
insert into web_regions (region_id,city_id,region) values (410311,4103,'������');
insert into web_regions (region_id,city_id,region) values (410322,4103,'�Ͻ���');
insert into web_regions (region_id,city_id,region) values (410323,4103,'�°���');
insert into web_regions (region_id,city_id,region) values (410324,4103,'�ﴨ��');
insert into web_regions (region_id,city_id,region) values (410325,4103,'����');
insert into web_regions (region_id,city_id,region) values (410326,4103,'������');
insert into web_regions (region_id,city_id,region) values (410327,4103,'������');
insert into web_regions (region_id,city_id,region) values (410328,4103,'������');
insert into web_regions (region_id,city_id,region) values (410329,4103,'������');
insert into web_regions (region_id,city_id,region) values (410381,4103,'��ʦ��');
insert into web_regions (region_id,city_id,region) values (410402,4104,'�»���');
insert into web_regions (region_id,city_id,region) values (410403,4104,'������');
insert into web_regions (region_id,city_id,region) values (410404,4104,'ʯ����');
insert into web_regions (region_id,city_id,region) values (410411,4104,'տ����');
insert into web_regions (region_id,city_id,region) values (410421,4104,'������');
insert into web_regions (region_id,city_id,region) values (410422,4104,'Ҷ��');
insert into web_regions (region_id,city_id,region) values (410423,4104,'³ɽ��');
insert into web_regions (region_id,city_id,region) values (410425,4104,'ۣ��');
insert into web_regions (region_id,city_id,region) values (410481,4104,'�����');
insert into web_regions (region_id,city_id,region) values (410482,4104,'������');
insert into web_regions (region_id,city_id,region) values (410502,4105,'�ķ���');
insert into web_regions (region_id,city_id,region) values (410503,4105,'������');
insert into web_regions (region_id,city_id,region) values (410505,4105,'����');
insert into web_regions (region_id,city_id,region) values (410506,4105,'������');
insert into web_regions (region_id,city_id,region) values (410522,4105,'������');
insert into web_regions (region_id,city_id,region) values (410523,4105,'������');
insert into web_regions (region_id,city_id,region) values (410526,4105,'����');
insert into web_regions (region_id,city_id,region) values (410527,4105,'�ڻ���');
insert into web_regions (region_id,city_id,region) values (410581,4105,'������');
insert into web_regions (region_id,city_id,region) values (410602,4106,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (410603,4106,'ɽ����');
insert into web_regions (region_id,city_id,region) values (410611,4106,'俱���');
insert into web_regions (region_id,city_id,region) values (410621,4106,'����');
insert into web_regions (region_id,city_id,region) values (410622,4106,'���');
insert into web_regions (region_id,city_id,region) values (410702,4107,'������');
insert into web_regions (region_id,city_id,region) values (410703,4107,'������');
insert into web_regions (region_id,city_id,region) values (410704,4107,'��Ȫ��');
insert into web_regions (region_id,city_id,region) values (410711,4107,'��Ұ��');
insert into web_regions (region_id,city_id,region) values (410721,4107,'������');
insert into web_regions (region_id,city_id,region) values (410724,4107,'�����');
insert into web_regions (region_id,city_id,region) values (410725,4107,'ԭ����');
insert into web_regions (region_id,city_id,region) values (410726,4107,'�ӽ���');
insert into web_regions (region_id,city_id,region) values (410727,4107,'������');
insert into web_regions (region_id,city_id,region) values (410728,4107,'��ԫ��');
insert into web_regions (region_id,city_id,region) values (410781,4107,'������');
insert into web_regions (region_id,city_id,region) values (410782,4107,'������');
insert into web_regions (region_id,city_id,region) values (410802,4108,'�����');
insert into web_regions (region_id,city_id,region) values (410803,4108,'��վ��');
insert into web_regions (region_id,city_id,region) values (410804,4108,'������');
insert into web_regions (region_id,city_id,region) values (410811,4108,'ɽ����');
insert into web_regions (region_id,city_id,region) values (410821,4108,'������');
insert into web_regions (region_id,city_id,region) values (410822,4108,'������');
insert into web_regions (region_id,city_id,region) values (410823,4108,'������');
insert into web_regions (region_id,city_id,region) values (410825,4108,'����');
insert into web_regions (region_id,city_id,region) values (410882,4108,'������');
insert into web_regions (region_id,city_id,region) values (410883,4108,'������');
insert into web_regions (region_id,city_id,region) values (410902,4109,'������');
insert into web_regions (region_id,city_id,region) values (410922,4109,'�����');
insert into web_regions (region_id,city_id,region) values (410923,4109,'������');
insert into web_regions (region_id,city_id,region) values (410926,4109,'����');
insert into web_regions (region_id,city_id,region) values (410927,4109,'̨ǰ��');
insert into web_regions (region_id,city_id,region) values (410928,4109,'�����');
insert into web_regions (region_id,city_id,region) values (411002,4110,'κ����');
insert into web_regions (region_id,city_id,region) values (411023,4110,'������');
insert into web_regions (region_id,city_id,region) values (411024,4110,'۳����');
insert into web_regions (region_id,city_id,region) values (411025,4110,'�����');
insert into web_regions (region_id,city_id,region) values (411081,4110,'������');
insert into web_regions (region_id,city_id,region) values (411082,4110,'������');
insert into web_regions (region_id,city_id,region) values (411102,4111,'Դ����');
insert into web_regions (region_id,city_id,region) values (411103,4111,'۱����');
insert into web_regions (region_id,city_id,region) values (411104,4111,'������');
insert into web_regions (region_id,city_id,region) values (411121,4111,'������');
insert into web_regions (region_id,city_id,region) values (411122,4111,'�����');
insert into web_regions (region_id,city_id,region) values (411202,4112,'������');
insert into web_regions (region_id,city_id,region) values (411221,4112,'�ų���');
insert into web_regions (region_id,city_id,region) values (411222,4112,'����');
insert into web_regions (region_id,city_id,region) values (411224,4112,'¬����');
insert into web_regions (region_id,city_id,region) values (411281,4112,'������');
insert into web_regions (region_id,city_id,region) values (411282,4112,'�鱦��');
insert into web_regions (region_id,city_id,region) values (411302,4113,'�����');
insert into web_regions (region_id,city_id,region) values (411303,4113,'������');
insert into web_regions (region_id,city_id,region) values (411321,4113,'������');
insert into web_regions (region_id,city_id,region) values (411322,4113,'������');
insert into web_regions (region_id,city_id,region) values (411323,4113,'��Ͽ��');
insert into web_regions (region_id,city_id,region) values (411324,4113,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (411325,4113,'������');
insert into web_regions (region_id,city_id,region) values (411326,4113,'������');
insert into web_regions (region_id,city_id,region) values (411327,4113,'������');
insert into web_regions (region_id,city_id,region) values (411328,4113,'�ƺ���');
insert into web_regions (region_id,city_id,region) values (411329,4113,'��Ұ��');
insert into web_regions (region_id,city_id,region) values (411330,4113,'ͩ����');
insert into web_regions (region_id,city_id,region) values (411381,4113,'������');
insert into web_regions (region_id,city_id,region) values (411402,4114,'��԰��');
insert into web_regions (region_id,city_id,region) values (411403,4114,'�����');
insert into web_regions (region_id,city_id,region) values (411421,4114,'��Ȩ��');
insert into web_regions (region_id,city_id,region) values (411422,4114,'���');
insert into web_regions (region_id,city_id,region) values (411423,4114,'������');
insert into web_regions (region_id,city_id,region) values (411424,4114,'�ϳ���');
insert into web_regions (region_id,city_id,region) values (411425,4114,'�ݳ���');
insert into web_regions (region_id,city_id,region) values (411426,4114,'������');
insert into web_regions (region_id,city_id,region) values (411481,4114,'������');
insert into web_regions (region_id,city_id,region) values (411502,4115,'������');
insert into web_regions (region_id,city_id,region) values (411503,4115,'ƽ����');
insert into web_regions (region_id,city_id,region) values (411521,4115,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (411522,4115,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (411523,4115,'����');
insert into web_regions (region_id,city_id,region) values (411524,4115,'�̳���');
insert into web_regions (region_id,city_id,region) values (411525,4115,'��ʼ��');
insert into web_regions (region_id,city_id,region) values (411526,4115,'�괨��');
insert into web_regions (region_id,city_id,region) values (411527,4115,'������');
insert into web_regions (region_id,city_id,region) values (411528,4115,'Ϣ��');
insert into web_regions (region_id,city_id,region) values (411602,4116,'������');
insert into web_regions (region_id,city_id,region) values (411621,4116,'������');
insert into web_regions (region_id,city_id,region) values (411622,4116,'������');
insert into web_regions (region_id,city_id,region) values (411623,4116,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (411624,4116,'������');
insert into web_regions (region_id,city_id,region) values (411625,4116,'������');
insert into web_regions (region_id,city_id,region) values (411626,4116,'������');
insert into web_regions (region_id,city_id,region) values (411627,4116,'̫����');
insert into web_regions (region_id,city_id,region) values (411628,4116,'¹����');
insert into web_regions (region_id,city_id,region) values (411681,4116,'�����');
insert into web_regions (region_id,city_id,region) values (411702,4117,'�����');
insert into web_regions (region_id,city_id,region) values (411721,4117,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (411722,4117,'�ϲ���');
insert into web_regions (region_id,city_id,region) values (411723,4117,'ƽ����');
insert into web_regions (region_id,city_id,region) values (411724,4117,'������');
insert into web_regions (region_id,city_id,region) values (411725,4117,'ȷɽ��');
insert into web_regions (region_id,city_id,region) values (411726,4117,'������');
insert into web_regions (region_id,city_id,region) values (411727,4117,'������');
insert into web_regions (region_id,city_id,region) values (411728,4117,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (411729,4117,'�²���');
insert into web_regions (region_id,city_id,region) values (419001,4190,'��Դ��');
insert into web_regions (region_id,city_id,region) values (420102,4201,'������');
insert into web_regions (region_id,city_id,region) values (420103,4201,'������');
insert into web_regions (region_id,city_id,region) values (420104,4201,'�~����');
insert into web_regions (region_id,city_id,region) values (420105,4201,'������');
insert into web_regions (region_id,city_id,region) values (420106,4201,'�����');
insert into web_regions (region_id,city_id,region) values (420107,4201,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (420111,4201,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (420112,4201,'��������');
insert into web_regions (region_id,city_id,region) values (420113,4201,'������');
insert into web_regions (region_id,city_id,region) values (420114,4201,'�̵���');
insert into web_regions (region_id,city_id,region) values (420115,4201,'������');
insert into web_regions (region_id,city_id,region) values (420116,4201,'������');
insert into web_regions (region_id,city_id,region) values (420117,4201,'������');
insert into web_regions (region_id,city_id,region) values (420202,4202,'��ʯ����');
insert into web_regions (region_id,city_id,region) values (420203,4202,'����ɽ��');
insert into web_regions (region_id,city_id,region) values (420204,4202,'��½��');
insert into web_regions (region_id,city_id,region) values (420205,4202,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (420222,4202,'������');
insert into web_regions (region_id,city_id,region) values (420281,4202,'��ұ��');
insert into web_regions (region_id,city_id,region) values (420302,4203,'é����');
insert into web_regions (region_id,city_id,region) values (420303,4203,'������');
insert into web_regions (region_id,city_id,region) values (420304,4203,'������');
insert into web_regions (region_id,city_id,region) values (420322,4203,'������');
insert into web_regions (region_id,city_id,region) values (420323,4203,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (420324,4203,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (420325,4203,'����');
insert into web_regions (region_id,city_id,region) values (420381,4203,'��������');
insert into web_regions (region_id,city_id,region) values (420502,4205,'������');
insert into web_regions (region_id,city_id,region) values (420503,4205,'��Ҹ���');
insert into web_regions (region_id,city_id,region) values (420504,4205,'�����');
insert into web_regions (region_id,city_id,region) values (420505,4205,'�Vͤ��');
insert into web_regions (region_id,city_id,region) values (420506,4205,'������');
insert into web_regions (region_id,city_id,region) values (420525,4205,'Զ����');
insert into web_regions (region_id,city_id,region) values (420526,4205,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (420527,4205,'������');
insert into web_regions (region_id,city_id,region) values (420528,4205,'����������������');
insert into web_regions (region_id,city_id,region) values (420529,4205,'���������������');
insert into web_regions (region_id,city_id,region) values (420581,4205,'�˶���');
insert into web_regions (region_id,city_id,region) values (420582,4205,'������');
insert into web_regions (region_id,city_id,region) values (420583,4205,'֦����');
insert into web_regions (region_id,city_id,region) values (420602,4206,'�����');
insert into web_regions (region_id,city_id,region) values (420606,4206,'������');
insert into web_regions (region_id,city_id,region) values (420607,4206,'������');
insert into web_regions (region_id,city_id,region) values (420624,4206,'������');
insert into web_regions (region_id,city_id,region) values (420625,4206,'�ȳ���');
insert into web_regions (region_id,city_id,region) values (420626,4206,'������');
insert into web_regions (region_id,city_id,region) values (420682,4206,'�Ϻӿ���');
insert into web_regions (region_id,city_id,region) values (420683,4206,'������');
insert into web_regions (region_id,city_id,region) values (420684,4206,'�˳���');
insert into web_regions (region_id,city_id,region) values (420702,4207,'���Ӻ���');
insert into web_regions (region_id,city_id,region) values (420703,4207,'������');
insert into web_regions (region_id,city_id,region) values (420704,4207,'������');
insert into web_regions (region_id,city_id,region) values (420802,4208,'������');
insert into web_regions (region_id,city_id,region) values (420804,4208,'�޵���');
insert into web_regions (region_id,city_id,region) values (420821,4208,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (420822,4208,'ɳ����');
insert into web_regions (region_id,city_id,region) values (420881,4208,'������');
insert into web_regions (region_id,city_id,region) values (420902,4209,'Т����');
insert into web_regions (region_id,city_id,region) values (420921,4209,'Т����');
insert into web_regions (region_id,city_id,region) values (420922,4209,'������');
insert into web_regions (region_id,city_id,region) values (420923,4209,'������');
insert into web_regions (region_id,city_id,region) values (420981,4209,'Ӧ����');
insert into web_regions (region_id,city_id,region) values (420982,4209,'��½��');
insert into web_regions (region_id,city_id,region) values (420984,4209,'������');
insert into web_regions (region_id,city_id,region) values (421002,4210,'ɳ����');
insert into web_regions (region_id,city_id,region) values (421003,4210,'������');
insert into web_regions (region_id,city_id,region) values (421022,4210,'������');
insert into web_regions (region_id,city_id,region) values (421023,4210,'������');
insert into web_regions (region_id,city_id,region) values (421024,4210,'������');
insert into web_regions (region_id,city_id,region) values (421081,4210,'ʯ����');
insert into web_regions (region_id,city_id,region) values (421083,4210,'�����');
insert into web_regions (region_id,city_id,region) values (421087,4210,'������');
insert into web_regions (region_id,city_id,region) values (421102,4211,'������');
insert into web_regions (region_id,city_id,region) values (421121,4211,'�ŷ���');
insert into web_regions (region_id,city_id,region) values (421122,4211,'�찲��');
insert into web_regions (region_id,city_id,region) values (421123,4211,'������');
insert into web_regions (region_id,city_id,region) values (421124,4211,'Ӣɽ��');
insert into web_regions (region_id,city_id,region) values (421125,4211,'�ˮ��');
insert into web_regions (region_id,city_id,region) values (421126,4211,'ޭ����');
insert into web_regions (region_id,city_id,region) values (421127,4211,'��÷��');
insert into web_regions (region_id,city_id,region) values (421181,4211,'�����');
insert into web_regions (region_id,city_id,region) values (421182,4211,'��Ѩ��');
insert into web_regions (region_id,city_id,region) values (421202,4212,'�̰���');
insert into web_regions (region_id,city_id,region) values (421221,4212,'������');
insert into web_regions (region_id,city_id,region) values (421222,4212,'ͨ����');
insert into web_regions (region_id,city_id,region) values (421223,4212,'������');
insert into web_regions (region_id,city_id,region) values (421224,4212,'ͨɽ��');
insert into web_regions (region_id,city_id,region) values (421281,4212,'�����');
insert into web_regions (region_id,city_id,region) values (421303,4213,'������');
insert into web_regions (region_id,city_id,region) values (421321,4213,'����');
insert into web_regions (region_id,city_id,region) values (421381,4213,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (422801,4228,'��ʩ��');
insert into web_regions (region_id,city_id,region) values (422802,4228,'������');
insert into web_regions (region_id,city_id,region) values (422822,4228,'��ʼ��');
insert into web_regions (region_id,city_id,region) values (422823,4228,'�Ͷ���');
insert into web_regions (region_id,city_id,region) values (422825,4228,'������');
insert into web_regions (region_id,city_id,region) values (422826,4228,'�̷���');
insert into web_regions (region_id,city_id,region) values (422827,4228,'������');
insert into web_regions (region_id,city_id,region) values (422828,4228,'�׷���');
insert into web_regions (region_id,city_id,region) values (429004,4290,'������');
insert into web_regions (region_id,city_id,region) values (429005,4290,'Ǳ����');
insert into web_regions (region_id,city_id,region) values (429006,4290,'������');
insert into web_regions (region_id,city_id,region) values (429021,4290,'��ũ������');
insert into web_regions (region_id,city_id,region) values (430102,4301,'ܽ����');
insert into web_regions (region_id,city_id,region) values (430103,4301,'������');
insert into web_regions (region_id,city_id,region) values (430104,4301,'��´��');
insert into web_regions (region_id,city_id,region) values (430105,4301,'������');
insert into web_regions (region_id,city_id,region) values (430111,4301,'�껨��');
insert into web_regions (region_id,city_id,region) values (430112,4301,'������');
insert into web_regions (region_id,city_id,region) values (430121,4301,'��ɳ��');
insert into web_regions (region_id,city_id,region) values (430124,4301,'������');
insert into web_regions (region_id,city_id,region) values (430181,4301,'�����');
insert into web_regions (region_id,city_id,region) values (430202,4302,'������');
insert into web_regions (region_id,city_id,region) values (430203,4302,'«����');
insert into web_regions (region_id,city_id,region) values (430204,4302,'ʯ����');
insert into web_regions (region_id,city_id,region) values (430211,4302,'��Ԫ��');
insert into web_regions (region_id,city_id,region) values (430221,4302,'������');
insert into web_regions (region_id,city_id,region) values (430223,4302,'����');
insert into web_regions (region_id,city_id,region) values (430224,4302,'������');
insert into web_regions (region_id,city_id,region) values (430225,4302,'������');
insert into web_regions (region_id,city_id,region) values (430281,4302,'������');
insert into web_regions (region_id,city_id,region) values (430302,4303,'�����');
insert into web_regions (region_id,city_id,region) values (430304,4303,'������');
insert into web_regions (region_id,city_id,region) values (430321,4303,'��̶��');
insert into web_regions (region_id,city_id,region) values (430381,4303,'������');
insert into web_regions (region_id,city_id,region) values (430382,4303,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (430405,4304,'������');
insert into web_regions (region_id,city_id,region) values (430406,4304,'�����');
insert into web_regions (region_id,city_id,region) values (430407,4304,'ʯ����');
insert into web_regions (region_id,city_id,region) values (430408,4304,'������');
insert into web_regions (region_id,city_id,region) values (430412,4304,'������');
insert into web_regions (region_id,city_id,region) values (430421,4304,'������');
insert into web_regions (region_id,city_id,region) values (430422,4304,'������');
insert into web_regions (region_id,city_id,region) values (430423,4304,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (430424,4304,'�ⶫ��');
insert into web_regions (region_id,city_id,region) values (430426,4304,'���');
insert into web_regions (region_id,city_id,region) values (430481,4304,'������');
insert into web_regions (region_id,city_id,region) values (430482,4304,'������');
insert into web_regions (region_id,city_id,region) values (430502,4305,'˫����');
insert into web_regions (region_id,city_id,region) values (430503,4305,'������');
insert into web_regions (region_id,city_id,region) values (430511,4305,'������');
insert into web_regions (region_id,city_id,region) values (430521,4305,'�۶���');
insert into web_regions (region_id,city_id,region) values (430522,4305,'������');
insert into web_regions (region_id,city_id,region) values (430523,4305,'������');
insert into web_regions (region_id,city_id,region) values (430524,4305,'¡����');
insert into web_regions (region_id,city_id,region) values (430525,4305,'������');
insert into web_regions (region_id,city_id,region) values (430527,4305,'������');
insert into web_regions (region_id,city_id,region) values (430528,4305,'������');
insert into web_regions (region_id,city_id,region) values (430529,4305,'�ǲ�����������');
insert into web_regions (region_id,city_id,region) values (430581,4305,'�����');
insert into web_regions (region_id,city_id,region) values (430602,4306,'����¥��');
insert into web_regions (region_id,city_id,region) values (430603,4306,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (430611,4306,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (430621,4306,'������');
insert into web_regions (region_id,city_id,region) values (430623,4306,'������');
insert into web_regions (region_id,city_id,region) values (430624,4306,'������');
insert into web_regions (region_id,city_id,region) values (430626,4306,'ƽ����');
insert into web_regions (region_id,city_id,region) values (430681,4306,'������');
insert into web_regions (region_id,city_id,region) values (430682,4306,'������');
insert into web_regions (region_id,city_id,region) values (430702,4307,'������');
insert into web_regions (region_id,city_id,region) values (430703,4307,'������');
insert into web_regions (region_id,city_id,region) values (430721,4307,'������');
insert into web_regions (region_id,city_id,region) values (430722,4307,'������');
insert into web_regions (region_id,city_id,region) values (430723,4307,'���');
insert into web_regions (region_id,city_id,region) values (430724,4307,'�����');
insert into web_regions (region_id,city_id,region) values (430725,4307,'��Դ��');
insert into web_regions (region_id,city_id,region) values (430726,4307,'ʯ����');
insert into web_regions (region_id,city_id,region) values (430781,4307,'������');
insert into web_regions (region_id,city_id,region) values (430802,4308,'������');
insert into web_regions (region_id,city_id,region) values (430811,4308,'����Դ��');
insert into web_regions (region_id,city_id,region) values (430821,4308,'������');
insert into web_regions (region_id,city_id,region) values (430822,4308,'ɣֲ��');
insert into web_regions (region_id,city_id,region) values (430902,4309,'������');
insert into web_regions (region_id,city_id,region) values (430903,4309,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (430921,4309,'����');
insert into web_regions (region_id,city_id,region) values (430922,4309,'�ҽ���');
insert into web_regions (region_id,city_id,region) values (430923,4309,'������');
insert into web_regions (region_id,city_id,region) values (430981,4309,'�佭��');
insert into web_regions (region_id,city_id,region) values (431002,4310,'������');
insert into web_regions (region_id,city_id,region) values (431003,4310,'������');
insert into web_regions (region_id,city_id,region) values (431021,4310,'������');
insert into web_regions (region_id,city_id,region) values (431022,4310,'������');
insert into web_regions (region_id,city_id,region) values (431023,4310,'������');
insert into web_regions (region_id,city_id,region) values (431024,4310,'�κ���');
insert into web_regions (region_id,city_id,region) values (431025,4310,'������');
insert into web_regions (region_id,city_id,region) values (431026,4310,'�����');
insert into web_regions (region_id,city_id,region) values (431027,4310,'����');
insert into web_regions (region_id,city_id,region) values (431028,4310,'������');
insert into web_regions (region_id,city_id,region) values (431081,4310,'������');
insert into web_regions (region_id,city_id,region) values (431102,4311,'������');
insert into web_regions (region_id,city_id,region) values (431103,4311,'��ˮ̲��');
insert into web_regions (region_id,city_id,region) values (431121,4311,'������');
insert into web_regions (region_id,city_id,region) values (431122,4311,'������');
insert into web_regions (region_id,city_id,region) values (431123,4311,'˫����');
insert into web_regions (region_id,city_id,region) values (431124,4311,'����');
insert into web_regions (region_id,city_id,region) values (431125,4311,'������');
insert into web_regions (region_id,city_id,region) values (431126,4311,'��Զ��');
insert into web_regions (region_id,city_id,region) values (431127,4311,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (431128,4311,'������');
insert into web_regions (region_id,city_id,region) values (431129,4311,'��������������');
insert into web_regions (region_id,city_id,region) values (431202,4312,'�׳���');
insert into web_regions (region_id,city_id,region) values (431221,4312,'�з���');
insert into web_regions (region_id,city_id,region) values (431222,4312,'������');
insert into web_regions (region_id,city_id,region) values (431223,4312,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (431224,4312,'������');
insert into web_regions (region_id,city_id,region) values (431225,4312,'��ͬ��');
insert into web_regions (region_id,city_id,region) values (431226,4312,'��������������');
insert into web_regions (region_id,city_id,region) values (431227,4312,'�»ζ���������');
insert into web_regions (region_id,city_id,region) values (431228,4312,'�ƽ�����������');
insert into web_regions (region_id,city_id,region) values (431229,4312,'�������嶱��������');
insert into web_regions (region_id,city_id,region) values (431230,4312,'ͨ������������');
insert into web_regions (region_id,city_id,region) values (431281,4312,'�齭��');
insert into web_regions (region_id,city_id,region) values (431302,4313,'¦����');
insert into web_regions (region_id,city_id,region) values (431321,4313,'˫����');
insert into web_regions (region_id,city_id,region) values (431322,4313,'�»���');
insert into web_regions (region_id,city_id,region) values (431381,4313,'��ˮ����');
insert into web_regions (region_id,city_id,region) values (431382,4313,'��Դ��');
insert into web_regions (region_id,city_id,region) values (433101,4331,'������');
insert into web_regions (region_id,city_id,region) values (433122,4331,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (433123,4331,'�����');
insert into web_regions (region_id,city_id,region) values (433124,4331,'��ԫ��');
insert into web_regions (region_id,city_id,region) values (433125,4331,'������');
insert into web_regions (region_id,city_id,region) values (433126,4331,'������');
insert into web_regions (region_id,city_id,region) values (433127,4331,'��˳��');
insert into web_regions (region_id,city_id,region) values (433130,4331,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (440103,4401,'������');
insert into web_regions (region_id,city_id,region) values (440104,4401,'Խ����');
insert into web_regions (region_id,city_id,region) values (440105,4401,'������');
insert into web_regions (region_id,city_id,region) values (440106,4401,'�����');
insert into web_regions (region_id,city_id,region) values (440111,4401,'������');
insert into web_regions (region_id,city_id,region) values (440112,4401,'������');
insert into web_regions (region_id,city_id,region) values (440113,4401,'��خ��');
insert into web_regions (region_id,city_id,region) values (440114,4401,'������');
insert into web_regions (region_id,city_id,region) values (440115,4401,'��ɳ��');
insert into web_regions (region_id,city_id,region) values (440117,4401,'�ӻ���');
insert into web_regions (region_id,city_id,region) values (440118,4401,'������');
insert into web_regions (region_id,city_id,region) values (440119,4401,'�ܸ���');
insert into web_regions (region_id,city_id,region) values (440203,4402,'�佭��');
insert into web_regions (region_id,city_id,region) values (440204,4402,'䥽���');
insert into web_regions (region_id,city_id,region) values (440205,4402,'������');
insert into web_regions (region_id,city_id,region) values (440222,4402,'ʼ����');
insert into web_regions (region_id,city_id,region) values (440224,4402,'�ʻ���');
insert into web_regions (region_id,city_id,region) values (440229,4402,'��Դ��');
insert into web_regions (region_id,city_id,region) values (440232,4402,'��Դ����������');
insert into web_regions (region_id,city_id,region) values (440233,4402,'�·���');
insert into web_regions (region_id,city_id,region) values (440281,4402,'�ֲ���');
insert into web_regions (region_id,city_id,region) values (440282,4402,'������');
insert into web_regions (region_id,city_id,region) values (440303,4403,'�޺���');
insert into web_regions (region_id,city_id,region) values (440304,4403,'������');
insert into web_regions (region_id,city_id,region) values (440305,4403,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (440306,4403,'������');
insert into web_regions (region_id,city_id,region) values (440307,4403,'������');
insert into web_regions (region_id,city_id,region) values (440308,4403,'������');
insert into web_regions (region_id,city_id,region) values (440309,4403,'��������');
insert into web_regions (region_id,city_id,region) values (440310,4403,'ƺɽ����');
insert into web_regions (region_id,city_id,region) values (440311,4403,'��������');
insert into web_regions (region_id,city_id,region) values (440312,4403,'��������');
insert into web_regions (region_id,city_id,region) values (440402,4404,'������');
insert into web_regions (region_id,city_id,region) values (440403,4404,'������');
insert into web_regions (region_id,city_id,region) values (440404,4404,'������');
insert into web_regions (region_id,city_id,region) values (440507,4405,'������');
insert into web_regions (region_id,city_id,region) values (440511,4405,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (440512,4405,'婽���');
insert into web_regions (region_id,city_id,region) values (440513,4405,'������');
insert into web_regions (region_id,city_id,region) values (440514,4405,'������');
insert into web_regions (region_id,city_id,region) values (440515,4405,'�κ���');
insert into web_regions (region_id,city_id,region) values (440523,4405,'�ϰ���');
insert into web_regions (region_id,city_id,region) values (440604,4406,'������');
insert into web_regions (region_id,city_id,region) values (440605,4406,'�Ϻ���');
insert into web_regions (region_id,city_id,region) values (440606,4406,'˳����');
insert into web_regions (region_id,city_id,region) values (440607,4406,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (440608,4406,'������');
insert into web_regions (region_id,city_id,region) values (440703,4407,'���');
insert into web_regions (region_id,city_id,region) values (440704,4407,'������');
insert into web_regions (region_id,city_id,region) values (440705,4407,'�»���');
insert into web_regions (region_id,city_id,region) values (440781,4407,'̨ɽ��');
insert into web_regions (region_id,city_id,region) values (440783,4407,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (440784,4407,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (440785,4407,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (440802,4408,'�࿲��');
insert into web_regions (region_id,city_id,region) values (440803,4408,'ϼɽ��');
insert into web_regions (region_id,city_id,region) values (440804,4408,'��ͷ��');
insert into web_regions (region_id,city_id,region) values (440811,4408,'������');
insert into web_regions (region_id,city_id,region) values (440823,4408,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (440825,4408,'������');
insert into web_regions (region_id,city_id,region) values (440881,4408,'������');
insert into web_regions (region_id,city_id,region) values (440882,4408,'������');
insert into web_regions (region_id,city_id,region) values (440883,4408,'�⴨��');
insert into web_regions (region_id,city_id,region) values (440902,4409,'ï����');
insert into web_regions (region_id,city_id,region) values (440904,4409,'�����');
insert into web_regions (region_id,city_id,region) values (440981,4409,'������');
insert into web_regions (region_id,city_id,region) values (440982,4409,'������');
insert into web_regions (region_id,city_id,region) values (440983,4409,'������');
insert into web_regions (region_id,city_id,region) values (441202,4412,'������');
insert into web_regions (region_id,city_id,region) values (441203,4412,'������');
insert into web_regions (region_id,city_id,region) values (441223,4412,'������');
insert into web_regions (region_id,city_id,region) values (441224,4412,'������');
insert into web_regions (region_id,city_id,region) values (441225,4412,'�⿪��');
insert into web_regions (region_id,city_id,region) values (441226,4412,'������');
insert into web_regions (region_id,city_id,region) values (441283,4412,'��Ҫ��');
insert into web_regions (region_id,city_id,region) values (441284,4412,'�Ļ���');
insert into web_regions (region_id,city_id,region) values (441302,4413,'�ݳ���');
insert into web_regions (region_id,city_id,region) values (441303,4413,'������');
insert into web_regions (region_id,city_id,region) values (441322,4413,'������');
insert into web_regions (region_id,city_id,region) values (441323,4413,'�ݶ���');
insert into web_regions (region_id,city_id,region) values (441324,4413,'������');
insert into web_regions (region_id,city_id,region) values (441402,4414,'÷����');
insert into web_regions (region_id,city_id,region) values (441403,4414,'÷����');
insert into web_regions (region_id,city_id,region) values (441422,4414,'������');
insert into web_regions (region_id,city_id,region) values (441423,4414,'��˳��');
insert into web_regions (region_id,city_id,region) values (441424,4414,'�廪��');
insert into web_regions (region_id,city_id,region) values (441426,4414,'ƽԶ��');
insert into web_regions (region_id,city_id,region) values (441427,4414,'������');
insert into web_regions (region_id,city_id,region) values (441481,4414,'������');
insert into web_regions (region_id,city_id,region) values (441502,4415,'����');
insert into web_regions (region_id,city_id,region) values (441521,4415,'������');
insert into web_regions (region_id,city_id,region) values (441523,4415,'½����');
insert into web_regions (region_id,city_id,region) values (441581,4415,'½����');
insert into web_regions (region_id,city_id,region) values (441602,4416,'Դ����');
insert into web_regions (region_id,city_id,region) values (441621,4416,'�Ͻ���');
insert into web_regions (region_id,city_id,region) values (441622,4416,'������');
insert into web_regions (region_id,city_id,region) values (441623,4416,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (441624,4416,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (441625,4416,'��Դ��');
insert into web_regions (region_id,city_id,region) values (441702,4417,'������');
insert into web_regions (region_id,city_id,region) values (441704,4417,'������');
insert into web_regions (region_id,city_id,region) values (441721,4417,'������');
insert into web_regions (region_id,city_id,region) values (441781,4417,'������');
insert into web_regions (region_id,city_id,region) values (441802,4418,'�����');
insert into web_regions (region_id,city_id,region) values (441803,4418,'������');
insert into web_regions (region_id,city_id,region) values (441821,4418,'�����');
insert into web_regions (region_id,city_id,region) values (441823,4418,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (441825,4418,'��ɽ׳������������');
insert into web_regions (region_id,city_id,region) values (441826,4418,'��������������');
insert into web_regions (region_id,city_id,region) values (441881,4418,'Ӣ����');
insert into web_regions (region_id,city_id,region) values (441882,4418,'������');
insert into web_regions (region_id,city_id,region) values (441901,4419,'ݸ����');
insert into web_regions (region_id,city_id,region) values (441902,4419,'�ϳ���');
insert into web_regions (region_id,city_id,region) values (441904,4419,'����');
insert into web_regions (region_id,city_id,region) values (441905,4419,'ʯ����');
insert into web_regions (region_id,city_id,region) values (441906,4419,'ʯ����');
insert into web_regions (region_id,city_id,region) values (441907,4419,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (441908,4419,'ʯ����');
insert into web_regions (region_id,city_id,region) values (441909,4419,'��ʯ��');
insert into web_regions (region_id,city_id,region) values (441910,4419,'������');
insert into web_regions (region_id,city_id,region) values (441911,4419,'��ͷ��');
insert into web_regions (region_id,city_id,region) values (441912,4419,'л����');
insert into web_regions (region_id,city_id,region) values (441913,4419,'������');
insert into web_regions (region_id,city_id,region) values (441914,4419,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (441915,4419,'弲���');
insert into web_regions (region_id,city_id,region) values (441916,4419,'������');
insert into web_regions (region_id,city_id,region) values (441917,4419,'��ӿ��');
insert into web_regions (region_id,city_id,region) values (441918,4419,'������');
insert into web_regions (region_id,city_id,region) values (441919,4419,'�߈���');
insert into web_regions (region_id,city_id,region) values (441920,4419,'��ľͷ��');
insert into web_regions (region_id,city_id,region) values (441921,4419,'����ɽ��');
insert into web_regions (region_id,city_id,region) values (441922,4419,'��ţ����');
insert into web_regions (region_id,city_id,region) values (441923,4419,'�ƽ���');
insert into web_regions (region_id,city_id,region) values (441924,4419,'��÷��');
insert into web_regions (region_id,city_id,region) values (441925,4419,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (441926,4419,'ɳ����');
insert into web_regions (region_id,city_id,region) values (441927,4419,'������');
insert into web_regions (region_id,city_id,region) values (441928,4419,'������');
insert into web_regions (region_id,city_id,region) values (441929,4419,'������');
insert into web_regions (region_id,city_id,region) values (441930,4419,'�����');
insert into web_regions (region_id,city_id,region) values (441931,4419,'�����');
insert into web_regions (region_id,city_id,region) values (441932,4419,'������');
insert into web_regions (region_id,city_id,region) values (442001,4420,'ʯ���');
insert into web_regions (region_id,city_id,region) values (442004,4420,'����');
insert into web_regions (region_id,city_id,region) values (442005,4420,'���ɽ��');
insert into web_regions (region_id,city_id,region) values (442006,4420,'��濪����');
insert into web_regions (region_id,city_id,region) values (442007,4420,'������');
insert into web_regions (region_id,city_id,region) values (442008,4420,'��ͷ��');
insert into web_regions (region_id,city_id,region) values (442009,4420,'������');
insert into web_regions (region_id,city_id,region) values (442010,4420,'��ɳ��');
insert into web_regions (region_id,city_id,region) values (442011,4420,'С���');
insert into web_regions (region_id,city_id,region) values (442012,4420,'������');
insert into web_regions (region_id,city_id,region) values (442013,4420,'������');
insert into web_regions (region_id,city_id,region) values (442014,4420,'������');
insert into web_regions (region_id,city_id,region) values (442015,4420,'������');
insert into web_regions (region_id,city_id,region) values (442016,4420,'������');
insert into web_regions (region_id,city_id,region) values (442017,4420,'������');
insert into web_regions (region_id,city_id,region) values (442018,4420,'�ۿ���');
insert into web_regions (region_id,city_id,region) values (442019,4420,'��ӿ��');
insert into web_regions (region_id,city_id,region) values (442020,4420,'ɳϪ��');
insert into web_regions (region_id,city_id,region) values (442021,4420,'������');
insert into web_regions (region_id,city_id,region) values (442022,4420,'��ܽ��');
insert into web_regions (region_id,city_id,region) values (442023,4420,'������');
insert into web_regions (region_id,city_id,region) values (442024,4420,'̹����');
insert into web_regions (region_id,city_id,region) values (445102,4451,'������');
insert into web_regions (region_id,city_id,region) values (445103,4451,'������');
insert into web_regions (region_id,city_id,region) values (445122,4451,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (445202,4452,'�ų���');
insert into web_regions (region_id,city_id,region) values (445203,4452,'�Ҷ���');
insert into web_regions (region_id,city_id,region) values (445222,4452,'������');
insert into web_regions (region_id,city_id,region) values (445224,4452,'������');
insert into web_regions (region_id,city_id,region) values (445281,4452,'������');
insert into web_regions (region_id,city_id,region) values (445302,4453,'�Ƴ���');
insert into web_regions (region_id,city_id,region) values (445303,4453,'�ư���');
insert into web_regions (region_id,city_id,region) values (445321,4453,'������');
insert into web_regions (region_id,city_id,region) values (445322,4453,'������');
insert into web_regions (region_id,city_id,region) values (445381,4453,'�޶���');
insert into web_regions (region_id,city_id,region) values (450102,4501,'������');
insert into web_regions (region_id,city_id,region) values (450103,4501,'������');
insert into web_regions (region_id,city_id,region) values (450105,4501,'������');
insert into web_regions (region_id,city_id,region) values (450107,4501,'��������');
insert into web_regions (region_id,city_id,region) values (450108,4501,'������');
insert into web_regions (region_id,city_id,region) values (450109,4501,'������');
insert into web_regions (region_id,city_id,region) values (450122,4501,'������');
insert into web_regions (region_id,city_id,region) values (450123,4501,'¡����');
insert into web_regions (region_id,city_id,region) values (450124,4501,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (450125,4501,'������');
insert into web_regions (region_id,city_id,region) values (450126,4501,'������');
insert into web_regions (region_id,city_id,region) values (450127,4501,'����');
insert into web_regions (region_id,city_id,region) values (450128,4501,'��������');
insert into web_regions (region_id,city_id,region) values (450202,4502,'������');
insert into web_regions (region_id,city_id,region) values (450203,4502,'�����');
insert into web_regions (region_id,city_id,region) values (450204,4502,'������');
insert into web_regions (region_id,city_id,region) values (450205,4502,'������');
insert into web_regions (region_id,city_id,region) values (450221,4502,'������');
insert into web_regions (region_id,city_id,region) values (450222,4502,'������');
insert into web_regions (region_id,city_id,region) values (450223,4502,'¹կ��');
insert into web_regions (region_id,city_id,region) values (450224,4502,'�ڰ���');
insert into web_regions (region_id,city_id,region) values (450225,4502,'��ˮ����������');
insert into web_regions (region_id,city_id,region) values (450226,4502,'��������������');
insert into web_regions (region_id,city_id,region) values (450227,4502,'��������');
insert into web_regions (region_id,city_id,region) values (450302,4503,'�����');
insert into web_regions (region_id,city_id,region) values (450303,4503,'������');
insert into web_regions (region_id,city_id,region) values (450304,4503,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (450305,4503,'������');
insert into web_regions (region_id,city_id,region) values (450311,4503,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (450312,4503,'�ٹ���');
insert into web_regions (region_id,city_id,region) values (450321,4503,'��˷��');
insert into web_regions (region_id,city_id,region) values (450323,4503,'�鴨��');
insert into web_regions (region_id,city_id,region) values (450324,4503,'ȫ����');
insert into web_regions (region_id,city_id,region) values (450325,4503,'�˰���');
insert into web_regions (region_id,city_id,region) values (450326,4503,'������');
insert into web_regions (region_id,city_id,region) values (450327,4503,'������');
insert into web_regions (region_id,city_id,region) values (450328,4503,'��ʤ����������');
insert into web_regions (region_id,city_id,region) values (450329,4503,'��Դ��');
insert into web_regions (region_id,city_id,region) values (450330,4503,'ƽ����');
insert into web_regions (region_id,city_id,region) values (450331,4503,'������');
insert into web_regions (region_id,city_id,region) values (450332,4503,'��������������');
insert into web_regions (region_id,city_id,region) values (450403,4504,'������');
insert into web_regions (region_id,city_id,region) values (450405,4504,'������');
insert into web_regions (region_id,city_id,region) values (450406,4504,'������');
insert into web_regions (region_id,city_id,region) values (450421,4504,'������');
insert into web_regions (region_id,city_id,region) values (450422,4504,'����');
insert into web_regions (region_id,city_id,region) values (450423,4504,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (450481,4504,'�Ϫ��');
insert into web_regions (region_id,city_id,region) values (450502,4505,'������');
insert into web_regions (region_id,city_id,region) values (450503,4505,'������');
insert into web_regions (region_id,city_id,region) values (450512,4505,'��ɽ����');
insert into web_regions (region_id,city_id,region) values (450521,4505,'������');
insert into web_regions (region_id,city_id,region) values (450602,4506,'�ۿ���');
insert into web_regions (region_id,city_id,region) values (450603,4506,'������');
insert into web_regions (region_id,city_id,region) values (450621,4506,'��˼��');
insert into web_regions (region_id,city_id,region) values (450681,4506,'������');
insert into web_regions (region_id,city_id,region) values (450702,4507,'������');
insert into web_regions (region_id,city_id,region) values (450703,4507,'�ձ���');
insert into web_regions (region_id,city_id,region) values (450721,4507,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (450722,4507,'�ֱ���');
insert into web_regions (region_id,city_id,region) values (450802,4508,'�۱���');
insert into web_regions (region_id,city_id,region) values (450803,4508,'������');
insert into web_regions (region_id,city_id,region) values (450804,4508,'������');
insert into web_regions (region_id,city_id,region) values (450821,4508,'ƽ����');
insert into web_regions (region_id,city_id,region) values (450881,4508,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (450902,4509,'������');
insert into web_regions (region_id,city_id,region) values (450903,4509,'������');
insert into web_regions (region_id,city_id,region) values (450904,4509,'������');
insert into web_regions (region_id,city_id,region) values (450921,4509,'����');
insert into web_regions (region_id,city_id,region) values (450922,4509,'½����');
insert into web_regions (region_id,city_id,region) values (450923,4509,'������');
insert into web_regions (region_id,city_id,region) values (450924,4509,'��ҵ��');
insert into web_regions (region_id,city_id,region) values (450981,4509,'������');
insert into web_regions (region_id,city_id,region) values (451002,4510,'�ҽ���');
insert into web_regions (region_id,city_id,region) values (451021,4510,'������');
insert into web_regions (region_id,city_id,region) values (451022,4510,'�ﶫ��');
insert into web_regions (region_id,city_id,region) values (451023,4510,'ƽ����');
insert into web_regions (region_id,city_id,region) values (451024,4510,'�±���');
insert into web_regions (region_id,city_id,region) values (451025,4510,'������');
insert into web_regions (region_id,city_id,region) values (451026,4510,'������');
insert into web_regions (region_id,city_id,region) values (451027,4510,'������');
insert into web_regions (region_id,city_id,region) values (451028,4510,'��ҵ��');
insert into web_regions (region_id,city_id,region) values (451029,4510,'������');
insert into web_regions (region_id,city_id,region) values (451030,4510,'������');
insert into web_regions (region_id,city_id,region) values (451031,4510,'¡�ָ���������');
insert into web_regions (region_id,city_id,region) values (451102,4511,'�˲���');
insert into web_regions (region_id,city_id,region) values (451121,4511,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (451122,4511,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (451123,4511,'��������������');
insert into web_regions (region_id,city_id,region) values (451124,4511,'ƽ�������');
insert into web_regions (region_id,city_id,region) values (451202,4512,'��ǽ���');
insert into web_regions (region_id,city_id,region) values (451221,4512,'�ϵ���');
insert into web_regions (region_id,city_id,region) values (451222,4512,'�����');
insert into web_regions (region_id,city_id,region) values (451223,4512,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (451224,4512,'������');
insert into web_regions (region_id,city_id,region) values (451225,4512,'�޳�������������');
insert into web_regions (region_id,city_id,region) values (451226,4512,'����ë����������');
insert into web_regions (region_id,city_id,region) values (451227,4512,'��������������');
insert into web_regions (region_id,city_id,region) values (451228,4512,'��������������');
insert into web_regions (region_id,city_id,region) values (451229,4512,'������������');
insert into web_regions (region_id,city_id,region) values (451281,4512,'������');
insert into web_regions (region_id,city_id,region) values (451302,4513,'�˱���');
insert into web_regions (region_id,city_id,region) values (451321,4513,'�ó���');
insert into web_regions (region_id,city_id,region) values (451322,4513,'������');
insert into web_regions (region_id,city_id,region) values (451323,4513,'������');
insert into web_regions (region_id,city_id,region) values (451324,4513,'��������������');
insert into web_regions (region_id,city_id,region) values (451381,4513,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (451402,4514,'������');
insert into web_regions (region_id,city_id,region) values (451421,4514,'������');
insert into web_regions (region_id,city_id,region) values (451422,4514,'������');
insert into web_regions (region_id,city_id,region) values (451423,4514,'������');
insert into web_regions (region_id,city_id,region) values (451424,4514,'������');
insert into web_regions (region_id,city_id,region) values (451425,4514,'�����');
insert into web_regions (region_id,city_id,region) values (451481,4514,'ƾ����');
insert into web_regions (region_id,city_id,region) values (460105,4601,'��Ӣ��');
insert into web_regions (region_id,city_id,region) values (460106,4601,'������');
insert into web_regions (region_id,city_id,region) values (460107,4601,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (460108,4601,'������');
insert into web_regions (region_id,city_id,region) values (460202,4602,'������');
insert into web_regions (region_id,city_id,region) values (460203,4602,'������');
insert into web_regions (region_id,city_id,region) values (460204,4602,'������');
insert into web_regions (region_id,city_id,region) values (460205,4602,'������');
insert into web_regions (region_id,city_id,region) values (460321,4603,'��ɳȺ��');
insert into web_regions (region_id,city_id,region) values (460322,4603,'��ɳȺ��');
insert into web_regions (region_id,city_id,region) values (460323,4603,'��ɳȺ��');
insert into web_regions (region_id,city_id,region) values (469001,4690,'��ָɽ��');
insert into web_regions (region_id,city_id,region) values (469002,4690,'������');
insert into web_regions (region_id,city_id,region) values (469003,4690,'������');
insert into web_regions (region_id,city_id,region) values (469005,4690,'�Ĳ���');
insert into web_regions (region_id,city_id,region) values (469006,4690,'������');
insert into web_regions (region_id,city_id,region) values (469007,4690,'������');
insert into web_regions (region_id,city_id,region) values (469021,4690,'������');
insert into web_regions (region_id,city_id,region) values (469022,4690,'�Ͳ���');
insert into web_regions (region_id,city_id,region) values (469023,4690,'������');
insert into web_regions (region_id,city_id,region) values (469024,4690,'�ٸ���');
insert into web_regions (region_id,city_id,region) values (469025,4690,'��ɳ����������');
insert into web_regions (region_id,city_id,region) values (469026,4690,'��������������');
insert into web_regions (region_id,city_id,region) values (469027,4690,'�ֶ�����������');
insert into web_regions (region_id,city_id,region) values (469028,4690,'��ˮ����������');
insert into web_regions (region_id,city_id,region) values (469029,4690,'��ͤ��������������');
insert into web_regions (region_id,city_id,region) values (469030,4690,'������������������');
insert into web_regions (region_id,city_id,region) values (500101,5001,'������');
insert into web_regions (region_id,city_id,region) values (500102,5001,'������');
insert into web_regions (region_id,city_id,region) values (500103,5001,'������');
insert into web_regions (region_id,city_id,region) values (500104,5001,'��ɿ���');
insert into web_regions (region_id,city_id,region) values (500105,5001,'������');
insert into web_regions (region_id,city_id,region) values (500106,5001,'ɳƺ����');
insert into web_regions (region_id,city_id,region) values (500107,5001,'��������');
insert into web_regions (region_id,city_id,region) values (500108,5001,'�ϰ���');
insert into web_regions (region_id,city_id,region) values (500109,5001,'������');
insert into web_regions (region_id,city_id,region) values (500110,5001,'�뽭��');
insert into web_regions (region_id,city_id,region) values (500111,5001,'������');
insert into web_regions (region_id,city_id,region) values (500112,5001,'�山��');
insert into web_regions (region_id,city_id,region) values (500113,5001,'������');
insert into web_regions (region_id,city_id,region) values (500114,5001,'ǭ����');
insert into web_regions (region_id,city_id,region) values (500115,5001,'������');
insert into web_regions (region_id,city_id,region) values (500116,5001,'������');
insert into web_regions (region_id,city_id,region) values (500117,5001,'�ϴ���');
insert into web_regions (region_id,city_id,region) values (500118,5001,'������');
insert into web_regions (region_id,city_id,region) values (500119,5001,'�ϴ���');
insert into web_regions (region_id,city_id,region) values (500120,5001,'�ɽ��');
insert into web_regions (region_id,city_id,region) values (500151,5001,'ͭ����');
insert into web_regions (region_id,city_id,region) values (500223,5001,'������');
insert into web_regions (region_id,city_id,region) values (500226,5001,'�ٲ���');
insert into web_regions (region_id,city_id,region) values (500228,5001,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (500229,5001,'�ǿ���');
insert into web_regions (region_id,city_id,region) values (500230,5001,'�ᶼ��');
insert into web_regions (region_id,city_id,region) values (500231,5001,'�潭��');
insert into web_regions (region_id,city_id,region) values (500232,5001,'��¡��');
insert into web_regions (region_id,city_id,region) values (500233,5001,'����');
insert into web_regions (region_id,city_id,region) values (500234,5001,'����');
insert into web_regions (region_id,city_id,region) values (500235,5001,'������');
insert into web_regions (region_id,city_id,region) values (500236,5001,'�����');
insert into web_regions (region_id,city_id,region) values (500237,5001,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (500238,5001,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (500240,5001,'ʯ��������������');
insert into web_regions (region_id,city_id,region) values (500241,5001,'��ɽ����������������');
insert into web_regions (region_id,city_id,region) values (500242,5001,'��������������������');
insert into web_regions (region_id,city_id,region) values (500243,5001,'��ˮ����������������');
insert into web_regions (region_id,city_id,region) values (500301,5003,'��������');
insert into web_regions (region_id,city_id,region) values (500302,5003,'��˰����');
insert into web_regions (region_id,city_id,region) values (500303,5003,'��ҵ԰��');
insert into web_regions (region_id,city_id,region) values (510104,5101,'������');
insert into web_regions (region_id,city_id,region) values (510105,5101,'������');
insert into web_regions (region_id,city_id,region) values (510106,5101,'��ţ��');
insert into web_regions (region_id,city_id,region) values (510107,5101,'�����');
insert into web_regions (region_id,city_id,region) values (510108,5101,'�ɻ���');
insert into web_regions (region_id,city_id,region) values (510112,5101,'��Ȫ����');
insert into web_regions (region_id,city_id,region) values (510113,5101,'��׽���');
insert into web_regions (region_id,city_id,region) values (510114,5101,'�¶���');
insert into web_regions (region_id,city_id,region) values (510115,5101,'�½���');
insert into web_regions (region_id,city_id,region) values (510121,5101,'������');
insert into web_regions (region_id,city_id,region) values (510122,5101,'˫����');
insert into web_regions (region_id,city_id,region) values (510124,5101,'ۯ��');
insert into web_regions (region_id,city_id,region) values (510129,5101,'������');
insert into web_regions (region_id,city_id,region) values (510131,5101,'�ѽ���');
insert into web_regions (region_id,city_id,region) values (510132,5101,'�½���');
insert into web_regions (region_id,city_id,region) values (510181,5101,'��������');
insert into web_regions (region_id,city_id,region) values (510182,5101,'������');
insert into web_regions (region_id,city_id,region) values (510183,5101,'������');
insert into web_regions (region_id,city_id,region) values (510184,5101,'������');
insert into web_regions (region_id,city_id,region) values (510302,5103,'��������');
insert into web_regions (region_id,city_id,region) values (510303,5103,'������');
insert into web_regions (region_id,city_id,region) values (510304,5103,'����');
insert into web_regions (region_id,city_id,region) values (510311,5103,'��̲��');
insert into web_regions (region_id,city_id,region) values (510321,5103,'����');
insert into web_regions (region_id,city_id,region) values (510322,5103,'��˳��');
insert into web_regions (region_id,city_id,region) values (510402,5104,'����');
insert into web_regions (region_id,city_id,region) values (510403,5104,'����');
insert into web_regions (region_id,city_id,region) values (510411,5104,'�ʺ���');
insert into web_regions (region_id,city_id,region) values (510421,5104,'������');
insert into web_regions (region_id,city_id,region) values (510422,5104,'�α���');
insert into web_regions (region_id,city_id,region) values (510502,5105,'������');
insert into web_regions (region_id,city_id,region) values (510503,5105,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (510504,5105,'����̶��');
insert into web_regions (region_id,city_id,region) values (510521,5105,'����');
insert into web_regions (region_id,city_id,region) values (510522,5105,'�Ͻ���');
insert into web_regions (region_id,city_id,region) values (510524,5105,'������');
insert into web_regions (region_id,city_id,region) values (510525,5105,'������');
insert into web_regions (region_id,city_id,region) values (510603,5106,'�����');
insert into web_regions (region_id,city_id,region) values (510623,5106,'�н���');
insert into web_regions (region_id,city_id,region) values (510626,5106,'�޽���');
insert into web_regions (region_id,city_id,region) values (510681,5106,'�㺺��');
insert into web_regions (region_id,city_id,region) values (510682,5106,'ʲ����');
insert into web_regions (region_id,city_id,region) values (510683,5106,'������');
insert into web_regions (region_id,city_id,region) values (510703,5107,'������');
insert into web_regions (region_id,city_id,region) values (510704,5107,'������');
insert into web_regions (region_id,city_id,region) values (510722,5107,'��̨��');
insert into web_regions (region_id,city_id,region) values (510723,5107,'��ͤ��');
insert into web_regions (region_id,city_id,region) values (510724,5107,'����');
insert into web_regions (region_id,city_id,region) values (510725,5107,'������');
insert into web_regions (region_id,city_id,region) values (510726,5107,'����Ǽ��������');
insert into web_regions (region_id,city_id,region) values (510727,5107,'ƽ����');
insert into web_regions (region_id,city_id,region) values (510781,5107,'������');
insert into web_regions (region_id,city_id,region) values (510802,5108,'������');
insert into web_regions (region_id,city_id,region) values (510811,5108,'�ѻ���');
insert into web_regions (region_id,city_id,region) values (510812,5108,'������');
insert into web_regions (region_id,city_id,region) values (510821,5108,'������');
insert into web_regions (region_id,city_id,region) values (510822,5108,'�ന��');
insert into web_regions (region_id,city_id,region) values (510823,5108,'������');
insert into web_regions (region_id,city_id,region) values (510824,5108,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (510903,5109,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (510904,5109,'������');
insert into web_regions (region_id,city_id,region) values (510921,5109,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (510922,5109,'�����');
insert into web_regions (region_id,city_id,region) values (510923,5109,'��Ӣ��');
insert into web_regions (region_id,city_id,region) values (511002,5110,'������');
insert into web_regions (region_id,city_id,region) values (511011,5110,'������');
insert into web_regions (region_id,city_id,region) values (511024,5110,'��Զ��');
insert into web_regions (region_id,city_id,region) values (511025,5110,'������');
insert into web_regions (region_id,city_id,region) values (511028,5110,'¡����');
insert into web_regions (region_id,city_id,region) values (511102,5111,'������');
insert into web_regions (region_id,city_id,region) values (511111,5111,'ɳ����');
insert into web_regions (region_id,city_id,region) values (511112,5111,'��ͨ����');
insert into web_regions (region_id,city_id,region) values (511113,5111,'��ں���');
insert into web_regions (region_id,city_id,region) values (511123,5111,'��Ϊ��');
insert into web_regions (region_id,city_id,region) values (511124,5111,'������');
insert into web_regions (region_id,city_id,region) values (511126,5111,'�н���');
insert into web_regions (region_id,city_id,region) values (511129,5111,'�崨��');
insert into web_regions (region_id,city_id,region) values (511132,5111,'�������������');
insert into web_regions (region_id,city_id,region) values (511133,5111,'��������������');
insert into web_regions (region_id,city_id,region) values (511181,5111,'��üɽ��');
insert into web_regions (region_id,city_id,region) values (511302,5113,'˳����');
insert into web_regions (region_id,city_id,region) values (511303,5113,'��ƺ��');
insert into web_regions (region_id,city_id,region) values (511304,5113,'������');
insert into web_regions (region_id,city_id,region) values (511321,5113,'�ϲ���');
insert into web_regions (region_id,city_id,region) values (511322,5113,'Ӫɽ��');
insert into web_regions (region_id,city_id,region) values (511323,5113,'���');
insert into web_regions (region_id,city_id,region) values (511324,5113,'��¤��');
insert into web_regions (region_id,city_id,region) values (511325,5113,'������');
insert into web_regions (region_id,city_id,region) values (511381,5113,'������');
insert into web_regions (region_id,city_id,region) values (511402,5114,'������');
insert into web_regions (region_id,city_id,region) values (511403,5114,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (511421,5114,'������');
insert into web_regions (region_id,city_id,region) values (511423,5114,'������');
insert into web_regions (region_id,city_id,region) values (511424,5114,'������');
insert into web_regions (region_id,city_id,region) values (511425,5114,'������');
insert into web_regions (region_id,city_id,region) values (511502,5115,'������');
insert into web_regions (region_id,city_id,region) values (511503,5115,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (511521,5115,'�˱���');
insert into web_regions (region_id,city_id,region) values (511523,5115,'������');
insert into web_regions (region_id,city_id,region) values (511524,5115,'������');
insert into web_regions (region_id,city_id,region) values (511525,5115,'����');
insert into web_regions (region_id,city_id,region) values (511526,5115,'����');
insert into web_regions (region_id,city_id,region) values (511527,5115,'������');
insert into web_regions (region_id,city_id,region) values (511528,5115,'������');
insert into web_regions (region_id,city_id,region) values (511529,5115,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (511602,5116,'�㰲��');
insert into web_regions (region_id,city_id,region) values (511603,5116,'ǰ����');
insert into web_regions (region_id,city_id,region) values (511621,5116,'������');
insert into web_regions (region_id,city_id,region) values (511622,5116,'��ʤ��');
insert into web_regions (region_id,city_id,region) values (511623,5116,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (511681,5116,'������');
insert into web_regions (region_id,city_id,region) values (511702,5117,'ͨ����');
insert into web_regions (region_id,city_id,region) values (511703,5117,'�ﴨ��');
insert into web_regions (region_id,city_id,region) values (511722,5117,'������');
insert into web_regions (region_id,city_id,region) values (511723,5117,'������');
insert into web_regions (region_id,city_id,region) values (511724,5117,'������');
insert into web_regions (region_id,city_id,region) values (511725,5117,'����');
insert into web_regions (region_id,city_id,region) values (511781,5117,'��Դ��');
insert into web_regions (region_id,city_id,region) values (511802,5118,'�����');
insert into web_regions (region_id,city_id,region) values (511803,5118,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (511822,5118,'������');
insert into web_regions (region_id,city_id,region) values (511823,5118,'��Դ��');
insert into web_regions (region_id,city_id,region) values (511824,5118,'ʯ����');
insert into web_regions (region_id,city_id,region) values (511825,5118,'��ȫ��');
insert into web_regions (region_id,city_id,region) values (511826,5118,'«ɽ��');
insert into web_regions (region_id,city_id,region) values (511827,5118,'������');
insert into web_regions (region_id,city_id,region) values (511902,5119,'������');
insert into web_regions (region_id,city_id,region) values (511903,5119,'������');
insert into web_regions (region_id,city_id,region) values (511921,5119,'ͨ����');
insert into web_regions (region_id,city_id,region) values (511922,5119,'�Ͻ���');
insert into web_regions (region_id,city_id,region) values (511923,5119,'ƽ����');
insert into web_regions (region_id,city_id,region) values (512002,5120,'�㽭��');
insert into web_regions (region_id,city_id,region) values (512021,5120,'������');
insert into web_regions (region_id,city_id,region) values (512022,5120,'������');
insert into web_regions (region_id,city_id,region) values (512081,5120,'������');
insert into web_regions (region_id,city_id,region) values (513221,5132,'�봨��');
insert into web_regions (region_id,city_id,region) values (513222,5132,'����');
insert into web_regions (region_id,city_id,region) values (513223,5132,'ï��');
insert into web_regions (region_id,city_id,region) values (513224,5132,'������');
insert into web_regions (region_id,city_id,region) values (513225,5132,'��կ����');
insert into web_regions (region_id,city_id,region) values (513226,5132,'����');
insert into web_regions (region_id,city_id,region) values (513227,5132,'С����');
insert into web_regions (region_id,city_id,region) values (513228,5132,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (513229,5132,'��������');
insert into web_regions (region_id,city_id,region) values (513230,5132,'������');
insert into web_regions (region_id,city_id,region) values (513231,5132,'������');
insert into web_regions (region_id,city_id,region) values (513232,5132,'��������');
insert into web_regions (region_id,city_id,region) values (513233,5132,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (513321,5133,'������');
insert into web_regions (region_id,city_id,region) values (513322,5133,'����');
insert into web_regions (region_id,city_id,region) values (513323,5133,'������');
insert into web_regions (region_id,city_id,region) values (513324,5133,'������');
insert into web_regions (region_id,city_id,region) values (513325,5133,'�Ž���');
insert into web_regions (region_id,city_id,region) values (513326,5133,'������');
insert into web_regions (region_id,city_id,region) values (513327,5133,'¯����');
insert into web_regions (region_id,city_id,region) values (513328,5133,'������');
insert into web_regions (region_id,city_id,region) values (513329,5133,'������');
insert into web_regions (region_id,city_id,region) values (513330,5133,'�¸���');
insert into web_regions (region_id,city_id,region) values (513331,5133,'������');
insert into web_regions (region_id,city_id,region) values (513332,5133,'ʯ����');
insert into web_regions (region_id,city_id,region) values (513333,5133,'ɫ����');
insert into web_regions (region_id,city_id,region) values (513334,5133,'������');
insert into web_regions (region_id,city_id,region) values (513335,5133,'������');
insert into web_regions (region_id,city_id,region) values (513336,5133,'�����');
insert into web_regions (region_id,city_id,region) values (513337,5133,'������');
insert into web_regions (region_id,city_id,region) values (513338,5133,'������');
insert into web_regions (region_id,city_id,region) values (513401,5134,'������');
insert into web_regions (region_id,city_id,region) values (513422,5134,'ľ�����������');
insert into web_regions (region_id,city_id,region) values (513423,5134,'��Դ��');
insert into web_regions (region_id,city_id,region) values (513424,5134,'�²���');
insert into web_regions (region_id,city_id,region) values (513425,5134,'������');
insert into web_regions (region_id,city_id,region) values (513426,5134,'�ᶫ��');
insert into web_regions (region_id,city_id,region) values (513427,5134,'������');
insert into web_regions (region_id,city_id,region) values (513428,5134,'�ո���');
insert into web_regions (region_id,city_id,region) values (513429,5134,'������');
insert into web_regions (region_id,city_id,region) values (513430,5134,'������');
insert into web_regions (region_id,city_id,region) values (513431,5134,'�Ѿ���');
insert into web_regions (region_id,city_id,region) values (513432,5134,'ϲ����');
insert into web_regions (region_id,city_id,region) values (513433,5134,'������');
insert into web_regions (region_id,city_id,region) values (513434,5134,'Խ����');
insert into web_regions (region_id,city_id,region) values (513435,5134,'������');
insert into web_regions (region_id,city_id,region) values (513436,5134,'������');
insert into web_regions (region_id,city_id,region) values (513437,5134,'�ײ���');
insert into web_regions (region_id,city_id,region) values (520102,5201,'������');
insert into web_regions (region_id,city_id,region) values (520103,5201,'������');
insert into web_regions (region_id,city_id,region) values (520111,5201,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (520112,5201,'�ڵ���');
insert into web_regions (region_id,city_id,region) values (520113,5201,'������');
insert into web_regions (region_id,city_id,region) values (520115,5201,'��ɽ����');
insert into web_regions (region_id,city_id,region) values (520121,5201,'������');
insert into web_regions (region_id,city_id,region) values (520122,5201,'Ϣ����');
insert into web_regions (region_id,city_id,region) values (520123,5201,'������');
insert into web_regions (region_id,city_id,region) values (520181,5201,'������');
insert into web_regions (region_id,city_id,region) values (520201,5202,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (520203,5202,'��֦����');
insert into web_regions (region_id,city_id,region) values (520221,5202,'ˮ����');
insert into web_regions (region_id,city_id,region) values (520222,5202,'����');
insert into web_regions (region_id,city_id,region) values (520302,5203,'�컨����');
insert into web_regions (region_id,city_id,region) values (520303,5203,'�㴨��');
insert into web_regions (region_id,city_id,region) values (520321,5203,'������');
insert into web_regions (region_id,city_id,region) values (520322,5203,'ͩ����');
insert into web_regions (region_id,city_id,region) values (520323,5203,'������');
insert into web_regions (region_id,city_id,region) values (520324,5203,'������');
insert into web_regions (region_id,city_id,region) values (520325,5203,'��������������������');
insert into web_regions (region_id,city_id,region) values (520326,5203,'������������������');
insert into web_regions (region_id,city_id,region) values (520327,5203,'�����');
insert into web_regions (region_id,city_id,region) values (520328,5203,'��̶��');
insert into web_regions (region_id,city_id,region) values (520329,5203,'������');
insert into web_regions (region_id,city_id,region) values (520330,5203,'ϰˮ��');
insert into web_regions (region_id,city_id,region) values (520381,5203,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (520382,5203,'�ʻ���');
insert into web_regions (region_id,city_id,region) values (520402,5204,'������');
insert into web_regions (region_id,city_id,region) values (520421,5204,'ƽ����');
insert into web_regions (region_id,city_id,region) values (520422,5204,'�ն���');
insert into web_regions (region_id,city_id,region) values (520423,5204,'��������������������');
insert into web_regions (region_id,city_id,region) values (520424,5204,'���벼��������������');
insert into web_regions (region_id,city_id,region) values (520425,5204,'�������岼����������');
insert into web_regions (region_id,city_id,region) values (520502,5205,'���ǹ���');
insert into web_regions (region_id,city_id,region) values (520521,5205,'����');
insert into web_regions (region_id,city_id,region) values (520522,5205,'ǭ����');
insert into web_regions (region_id,city_id,region) values (520523,5205,'��ɳ��');
insert into web_regions (region_id,city_id,region) values (520524,5205,'֯����');
insert into web_regions (region_id,city_id,region) values (520525,5205,'��Ӻ��');
insert into web_regions (region_id,city_id,region) values (520526,5205,'���������������������');
insert into web_regions (region_id,city_id,region) values (520527,5205,'������');
insert into web_regions (region_id,city_id,region) values (520602,5206,'�̽���');
insert into web_regions (region_id,city_id,region) values (520603,5206,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (520621,5206,'������');
insert into web_regions (region_id,city_id,region) values (520622,5206,'��������������');
insert into web_regions (region_id,city_id,region) values (520623,5206,'ʯ����');
insert into web_regions (region_id,city_id,region) values (520624,5206,'˼����');
insert into web_regions (region_id,city_id,region) values (520625,5206,'ӡ������������������');
insert into web_regions (region_id,city_id,region) values (520626,5206,'�½���');
insert into web_regions (region_id,city_id,region) values (520627,5206,'�غ�������������');
insert into web_regions (region_id,city_id,region) values (520628,5206,'��������������');
insert into web_regions (region_id,city_id,region) values (522301,5223,'������ ');
insert into web_regions (region_id,city_id,region) values (522322,5223,'������');
insert into web_regions (region_id,city_id,region) values (522323,5223,'�հ���');
insert into web_regions (region_id,city_id,region) values (522324,5223,'��¡��');
insert into web_regions (region_id,city_id,region) values (522325,5223,'�����');
insert into web_regions (region_id,city_id,region) values (522326,5223,'������');
insert into web_regions (region_id,city_id,region) values (522327,5223,'�����');
insert into web_regions (region_id,city_id,region) values (522328,5223,'������');
insert into web_regions (region_id,city_id,region) values (522601,5226,'������');
insert into web_regions (region_id,city_id,region) values (522622,5226,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (522623,5226,'ʩ����');
insert into web_regions (region_id,city_id,region) values (522624,5226,'������');
insert into web_regions (region_id,city_id,region) values (522625,5226,'��Զ��');
insert into web_regions (region_id,city_id,region) values (522626,5226,'᯹���');
insert into web_regions (region_id,city_id,region) values (522627,5226,'������');
insert into web_regions (region_id,city_id,region) values (522628,5226,'������');
insert into web_regions (region_id,city_id,region) values (522629,5226,'������');
insert into web_regions (region_id,city_id,region) values (522630,5226,'̨����');
insert into web_regions (region_id,city_id,region) values (522631,5226,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (522632,5226,'�Ž���');
insert into web_regions (region_id,city_id,region) values (522633,5226,'�ӽ���');
insert into web_regions (region_id,city_id,region) values (522634,5226,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (522635,5226,'�齭��');
insert into web_regions (region_id,city_id,region) values (522636,5226,'��կ��');
insert into web_regions (region_id,city_id,region) values (522701,5227,'������');
insert into web_regions (region_id,city_id,region) values (522702,5227,'��Ȫ��');
insert into web_regions (region_id,city_id,region) values (522722,5227,'����');
insert into web_regions (region_id,city_id,region) values (522723,5227,'����');
insert into web_regions (region_id,city_id,region) values (522725,5227,'�Ͱ���');
insert into web_regions (region_id,city_id,region) values (522726,5227,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (522727,5227,'ƽ����');
insert into web_regions (region_id,city_id,region) values (522728,5227,'�޵���');
insert into web_regions (region_id,city_id,region) values (522729,5227,'��˳��');
insert into web_regions (region_id,city_id,region) values (522730,5227,'������');
insert into web_regions (region_id,city_id,region) values (522731,5227,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (522732,5227,'����ˮ��������');
insert into web_regions (region_id,city_id,region) values (530102,5301,'�廪��');
insert into web_regions (region_id,city_id,region) values (530103,5301,'������');
insert into web_regions (region_id,city_id,region) values (530111,5301,'�ٶ���');
insert into web_regions (region_id,city_id,region) values (530112,5301,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (530113,5301,'������');
insert into web_regions (region_id,city_id,region) values (530114,5301,'�ʹ���');
insert into web_regions (region_id,city_id,region) values (530122,5301,'������');
insert into web_regions (region_id,city_id,region) values (530124,5301,'������');
insert into web_regions (region_id,city_id,region) values (530125,5301,'������');
insert into web_regions (region_id,city_id,region) values (530126,5301,'ʯ������������');
insert into web_regions (region_id,city_id,region) values (530127,5301,'������');
insert into web_regions (region_id,city_id,region) values (530128,5301,'»Ȱ��������������');
insert into web_regions (region_id,city_id,region) values (530129,5301,'Ѱ��������������� ');
insert into web_regions (region_id,city_id,region) values (530181,5301,'������');
insert into web_regions (region_id,city_id,region) values (530302,5303,'������');
insert into web_regions (region_id,city_id,region) values (530321,5303,'������');
insert into web_regions (region_id,city_id,region) values (530322,5303,'½����');
insert into web_regions (region_id,city_id,region) values (530323,5303,'ʦ����');
insert into web_regions (region_id,city_id,region) values (530324,5303,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (530325,5303,'��Դ��');
insert into web_regions (region_id,city_id,region) values (530326,5303,'������');
insert into web_regions (region_id,city_id,region) values (530328,5303,'մ����');
insert into web_regions (region_id,city_id,region) values (530381,5303,'������');
insert into web_regions (region_id,city_id,region) values (530402,5304,'������');
insert into web_regions (region_id,city_id,region) values (530421,5304,'������');
insert into web_regions (region_id,city_id,region) values (530422,5304,'�ν���');
insert into web_regions (region_id,city_id,region) values (530423,5304,'ͨ����');
insert into web_regions (region_id,city_id,region) values (530424,5304,'������');
insert into web_regions (region_id,city_id,region) values (530425,5304,'������');
insert into web_regions (region_id,city_id,region) values (530426,5304,'��ɽ����������');
insert into web_regions (region_id,city_id,region) values (530427,5304,'��ƽ�������������');
insert into web_regions (region_id,city_id,region) values (530428,5304,'Ԫ���������������������');
insert into web_regions (region_id,city_id,region) values (530502,5305,'¡����');
insert into web_regions (region_id,city_id,region) values (530521,5305,'ʩ����');
insert into web_regions (region_id,city_id,region) values (530522,5305,'�ڳ���');
insert into web_regions (region_id,city_id,region) values (530523,5305,'������');
insert into web_regions (region_id,city_id,region) values (530524,5305,'������');
insert into web_regions (region_id,city_id,region) values (530602,5306,'������');
insert into web_regions (region_id,city_id,region) values (530621,5306,'³����');
insert into web_regions (region_id,city_id,region) values (530622,5306,'�ɼ���');
insert into web_regions (region_id,city_id,region) values (530623,5306,'�ν���');
insert into web_regions (region_id,city_id,region) values (530624,5306,'�����');
insert into web_regions (region_id,city_id,region) values (530625,5306,'������');
insert into web_regions (region_id,city_id,region) values (530626,5306,'�罭��');
insert into web_regions (region_id,city_id,region) values (530627,5306,'������');
insert into web_regions (region_id,city_id,region) values (530628,5306,'������');
insert into web_regions (region_id,city_id,region) values (530629,5306,'������');
insert into web_regions (region_id,city_id,region) values (530630,5306,'ˮ����');
insert into web_regions (region_id,city_id,region) values (530702,5307,'�ų���');
insert into web_regions (region_id,city_id,region) values (530721,5307,'����������������');
insert into web_regions (region_id,city_id,region) values (530722,5307,'��ʤ��');
insert into web_regions (region_id,city_id,region) values (530723,5307,'��ƺ��');
insert into web_regions (region_id,city_id,region) values (530724,5307,'��������������');
insert into web_regions (region_id,city_id,region) values (530802,5308,'˼é��');
insert into web_regions (region_id,city_id,region) values (530821,5308,'��������������������');
insert into web_regions (region_id,city_id,region) values (530822,5308,'ī��������������');
insert into web_regions (region_id,city_id,region) values (530823,5308,'��������������');
insert into web_regions (region_id,city_id,region) values (530824,5308,'���ȴ�������������');
insert into web_regions (region_id,city_id,region) values (530825,5308,'�������������������������');
insert into web_regions (region_id,city_id,region) values (530826,5308,'���ǹ���������������');
insert into web_regions (region_id,city_id,region) values (530827,5308,'������������������������');
insert into web_regions (region_id,city_id,region) values (530828,5308,'����������������');
insert into web_regions (region_id,city_id,region) values (530829,5308,'��������������');
insert into web_regions (region_id,city_id,region) values (530902,5309,'������');
insert into web_regions (region_id,city_id,region) values (530921,5309,'������');
insert into web_regions (region_id,city_id,region) values (530922,5309,'����');
insert into web_regions (region_id,city_id,region) values (530923,5309,'������');
insert into web_regions (region_id,city_id,region) values (530924,5309,'����');
insert into web_regions (region_id,city_id,region) values (530925,5309,'˫�����������岼�������������');
insert into web_regions (region_id,city_id,region) values (530926,5309,'������������������');
insert into web_regions (region_id,city_id,region) values (530927,5309,'��Դ����������');
insert into web_regions (region_id,city_id,region) values (532301,5323,'������');
insert into web_regions (region_id,city_id,region) values (532322,5323,'˫����');
insert into web_regions (region_id,city_id,region) values (532323,5323,'Ĳ����');
insert into web_regions (region_id,city_id,region) values (532324,5323,'�ϻ���');
insert into web_regions (region_id,city_id,region) values (532325,5323,'Ҧ����');
insert into web_regions (region_id,city_id,region) values (532326,5323,'��Ҧ��');
insert into web_regions (region_id,city_id,region) values (532327,5323,'������');
insert into web_regions (region_id,city_id,region) values (532328,5323,'Ԫı��');
insert into web_regions (region_id,city_id,region) values (532329,5323,'�䶨��');
insert into web_regions (region_id,city_id,region) values (532331,5323,'»����');
insert into web_regions (region_id,city_id,region) values (532501,5325,'������');
insert into web_regions (region_id,city_id,region) values (532502,5325,'��Զ��');
insert into web_regions (region_id,city_id,region) values (532503,5325,'������');
insert into web_regions (region_id,city_id,region) values (532504,5325,'������');
insert into web_regions (region_id,city_id,region) values (532523,5325,'��������������');
insert into web_regions (region_id,city_id,region) values (532524,5325,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (532525,5325,'ʯ����');
insert into web_regions (region_id,city_id,region) values (532527,5325,'������');
insert into web_regions (region_id,city_id,region) values (532528,5325,'Ԫ����');
insert into web_regions (region_id,city_id,region) values (532529,5325,'�����');
insert into web_regions (region_id,city_id,region) values (532530,5325,'��ƽ�����������������');
insert into web_regions (region_id,city_id,region) values (532531,5325,'�̴���');
insert into web_regions (region_id,city_id,region) values (532532,5325,'�ӿ�����������');
insert into web_regions (region_id,city_id,region) values (532601,5326,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (532622,5326,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (532623,5326,'������');
insert into web_regions (region_id,city_id,region) values (532624,5326,'��������');
insert into web_regions (region_id,city_id,region) values (532625,5326,'������');
insert into web_regions (region_id,city_id,region) values (532626,5326,'����');
insert into web_regions (region_id,city_id,region) values (532627,5326,'������');
insert into web_regions (region_id,city_id,region) values (532628,5326,'������');
insert into web_regions (region_id,city_id,region) values (532801,5328,'������');
insert into web_regions (region_id,city_id,region) values (532822,5328,'�º���');
insert into web_regions (region_id,city_id,region) values (532823,5328,'������');
insert into web_regions (region_id,city_id,region) values (532901,5329,'������');
insert into web_regions (region_id,city_id,region) values (532922,5329,'�������������');
insert into web_regions (region_id,city_id,region) values (532923,5329,'������');
insert into web_regions (region_id,city_id,region) values (532924,5329,'������');
insert into web_regions (region_id,city_id,region) values (532925,5329,'�ֶ���');
insert into web_regions (region_id,city_id,region) values (532926,5329,'�Ͻ�����������');
insert into web_regions (region_id,city_id,region) values (532927,5329,'Ρɽ�������������');
insert into web_regions (region_id,city_id,region) values (532928,5329,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (532929,5329,'������');
insert into web_regions (region_id,city_id,region) values (532930,5329,'��Դ��');
insert into web_regions (region_id,city_id,region) values (532931,5329,'������');
insert into web_regions (region_id,city_id,region) values (532932,5329,'������');
insert into web_regions (region_id,city_id,region) values (533102,5331,'������');
insert into web_regions (region_id,city_id,region) values (533103,5331,'â��');
insert into web_regions (region_id,city_id,region) values (533122,5331,'������');
insert into web_regions (region_id,city_id,region) values (533123,5331,'ӯ����');
insert into web_regions (region_id,city_id,region) values (533124,5331,'¤����');
insert into web_regions (region_id,city_id,region) values (533321,5333,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (533323,5333,'������');
insert into web_regions (region_id,city_id,region) values (533324,5333,'��ɽ������ŭ��������');
insert into web_regions (region_id,city_id,region) values (533325,5333,'��ƺ����������������');
insert into web_regions (region_id,city_id,region) values (533421,5334,'���������');
insert into web_regions (region_id,city_id,region) values (533422,5334,'������');
insert into web_regions (region_id,city_id,region) values (533423,5334,'ά��������������');
insert into web_regions (region_id,city_id,region) values (540102,5401,'�ǹ���');
insert into web_regions (region_id,city_id,region) values (540121,5401,'������');
insert into web_regions (region_id,city_id,region) values (540122,5401,'������');
insert into web_regions (region_id,city_id,region) values (540123,5401,'��ľ��');
insert into web_regions (region_id,city_id,region) values (540124,5401,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (540125,5401,'����������');
insert into web_regions (region_id,city_id,region) values (540126,5401,'������');
insert into web_regions (region_id,city_id,region) values (540127,5401,'ī�񹤿���');
insert into web_regions (region_id,city_id,region) values (540202,5402,'ɣ������');
insert into web_regions (region_id,city_id,region) values (540221,5402,'��ľ����');
insert into web_regions (region_id,city_id,region) values (540222,5402,'������');
insert into web_regions (region_id,city_id,region) values (540223,5402,'������');
insert into web_regions (region_id,city_id,region) values (540224,5402,'������');
insert into web_regions (region_id,city_id,region) values (540225,5402,'������');
insert into web_regions (region_id,city_id,region) values (540226,5402,'������');
insert into web_regions (region_id,city_id,region) values (540227,5402,'лͨ����');
insert into web_regions (region_id,city_id,region) values (540228,5402,'������');
insert into web_regions (region_id,city_id,region) values (540229,5402,'�ʲ���');
insert into web_regions (region_id,city_id,region) values (540230,5402,'������');
insert into web_regions (region_id,city_id,region) values (540231,5402,'������');
insert into web_regions (region_id,city_id,region) values (540232,5402,'�ٰ���');
insert into web_regions (region_id,city_id,region) values (540233,5402,'�Ƕ���');
insert into web_regions (region_id,city_id,region) values (540234,5402,'��¡��');
insert into web_regions (region_id,city_id,region) values (540235,5402,'����ľ��');
insert into web_regions (region_id,city_id,region) values (540236,5402,'������');
insert into web_regions (region_id,city_id,region) values (540237,5402,'�ڰ���');
insert into web_regions (region_id,city_id,region) values (540302,5403,'������');
insert into web_regions (region_id,city_id,region) values (540321,5403,'������');
insert into web_regions (region_id,city_id,region) values (540322,5403,'������');
insert into web_regions (region_id,city_id,region) values (540323,5403,'��������');
insert into web_regions (region_id,city_id,region) values (540324,5403,'������');
insert into web_regions (region_id,city_id,region) values (540325,5403,'������');
insert into web_regions (region_id,city_id,region) values (540326,5403,'������');
insert into web_regions (region_id,city_id,region) values (540327,5403,'����');
insert into web_regions (region_id,city_id,region) values (540328,5403,'â����');
insert into web_regions (region_id,city_id,region) values (540329,5403,'��¡��');
insert into web_regions (region_id,city_id,region) values (540330,5403,'�߰���');
insert into web_regions (region_id,city_id,region) values (542221,5422,'�˶���');
insert into web_regions (region_id,city_id,region) values (542222,5422,'������');
insert into web_regions (region_id,city_id,region) values (542223,5422,'������');
insert into web_regions (region_id,city_id,region) values (542224,5422,'ɣ����');
insert into web_regions (region_id,city_id,region) values (542225,5422,'������');
insert into web_regions (region_id,city_id,region) values (542226,5422,'������');
insert into web_regions (region_id,city_id,region) values (542227,5422,'������');
insert into web_regions (region_id,city_id,region) values (542228,5422,'������');
insert into web_regions (region_id,city_id,region) values (542229,5422,'�Ӳ���');
insert into web_regions (region_id,city_id,region) values (542231,5422,'¡����');
insert into web_regions (region_id,city_id,region) values (542232,5422,'������');
insert into web_regions (region_id,city_id,region) values (542233,5422,'�˿�����');
insert into web_regions (region_id,city_id,region) values (542421,5424,'������');
insert into web_regions (region_id,city_id,region) values (542422,5424,'������');
insert into web_regions (region_id,city_id,region) values (542423,5424,'������');
insert into web_regions (region_id,city_id,region) values (542424,5424,'������');
insert into web_regions (region_id,city_id,region) values (542425,5424,'������');
insert into web_regions (region_id,city_id,region) values (542426,5424,'������');
insert into web_regions (region_id,city_id,region) values (542427,5424,'����');
insert into web_regions (region_id,city_id,region) values (542428,5424,'�����');
insert into web_regions (region_id,city_id,region) values (542429,5424,'������');
insert into web_regions (region_id,city_id,region) values (542430,5424,'������');
insert into web_regions (region_id,city_id,region) values (542431,5424,'˫����');
insert into web_regions (region_id,city_id,region) values (542521,5425,'������');
insert into web_regions (region_id,city_id,region) values (542522,5425,'������');
insert into web_regions (region_id,city_id,region) values (542523,5425,'������');
insert into web_regions (region_id,city_id,region) values (542524,5425,'������');
insert into web_regions (region_id,city_id,region) values (542525,5425,'�Ｊ��');
insert into web_regions (region_id,city_id,region) values (542526,5425,'������');
insert into web_regions (region_id,city_id,region) values (542527,5425,'������');
insert into web_regions (region_id,city_id,region) values (542621,5426,'��֥��');
insert into web_regions (region_id,city_id,region) values (542622,5426,'����������');
insert into web_regions (region_id,city_id,region) values (542623,5426,'������');
insert into web_regions (region_id,city_id,region) values (542624,5426,'ī����');
insert into web_regions (region_id,city_id,region) values (542625,5426,'������');
insert into web_regions (region_id,city_id,region) values (542626,5426,'������');
insert into web_regions (region_id,city_id,region) values (542627,5426,'����');
insert into web_regions (region_id,city_id,region) values (610102,6101,'�³���');
insert into web_regions (region_id,city_id,region) values (610103,6101,'������');
insert into web_regions (region_id,city_id,region) values (610104,6101,'������');
insert into web_regions (region_id,city_id,region) values (610111,6101,'�����');
insert into web_regions (region_id,city_id,region) values (610112,6101,'δ����');
insert into web_regions (region_id,city_id,region) values (610113,6101,'������');
insert into web_regions (region_id,city_id,region) values (610114,6101,'������');
insert into web_regions (region_id,city_id,region) values (610115,6101,'������');
insert into web_regions (region_id,city_id,region) values (610116,6101,'������');
insert into web_regions (region_id,city_id,region) values (610122,6101,'������');
insert into web_regions (region_id,city_id,region) values (610124,6101,'������');
insert into web_regions (region_id,city_id,region) values (610125,6101,'����');
insert into web_regions (region_id,city_id,region) values (610126,6101,'������');
insert into web_regions (region_id,city_id,region) values (610202,6102,'������');
insert into web_regions (region_id,city_id,region) values (610203,6102,'ӡ̨��');
insert into web_regions (region_id,city_id,region) values (610204,6102,'ҫ����');
insert into web_regions (region_id,city_id,region) values (610222,6102,'�˾���');
insert into web_regions (region_id,city_id,region) values (610302,6103,'μ����');
insert into web_regions (region_id,city_id,region) values (610303,6103,'��̨��');
insert into web_regions (region_id,city_id,region) values (610304,6103,'�²���');
insert into web_regions (region_id,city_id,region) values (610322,6103,'������');
insert into web_regions (region_id,city_id,region) values (610323,6103,'�ɽ��');
insert into web_regions (region_id,city_id,region) values (610324,6103,'������');
insert into web_regions (region_id,city_id,region) values (610326,6103,'ü��');
insert into web_regions (region_id,city_id,region) values (610327,6103,'¤��');
insert into web_regions (region_id,city_id,region) values (610328,6103,'ǧ����');
insert into web_regions (region_id,city_id,region) values (610329,6103,'������');
insert into web_regions (region_id,city_id,region) values (610330,6103,'����');
insert into web_regions (region_id,city_id,region) values (610331,6103,'̫����');
insert into web_regions (region_id,city_id,region) values (610402,6104,'�ض���');
insert into web_regions (region_id,city_id,region) values (610403,6104,'������');
insert into web_regions (region_id,city_id,region) values (610404,6104,'μ����');
insert into web_regions (region_id,city_id,region) values (610422,6104,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (610423,6104,'������');
insert into web_regions (region_id,city_id,region) values (610424,6104,'Ǭ��');
insert into web_regions (region_id,city_id,region) values (610425,6104,'��Ȫ��');
insert into web_regions (region_id,city_id,region) values (610426,6104,'������');
insert into web_regions (region_id,city_id,region) values (610427,6104,'����');
insert into web_regions (region_id,city_id,region) values (610428,6104,'������');
insert into web_regions (region_id,city_id,region) values (610429,6104,'Ѯ����');
insert into web_regions (region_id,city_id,region) values (610430,6104,'������');
insert into web_regions (region_id,city_id,region) values (610431,6104,'�书��');
insert into web_regions (region_id,city_id,region) values (610481,6104,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (610502,6105,'��μ��');
insert into web_regions (region_id,city_id,region) values (610521,6105,'����');
insert into web_regions (region_id,city_id,region) values (610522,6105,'������');
insert into web_regions (region_id,city_id,region) values (610523,6105,'������');
insert into web_regions (region_id,city_id,region) values (610524,6105,'������');
insert into web_regions (region_id,city_id,region) values (610525,6105,'�γ���');
insert into web_regions (region_id,city_id,region) values (610526,6105,'�ѳ���');
insert into web_regions (region_id,city_id,region) values (610527,6105,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (610528,6105,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (610581,6105,'������');
insert into web_regions (region_id,city_id,region) values (610582,6105,'������');
insert into web_regions (region_id,city_id,region) values (610602,6106,'������');
insert into web_regions (region_id,city_id,region) values (610621,6106,'�ӳ���');
insert into web_regions (region_id,city_id,region) values (610622,6106,'�Ӵ���');
insert into web_regions (region_id,city_id,region) values (610623,6106,'�ӳ���');
insert into web_regions (region_id,city_id,region) values (610624,6106,'������');
insert into web_regions (region_id,city_id,region) values (610625,6106,'־����');
insert into web_regions (region_id,city_id,region) values (610626,6106,'������');
insert into web_regions (region_id,city_id,region) values (610627,6106,'��Ȫ��');
insert into web_regions (region_id,city_id,region) values (610628,6106,'����');
insert into web_regions (region_id,city_id,region) values (610629,6106,'�崨��');
insert into web_regions (region_id,city_id,region) values (610630,6106,'�˴���');
insert into web_regions (region_id,city_id,region) values (610631,6106,'������');
insert into web_regions (region_id,city_id,region) values (610632,6106,'������');
insert into web_regions (region_id,city_id,region) values (610702,6107,'��̨��');
insert into web_regions (region_id,city_id,region) values (610721,6107,'��֣��');
insert into web_regions (region_id,city_id,region) values (610722,6107,'�ǹ���');
insert into web_regions (region_id,city_id,region) values (610723,6107,'����');
insert into web_regions (region_id,city_id,region) values (610724,6107,'������');
insert into web_regions (region_id,city_id,region) values (610725,6107,'����');
insert into web_regions (region_id,city_id,region) values (610726,6107,'��ǿ��');
insert into web_regions (region_id,city_id,region) values (610727,6107,'������');
insert into web_regions (region_id,city_id,region) values (610728,6107,'�����');
insert into web_regions (region_id,city_id,region) values (610729,6107,'������');
insert into web_regions (region_id,city_id,region) values (610730,6107,'��ƺ��');
insert into web_regions (region_id,city_id,region) values (610802,6108,'������');
insert into web_regions (region_id,city_id,region) values (610821,6108,'��ľ��');
insert into web_regions (region_id,city_id,region) values (610822,6108,'������');
insert into web_regions (region_id,city_id,region) values (610823,6108,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (610824,6108,'������');
insert into web_regions (region_id,city_id,region) values (610825,6108,'������');
insert into web_regions (region_id,city_id,region) values (610826,6108,'�����');
insert into web_regions (region_id,city_id,region) values (610827,6108,'��֬��');
insert into web_regions (region_id,city_id,region) values (610828,6108,'����');
insert into web_regions (region_id,city_id,region) values (610829,6108,'�Ɽ��');
insert into web_regions (region_id,city_id,region) values (610830,6108,'�彧��');
insert into web_regions (region_id,city_id,region) values (610831,6108,'������');
insert into web_regions (region_id,city_id,region) values (610902,6109,'������');
insert into web_regions (region_id,city_id,region) values (610921,6109,'������');
insert into web_regions (region_id,city_id,region) values (610922,6109,'ʯȪ��');
insert into web_regions (region_id,city_id,region) values (610923,6109,'������');
insert into web_regions (region_id,city_id,region) values (610924,6109,'������');
insert into web_regions (region_id,city_id,region) values (610925,6109,'᰸���');
insert into web_regions (region_id,city_id,region) values (610926,6109,'ƽ����');
insert into web_regions (region_id,city_id,region) values (610927,6109,'��ƺ��');
insert into web_regions (region_id,city_id,region) values (610928,6109,'Ѯ����');
insert into web_regions (region_id,city_id,region) values (610929,6109,'�׺���');
insert into web_regions (region_id,city_id,region) values (611002,6110,'������');
insert into web_regions (region_id,city_id,region) values (611021,6110,'������');
insert into web_regions (region_id,city_id,region) values (611022,6110,'������');
insert into web_regions (region_id,city_id,region) values (611023,6110,'������');
insert into web_regions (region_id,city_id,region) values (611024,6110,'ɽ����');
insert into web_regions (region_id,city_id,region) values (611025,6110,'����');
insert into web_regions (region_id,city_id,region) values (611026,6110,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (611101,6111,'�ո��³�');
insert into web_regions (region_id,city_id,region) values (611102,6111,'�㶫�³�');
insert into web_regions (region_id,city_id,region) values (611103,6111,'�غ��³�');
insert into web_regions (region_id,city_id,region) values (611104,6111,'�����³�');
insert into web_regions (region_id,city_id,region) values (611105,6111,'�����³�');
insert into web_regions (region_id,city_id,region) values (620102,6201,'�ǹ���');
insert into web_regions (region_id,city_id,region) values (620103,6201,'�������');
insert into web_regions (region_id,city_id,region) values (620104,6201,'������');
insert into web_regions (region_id,city_id,region) values (620105,6201,'������');
insert into web_regions (region_id,city_id,region) values (620111,6201,'�����');
insert into web_regions (region_id,city_id,region) values (620121,6201,'������');
insert into web_regions (region_id,city_id,region) values (620122,6201,'������');
insert into web_regions (region_id,city_id,region) values (620123,6201,'������');
insert into web_regions (region_id,city_id,region) values (620201,6202,'�۹���');
insert into web_regions (region_id,city_id,region) values (620202,6202,'������');
insert into web_regions (region_id,city_id,region) values (620203,6202,'������');
insert into web_regions (region_id,city_id,region) values (620302,6203,'����');
insert into web_regions (region_id,city_id,region) values (620321,6203,'������');
insert into web_regions (region_id,city_id,region) values (620402,6204,'������');
insert into web_regions (region_id,city_id,region) values (620403,6204,'ƽ����');
insert into web_regions (region_id,city_id,region) values (620421,6204,'��Զ��');
insert into web_regions (region_id,city_id,region) values (620422,6204,'������');
insert into web_regions (region_id,city_id,region) values (620423,6204,'��̩��');
insert into web_regions (region_id,city_id,region) values (620502,6205,'������');
insert into web_regions (region_id,city_id,region) values (620503,6205,'�����');
insert into web_regions (region_id,city_id,region) values (620521,6205,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (620522,6205,'�ذ���');
insert into web_regions (region_id,city_id,region) values (620523,6205,'�ʹ���');
insert into web_regions (region_id,city_id,region) values (620524,6205,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (620525,6205,'�żҴ�����������');
insert into web_regions (region_id,city_id,region) values (620602,6206,'������');
insert into web_regions (region_id,city_id,region) values (620621,6206,'������');
insert into web_regions (region_id,city_id,region) values (620622,6206,'������');
insert into web_regions (region_id,city_id,region) values (620623,6206,'��ף����������');
insert into web_regions (region_id,city_id,region) values (620702,6207,'������');
insert into web_regions (region_id,city_id,region) values (620721,6207,'����ԣ����������');
insert into web_regions (region_id,city_id,region) values (620722,6207,'������');
insert into web_regions (region_id,city_id,region) values (620723,6207,'������');
insert into web_regions (region_id,city_id,region) values (620724,6207,'��̨��');
insert into web_regions (region_id,city_id,region) values (620725,6207,'ɽ����');
insert into web_regions (region_id,city_id,region) values (620802,6208,'�����');
insert into web_regions (region_id,city_id,region) values (620821,6208,'������');
insert into web_regions (region_id,city_id,region) values (620822,6208,'��̨��');
insert into web_regions (region_id,city_id,region) values (620823,6208,'������');
insert into web_regions (region_id,city_id,region) values (620824,6208,'��ͤ��');
insert into web_regions (region_id,city_id,region) values (620825,6208,'ׯ����');
insert into web_regions (region_id,city_id,region) values (620826,6208,'������');
insert into web_regions (region_id,city_id,region) values (620902,6209,'������');
insert into web_regions (region_id,city_id,region) values (620921,6209,'������');
insert into web_regions (region_id,city_id,region) values (620922,6209,'������');
insert into web_regions (region_id,city_id,region) values (620923,6209,'�౱�ɹ���������');
insert into web_regions (region_id,city_id,region) values (620924,6209,'��������������������');
insert into web_regions (region_id,city_id,region) values (620981,6209,'������');
insert into web_regions (region_id,city_id,region) values (620982,6209,'�ػ���');
insert into web_regions (region_id,city_id,region) values (621002,6210,'������');
insert into web_regions (region_id,city_id,region) values (621021,6210,'�����');
insert into web_regions (region_id,city_id,region) values (621022,6210,'����');
insert into web_regions (region_id,city_id,region) values (621023,6210,'������');
insert into web_regions (region_id,city_id,region) values (621024,6210,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (621025,6210,'������');
insert into web_regions (region_id,city_id,region) values (621026,6210,'����');
insert into web_regions (region_id,city_id,region) values (621027,6210,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (621102,6211,'������');
insert into web_regions (region_id,city_id,region) values (621121,6211,'ͨμ��');
insert into web_regions (region_id,city_id,region) values (621122,6211,'¤����');
insert into web_regions (region_id,city_id,region) values (621123,6211,'μԴ��');
insert into web_regions (region_id,city_id,region) values (621124,6211,'�����');
insert into web_regions (region_id,city_id,region) values (621125,6211,'����');
insert into web_regions (region_id,city_id,region) values (621126,6211,'���');
insert into web_regions (region_id,city_id,region) values (621202,6212,'�䶼��');
insert into web_regions (region_id,city_id,region) values (621221,6212,'����');
insert into web_regions (region_id,city_id,region) values (621222,6212,'����');
insert into web_regions (region_id,city_id,region) values (621223,6212,'崲���');
insert into web_regions (region_id,city_id,region) values (621224,6212,'����');
insert into web_regions (region_id,city_id,region) values (621225,6212,'������');
insert into web_regions (region_id,city_id,region) values (621226,6212,'����');
insert into web_regions (region_id,city_id,region) values (621227,6212,'����');
insert into web_regions (region_id,city_id,region) values (621228,6212,'������');
insert into web_regions (region_id,city_id,region) values (622901,6229,'������');
insert into web_regions (region_id,city_id,region) values (622921,6229,'������');
insert into web_regions (region_id,city_id,region) values (622922,6229,'������');
insert into web_regions (region_id,city_id,region) values (622923,6229,'������');
insert into web_regions (region_id,city_id,region) values (622924,6229,'�����');
insert into web_regions (region_id,city_id,region) values (622925,6229,'������');
insert into web_regions (region_id,city_id,region) values (622926,6229,'������������');
insert into web_regions (region_id,city_id,region) values (622927,6229,'��ʯɽ�����嶫����������������');
insert into web_regions (region_id,city_id,region) values (623001,6230,'������');
insert into web_regions (region_id,city_id,region) values (623021,6230,'��̶��');
insert into web_regions (region_id,city_id,region) values (623022,6230,'׿����');
insert into web_regions (region_id,city_id,region) values (623023,6230,'������');
insert into web_regions (region_id,city_id,region) values (623024,6230,'������');
insert into web_regions (region_id,city_id,region) values (623025,6230,'������');
insert into web_regions (region_id,city_id,region) values (623026,6230,'µ����');
insert into web_regions (region_id,city_id,region) values (623027,6230,'�ĺ���');
insert into web_regions (region_id,city_id,region) values (630102,6301,'�Ƕ���');
insert into web_regions (region_id,city_id,region) values (630103,6301,'������');
insert into web_regions (region_id,city_id,region) values (630104,6301,'������');
insert into web_regions (region_id,city_id,region) values (630105,6301,'�Ǳ���');
insert into web_regions (region_id,city_id,region) values (630121,6301,'��ͨ��������������');
insert into web_regions (region_id,city_id,region) values (630122,6301,'������');
insert into web_regions (region_id,city_id,region) values (630123,6301,'��Դ��');
insert into web_regions (region_id,city_id,region) values (630202,6302,'�ֶ���');
insert into web_regions (region_id,city_id,region) values (630221,6302,'ƽ����');
insert into web_regions (region_id,city_id,region) values (630222,6302,'��ͻ�������������');
insert into web_regions (region_id,city_id,region) values (630223,6302,'��������������');
insert into web_regions (region_id,city_id,region) values (630224,6302,'��¡����������');
insert into web_regions (region_id,city_id,region) values (630225,6302,'ѭ��������������');
insert into web_regions (region_id,city_id,region) values (632221,6322,'��Դ����������');
insert into web_regions (region_id,city_id,region) values (632222,6322,'������');
insert into web_regions (region_id,city_id,region) values (632223,6322,'������');
insert into web_regions (region_id,city_id,region) values (632224,6322,'�ղ���');
insert into web_regions (region_id,city_id,region) values (632321,6323,'ͬ����');
insert into web_regions (region_id,city_id,region) values (632322,6323,'������');
insert into web_regions (region_id,city_id,region) values (632323,6323,'�����');
insert into web_regions (region_id,city_id,region) values (632324,6323,'�����ɹ���������');
insert into web_regions (region_id,city_id,region) values (632521,6325,'������');
insert into web_regions (region_id,city_id,region) values (632522,6325,'ͬ����');
insert into web_regions (region_id,city_id,region) values (632523,6325,'�����');
insert into web_regions (region_id,city_id,region) values (632524,6325,'�˺���');
insert into web_regions (region_id,city_id,region) values (632525,6325,'������');
insert into web_regions (region_id,city_id,region) values (632621,6326,'������');
insert into web_regions (region_id,city_id,region) values (632622,6326,'������');
insert into web_regions (region_id,city_id,region) values (632623,6326,'�ʵ���');
insert into web_regions (region_id,city_id,region) values (632624,6326,'������');
insert into web_regions (region_id,city_id,region) values (632625,6326,'������');
insert into web_regions (region_id,city_id,region) values (632626,6326,'�����');
insert into web_regions (region_id,city_id,region) values (632701,6327,'������');
insert into web_regions (region_id,city_id,region) values (632722,6327,'�Ӷ���');
insert into web_regions (region_id,city_id,region) values (632723,6327,'�ƶ���');
insert into web_regions (region_id,city_id,region) values (632724,6327,'�ζ���');
insert into web_regions (region_id,city_id,region) values (632725,6327,'��ǫ��');
insert into web_regions (region_id,city_id,region) values (632726,6327,'��������');
insert into web_regions (region_id,city_id,region) values (632801,6328,'���ľ��');
insert into web_regions (region_id,city_id,region) values (632802,6328,'�������');
insert into web_regions (region_id,city_id,region) values (632821,6328,'������');
insert into web_regions (region_id,city_id,region) values (632822,6328,'������');
insert into web_regions (region_id,city_id,region) values (632823,6328,'�����');
insert into web_regions (region_id,city_id,region) values (640104,6401,'������');
insert into web_regions (region_id,city_id,region) values (640105,6401,'������');
insert into web_regions (region_id,city_id,region) values (640106,6401,'�����');
insert into web_regions (region_id,city_id,region) values (640121,6401,'������');
insert into web_regions (region_id,city_id,region) values (640122,6401,'������');
insert into web_regions (region_id,city_id,region) values (640181,6401,'������');
insert into web_regions (region_id,city_id,region) values (640202,6402,'�������');
insert into web_regions (region_id,city_id,region) values (640205,6402,'��ũ��');
insert into web_regions (region_id,city_id,region) values (640221,6402,'ƽ����');
insert into web_regions (region_id,city_id,region) values (640302,6403,'��ͨ��');
insert into web_regions (region_id,city_id,region) values (640303,6403,'���±���');
insert into web_regions (region_id,city_id,region) values (640323,6403,'�γ���');
insert into web_regions (region_id,city_id,region) values (640324,6403,'ͬ����');
insert into web_regions (region_id,city_id,region) values (640381,6403,'��ͭϿ��');
insert into web_regions (region_id,city_id,region) values (640402,6404,'ԭ����');
insert into web_regions (region_id,city_id,region) values (640422,6404,'������');
insert into web_regions (region_id,city_id,region) values (640423,6404,'¡����');
insert into web_regions (region_id,city_id,region) values (640424,6404,'��Դ��');
insert into web_regions (region_id,city_id,region) values (640425,6404,'������');
insert into web_regions (region_id,city_id,region) values (640502,6405,'ɳ��ͷ��');
insert into web_regions (region_id,city_id,region) values (640521,6405,'������');
insert into web_regions (region_id,city_id,region) values (640522,6405,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (650102,6501,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (650103,6501,'ɳ���Ϳ���');
insert into web_regions (region_id,city_id,region) values (650104,6501,'������');
insert into web_regions (region_id,city_id,region) values (650105,6501,'ˮĥ����');
insert into web_regions (region_id,city_id,region) values (650106,6501,'ͷ�ͺ���');
insert into web_regions (region_id,city_id,region) values (650107,6501,'�������');
insert into web_regions (region_id,city_id,region) values (650109,6501,'�׶���');
insert into web_regions (region_id,city_id,region) values (650121,6501,'��³ľ����');
insert into web_regions (region_id,city_id,region) values (650202,6502,'��ɽ����');
insert into web_regions (region_id,city_id,region) values (650203,6502,'����������');
insert into web_regions (region_id,city_id,region) values (650204,6502,'�׼�̲��');
insert into web_regions (region_id,city_id,region) values (650205,6502,'�ڶ�����');
insert into web_regions (region_id,city_id,region) values (652101,6521,'��³����');
insert into web_regions (region_id,city_id,region) values (652122,6521,'۷����');
insert into web_regions (region_id,city_id,region) values (652123,6521,'�п�ѷ��');
insert into web_regions (region_id,city_id,region) values (652201,6522,'������');
insert into web_regions (region_id,city_id,region) values (652222,6522,'������������������');
insert into web_regions (region_id,city_id,region) values (652223,6522,'������');
insert into web_regions (region_id,city_id,region) values (652301,6523,'������');
insert into web_regions (region_id,city_id,region) values (652302,6523,'������');
insert into web_regions (region_id,city_id,region) values (652323,6523,'��ͼ����');
insert into web_regions (region_id,city_id,region) values (652324,6523,'����˹��');
insert into web_regions (region_id,city_id,region) values (652325,6523,'��̨��');
insert into web_regions (region_id,city_id,region) values (652327,6523,'��ľ������');
insert into web_regions (region_id,city_id,region) values (652328,6523,'ľ�ݹ�����������');
insert into web_regions (region_id,city_id,region) values (652701,6527,'������');
insert into web_regions (region_id,city_id,region) values (652702,6527,'����ɽ����');
insert into web_regions (region_id,city_id,region) values (652722,6527,'������');
insert into web_regions (region_id,city_id,region) values (652723,6527,'��Ȫ��');
insert into web_regions (region_id,city_id,region) values (652801,6528,'�������');
insert into web_regions (region_id,city_id,region) values (652822,6528,'��̨��');
insert into web_regions (region_id,city_id,region) values (652823,6528,'ξ����');
insert into web_regions (region_id,city_id,region) values (652824,6528,'��Ǽ��');
insert into web_regions (region_id,city_id,region) values (652825,6528,'��ĩ��');
insert into web_regions (region_id,city_id,region) values (652826,6528,'���Ȼ���������');
insert into web_regions (region_id,city_id,region) values (652827,6528,'�;���');
insert into web_regions (region_id,city_id,region) values (652828,6528,'��˶��');
insert into web_regions (region_id,city_id,region) values (652829,6528,'������');
insert into web_regions (region_id,city_id,region) values (652901,6529,'��������');
insert into web_regions (region_id,city_id,region) values (652922,6529,'������');
insert into web_regions (region_id,city_id,region) values (652923,6529,'�⳵��');
insert into web_regions (region_id,city_id,region) values (652924,6529,'ɳ����');
insert into web_regions (region_id,city_id,region) values (652925,6529,'�º���');
insert into web_regions (region_id,city_id,region) values (652926,6529,'�ݳ���');
insert into web_regions (region_id,city_id,region) values (652927,6529,'��ʲ��');
insert into web_regions (region_id,city_id,region) values (652928,6529,'��������');
insert into web_regions (region_id,city_id,region) values (652929,6529,'��ƺ��');
insert into web_regions (region_id,city_id,region) values (653001,6530,'��ͼʲ��');
insert into web_regions (region_id,city_id,region) values (653022,6530,'��������');
insert into web_regions (region_id,city_id,region) values (653023,6530,'��������');
insert into web_regions (region_id,city_id,region) values (653024,6530,'��ǡ��');
insert into web_regions (region_id,city_id,region) values (653101,6531,'��ʲ��');
insert into web_regions (region_id,city_id,region) values (653121,6531,'�踽��');
insert into web_regions (region_id,city_id,region) values (653122,6531,'������');
insert into web_regions (region_id,city_id,region) values (653123,6531,'Ӣ��ɳ��');
insert into web_regions (region_id,city_id,region) values (653124,6531,'������');
insert into web_regions (region_id,city_id,region) values (653125,6531,'ɯ����');
insert into web_regions (region_id,city_id,region) values (653126,6531,'Ҷ����');
insert into web_regions (region_id,city_id,region) values (653127,6531,'�������');
insert into web_regions (region_id,city_id,region) values (653128,6531,'���պ���');
insert into web_regions (region_id,city_id,region) values (653129,6531,'٤ʦ��');
insert into web_regions (region_id,city_id,region) values (653130,6531,'�ͳ���');
insert into web_regions (region_id,city_id,region) values (653131,6531,'��ʲ�����������������');
insert into web_regions (region_id,city_id,region) values (653201,6532,'������');
insert into web_regions (region_id,city_id,region) values (653221,6532,'������');
insert into web_regions (region_id,city_id,region) values (653222,6532,'ī����');
insert into web_regions (region_id,city_id,region) values (653223,6532,'Ƥɽ��');
insert into web_regions (region_id,city_id,region) values (653224,6532,'������');
insert into web_regions (region_id,city_id,region) values (653225,6532,'������');
insert into web_regions (region_id,city_id,region) values (653226,6532,'������');
insert into web_regions (region_id,city_id,region) values (653227,6532,'�����');
insert into web_regions (region_id,city_id,region) values (654002,6540,'������');
insert into web_regions (region_id,city_id,region) values (654003,6540,'������');
insert into web_regions (region_id,city_id,region) values (654004,6540,'������˹��');
insert into web_regions (region_id,city_id,region) values (654021,6540,'������');
insert into web_regions (region_id,city_id,region) values (654022,6540,'�첼�������������');
insert into web_regions (region_id,city_id,region) values (654023,6540,'������');
insert into web_regions (region_id,city_id,region) values (654024,6540,'������');
insert into web_regions (region_id,city_id,region) values (654025,6540,'��Դ��');
insert into web_regions (region_id,city_id,region) values (654026,6540,'������');
insert into web_regions (region_id,city_id,region) values (654027,6540,'�ؿ�˹��');
insert into web_regions (region_id,city_id,region) values (654028,6540,'���տ���');
insert into web_regions (region_id,city_id,region) values (654201,6542,'������');
insert into web_regions (region_id,city_id,region) values (654202,6542,'������');
insert into web_regions (region_id,city_id,region) values (654221,6542,'������');
insert into web_regions (region_id,city_id,region) values (654223,6542,'ɳ����');
insert into web_regions (region_id,city_id,region) values (654224,6542,'������');
insert into web_regions (region_id,city_id,region) values (654225,6542,'ԣ����');
insert into web_regions (region_id,city_id,region) values (654226,6542,'�Ͳ��������ɹ�������');
insert into web_regions (region_id,city_id,region) values (654301,6543,'����̩��');
insert into web_regions (region_id,city_id,region) values (654321,6543,'��������');
insert into web_regions (region_id,city_id,region) values (654322,6543,'������');
insert into web_regions (region_id,city_id,region) values (654323,6543,'������');
insert into web_regions (region_id,city_id,region) values (654324,6543,'���ͺ���');
insert into web_regions (region_id,city_id,region) values (654325,6543,'�����');
insert into web_regions (region_id,city_id,region) values (654326,6543,'��ľ����');
insert into web_regions (region_id,city_id,region) values (659001,6590,'ʯ������');
insert into web_regions (region_id,city_id,region) values (659002,6590,'��������');
insert into web_regions (region_id,city_id,region) values (659003,6590,'ͼľ�����');
insert into web_regions (region_id,city_id,region) values (659004,6590,'�������');
insert into web_regions (region_id,city_id,region) values (659005,6590,'������');
insert into web_regions (region_id,city_id,region) values (659006,6590,'���Ź���');
insert into web_regions (region_id,city_id,region) values (659007,6590,'˫����');
insert into web_regions (region_id,city_id,region) values (710101,7101,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (710102,7101,'������');
insert into web_regions (region_id,city_id,region) values (710103,7101,'����');
insert into web_regions (region_id,city_id,region) values (710104,7101,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (710105,7101,'������');
insert into web_regions (region_id,city_id,region) values (710106,7101,'��ͬ��');
insert into web_regions (region_id,city_id,region) values (710107,7101,'����');
insert into web_regions (region_id,city_id,region) values (710108,7101,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (710109,7101,'�ϸ���');
insert into web_regions (region_id,city_id,region) values (710110,7101,'�ں���');
insert into web_regions (region_id,city_id,region) values (710111,7101,'ʿ����');
insert into web_regions (region_id,city_id,region) values (710112,7101,'��Ͷ��');
insert into web_regions (region_id,city_id,region) values (710201,7102,'������');
insert into web_regions (region_id,city_id,region) values (710202,7102,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (710203,7102,'��Ӫ��');
insert into web_regions (region_id,city_id,region) values (710204,7102,'�����');
insert into web_regions (region_id,city_id,region) values (710205,7102,'������');
insert into web_regions (region_id,city_id,region) values (710206,7102,'������');
insert into web_regions (region_id,city_id,region) values (710207,7102,'ǰ����');
insert into web_regions (region_id,city_id,region) values (710208,7102,'������');
insert into web_regions (region_id,city_id,region) values (710209,7102,'ǰ����');
insert into web_regions (region_id,city_id,region) values (710210,7102,'�����');
insert into web_regions (region_id,city_id,region) values (710211,7102,'С����');
insert into web_regions (region_id,city_id,region) values (710212,7102,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (710213,7102,'��԰��');
insert into web_regions (region_id,city_id,region) values (710214,7102,'�����');
insert into web_regions (region_id,city_id,region) values (710215,7102,'������');
insert into web_regions (region_id,city_id,region) values (710216,7102,'������');
insert into web_regions (region_id,city_id,region) values (710217,7102,'������');
insert into web_regions (region_id,city_id,region) values (710218,7102,'������');
insert into web_regions (region_id,city_id,region) values (710219,7102,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (710220,7102,'��ͷ��');
insert into web_regions (region_id,city_id,region) values (710221,7102,'�ೲ��');
insert into web_regions (region_id,city_id,region) values (710222,7102,'�����');
insert into web_regions (region_id,city_id,region) values (710223,7102,'������');
insert into web_regions (region_id,city_id,region) values (710224,7102,'·����');
insert into web_regions (region_id,city_id,region) values (710225,7102,'������');
insert into web_regions (region_id,city_id,region) values (710226,7102,'���b��');
insert into web_regions (region_id,city_id,region) values (710227,7102,'������');
insert into web_regions (region_id,city_id,region) values (710228,7102,'������');
insert into web_regions (region_id,city_id,region) values (710229,7102,'������');
insert into web_regions (region_id,city_id,region) values (710230,7102,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (710231,7102,'��Ũ��');
insert into web_regions (region_id,city_id,region) values (710232,7102,'������');
insert into web_regions (region_id,city_id,region) values (710233,7102,'������');
insert into web_regions (region_id,city_id,region) values (710234,7102,'ɼ����');
insert into web_regions (region_id,city_id,region) values (710235,7102,'������');
insert into web_regions (region_id,city_id,region) values (710236,7102,'ï����');
insert into web_regions (region_id,city_id,region) values (710237,7102,'��Դ��');
insert into web_regions (region_id,city_id,region) values (710238,7102,'��������');
insert into web_regions (region_id,city_id,region) values (710301,7103,'������');
insert into web_regions (region_id,city_id,region) values (710302,7103,'�߶���');
insert into web_regions (region_id,city_id,region) values (710303,7103,'ůů��');
insert into web_regions (region_id,city_id,region) values (710304,7103,'�ʰ���');
insert into web_regions (region_id,city_id,region) values (710305,7103,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (710306,7103,'������');
insert into web_regions (region_id,city_id,region) values (710307,7103,'������');
insert into web_regions (region_id,city_id,region) values (710401,7104,'����');
insert into web_regions (region_id,city_id,region) values (710402,7104,'����');
insert into web_regions (region_id,city_id,region) values (710403,7104,'����');
insert into web_regions (region_id,city_id,region) values (710404,7104,'����');
insert into web_regions (region_id,city_id,region) values (710405,7104,'����');
insert into web_regions (region_id,city_id,region) values (710406,7104,'������');
insert into web_regions (region_id,city_id,region) values (710407,7104,'������');
insert into web_regions (region_id,city_id,region) values (710408,7104,'������');
insert into web_regions (region_id,city_id,region) values (710409,7104,'��ԭ��');
insert into web_regions (region_id,city_id,region) values (710410,7104,'������');
insert into web_regions (region_id,city_id,region) values (710411,7104,'�����');
insert into web_regions (region_id,city_id,region) values (710412,7104,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (710413,7104,'ɳ¹��');
insert into web_regions (region_id,city_id,region) values (710414,7104,'������');
insert into web_regions (region_id,city_id,region) values (710415,7104,'������');
insert into web_regions (region_id,city_id,region) values (710416,7104,'�����');
insert into web_regions (region_id,city_id,region) values (710417,7104,'̶����');
insert into web_regions (region_id,city_id,region) values (710418,7104,'������');
insert into web_regions (region_id,city_id,region) values (710419,7104,'������');
insert into web_regions (region_id,city_id,region) values (710420,7104,'ʯ����');
insert into web_regions (region_id,city_id,region) values (710421,7104,'������');
insert into web_regions (region_id,city_id,region) values (710422,7104,'����');
insert into web_regions (region_id,city_id,region) values (710423,7104,'������');
insert into web_regions (region_id,city_id,region) values (710424,7104,'�����');
insert into web_regions (region_id,city_id,region) values (710425,7104,'������');
insert into web_regions (region_id,city_id,region) values (710426,7104,'������');
insert into web_regions (region_id,city_id,region) values (710427,7104,'̫ƽ��');
insert into web_regions (region_id,city_id,region) values (710428,7104,'������');
insert into web_regions (region_id,city_id,region) values (710429,7104,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (710501,7105,'����');
insert into web_regions (region_id,city_id,region) values (710502,7105,'����');
insert into web_regions (region_id,city_id,region) values (710504,7105,'����');
insert into web_regions (region_id,city_id,region) values (710506,7105,'������');
insert into web_regions (region_id,city_id,region) values (710507,7105,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (710508,7105,'������');
insert into web_regions (region_id,city_id,region) values (710509,7105,'��Ӫ��');
insert into web_regions (region_id,city_id,region) values (710510,7105,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (710511,7105,'�׺���');
insert into web_regions (region_id,city_id,region) values (710512,7105,'��Ӫ��');
insert into web_regions (region_id,city_id,region) values (710513,7105,'�����');
insert into web_regions (region_id,city_id,region) values (710514,7105,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (710515,7105,'�鶹��');
insert into web_regions (region_id,city_id,region) values (710516,7105,'��Ӫ��');
insert into web_regions (region_id,city_id,region) values (710517,7105,'������');
insert into web_regions (region_id,city_id,region) values (710518,7105,'������');
insert into web_regions (region_id,city_id,region) values (710519,7105,'������');
insert into web_regions (region_id,city_id,region) values (710520,7105,'������');
insert into web_regions (region_id,city_id,region) values (710521,7105,'ѧ����');
insert into web_regions (region_id,city_id,region) values (710522,7105,'������');
insert into web_regions (region_id,city_id,region) values (710523,7105,'�߹���');
insert into web_regions (region_id,city_id,region) values (710524,7105,'������');
insert into web_regions (region_id,city_id,region) values (710525,7105,'������');
insert into web_regions (region_id,city_id,region) values (710526,7105,'�»���');
insert into web_regions (region_id,city_id,region) values (710527,7105,'�ƻ���');
insert into web_regions (region_id,city_id,region) values (710528,7105,'������');
insert into web_regions (region_id,city_id,region) values (710529,7105,'������');
insert into web_regions (region_id,city_id,region) values (710530,7105,'ɽ����');
insert into web_regions (region_id,city_id,region) values (710531,7105,'����');
insert into web_regions (region_id,city_id,region) values (710532,7105,'�����');
insert into web_regions (region_id,city_id,region) values (710533,7105,'�ϻ���');
insert into web_regions (region_id,city_id,region) values (710534,7105,'������');
insert into web_regions (region_id,city_id,region) values (710535,7105,'�ʵ���');
insert into web_regions (region_id,city_id,region) values (710536,7105,'������');
insert into web_regions (region_id,city_id,region) values (710537,7105,'������');
insert into web_regions (region_id,city_id,region) values (710538,7105,'������');
insert into web_regions (region_id,city_id,region) values (710539,7105,'������');
insert into web_regions (region_id,city_id,region) values (710601,7106,'����');
insert into web_regions (region_id,city_id,region) values (710602,7106,'����');
insert into web_regions (region_id,city_id,region) values (710603,7106,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (710701,7107,'����');
insert into web_regions (region_id,city_id,region) values (710702,7107,'����');
insert into web_regions (region_id,city_id,region) values (710801,7108,'������');
insert into web_regions (region_id,city_id,region) values (710802,7108,'������');
insert into web_regions (region_id,city_id,region) values (710803,7108,'�к���');
insert into web_regions (region_id,city_id,region) values (710804,7108,'������');
insert into web_regions (region_id,city_id,region) values (710805,7108,'��ׯ��');
insert into web_regions (region_id,city_id,region) values (710806,7108,'�µ���');
insert into web_regions (region_id,city_id,region) values (710807,7108,'������');
insert into web_regions (region_id,city_id,region) values (710808,7108,'ݺ����');
insert into web_regions (region_id,city_id,region) values (710809,7108,'��Ͽ��');
insert into web_regions (region_id,city_id,region) values (710810,7108,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (710811,7108,'ϫֹ��');
insert into web_regions (region_id,city_id,region) values (710812,7108,'����');
insert into web_regions (region_id,city_id,region) values (710813,7108,'������');
insert into web_regions (region_id,city_id,region) values (710814,7108,'«����');
insert into web_regions (region_id,city_id,region) values (710815,7108,'�����');
insert into web_regions (region_id,city_id,region) values (710816,7108,'̩ɽ��');
insert into web_regions (region_id,city_id,region) values (710817,7108,'�ֿ���');
insert into web_regions (region_id,city_id,region) values (710818,7108,'�����');
insert into web_regions (region_id,city_id,region) values (710819,7108,'ʯ����');
insert into web_regions (region_id,city_id,region) values (710820,7108,'ƺ����');
insert into web_regions (region_id,city_id,region) values (710821,7108,'��֥��');
insert into web_regions (region_id,city_id,region) values (710822,7108,'ʯ����');
insert into web_regions (region_id,city_id,region) values (710823,7108,'������');
insert into web_regions (region_id,city_id,region) values (710824,7108,'ƽϪ��');
insert into web_regions (region_id,city_id,region) values (710825,7108,'˫Ϫ��');
insert into web_regions (region_id,city_id,region) values (710826,7108,'�����');
insert into web_regions (region_id,city_id,region) values (710827,7108,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (710828,7108,'������');
insert into web_regions (region_id,city_id,region) values (710829,7108,'������');
insert into web_regions (region_id,city_id,region) values (712201,7122,'������');
insert into web_regions (region_id,city_id,region) values (712221,7122,'�޶���');
insert into web_regions (region_id,city_id,region) values (712222,7122,'�հ���');
insert into web_regions (region_id,city_id,region) values (712223,7122,'ͷ����');
insert into web_regions (region_id,city_id,region) values (712224,7122,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (712225,7122,'׳Χ��');
insert into web_regions (region_id,city_id,region) values (712226,7122,'Աɽ��');
insert into web_regions (region_id,city_id,region) values (712227,7122,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (712228,7122,'�����');
insert into web_regions (region_id,city_id,region) values (712229,7122,'������');
insert into web_regions (region_id,city_id,region) values (712230,7122,'��ͬ��');
insert into web_regions (region_id,city_id,region) values (712231,7122,'�ϰ���');
insert into web_regions (region_id,city_id,region) values (712301,7123,'��԰��');
insert into web_regions (region_id,city_id,region) values (712302,7123,'������');
insert into web_regions (region_id,city_id,region) values (712303,7123,'ƽ����');
insert into web_regions (region_id,city_id,region) values (712304,7123,'�˵���');
insert into web_regions (region_id,city_id,region) values (712305,7123,'��÷��');
insert into web_regions (region_id,city_id,region) values (712306,7123,'«����');
insert into web_regions (region_id,city_id,region) values (712321,7123,'��Ϫ��');
insert into web_regions (region_id,city_id,region) values (712324,7123,'��԰��');
insert into web_regions (region_id,city_id,region) values (712325,7123,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (712327,7123,'��̶��');
insert into web_regions (region_id,city_id,region) values (712329,7123,'������');
insert into web_regions (region_id,city_id,region) values (712330,7123,'������');
insert into web_regions (region_id,city_id,region) values (712331,7123,'������');
insert into web_regions (region_id,city_id,region) values (712401,7124,'����');
insert into web_regions (region_id,city_id,region) values (712421,7124,'����');
insert into web_regions (region_id,city_id,region) values (712422,7124,'������');
insert into web_regions (region_id,city_id,region) values (712423,7124,'������');
insert into web_regions (region_id,city_id,region) values (712424,7124,'������');
insert into web_regions (region_id,city_id,region) values (712425,7124,'�·���');
insert into web_regions (region_id,city_id,region) values (712426,7124,'ܺ����');
insert into web_regions (region_id,city_id,region) values (712427,7124,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (712428,7124,'������');
insert into web_regions (region_id,city_id,region) values (712429,7124,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (712430,7124,'��ü��');
insert into web_regions (region_id,city_id,region) values (712431,7124,'��ʯ��');
insert into web_regions (region_id,city_id,region) values (712432,7124,'�����');
insert into web_regions (region_id,city_id,region) values (712501,7125,'������');
insert into web_regions (region_id,city_id,region) values (712521,7125,'Է����');
insert into web_regions (region_id,city_id,region) values (712522,7125,'ͨ����');
insert into web_regions (region_id,city_id,region) values (712523,7125,'������');
insert into web_regions (region_id,city_id,region) values (712524,7125,'ͷ����');
insert into web_regions (region_id,city_id,region) values (712525,7125,'������');
insert into web_regions (region_id,city_id,region) values (712526,7125,'׿����');
insert into web_regions (region_id,city_id,region) values (712527,7125,'�����');
insert into web_regions (region_id,city_id,region) values (712528,7125,'������');
insert into web_regions (region_id,city_id,region) values (712529,7125,'ͭ����');
insert into web_regions (region_id,city_id,region) values (712530,7125,'��ׯ��');
insert into web_regions (region_id,city_id,region) values (712531,7125,'ͷ����');
insert into web_regions (region_id,city_id,region) values (712532,7125,'������');
insert into web_regions (region_id,city_id,region) values (712533,7125,'������');
insert into web_regions (region_id,city_id,region) values (712534,7125,'������');
insert into web_regions (region_id,city_id,region) values (712535,7125,'������');
insert into web_regions (region_id,city_id,region) values (712536,7125,'ʨ̶��');
insert into web_regions (region_id,city_id,region) values (712537,7125,'̩����');
insert into web_regions (region_id,city_id,region) values (712701,7127,'�û���');
insert into web_regions (region_id,city_id,region) values (712721,7127,'¹����');
insert into web_regions (region_id,city_id,region) values (712722,7127,'������');
insert into web_regions (region_id,city_id,region) values (712723,7127,'������');
insert into web_regions (region_id,city_id,region) values (712724,7127,'�����');
insert into web_regions (region_id,city_id,region) values (712725,7127,'������');
insert into web_regions (region_id,city_id,region) values (712726,7127,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (712727,7127,'��̳��');
insert into web_regions (region_id,city_id,region) values (712728,7127,'��԰��');
insert into web_regions (region_id,city_id,region) values (712729,7127,'Ա����');
insert into web_regions (region_id,city_id,region) values (712730,7127,'Ϫ����');
insert into web_regions (region_id,city_id,region) values (712731,7127,'������');
insert into web_regions (region_id,city_id,region) values (712732,7127,'�����');
insert into web_regions (region_id,city_id,region) values (712733,7127,'������');
insert into web_regions (region_id,city_id,region) values (712734,7127,'������');
insert into web_regions (region_id,city_id,region) values (712735,7127,'������');
insert into web_regions (region_id,city_id,region) values (712736,7127,'��ͷ��');
insert into web_regions (region_id,city_id,region) values (712737,7127,'��ˮ��');
insert into web_regions (region_id,city_id,region) values (712738,7127,'������');
insert into web_regions (region_id,city_id,region) values (712739,7127,'������');
insert into web_regions (region_id,city_id,region) values (712740,7127,'��β��');
insert into web_regions (region_id,city_id,region) values (712741,7127,'��ͷ��');
insert into web_regions (region_id,city_id,region) values (712742,7127,'��Է��');
insert into web_regions (region_id,city_id,region) values (712743,7127,'�����');
insert into web_regions (region_id,city_id,region) values (712744,7127,'������');
insert into web_regions (region_id,city_id,region) values (712745,7127,'Ϫ����');
insert into web_regions (region_id,city_id,region) values (712801,7128,'��Ͷ��');
insert into web_regions (region_id,city_id,region) values (712821,7128,'������');
insert into web_regions (region_id,city_id,region) values (712822,7128,'������');
insert into web_regions (region_id,city_id,region) values (712823,7128,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (712824,7128,'������');
insert into web_regions (region_id,city_id,region) values (712825,7128,'������');
insert into web_regions (region_id,city_id,region) values (712826,7128,'¹����');
insert into web_regions (region_id,city_id,region) values (712827,7128,'�����');
insert into web_regions (region_id,city_id,region) values (712828,7128,'�����');
insert into web_regions (region_id,city_id,region) values (712829,7128,'������');
insert into web_regions (region_id,city_id,region) values (712830,7128,'ˮ����');
insert into web_regions (region_id,city_id,region) values (712831,7128,'������');
insert into web_regions (region_id,city_id,region) values (712832,7128,'�ʰ���');
insert into web_regions (region_id,city_id,region) values (712901,7129,'������');
insert into web_regions (region_id,city_id,region) values (712921,7129,'������');
insert into web_regions (region_id,city_id,region) values (712922,7129,'��β��');
insert into web_regions (region_id,city_id,region) values (712923,7129,'������');
insert into web_regions (region_id,city_id,region) values (712924,7129,'������');
insert into web_regions (region_id,city_id,region) values (712925,7129,'������');
insert into web_regions (region_id,city_id,region) values (712926,7129,'�ſ���');
insert into web_regions (region_id,city_id,region) values (712927,7129,'������');
insert into web_regions (region_id,city_id,region) values (712928,7129,'Ǆͩ��');
insert into web_regions (region_id,city_id,region) values (712929,7129,'������');
insert into web_regions (region_id,city_id,region) values (712930,7129,'������');
insert into web_regions (region_id,city_id,region) values (712931,7129,'�ر���');
insert into web_regions (region_id,city_id,region) values (712932,7129,'�����');
insert into web_regions (region_id,city_id,region) values (712933,7129,'������');
insert into web_regions (region_id,city_id,region) values (712934,7129,'������');
insert into web_regions (region_id,city_id,region) values (712935,7129,'̨����');
insert into web_regions (region_id,city_id,region) values (712936,7129,'Ԫ����');
insert into web_regions (region_id,city_id,region) values (712937,7129,'�ĺ���');
insert into web_regions (region_id,city_id,region) values (712938,7129,'�ں���');
insert into web_regions (region_id,city_id,region) values (712939,7129,'ˮ����');
insert into web_regions (region_id,city_id,region) values (713001,7130,'̫����');
insert into web_regions (region_id,city_id,region) values (713002,7130,'������');
insert into web_regions (region_id,city_id,region) values (713023,7130,'������');
insert into web_regions (region_id,city_id,region) values (713024,7130,'������');
insert into web_regions (region_id,city_id,region) values (713025,7130,'������');
insert into web_regions (region_id,city_id,region) values (713026,7130,'Ϫ����');
insert into web_regions (region_id,city_id,region) values (713027,7130,'�¸���');
insert into web_regions (region_id,city_id,region) values (713028,7130,'������');
insert into web_regions (region_id,city_id,region) values (713029,7130,'��ʯ��');
insert into web_regions (region_id,city_id,region) values (713030,7130,'������');
insert into web_regions (region_id,city_id,region) values (713031,7130,'¹����');
insert into web_regions (region_id,city_id,region) values (713032,7130,'ˮ����');
insert into web_regions (region_id,city_id,region) values (713033,7130,'������');
insert into web_regions (region_id,city_id,region) values (713034,7130,'������');
insert into web_regions (region_id,city_id,region) values (713035,7130,'÷ɽ��');
insert into web_regions (region_id,city_id,region) values (713036,7130,'��·��');
insert into web_regions (region_id,city_id,region) values (713037,7130,'������');
insert into web_regions (region_id,city_id,region) values (713038,7130,'����ɽ��');
insert into web_regions (region_id,city_id,region) values (713301,7133,'������');
insert into web_regions (region_id,city_id,region) values (713321,7133,'������');
insert into web_regions (region_id,city_id,region) values (713322,7133,'������');
insert into web_regions (region_id,city_id,region) values (713323,7133,'�㴺��');
insert into web_regions (region_id,city_id,region) values (713324,7133,'����');
insert into web_regions (region_id,city_id,region) values (713325,7133,'������');
insert into web_regions (region_id,city_id,region) values (713326,7133,'������');
insert into web_regions (region_id,city_id,region) values (713327,7133,'������');
insert into web_regions (region_id,city_id,region) values (713328,7133,'�����');
insert into web_regions (region_id,city_id,region) values (713329,7133,'������');
insert into web_regions (region_id,city_id,region) values (713330,7133,'������');
insert into web_regions (region_id,city_id,region) values (713331,7133,'������');
insert into web_regions (region_id,city_id,region) values (713332,7133,'������');
insert into web_regions (region_id,city_id,region) values (713333,7133,'������');
insert into web_regions (region_id,city_id,region) values (713334,7133,'������');
insert into web_regions (region_id,city_id,region) values (713335,7133,'�����');
insert into web_regions (region_id,city_id,region) values (713336,7133,'��԰��');
insert into web_regions (region_id,city_id,region) values (713337,7133,'������');
insert into web_regions (region_id,city_id,region) values (713338,7133,'�ֱ���');
insert into web_regions (region_id,city_id,region) values (713339,7133,'������');
insert into web_regions (region_id,city_id,region) values (713340,7133,'�Ѷ���');
insert into web_regions (region_id,city_id,region) values (713341,7133,'������');
insert into web_regions (region_id,city_id,region) values (713342,7133,'������');
insert into web_regions (region_id,city_id,region) values (713343,7133,'������');
insert into web_regions (region_id,city_id,region) values (713344,7133,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (713345,7133,'��������');
insert into web_regions (region_id,city_id,region) values (713346,7133,'��̨��');
insert into web_regions (region_id,city_id,region) values (713347,7133,'�����');
insert into web_regions (region_id,city_id,region) values (713348,7133,'̩����');
insert into web_regions (region_id,city_id,region) values (713349,7133,'������');
insert into web_regions (region_id,city_id,region) values (713350,7133,'������');
insert into web_regions (region_id,city_id,region) values (713351,7133,'ʨ����');
insert into web_regions (region_id,city_id,region) values (713352,7133,'ĵ����');
insert into web_regions (region_id,city_id,region) values (713401,7134,'̨����');
insert into web_regions (region_id,city_id,region) values (713421,7134,'�ɹ���');
insert into web_regions (region_id,city_id,region) values (713422,7134,'��ɽ��');
insert into web_regions (region_id,city_id,region) values (713423,7134,'������');
insert into web_regions (region_id,city_id,region) values (713424,7134,'¹Ұ��');
insert into web_regions (region_id,city_id,region) values (713425,7134,'������');
insert into web_regions (region_id,city_id,region) values (713426,7134,'������');
insert into web_regions (region_id,city_id,region) values (713427,7134,'������');
insert into web_regions (region_id,city_id,region) values (713428,7134,'̫������');
insert into web_regions (region_id,city_id,region) values (713429,7134,'������');
insert into web_regions (region_id,city_id,region) values (713430,7134,'�̵���');
insert into web_regions (region_id,city_id,region) values (713431,7134,'������');
insert into web_regions (region_id,city_id,region) values (713432,7134,'��ƽ��');
insert into web_regions (region_id,city_id,region) values (713433,7134,'�����');
insert into web_regions (region_id,city_id,region) values (713434,7134,'������');
insert into web_regions (region_id,city_id,region) values (713435,7134,'������');
insert into web_regions (region_id,city_id,region) values (713501,7135,'������');
insert into web_regions (region_id,city_id,region) values (713521,7135,'������');
insert into web_regions (region_id,city_id,region) values (713522,7135,'������');
insert into web_regions (region_id,city_id,region) values (713523,7135,'�³���');
insert into web_regions (region_id,city_id,region) values (713524,7135,'������');
insert into web_regions (region_id,city_id,region) values (713525,7135,'�ٷ���');
insert into web_regions (region_id,city_id,region) values (713526,7135,'�⸴��');
insert into web_regions (region_id,city_id,region) values (713527,7135,'�����');
insert into web_regions (region_id,city_id,region) values (713528,7135,'������');
insert into web_regions (region_id,city_id,region) values (713529,7135,'������');
insert into web_regions (region_id,city_id,region) values (713530,7135,'������');
insert into web_regions (region_id,city_id,region) values (713531,7135,'������');
insert into web_regions (region_id,city_id,region) values (713532,7135,'׿Ϫ��');
insert into web_regions (region_id,city_id,region) values (713601,7136,'������');
insert into web_regions (region_id,city_id,region) values (713621,7136,'������');
insert into web_regions (region_id,city_id,region) values (713622,7136,'��ɳ��');
insert into web_regions (region_id,city_id,region) values (713623,7136,'������');
insert into web_regions (region_id,city_id,region) values (713624,7136,'������');
insert into web_regions (region_id,city_id,region) values (713625,7136,'������');
insert into web_regions (region_id,city_id,region) values (713701,7137,'�����');
insert into web_regions (region_id,city_id,region) values (713702,7137,'�����');
insert into web_regions (region_id,city_id,region) values (713703,7137,'��ɳ��');
insert into web_regions (region_id,city_id,region) values (713704,7137,'������');
insert into web_regions (region_id,city_id,region) values (713705,7137,'������');
insert into web_regions (region_id,city_id,region) values (713706,7137,'������');
insert into web_regions (region_id,city_id,region) values (713801,7138,'�ϸ���');
insert into web_regions (region_id,city_id,region) values (713802,7138,'������');
insert into web_regions (region_id,city_id,region) values (713803,7138,'�����');
insert into web_regions (region_id,city_id,region) values (713804,7138,'������');
insert into web_regions (region_id,city_id,region) values (810101,8101,'������');
insert into web_regions (region_id,city_id,region) values (810102,8101,'������');
insert into web_regions (region_id,city_id,region) values (810103,8101,'����');
insert into web_regions (region_id,city_id,region) values (810104,8101,'����');
insert into web_regions (region_id,city_id,region) values (810201,8102,'�ͼ�����');
insert into web_regions (region_id,city_id,region) values (810202,8102,'��ˮ����');
insert into web_regions (region_id,city_id,region) values (810203,8102,'��������');
insert into web_regions (region_id,city_id,region) values (810204,8102,'�ƴ�����');
insert into web_regions (region_id,city_id,region) values (810205,8102,'������');
insert into web_regions (region_id,city_id,region) values (810301,8103,'������');
insert into web_regions (region_id,city_id,region) values (810302,8103,'������');
insert into web_regions (region_id,city_id,region) values (810303,8103,'Ԫ����');
insert into web_regions (region_id,city_id,region) values (810304,8103,'����');
insert into web_regions (region_id,city_id,region) values (810305,8103,'������');
insert into web_regions (region_id,city_id,region) values (810306,8103,'������');
insert into web_regions (region_id,city_id,region) values (810307,8103,'ɳ����');
insert into web_regions (region_id,city_id,region) values (810308,8103,'������');
insert into web_regions (region_id,city_id,region) values (810309,8103,'�뵺��');
insert into web_regions (region_id,city_id,region) values (820101,8201,'����������');
insert into web_regions (region_id,city_id,region) values (820102,8201,'ʥ����������');
insert into web_regions (region_id,city_id,region) values (820103,8201,'������');
insert into web_regions (region_id,city_id,region) values (820104,8201,'��������');
insert into web_regions (region_id,city_id,region) values (820105,8201,'��˳����');
insert into web_regions (region_id,city_id,region) values (820201,8202,'��ģ����');
insert into web_regions (region_id,city_id,region) values (820301,8203,'ʥ���ø�����');


update web_cities set city='�½�ά���ֱϽ�ؼ�' where city_id=6590;
  update web_cities set city='����ֱϽ�ؼ�' where city_id=4190;
  update web_cities set city='����ֱϽ�ؼ�' where city_id=4690;
  update web_cities set city='����ֱϽ�ؼ�' where city_id=4290;