CREATE DATABASE BAO_INOX 
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

USE BAO_INOX;

CREATE TABLE CHUC_VU(
	cv_id int not null auto_increment,
	cv_name varchar(30) not null,
    cv_list varchar(20) not null,-- list by menu ex: 1,2,3,4
	primary key(cv_id,cv_name),
	unique(cv_name)
);

CREATE TABLE NHAN_VIEN(
	nv_id varchar(10) not null,-- CMND
	nv_name varchar(30) not null,
    nv_pass varchar(45) not null,
	nv_access varchar(100) not null,
	nv_phone varchar(12) not null,
	cv_id int not null,
	primary key(nv_id)
);

CREATE TABLE LICH_LAM_VIEC(
	nv_id varchar(10) not null,
	llv_date timestamp DEFAULT CURRENT_TIMESTAMP,
	llv_note text not null,
	primary key(nv_id,llv_date)
);

CREATE TABLE DANH_MUC(
	dm_id int not null auto_increment,
	dm_name varchar(20) not null,
	dm_dad_dm int not null,
	primary key(dm_id,dm_name),
	unique(dm_id,dm_name)
);

CREATE TABLE SAN_PHAM(
	sp_id int not null auto_increment,
	sp_name varchar(50) not null,
	sp_price double not null,
	sp_num int not null,
	dm_id int not null,
	primary key(sp_id,sp_name)
);

CREATE TABLE XUAT_NHAP_KHO(
	sp_id int not null,
	num int not null,
	xnk_date timestamp DEFAULT  CURRENT_TIMESTAMP,
	type tinyint not null DEFAULT 0
);

CREATE TABLE PHUONG(
	p_id int not null,
	p_name varchar(30) not null,
	q_id int not null,
	primary key(p_id,q_id)
);

CREATE TABLE QUAN(
	q_id int not null,
	q_name varchar(30) not null,
	tp_id int not null,
	primary key(q_id,tp_id)
);

CREATE TABLE THANH_PHO(
	tp_id int not null,
	tp_name varchar(30) not null,
	primary key(tp_id,tp_name)
);

CREATE TABLE KHACH_HANG(
	kh_id int not null auto_increment,
	kh_name varchar(30) not null,
	kh_access varchar(100) not null,
	kh_phone varchar(12) not null,
	p_id int not null,
	q_id int not null,
	tp_id int not null,
    kh_work varchar(50) not null,
    primary key (kh_id)
);

CREATE TABLE DON_HANG(
	dh_id double not null,
	kh_id int not null,
	sp_id int not null,
	dh_date timestamp DEFAULT CURRENT_TIMESTAMP,
    dh_working text not null,
    dh_des text not null,
    kh_id int not null,
    nv_id varchar(10) not null,
	primary key(dh_id)
);

CREATE TABLE THONG_KE(
    tk_date date not null,
    tk_num int not null,
    tk_total double not null,
    primary key(tk_date)
);

CREATE TABLE TK_KHU_VUC(
    tk_date date not null,
    tp_id int not null,
    q_id int not null,
    tk_total double not null,
    primary key(tk_date,q_id,tp_id)
);

CREATE TABLE TK_NHAN_VIEN(
    tk_date date not null,
    nv_id int not null,
    tk_total double not null,
    primary key(tk_date,tk_total)
);

ALTER TABLE NHAN_VIEN ADD CONSTRAINT FK_NV_CV FOREIGN KEY (cv_id) REFERENCES CHUC_VU(cv_id);

ALTER TABLE LICH_LAM_VIEC ADD CONSTRAINT FK_LLV_NV FOREIGN KEY (nv_id) REFERENCES NHAN_VIEN(nv_id);

ALTER TABLE SAN_PHAM ADD CONSTRAINT FK_SP_DM FOREIGN KEY (dm_id) REFERENCES DANH_MUC(dm_id);

ALTER TABLE XUAT_NHAP_KHO ADD CONSTRAINT FK_SNK_SP FOREIGN KEY (sp_id) REFERENCES SAN_PHAM(sp_id);

ALTER TABLE DON_HANG ADD CONSTRAINT FK_DH_SP FOREIGN KEY (sp_id) REFERENCES SAN_PHAM(sp_id);

ALTER TABLE DON_HANG ADD CONSTRAINT FK_DH_NV FOREIGN KEY (nv_id) REFERENCES nhan_vien(nv_id);

ALTER TABLE DON_HANG ADD CONSTRAINT FK_DH_KH FOREIGN KEY (kh_id) REFERENCES khach_hang(kh_id);

ALTER TABLE PHUONG ADD CONSTRAINT FK_P_Q FOREIGN KEY (q_id) REFERENCES QUAN(q_id);

ALTER TABLE QUAN ADD CONSTRAINT FK_Q_TP FOREIGN KEY (tp_id) REFERENCES THANH_PHO(tp_id);

ALTER TABLE KHACH_HANG ADD CONSTRAINT FK_KH_P FOREIGN KEY (p_id) REFERENCES PHUONG(p_id);

ALTER TABLE KHACH_HANG ADD CONSTRAINT FK_KH_Q FOREIGN KEY (q_id) REFERENCES QUAN(q_id);

ALTER TABLE KHACH_HANG ADD CONSTRAINT FK_KH_TP FOREIGN KEY (tp_id) REFERENCES THANH_PHO(tp_id);

ALTER TABLE TK_KHU_VUC ADD CONSTRAINT FK_KV_TK FOREIGN KEY (tk_date) REFERENCES THONG_KE(tk_date);

ALTER TABLE TK_NHAN_VIEN ADD CONSTRAINT FK_TKNV_TK FOREIGN KEY (tk_date) REFERENCES THONG_KE(tk_date);